%% For a given data set generated for fixed nu_ATP and dye conductivity, plot
% Impact on Osmotic pressure (%), Impact on V_m (%) and Load time as function
% of dye conductivity and extracellular concentration

clear all

figure(1)

% subplot 1
h1 = subplot(2 , 2 , 1);
load('data/27022017_DyeData_pHe=7_nuATP=5000000000.mat')

imagesc(log10(v.Dye_e) , log10(v.g_Dye) , v.V_m' / v.V_m(1 , 1) * 100);

xlim(log10([v.Dye_e(1) , v.Dye_e(end)]))
ylim(log10([v.g_Dye(1) , v.g_Dye(end)]))
caxis([0.7 1] * 100)


title_s1 = title('\nu_{ATP} = 5.10^9 ATP/hour, pHe = 7' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

% subplot 2
h2 = subplot(2 , 2 , 2);
load('data/27022017_DyeData_pHe=7_nuATP=20000000000.mat')

imagesc(log10(v.Dye_e) , log10(v.g_Dye) , v.V_m' / v.V_m(1 , 1) * 100);

xlim(log10([v.Dye_e(1) , v.Dye_e(end)]))
ylim(log10([v.g_Dye(1) , v.g_Dye(end)]))
caxis([0.7 1] * 100)

title_s2 = title('\nu_{ATP} = 20.10^9 ATP/hour, pHe = 7' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

% subplot 3
h3 = subplot(2 , 2 , 3);
load('data/27022017_DyeData_pHe=5.500000e+00_nuATP=5000000000.mat')

imagesc(log10(v.Dye_e) , log10(v.g_Dye) , v.V_m' / v.V_m(1 , 1) * 100);

xlim(log10([v.Dye_e(1) , v.Dye_e(end)]))
ylim(log10([v.g_Dye(1) , v.g_Dye(end)]))
caxis([0.7 1] * 100)

title_s3 = title('\nu_{ATP} = 5.10^9 ATP/hour, pHe = 5.5' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

% subplot 4
h4 = subplot(2 , 2 , 4);
load('data/27022017_DyeData_pHe=5.500000e+00_nuATP=20000000000.mat');

imagesc(log10(v.Dye_e) , log10(v.g_Dye) , v.V_m' / v.V_m(1 , 1) * 100);

xlim(log10([v.Dye_e(1) , v.Dye_e(end)]))
ylim(log10([v.g_Dye(1) , v.g_Dye(end)]))
caxis([0.7 1] * 100)

title_s4 = title('\nu_{ATP} = 20.10^9 ATP/hour, pHe = 5.5' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

cbar = colorbar;

y_label = ylabel('log_{10}(Dye Conductance) [Siemens/m^2]' , 'fontsize' , 18);
x_label = xlabel('log_{10}(Medium pH)' , 'fontsize' , 18);

posx=get(x_label,'Pos');
set(x_label,'Pos',[-8 0.6 posx(3)])

posy=get(y_label,'Pos');
set(y_label,'Pos',[-15.5 -4 1])

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
c_label = ylabel(cbar, 'Membrane Potential [%]' , 'rot' , -90 , 'position' , [10 0.865 * 100 1]);

set(c_label , 'fontsize' , 18)
%set(c_label , 'position' , [0.9 , 0.5 10])
set(gca , 'fontsize' , 14)

print(gcf , 'Figures/Dye_Delta_Vm.eps' , '-dpsc2')

%% Figure 2: Variation in osmotic pressure
figure(2)
% subplot 1
h1 = subplot(2 , 2 , 1);
load('data/27022017_DyeData_pHe=7_nuATP=5000000000.mat')

imagesc(log10(v.Dye_e) , log10(v.g_Dye) , log10(v.OsmoticP' / v.OsmoticP(1 , 1) * 100));

xlim(log10([v.Dye_e(1) , v.Dye_e(end)]))
ylim(log10([v.g_Dye(1) , v.g_Dye(end)]))
caxis([2 4])


title_s1 = title('\nu_{ATP} = 5.10^9 ATP/hour, pHe = 7' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

% subplot 2
h2 = subplot(2 , 2 , 2);
load('data/27022017_DyeData_pHe=7_nuATP=20000000000.mat')

imagesc(log10(v.Dye_e) , log10(v.g_Dye) , log10(v.OsmoticP' / v.OsmoticP(1 , 1) * 100));

xlim(log10([v.Dye_e(1) , v.Dye_e(end)]))
ylim(log10([v.g_Dye(1) , v.g_Dye(end)]))
caxis([2 4])

title_s2 = title('\nu_{ATP} = 20.10^9 ATP/hour, pHe = 7' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

% subplot 3
h3 = subplot(2 , 2 , 3);
load('data/27022017_DyeData_pHe=5.500000e+00_nuATP=5000000000.mat')

imagesc(log10(v.Dye_e) , log10(v.g_Dye) , log10(v.OsmoticP' / v.OsmoticP(1 , 1) * 100));

xlim(log10([v.Dye_e(1) , v.Dye_e(end)]))
ylim(log10([v.g_Dye(1) , v.g_Dye(end)]))
caxis([2 4])

title_s3 = title('\nu_{ATP} = 5.10^9 ATP/hour, pHe = 5.5' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

% subplot 4
h4 = subplot(2 , 2 , 4);
load('data/27022017_DyeData_pHe=5.500000e+00_nuATP=20000000000.mat');

imagesc(log10(v.Dye_e) , log10(v.g_Dye) , log10(v.OsmoticP' / v.OsmoticP(1 , 1) * 100));

xlim(log10([v.Dye_e(1) , v.Dye_e(end)]))
ylim(log10([v.g_Dye(1) , v.g_Dye(end)]))
caxis([2 4])

title_s4 = title('\nu_{ATP} = 20.10^9 ATP/hour, pHe = 5.5' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

cbar = colorbar;

y_label = ylabel('log_{10}(Dye Conductance) [Siemens/m^2]' , 'fontsize' , 18);
x_label = xlabel('log_{10}(Medium pH)' , 'fontsize' , 18);

posx=get(x_label,'Pos');
set(x_label,'Pos',[-8 0.6 posx(3)])

posy=get(y_label,'Pos');
set(y_label,'Pos',[-15.5 -4 1])

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
c_label = ylabel(cbar, 'log_{10}(Osmotic Pressure) [%]' , 'rot' , -90 , 'position' , [10 2.865 1]);

set(c_label , 'fontsize' , 18)
%set(c_label , 'position' , [0.9 , 0.5 10])
set(gca , 'fontsize' , 14)

print(gcf , 'Figures/Dye_Delta_OsmoticPressure.eps' , '-dpsc2')

%% Figure 3: Loading Time
figure(3)
% subplot 1
h1 = subplot(2 , 2 , 1);
load('data/27022017_DyeData_pHe=7_nuATP=5000000000.mat')

imagesc(log10(v.Dye_e) , log10(v.g_Dye) , log10(v.LoadingTime'));

xlim(log10([v.Dye_e(1) , v.Dye_e(end)]))
ylim(log10([v.g_Dye(1) , v.g_Dye(end)]))
caxis([0 7])


title_s1 = title('\nu_{ATP} = 5.10^9 ATP/hour, pHe = 7' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

% subplot 2
h2 = subplot(2 , 2 , 2);
load('data/27022017_DyeData_pHe=7_nuATP=20000000000.mat')

imagesc(log10(v.Dye_e) , log10(v.g_Dye) , log10(v.LoadingTime'));

xlim(log10([v.Dye_e(1) , v.Dye_e(end)]))
ylim(log10([v.g_Dye(1) , v.g_Dye(end)]))
caxis([0 7])

title_s2 = title('\nu_{ATP} = 20.10^9 ATP/hour, pHe = 7' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

% subplot 3
h3 = subplot(2 , 2 , 3);
load('data/27022017_DyeData_pHe=5.500000e+00_nuATP=5000000000.mat')

imagesc(log10(v.Dye_e) , log10(v.g_Dye) , log10(v.LoadingTime'));

xlim(log10([v.Dye_e(1) , v.Dye_e(end)]))
ylim(log10([v.g_Dye(1) , v.g_Dye(end)]))
caxis([0 7])

title_s3 = title('\nu_{ATP} = 5.10^9 ATP/hour, pHe = 5.5' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

% subplot 4
h4 = subplot(2 , 2 , 4);
load('data/27022017_DyeData_pHe=5.500000e+00_nuATP=20000000000.mat');

imagesc(log10(v.Dye_e) , log10(v.g_Dye) , log10(v.LoadingTime'));

xlim(log10([v.Dye_e(1) , v.Dye_e(end)]))
ylim(log10([v.g_Dye(1) , v.g_Dye(end)]))
caxis([0 7])

title_s4 = title('\nu_{ATP} = 20.10^9 ATP/hour, pHe = 5.5' , 'fontsize' , 13);

set(gca , 'fontsize' , 14)

grid off

cbar = colorbar;

y_label = ylabel('log_{10}(Dye Conductance) [Siemens/m^2]' , 'fontsize' , 18);
x_label = xlabel('log_{10}(Medium pH)' , 'fontsize' , 18);

posx=get(x_label,'Pos');
set(x_label,'Pos',[-8 0.6 posx(3)])

posy=get(y_label,'Pos');
set(y_label,'Pos',[-15.5 -4 1])

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
c_label = ylabel(cbar, 'log_{10}(Loading Time) [seconds]' , 'rot' , -90 , 'position' , [8 3 1]);

set(c_label , 'fontsize' , 18)
%set(c_label , 'position' , [0.9 , 0.5 10])
set(gca , 'fontsize' , 14)

print(gcf , 'Figures/Dye_Delta_LoadingTime.eps' , '-dpsc2')
