%% For a given data set generated for fixed dye conductivity and concentration,
% as well as allocation of ATP work to different ions, plot
% Impact on Osmotic pressure (%), Impact on V_m (%) and Load time as function
% of nu_ATP and pHe 

clear all

figure(1)

% subplot 1
h1 = subplot(2 , 2 , 1);
load('data/28022017_DyeData_BetaK=3.333333e-01_BetaNa=3.333333e-01_BetaCl=3.333333e-01.mat')

imagesc((v.pHe) , (v.nu_ATP) / 1e9 , v.V_m' * 1e3);

xlim([v.pHe(1)   , v.pHe(end)])
ylim([v.nu_ATP(1) , v.nu_ATP(end)] / 1e9)
caxis([-300 0])


title_s1 = title('\beta_K = \beta_{Na} = \beta_{Cl} = 1/3' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

% subplot 2
h2 = subplot(2 , 2 , 2);
load('data/28022017_DyeData_BetaK=6.666667e-01_BetaNa=1.666667e-01_BetaCl=1.666667e-01.mat')

imagesc(v.pHe , v.nu_ATP / 1e9, v.V_m' * 1e3);

xlim([v.pHe(1)   , v.pHe(end)])
ylim([v.nu_ATP(1) , v.nu_ATP(end)] / 1e9)
caxis([-300 0])

title_s2 = title('\beta_{Na} = \beta_{Cl} = 1/6, \beta_K = 4/6' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

% subplot 3
h3 = subplot(2 , 2 , 3);
load('data/28022017_DyeData_BetaK=1.666667e-01_BetaNa=6.666667e-01_BetaCl=1.666667e-01.mat')

imagesc(v.pHe , v.nu_ATP / 1e9 , v.V_m' * 1e3);

xlim([v.pHe(1)   , v.pHe(end)])
ylim([v.nu_ATP(1) , v.nu_ATP(end)] / 1e9)
caxis([-300 0])

title_s3 = title('\beta_K = \beta_{Cl} = 1/6, \beta_{Na} = 4/6' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

% subplot 4
h4 = subplot(2 , 2 , 4);
load('data/28022017_DyeData_BetaK=1.666667e-01_BetaNa=1.666667e-01_BetaCl=6.666667e-01.mat');

imagesc(v.pHe , v.nu_ATP / 1e9 , v.V_m' * 1e3);

xlim([v.pHe(1)   , v.pHe(end)])
ylim([v.nu_ATP(1) , v.nu_ATP(end)] / 1e9)
caxis([-300 0])

title_s4 = title('\beta_K = \beta_{Na} = 1/6, \beta_{Cl} = 4/6' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

cbar = colorbar;

y_label = ylabel('ATP invested [ATP/hour/cell] * 1e9' , 'fontsize' , 18);
x_label = xlabel('Medium pH' , 'fontsize' , 18);

posx=get(x_label,'Pos');
set(x_label,'Pos',[4.8 2.4e1 posx(3)])

posy=get(y_label,'Pos');
set(y_label,'Pos',[2 -0.5e1 posy(3)])

set(cbar    , 'Position' , [0.85 , 0.1 , 0.04 , 0.8])

% Rescale size of subplot
RescalingSize = 0.9;

% Step 2: get current position
p1 = get(h1 , 'position');
p2 = get(h2 , 'position');
p3 = get(h3 , 'position');
p4 = get(h4 , 'position');

% Step 2: update position/size
p1(3) = p1(3) * RescalingSize;
p1(4) = p1(4) * RescalingSize;

p2(3) = p2(3) * RescalingSize;
p2(4) = p2(4) * RescalingSize;

p3(3) = p3(3) * RescalingSize;
p3(4) = p3(4) * RescalingSize;

p4(3) = p4(3) * RescalingSize;
p4(4) = p4(4) * RescalingSize;

% Step3: Impose rescaling
set(h1 , 'position' , p1) 
set(h2 , 'position' , p2) 
set(h3 , 'position' , p3) 
set(h4 , 'position' , p4) 

% Move slightly left subplot 2 & 4
MoveLeft = 0.9;

p2(1) = p2(1) * MoveLeft;
p4(1) = p4(1) * MoveLeft;

set(h2 , 'position' , p2)
set(h4 , 'position' , p4)

% Label colorbar
c_label = ylabel(cbar, 'Membrane Potential [mVolts]' , 'rot' , -90 , 'position' , [10 -150 1]);

set(c_label , 'fontsize' , 18)
%set(c_label , 'position' , [0.9 , 0.5 10])
set(gca , 'fontsize' , 14)

print(gcf , 'Figures/Dye_Vm_Allocation.eps' , '-dpsc2')

%% Figure 2: Variation in osmotic pressure
figure(2)

% subplot 1
h1 = subplot(2 , 2 , 1);
load('data/28022017_DyeData_BetaK=3.333333e-01_BetaNa=3.333333e-01_BetaCl=3.333333e-01.mat')

imagesc((v.pHe) , (v.nu_ATP) / 1e9 , log10(v.OsmoticP' / 1e2));

xlim([v.pHe(1)   , v.pHe(end)])
ylim([v.nu_ATP(1) , v.nu_ATP(end)] / 1e9)
caxis([-1 3])


title_s1 = title('\beta_K = \beta_{Na} = \beta_{Cl} = 1/3' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

% subplot 2
h2 = subplot(2 , 2 , 2);
load('data/28022017_DyeData_BetaK=6.666667e-01_BetaNa=1.666667e-01_BetaCl=1.666667e-01.mat')

imagesc(v.pHe , v.nu_ATP / 1e9 , log10(v.OsmoticP' / 1e2));

xlim([v.pHe(1)   , v.pHe(end)])
ylim([v.nu_ATP(1) , v.nu_ATP(end)] / 1e9)
caxis([-1 3])

title_s2 = title('\beta_K = 4/6, \beta_{Na} = \beta_{Cl} = 1/6' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

% subplot 3
h3 = subplot(2 , 2 , 3);
load('data/28022017_DyeData_BetaK=1.666667e-01_BetaNa=6.666667e-01_BetaCl=1.666667e-01.mat')

imagesc(v.pHe , v.nu_ATP / 1e9 , log10(v.OsmoticP' / 1e2));

xlim([v.pHe(1)   , v.pHe(end)])
ylim([v.nu_ATP(1) , v.nu_ATP(end)] / 1e9)
caxis([-1 3])

title_s1 = title('\beta_K = \beta_{Cl} = 1/6 \beta_{Na} = 4/6' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

% subplot 4
h4 = subplot(2 , 2 , 4);
load('data/28022017_DyeData_BetaK=1.666667e-01_BetaNa=1.666667e-01_BetaCl=6.666667e-01.mat');

imagesc(v.pHe , v.nu_ATP / 1e9 , log10(v.OsmoticP' / 1e2));

xlim([v.pHe(1)   , v.pHe(end)])
ylim([v.nu_ATP(1) , v.nu_ATP(end)] / 1e9)
caxis([-1 3])

title_s4 = title('\beta_K = \beta_{Na} = 1/6, \beta_{Cl} = 4/6' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

cbar = colorbar;

y_label = ylabel('ATP invested [ATP/hour/cell] * 1e9' , 'fontsize' , 18);
x_label = xlabel('Medium pH' , 'fontsize' , 18);

posx=get(x_label,'Pos');
set(x_label,'Pos',[4.8 23.5 posx(3)])

posy=get(y_label,'Pos');
set(y_label,'Pos',[2.1 -1 posy(3)])

set(cbar    , 'Position' , [0.85 , 0.1 , 0.04 , 0.8])

% Rescale size of subplot
RescalingSize = 0.9;

% Step 2: get current position
p1 = get(h1 , 'position');
p2 = get(h2 , 'position');
p3 = get(h3 , 'position');
p4 = get(h4 , 'position');

% Step 2: update position/size
p1(3) = p1(3) * RescalingSize;
p1(4) = p1(4) * RescalingSize;

p2(3) = p2(3) * RescalingSize;
p2(4) = p2(4) * RescalingSize;

p3(3) = p3(3) * RescalingSize;
p3(4) = p3(4) * RescalingSize;

p4(3) = p4(3) * RescalingSize;
p4(4) = p4(4) * RescalingSize;

% Step3: Impose rescaling
set(h1 , 'position' , p1) 
set(h2 , 'position' , p2) 
set(h3 , 'position' , p3) 
set(h4 , 'position' , p4) 

% Move slightly left subplot 2 & 4
MoveLeft = 0.9;

p2(1) = p2(1) * MoveLeft;
p4(1) = p4(1) * MoveLeft;

set(h2 , 'position' , p2)
set(h4 , 'position' , p4)

% Label colorbar
c_label = ylabel(cbar, 'log_{10}(Osmotic Pressure) [Atmospheres]' , 'rot' , -90 , 'position' , [10 1 1]);

set(c_label , 'fontsize' , 18)
%set(c_label , 'position' , [0.9 , 0.5 10])
set(gca , 'fontsize' , 14)

print(gcf , 'Figures/Dye_Delta_OsmoPressure_Allocation.eps' , '-dpsc2')

%% Figure 3: Loading Time
figure(3)

% subplot 1
h1 = subplot(2 , 2 , 1);
load('data/28022017_DyeData_BetaK=3.333333e-01_BetaNa=3.333333e-01_BetaCl=3.333333e-01.mat')

imagesc((v.pHe) , (v.nu_ATP) / 1e9 , log10(v.LoadingTime'));

xlim([v.pHe(1)   , v.pHe(end)])
ylim([v.nu_ATP(1) , v.nu_ATP(end)] / 1e9)
caxis([0 5])


title_s1 = title('\beta_K = \beta_{Na} = \beta_{Cl} = 1/3' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

% subplot 2
h2 = subplot(2 , 2 , 2);
load('data/28022017_DyeData_BetaK=6.666667e-01_BetaNa=1.666667e-01_BetaCl=1.666667e-01.mat')

imagesc(v.pHe , v.nu_ATP / 1e9 , log10(v.LoadingTime'));

xlim([v.pHe(1)   , v.pHe(end)])
ylim([v.nu_ATP(1) , v.nu_ATP(end)] / 1e9)
caxis([0 5])

title_s2 = title('\beta_K = 4/6, \beta_{Na} = \beta_{Cl} = 1/6' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

% subplot 3
h3 = subplot(2 , 2 , 3);
load('data/28022017_DyeData_BetaK=1.666667e-01_BetaNa=6.666667e-01_BetaCl=1.666667e-01.mat')

imagesc(v.pHe , v.nu_ATP / 1e9 , log10(v.LoadingTime'));

xlim([v.pHe(1)   , v.pHe(end)])
ylim([v.nu_ATP(1) , v.nu_ATP(end)] / 1e9)
caxis([0 5])

title_s1 = title('\beta_K = \beta_{Cl} = 1/6 \beta_{Na} = 4/6' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

% subplot 4
h4 = subplot(2 , 2 , 4);
load('data/28022017_DyeData_BetaK=1.666667e-01_BetaNa=1.666667e-01_BetaCl=6.666667e-01.mat');

imagesc(v.pHe , v.nu_ATP / 1e9 , log10(v.LoadingTime'));

xlim([v.pHe(1)   , v.pHe(end)])
ylim([v.nu_ATP(1) , v.nu_ATP(end)]  / 1e9)
caxis([0 5])

title_s4 = title('\beta_K = \beta_{Na} = 1/6, \beta_{Cl} = 4/6' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

cbar = colorbar;

y_label = ylabel('ATP invested [ATP/hour/cell] * 1e9' , 'fontsize' , 18);
x_label = xlabel('Medium pH' , 'fontsize' , 18);

posx=get(x_label,'Pos');
set(x_label,'Pos',[4.8 23 posx(3)])

posy=get(y_label,'Pos');
set(y_label,'Pos',[2 -4 1])

set(cbar    , 'Position' , [0.85 , 0.1 , 0.04 , 0.8])

% Rescale size of subplot
RescalingSize = 0.9;

% Step 2: get current position
p1 = get(h1 , 'position');
p2 = get(h2 , 'position');
p3 = get(h3 , 'position');
p4 = get(h4 , 'position');

% Step 2: update position/size
p1(3) = p1(3) * RescalingSize;
p1(4) = p1(4) * RescalingSize;

p2(3) = p2(3) * RescalingSize;
p2(4) = p2(4) * RescalingSize;

p3(3) = p3(3) * RescalingSize;
p3(4) = p3(4) * RescalingSize;

p4(3) = p4(3) * RescalingSize;
p4(4) = p4(4) * RescalingSize;

% Step3: Impose rescaling
set(h1 , 'position' , p1) 
set(h2 , 'position' , p2) 
set(h3 , 'position' , p3) 
set(h4 , 'position' , p4) 

% Move slightly left subplot 2 & 4
MoveLeft = 0.9;

p2(1) = p2(1) * MoveLeft;
p4(1) = p4(1) * MoveLeft;

set(h2 , 'position' , p2)
set(h4 , 'position' , p4)

% Label colorbar
c_label = ylabel(cbar, 'log_{10}(Loading Time) [seconds]' , 'rot' , -90 , 'position' , [10 2.5 1]);

set(c_label , 'fontsize' , 18)
%set(c_label , 'position' , [0.9 , 0.5 10])
set(gca , 'fontsize' , 14)

print(gcf , 'Figures/Dye_LoadingTime_Allocation.eps' , '-dpsc2')

%% Figure 4: Intracellular dye concentration

figure(4)

% subplot 1
h1 = subplot(2 , 2 , 1);
load('data/28022017_DyeData_BetaK=3.333333e-01_BetaNa=3.333333e-01_BetaCl=3.333333e-01.mat')

imagesc((v.pHe) , (v.nu_ATP) / 1e9 , log10(v.Dye_i' * 1e3));

xlim([v.pHe(1)   , v.pHe(end)])
ylim([v.nu_ATP(1) , v.nu_ATP(end)] / 1e9)
caxis([-3 3])


title_s1 = title('\beta_K = \beta_{Na} = \beta_{Cl} = 1/3' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

% subplot 2
h2 = subplot(2 , 2 , 2);
load('data/28022017_DyeData_BetaK=6.666667e-01_BetaNa=1.666667e-01_BetaCl=1.666667e-01.mat')

imagesc(v.pHe , v.nu_ATP /  1e9 , log10(v.Dye_i' * 1e3));

xlim([v.pHe(1)   , v.pHe(end)])
ylim([v.nu_ATP(1) , v.nu_ATP(end)] / 1e9)
caxis([-3 3])

title_s2 = title('\beta_K = 4/6, \beta_{Na} = \beta_{Cl} = 1/6' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

% subplot 3
h3 = subplot(2 , 2 , 3);
load('data/28022017_DyeData_BetaK=1.666667e-01_BetaNa=6.666667e-01_BetaCl=1.666667e-01.mat')

imagesc(v.pHe , v.nu_ATP / 1e9 , log10(v.Dye_i' * 1e3));

xlim([v.pHe(1)   , v.pHe(end)])
ylim([v.nu_ATP(1) , v.nu_ATP(end)] / 1e9)
caxis([-3 3])

title_s1 = title('\beta_K = \beta_{Cl} = 1/6 \beta_{Na} = 4/6' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

% subplot 4
h4 = subplot(2 , 2 , 4);
load('data/28022017_DyeData_BetaK=1.666667e-01_BetaNa=1.666667e-01_BetaCl=6.666667e-01.mat');

imagesc(v.pHe , v.nu_ATP / 1e9, log10(v.Dye_i' * 1e3));

xlim([v.pHe(1)   , v.pHe(end)])
ylim([v.nu_ATP(1) , v.nu_ATP(end)] / 1e9)
caxis([-3 3])

title_s4 = title('\beta_K = \beta_{Na} = 1/6, \beta_{Cl} = 4/6' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

cbar = colorbar;

y_label = ylabel('ATP invested [ATP/hour/cell] * 1e9' , 'fontsize' , 18);
x_label = xlabel('Medium pH' , 'fontsize' , 18);

posx=get(x_label,'Pos');
set(x_label,'Pos',[4.8 23 posx(3)])

posy=get(y_label,'Pos');
set(y_label,'Pos',[2 -4 1])

set(cbar    , 'Position' , [0.85 , 0.1 , 0.04 , 0.8])

% Rescale size of subplot
RescalingSize = 0.9;

% Step 2: get current position
p1 = get(h1 , 'position');
p2 = get(h2 , 'position');
p3 = get(h3 , 'position');
p4 = get(h4 , 'position');

% Step 2: update position/size
p1(3) = p1(3) * RescalingSize;
p1(4) = p1(4) * RescalingSize;

p2(3) = p2(3) * RescalingSize;
p2(4) = p2(4) * RescalingSize;

p3(3) = p3(3) * RescalingSize;
p3(4) = p3(4) * RescalingSize;

p4(3) = p4(3) * RescalingSize;
p4(4) = p4(4) * RescalingSize;

% Step3: Impose rescaling
set(h1 , 'position' , p1) 
set(h2 , 'position' , p2) 
set(h3 , 'position' , p3) 
set(h4 , 'position' , p4) 

% Move slightly left subplot 2 & 4
MoveLeft = 0.9;

p2(1) = p2(1) * MoveLeft;
p4(1) = p4(1) * MoveLeft;

set(h2 , 'position' , p2)
set(h4 , 'position' , p4)

% Label colorbar
c_label = ylabel(cbar, 'log_{10}(Intracellular dye concentration) [mM]' , 'rot' , -90 , 'position' , [10 0 1]);

set(c_label , 'fontsize' , 18)
%set(c_label , 'position' , [0.9 , 0.5 10])
set(gca , 'fontsize' , 14)

print(gcf , 'Figures/Dye_IntraConcentration_Allocation.eps' , '-dpsc2')
