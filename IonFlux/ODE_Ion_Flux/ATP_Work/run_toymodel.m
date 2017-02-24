% Model: track inside concentration of ionic species H, K, Cl and Na along time.

%% set simulation time
tfinal  = 1e5;                              % final time

%% configure integrator (check 'doc ode15s' for more info)
options = odeset('NonNegative',[1:5]);      % ensures variables stay positive 
                                            % (this is not always necessary 
                                            % but can be helpful, but make sure 
                                            % your system is actually a positive system!)

options = odeset(options, 'RelTol', 1e-6,...
                          'AbsTol', 1e-9);  % accuracy of integrator 
                                            % (here set to default values)

%% set parameters

k = struct();

% Physical constant
k.k_B = 1.38 * 1e-23; % Boltzmann constant [Joule/Kelvin]
k.T   = 293;          % Temperature [Kelvin]
k.e   = 1.60 * 1e-19; % Elementary charge [Coulombs]
k.NA  = 6.02 * 1e23;  % Avogadro constant [molecule/mol]

% Length & width of E.coli in glucose medium, ref: Basan 2015.
% Units in meter
length = 2.95 * 1e-6;
width  = 1.07 * 1e-6;
radius = width / 2;

% Surface and volume of E.coli in m^2 & m^3
k.S = 2 * pi * (radius)^2 + 2 * pi * radius * length; 
k.V = pi * radius ^2 * length;

% Medium pH
pH_e = 7;

% Ion concentration outside, for ionic species H, K, Cl, Na
% Ref, Neidhart 1974, M9 medium, units are number per volume of reference
% (= volume of one cell)
k.H_e  = 10^-pH_e     * k.V * 1e3 * k.NA;
k.K_e  = 22    * 1e-3 * k.V * 1e3 * k.NA;
k.Cl_e = 28.09 * 1e-3 * k.V * 1e3 * k.NA;
k.Na_e = 93    * 1e-3 * k.V * 1e3 * k.NA;

% Valence of each ion
k.z_H  = 1;
k.z_K  = 1;
k.z_Cl = -1;
k.z_Na = 1;

% Membrane conductance for each of these ions, in Siemens/m^2
k.g_H  = 0.25;
k.g_K  = 0.05;
k.g_Cl = 0.05;
k.g_Na = 0.05;

% Membrane capacitance, [Farad/m^2] ref: Kahm 2012
k.C_m = 1e2;

% Work Joule per molecule of ATP
k.G_ATP = -5.4 * 1e4 / k.NA;

% Flux of ATP available
N_ATP      = 0;     % In number of molecules per second per volume of reference (volume of one cell)
k.ATP_Flux = N_ATP; % in mol per second, 1e-3 to convert from m^3 to Liter

% ATP work parameters
k.sigma_ATP = 1;               % Efficiency of work conversion
k.v.work    = 2 * k.ATP_Flux;  % Max conversion of ATP into work per second
k.K.work    = 1e4;             % Affinity of ATP conversion to work

% Impose targetted pH inside
k.pH_in = 7.2;

%% set initial values
H_i0      = 1e-7   * k.V * 1e3 * k.NA;
K_i0      = 1e-3 * k.V * 1e3 * k.NA;
Cl_i0     = 200e-3 * k.V * 1e3 * k.NA;
Na_i0     = 1e-3  * k.V * 1e3 * k.NA;
ATP0      = 1e3;

x0      = [H_i0, K_i0, Cl_i0, Na_i0, ATP0]; % definition of the initial vector of variables

%% simulate
[t,result] = ode15s(@(t,result) toymodel_ode(t,result,k),[0,tfinal],x0,options);

%% rename variables
H_i  = result(:,1);    % a = first column of result
K_i  = result(:,2);    % b = second column of result
Cl_i = result(:,3);    % ... 
Na_i = result(:,4);
ATP0 = result(:,5);

% %% plot results
figure(1); clf; 
subplot(4,1,1)
plot(t,-log10(H_i ./ (k.NA * k.V * 1e3))); ylabel('pH_i', 'fontsize', 14);

subplot(4,1,2)
plot(t,K_i); ylabel('K_i', 'fontsize', 14);

subplot(4,1,3)
plot(t,Cl_i); ylabel('Cl_i', 'fontsize', 14);

subplot(4,1,4)
plot(t,Na_i); ylabel('Na_i', 'fontsize', 14); xlabel('time', 'fontsize', 14)
