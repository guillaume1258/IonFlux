% Model: track inside concentration of ionic species H, K, Cl and Na along time.

clear

%% set simulation time
tfinal  = 1e4;                              % final time

%% configure integrator (check 'doc ode15s' for more info)
options = odeset('NonNegative',[1:7]);      % ensures variables stay positive
% (this is not always necessary
% but can be helpful, but make sure
% your system is actually a positive system!)

options = odeset(options, 'RelTol', 1e-9,...
    'AbsTol', 1e-12);  % accuracy of integrator
% (here set to default values)

%% set parameters

Parameters;

%% set initial values [mol/Liter]
H_i0      = 1e-6;
K_i0      = 1e-4;
Cl_i0     = 1e0;
Na_i0     = 1e-3;
ATP0      = 1;
ADP0      = 5e-2;
Dye0      = 1e-6;

%% Loop over range of external Dye concentration

v = struct();

%v.Dye_e  = linspace(1 , 21  , 5) * 1e-6; % External concentration of dye
Dye_vec = [1 , 5  , 10 , 20 , 50] * 1e-6;
v.Dye_e=Dye_vec;

for i = 1 : length(v.Dye_e)
    
    
    x0 = [H_i0, K_i0, Cl_i0, Na_i0, ATP0, ADP0, Dye0]; % Reset initial conditions
    
    for z = 1 : 2
        
        if z == 2
            
            k.Dye_e = v.Dye_e(i);
            %k.Dye_e = 0;
            tfinal = 1e4;
            
        else
            
            k.Dye_e = 1e-6;
            tfinal  = 1e4;
            
        end
        
        tic;
        
        %% simulate
        [t,result] = ode15s(@(t,result) ODE(t,result,k),[0,tfinal],x0,options);
        
        %% rename variables
        
        Observables;
        
        % Now store observables we want to know the values for each
        % iteration of the loops, only from the moment we add the Dye
        v.V_m(i)      = V_m(end);
        v.DeltapHi(i) = Delta_pHi(end);
        v.PMF(i)      = PMF(end);
        v.DeltaG_H(i) = DeltaG_H(end);
        v.DeltaG_K(i) = DeltaG_K(end);
        v.Beta_H(i)   = Beta_H(end);
        
        TimeDynamics(i).t    = t;
        TimeDynamics(i).Dye  = Dye;
        
        x0 = [H_i(end) , K_i(end) , Cl_i(end) , Na_i(end) , ATP(end) , ADP(end) , Dye(end)];
   
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
    
    figure(3);
    plot(t,Dye*1e3); ylabel('[Dye]_i [mMol]' , 'fontsize', 14)
    
end