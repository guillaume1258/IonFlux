% Time dynamics of each specie
H_i  = result(:,1);    % a = first column of result
K_i  = result(:,2);    % b = second column of result
Cl_i = result(:,3);    % ... 
Na_i = result(:,4);
ATP  = result(:,5);
ADP  = result(:,6);

% Membrane potentials
V_m = k.e * k.NA * k.V / (k.S * k.C_m) * (H_i + K_i - Cl_i + Na_i - k.Z);

% Nernst potentials
Nernst = @(z , c_i , c_e) k.k_B * k.T ./ (z * k.e) * log(c_e ./ c_i);

V_H  = Nernst(k.z_H  , H_i  , k.H_e);
V_K  = Nernst(k.z_K  , K_i  , k.K_e);
V_Cl = Nernst(k.z_Cl , Cl_i , k.Cl_e);
V_Na = Nernst(k.z_Na , Na_i , k.Na_e);

% Proton Motive Force
PMF = V_m - V_H;

% Delta G ATP [Joule/mol]
DeltaG_ATP = k.k_B * k.T / k.e * log(ADP./ATP) * k.F;

% Available work [Joule/Liter/second]
Work = DeltaG_ATP * k.ATP_Prod;

% Delta G of ions [Joule/mol]
DeltaG = @(z , V_m , V_eq) z * k.F * (V_m - V_eq);

DeltaG_H  = DeltaG(k.z_H  , V_m , V_H);
DeltaG_K  = DeltaG(k.z_H  , V_m , V_K);
DeltaG_Cl = DeltaG(k.z_Cl , V_m , V_Cl);
DeltaG_Na = DeltaG(k.z_Na , V_m , V_Na);

% Work allocation in % of total work allocated to membrane potential
% maintenance, must sum up to 1
pHi_Current = -log10(H_i);
Delta_pHi   = abs(k.pHi_Target - pHi_Current);

Beta_H  = 1 / (1 + (k.K.H ./ Delta_pHi).^k.alpha_H);
Beta_K  = (1 - Beta_H)/3;
Beta_Cl = (1 - Beta_H)/3;
Beta_Na = (1 - Beta_H)/3;

% Osmotic pressure along time, [Joule/Liter] or [Pascal * 1e3] 
P_e   = k.NA * k.k_B * k.T * (k.H_e + k.K_e + k.Cl_e + k.Na_e + k.X_o); % Osmolarity of the medium
P_i   = k.NA * k.k_B * k.T * (H_i   + K_i   + Cl_i   + Na_i   + k.X_i); % Osmolarity of the cell
OP    = P_i - P_e;                                                      % Osmotic pressure is the difference between the 2 osmolarities