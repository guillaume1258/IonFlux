% Model: track inside concentration of ionic species H, K, Cl and Na along time.

clear

%% set simulation time
tfinal  = 1e5;                              % final time

%% configure integrator (check 'doc ode15s' for more info)
options = odeset('NonNegative',[1:6]);      % ensures variables stay positive
% (this is not always necessary
% but can be helpful, but make sure
% your system is actually a positive system!)

options = odeset(options, 'RelTol', 1e-9,...
    'AbsTol', 1e-12);  % accuracy of integrator
% (here set to default values)

%% set parameters

Parameters;

%% set initial values [mol/Liter]
H_i0      = 1e-7;
K_i0      = 1e-3;
Cl_i0     = 1e-1;
Na_i0     = 1e-3;
ATP0      = 1;
ADP0      = 5e-2;

x0      = [H_i0, K_i0, Cl_i0, Na_i0, ATP0, ADP0]; % definition of the initial vector of variables

%% Loop over range of pH and ATP fluxes

v = struct();

v.pHe    = linspace(5 , 7 , 11);        % External pH
v.nu_ATP = linspace(1 , 20 , 20) * 1e9; % In ATP/hour/cell

for i = 1 : 1%length(v.pHe)
    
    pHe = v.pHe(i);
    
    % Force pHe
    pHe = 7;
    k.H_e  = 10^-pHe;
    
    for j = 1 : 1%length(v.nu_ATP)
    
        nu_ATP     = 0;%v.nu_ATP(j) / 3600;       
        k.ATP_Prod = nu_ATP / (k.V * k.NA);

        tic;

        %% simulate
        [t,result] = ode15s(@(t,result) ODE(t,result,k),[0,tfinal],x0,options);
        
        %% rename variables
        
        Observables;
        
        % Now store observables we want to know the values for each
        % iteration of the loops:
        v.V_m(i , j)      = V_m(end);
        v.DeltapHi(i , j) = Delta_pHi(end);
        v.PMF(i , j)      = PMF(end);
        v.DeltaG_H(i , j) = DeltaG_H(end);
        v.DeltaG_K(i , j) = DeltaG_K(end);
        v.Beta_H(i , j)   = Beta_H(end);
        
        toc;
        
    end
    
end

ToPlot = 0;

if ToPlot == 0
    
    % %% plot results
    figure(1); clf;
    subplot(4,1,1)
    plot(t,-log10(H_i)); ylabel('pH_i', 'fontsize', 14);
    
    subplot(4,1,2)
    plot(t,K_i); ylabel('K_i', 'fontsize', 14);
    
    subplot(4,1,3)
    plot(t,Cl_i); ylabel('Cl_i', 'fontsize', 14);
    
    subplot(4,1,4)
    plot(t,Na_i); ylabel('Na_i', 'fontsize', 14); xlabel('time', 'fontsize', 14)
    
    figure(2);
    plot(t,V_m); ylabel('V_m','fontsize',14)
    
end