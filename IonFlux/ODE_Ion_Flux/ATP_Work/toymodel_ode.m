function dxdt = toymodel_ode(t, x, k)

% toymodel_ode(time, variables_vector, parameter_vector)
% Function that implements the right hand side of the ODE for toymodel. 

%% rename variables
H       = x(1);
K       = x(2);
Cl      = x(3);
Na      = x(4);
ATP     = x(5);

%% initialize the rates of change for each variable with 0
dHdt    = 0;
dKdt    = 0;
dCldt   = 0;
dNadt   = 0;
dATPdt  = 0;

%% Functions of the state

% Nernst equilibrium potentials

Nernst = @(z , c_i , c_e) - k.k_B * k.T / (z * k.e) * log(c_i / c_e);

V_H  = Nernst(k.z_H  , H  , k.H_e);
V_K  = Nernst(k.z_K  , K  , k.K_e);
V_Cl = Nernst(k.z_Cl , Cl , k.Cl_e);
V_Na = Nernst(k.z_Na , Na , k.Na_e);

% Membrane potential, given by charge balance, Ref: Kahm 2012.
V_m = k.e / k.S / k.C_m * (H + K - Cl + Na)

% Delta G associated with export of proton
Delta_G = @(z , V_eq , V_m) z * k.e * (V_m - V_eq);

G_H  = Delta_G(k.z_H  , V_H  , V_m);
G_K  = Delta_G(k.z_K  , V_K  , V_m);
G_Cl = Delta_G(k.z_Cl , V_Cl , V_m);
G_Na = Delta_G(k.z_Na , V_Na , V_m);

% ATP work conversion, follow Michaelis Menten
nu_ATP  = k.v.work / (1 + k.K.work / ATP);
nu_work = k.v.work / (1 + k.K.work / ATP) * k.G_ATP * k.sigma_ATP;

%% for each reaction - add up contributions to rates of changes

%% Ion Leakage
% H_i <-> H_e;
v1    = 1 / (k.e * k.z_H) * k.S * k.g_H  * (V_m - V_H);
dHdt  = dHdt - v1;

% K_i <-> K_e;
v2    = 1 / (k.e * k.z_K) * k.S * k.g_K  * (V_m - V_K);
dKdt  = dKdt - v2;

% Cl_i <-> Cl_e;
v3    = 1 / (k.e * k.z_Cl) * k.S * k.g_Cl * (V_m - V_Cl);
dCldt = dCldt - v3;

% H_i <-> H_e;
v4    = 1 / (k.e * k.z_Na) * k.S * k.g_Na * (V_m - V_Na);
dNadt = dNadt - v4;

%% Pumping
% -> ATP; @ k.ATP_Flux
v5     = k.ATP_Flux;
dATPdt = dATPdt + v5;

% H_i -> H_e; - nu_work / G_H
v6     = nu_work / G_H;
dHdt   = dHdt - v6;

% ATP -> work; @ nu_ATP
v7     = nu_ATP;
dATPdt = dATPdt - v7; 

%% output vector of rates of change of all variables
dxdt    = [dHdt; dKdt; dCldt; dNadt; dATPdt];