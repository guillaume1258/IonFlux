function dxdt = ODE(t, x, k)

% toymodel_ode(time, variables_vector, parameter_vector)
% Function that implements the right hand side of the ODE for toymodel. 

%% rename variables
H       = x(1);
K       = x(2);
Cl      = x(3);
Na      = x(4);
ATP     = x(5);
ADP     = x(6);
Dye     = x(7);

%% initialize the rates of change for each variable with 0
dHdt    = 0;
dKdt    = 0;
dCldt   = 0;
dNadt   = 0;
dATPdt  = 0;
dADPdt  = 0;
dDyedt  = 0;

%% Functions of the state

% Nernst equilibrium potentials [Volt]

Nernst = @(z , c_i , c_e) k.k_B * k.T / (z * k.e) * log(c_e / c_i);

V_H  = Nernst(k.z_H  , H  , k.H_e);
V_K  = Nernst(k.z_K  , K  , k.K_e);
V_Cl = Nernst(k.z_Cl , Cl , k.Cl_e);
V_Na = Nernst(k.z_Na , Na , k.Na_e);

% Nernst equilibrium potential for the Dye [Volt]
V_Dye = Nernst(k.z_Dye , Dye , k.Dye_e);

% Membrane potential, given by charge balance, Ref: Kahm 2012 [Volt].
V_m = k.e * k.NA * k.V  / (k.S * k.C_m) * (H + K - Cl + Na + Dye - k.Z);

% Delta G pump H [Volt]
DG_Hpump = k.k_B * k.T / k.e * log(ADP/ATP) + V_H - V_m;

% Delta G ATP [Joule/mol]
%DeltaG_ATP = k.k_B * k.T / k.e * log(ADP/ATP) * k.F;
DeltaG_ATP = -5 * 1e4;


% Available work [Joule/Liter/second]
Work = DeltaG_ATP * k.ATP_Prod;

% Delta G of importing ions [Joule/mol]
DeltaG = @(z , V_m , V_eq) z * k.F * (V_m - V_eq);

DeltaG_H  = DeltaG(k.z_H  , V_m , V_H);
DeltaG_K  = DeltaG(k.z_H  , V_m , V_K);
DeltaG_Cl = DeltaG(k.z_Cl , V_m , V_Cl);
DeltaG_Na = DeltaG(k.z_Na , V_m , V_Na);

% Work allocation in % of total work allocated to membrane potential
% maintenance, must sum up to 1
pHi_Current = -log10(H);
Delta_pHi   = abs(k.pHi_Target - pHi_Current);

Beta_H  = 1 / (1 + (k.K.H / Delta_pHi)^k.alpha_H);
Beta_K  = (1 - Beta_H) * k.Beta_K;
Beta_Cl = (1 - Beta_H) * k.Beta_Cl;
Beta_Na = (1 - Beta_H) * k.Beta_Na;

% Work allocated to each ions [Joule/Liter/second]
Work_H  = Beta_H  * Work;
Work_K  = Beta_K  * Work;
Work_Cl = Beta_Cl * Work;
Work_Na = Beta_Na * Work;

% Corresponding flux of ions moved against the electrochemical gradient [mol/Liter/second]
% If import is not favoured, ie DeltaG > 0, then Work/DeltaG < 0 and pumping mechanisms work
% to import, ie nu_imp > 0 <=> -min(Work/DeltaG,0) > 0.
nu_imp_H  = 0;
nu_imp_K  = 0;
nu_imp_Cl = - min(Work_Cl / DeltaG_Cl , 0);
nu_imp_Na = 0;

% If import is favoured, ie DeltaG < 0, then -Work/DeltaG < 0 and pumping mechanism work to
% export, ie nu_exp > 0 <=> max(Work/DeltaG,0) > 0
nu_exp_H  = max(Work_H  / DeltaG_H  , 0);
nu_exp_K  = max(Work_K  / DeltaG_K  , 0);
nu_exp_Cl = 0;
nu_exp_Na = max(Work_Na / DeltaG_Na , 0);

%% for each reaction - add up contributions to rates of changes

%% Ion Leakage
% H_i <-> H_e;
v1    = k.PB_H  / (k.e * k.z_H) * k.S * k.g_H  * (V_m - V_H) / (k.V * k.NA);  % [mol/Liter/second]
dHdt  = dHdt - v1;

% K_i <-> K_e;
v2    = k.PB_K  / (k.e * k.z_K) * k.S * k.g_K  * (V_m - V_K) / (k.V * k.NA);  % [mol/Liter/second]
dKdt  = dKdt - v2;

% Cl_i <q-> Cl_e;
v3    = k.PB_Cl / (k.e * k.z_Cl) * k.S * k.g_Cl * (V_m - V_Cl) / (k.V * k.NA); % [mol/Liter/second]
dCldt = dCldt - v3;

% H_i <-> H_e;
v4    = k.PB_Na / (k.e * k.z_Na) * k.S * k.g_Na * (V_m - V_Na) / (k.V * k.NA); % [mol/Liter/second]
dNadt = dNadt - v4;

%% Dye movement

v_Dye  = 1 / (k.e * k.z_Dye) * k.S * k.g_Dye  * (V_m - V_Dye) / (k.V * k.NA);
dDyedt = dDyedt - v_Dye;

%% Pumping
% H_i -> H_e; @k.g.Hpump * k.S / k.e * DG_pump
v5     = - k.g.Hpump * k.S / k.e * DG_Hpump / (k.V * k.NA);
dHdt   = dHdt   - v5;
dATPdt = dATPdt - v5;
dADPdt = dADPdt + v5;

% Export postivie ions, import negative ions, Note that current DeltaG is
% for import of positive ions so we have to put a negative sign because pumping work against it.
dHdt  = dHdt  + nu_imp_H  - nu_exp_H;
dKdt  = dKdt  + nu_imp_K  - nu_exp_K;
dCldt = dCldt + nu_imp_Cl - nu_exp_Cl;
dNadt = dNadt + nu_imp_Na - nu_exp_Na;


% v_m = 1e5;
% dKdt = dKdt - K * v_m;
% dCldt = dCldt + 1e-3;
% dNadt = dNadt - Na * v_m;
% dHdt  = dHdt  - H * v_m;
%% Catabolism

% reconstitue ATP from ADP
% ADP -> ATP;
v6     = k.cat / (1 + k.K.cat / ADP) / (k.V * k.NA);
dATPdt = dATPdt + v6;
dADPdt = dADPdt - v6;


%% output vector of rates of change of all variables
dxdt    = [dHdt; dKdt; dCldt; dNadt; dATPdt; dADPdt; dDyedt];