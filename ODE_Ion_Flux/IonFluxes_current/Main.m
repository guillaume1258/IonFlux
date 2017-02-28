% Model: track inside concentration of ionic species H, K, Cl and Na along time.

clear

%% set simulation time
tfinal  = 1e6;                              % final time

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
Dye0      = 1e-7;

%% Parameters for the experiment

% Extracellular concentration of protons
pHe   = 5.5;
k.H_e = 10^-pHe;

% ATP flow
nu_ATP     = 5 * 1e9 / 3600;       % ATP/second per cell
k.ATP_Prod = nu_ATP / (k.V * k.NA); % [mol/Liter/second], 1e6 is [molec/second], k.V is volume of a cell, k.NA is [mol^-1]

% Save the experiment under the following name
Save_Name = sprintf('data/27022017_DyeData_pHe=%d_nuATP=%d.mat' , pHe , nu_ATP * 3600);

%% Loop over range of external Dye concentration and conductance

v = struct();

%v.Dye_e  = linspace(1 , 21  , 5) * 1e-6; % External concentration of dye
v.Dye_e = logspace(log10(0.1) , log10(1e5) , 20) * 1e-6;
v.g_Dye = logspace(log10(0.1) , log10(100) , 10) * 1e-2;

for i = 1 : length(v.Dye_e)
    
    for j = 1 : length(v.g_Dye)
        
        
        x0 = [H_i0, K_i0, Cl_i0, Na_i0, ATP0, ADP0, Dye0]; % Reset initial conditions
        
        for z = 1 : 2
            
            if z == 2
                
                % Update extracellular Concentration of the dye
                k.Dye_e = v.Dye_e(i);
                tfinal = 1e8;
                %k.Dye_e = 0.1;
                % Update conductance of the Dye
                k.g_Dye = v.g_Dye(j);
                %k.g_Dye = 0.05;
            else
                
                k.Dye_e = 1e-9;
                tfinal  = 1e5;
                
            end
            
            tic;
            
            %% simulate
            [t,result] = ode15s(@(t,result) ODE(t,result,k),[0,tfinal],x0,options);
            
            %% rename variables
            
            Observables;
            
            % Now store observables we want to know the values for each
            % iteration of the loops, only from the moment we add the Dye
            v.V_m(i , j)         = V_m(end);
            v.DeltapHi(i , j)    = Delta_pHi(end);
            v.PMF(i , j)         = PMF(end);
            v.DeltaG_H(i , j)    = DeltaG_H(end);
            v.DeltaG_K(i , j)    = DeltaG_K(end);
            v.Beta_H(i , j)      = Beta_H(end);
            v.LoadingTime(i , j) = LoadingTime;
            v.OsmoticP(i ,  j)   = OP(end);
            
            TimeDynamics(i).t    = t;
            TimeDynamics(i).Dye  = Dye;
            
            x0 = [H_i(end) , K_i(end) , Cl_i(end) , Na_i(end) , ATP(end) , ADP(end) , Dye(end)];
            
            toc;
            
        end
        
    end
    
end

% Save data
save(Save_Name , 'v')


% To plot or not to plot ?
ToPlot = 1;

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