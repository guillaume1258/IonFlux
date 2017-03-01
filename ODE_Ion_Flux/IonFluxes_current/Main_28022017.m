% Model: track inside concentration of ionic species H, K, Cl and Na along time.

clear

addpath('data')
addpath('Figures')

%% set simulation time
tfinal  = 1e6;                              % final time

%% configure integrator (check 'doc ode15s' for more info)
options = odeset('NonNegative',[1:7]);      % ensures variables stay positive
% (this is not always necessary
% but can be helpful, but make sure
% your system is actually a positive system!)

options = odeset(options, 'RelTol', 1e-7,...
    'AbsTol', 1e-10);  % accuracy of integrator
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

k.Beta_K  = 1 / 6;
k.Beta_Cl = 1 / 6;
k.Beta_Na = 4 / 6;

% Save the experiment under the following name
Save_Name = sprintf('data/28022017_DyeData_BetaK=%d_BetaNa=%d_BetaCl=%d.mat' , k.Beta_K , k.Beta_Na , k.Beta_Cl);

%% Loop over range of external Dye concentration and conductance

v = struct();

%v.Dye_e  = linspace(1 , 21  , 5) * 1e-6; % External concentration of dye
v.pHe    = linspace(5 , 7 , 21);
v.nu_ATP = linspace(1 , 20 , 20) * 1e9;

for i = 1 : length(v.pHe)
    
    for j = 1 : length(v.nu_ATP)
        
        k.ATP_Prod = v.nu_ATP(j) / 3600 / (k.V * k.NA);
        k.pHe      = v.pHe(i);
        k.H_e      = 10^-k.pHe;
        
        x0 = [H_i0, K_i0, Cl_i0, Na_i0, ATP0, ADP0, Dye0]; % Reset initial conditions
        
        for z = 1 : 2
            
            if z == 2
                
                % Update extracellular Concentration of the dye
                k.Dye_e = 10e-6;
                tfinal = 1e6;
                
            else
                
                k.Dye_e = 1e-8;
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
            v.Dye_i(i , j)       = Dye(end);
            v.Na_i(i , j)        = Na_i(end);
            v.K_i(i , j)         = K_i(end);
            v.Cl_i(i , j)        = Cl_i(end);
            v.H_i(i , j)         = H_i(end);
            
            TimeDynamics(i).t    = t;
            TimeDynamics(i).Dye  = Dye;
            
            x0 = [H_i(end) , K_i(end) , Cl_i(end) , Na_i(end) , ATP(end) , ADP(end) , Dye(end)];
            
            toc;
            
        end
        
    end
    
end

% To save or not to save ?
ToSave = 1;

if ToSave == 1
    
    % Save data
    save(Save_Name , 'v')

end

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