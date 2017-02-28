k = struct();

% Medium pH
pHe = 7;

% Target pH inside the cell
k.pHi_Target = 7.5;

% Hill parameters for allocation of ATP work to transport of H+
k.K.H     = 0.2;
k.alpha_H = 2;

% Membrane capacitance farad/m^2, ref:  Kahm 2012
k.C_m = 1e2;

% Ion concentration outside, for ionic species H, K, Cl, Na
% Ref, Neidhart 1974, M9 medium, units are Mol/Liter
k.H_e  = 10^-pHe;
k.K_e  = 22    * 1e-3;
k.Cl_e = (28 + 106) * 1e-3;
k.Na_e = (93 + 19)  * 1e-3;

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

% Length & width of E.coli in glucose medium, ref: Basan 2015.
% Units in meter
Celllength = 2.95 * 1e-6;
Cellwidth  = 1.07 * 1e-6;
Cellradius = Cellwidth / 2;

% Surface and volume of E.coli in m^2 & m^3
k.S = 2 * pi * (Cellradius)^2 + 2 * pi * Cellradius * Celllength; 
k.V = pi * Cellradius ^2 * Celllength * 1e3; % 1e3 to convert to liter

% Physical constant
k.k_B = 1.38 * 1e-23; % Boltzmann constant [Joule/Kelvin]
k.T   = 293;          % Temperature [Kelvin]
k.e   = 1.60 * 1e-19; % Elementary charge [Coulombs]
k.NA  = 6.02 * 1e23;  % Avogadro constant [molecule/mol]
k.F   = k.NA * k.e;

% Pump constant
k.v.p     = 0 * 1e5;  % v_max of the pump
k.g.Hpump = 0;        % conductance of the H pump

% Catabolism constant
k.cat      = 0;
k.K.cat    = 1e-3;
nu_ATP     = 1 * 1e10 / 3600;       % ATP/second per cell
k.ATP_Prod = nu_ATP / (k.V * k.NA); % [mol/Liter/second], 1e6 is [molec/second], k.V is volume of a cell, k.NA is [mol^-1]

% Membrane Permeability boolean
k.PB_H  = 1;
k.PB_K  = 1;
k.PB_Cl = 1;
k.PB_Na = 1;

% Dye
k.g_Dye = 0.05;
k.z_Dye = 1;
k.Dye_e = 1e-6;

% Non permeable charges concentration
k.Z = 125 * 1e-3;