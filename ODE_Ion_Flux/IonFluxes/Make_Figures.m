% Make figures related to the model in this file, save them  in folder
% \Figures

%% Figure 1: V_m as function of pHe and ATP expenditure per hour

load('data/Sim_24_02_2017.mat');

figure(1)
hold all
imagesc(v.pHe , v.nu_ATP , v.V_m * 1e3);

h = colorbar;

x_label = xlabel('Medium pH');
y_label = ylabel('ATP invested [molecs/hour/cell]');
c_label = ylabel(h, 'Membrane Potential [mVolt]' , 'rot' , -90);

set(c_label, 'Units', 'Normalized', 'Position', [4 , 0.5, 0])
%set(c_label , 'ylim' , [0 10] * 1e10)

set(gca,'XTick',      v.pHe)
set(gca,'XTickLabel', v.pHe)

set(y_label ,'FontSize',18);
set(x_label ,'FontSize',18);
set(c_label ,'FontSize',18);
set(gca , 'FontSize' , 18)

xlim([5 7])
ylim([0 20] * 1e9)


grid off

print(gcf , 'Figures/Cmap_Vm_pHe_ATPFlow.eps' , '-dpsc2')

%% Figure 2: PMF as function of pHe and ATP expenditure per hour

figure(2)
hold all
imagesc(v.pHe , v.nu_ATP , v.PMF * 1e3);

h = colorbar;

x_label = xlabel('Medium pH');
y_label = ylabel('ATP invested [molecs/hour/cell]');
c_label = ylabel(h, 'PMF [mVolt]' , 'rot' , -90);

set(c_label, 'Units', 'Normalized', 'Position', [4 , 0.5, 0])
%set(c_label , 'ylim' , [0 10] * 1e10)

set(gca,'XTick',      v.pHe)
set(gca,'XTickLabel', v.pHe)

set(y_label ,'FontSize',18);
set(x_label ,'FontSize',18);
set(c_label ,'FontSize',18);
set(gca , 'FontSize' , 18)

xlim([5 7])
ylim([0 20] * 1e9)


grid off

print(gcf , 'Figures/Cmap_PMF_pHe_ATPFlow.eps' , '-dpsc2')

%% Figure 3: DeltapHi as function of pHe and ATP expenditure per hour

figure(3)
hold all
imagesc(v.pHe , v.nu_ATP , v.DeltapHi);

h = colorbar;

x_label = xlabel('Medium pH');
y_label = ylabel('ATP invested [molecs/hour/cell]');
c_label = ylabel(h, '\Delta pH_i' , 'rot' , -90);

set(c_label, 'Units', 'Normalized', 'Position', [4 , 0.5, 0])
%set(c_label , 'ylim' , [0 10] * 1e10)

set(gca,'XTick',      v.pHe)
set(gca,'XTickLabel', v.pHe)

set(y_label ,'FontSize',18);
set(x_label ,'FontSize',18);
set(c_label ,'FontSize',18);
set(gca , 'FontSize' , 18)

xlim([5 7])
ylim([0 20] * 1e9)


grid off

print(gcf , 'Figures/Cmap_DeltapHi_pHe_ATPFlow.eps' , '-dpsc2')

%% Figure 4: DeltaG_H/DeltaG_K as function of pHe and ATP expenditure per hour

figure(4)
hold all
imagesc(v.pHe , v.nu_ATP , v.DeltaG_H ./ v.DeltaG_K );

h = colorbar;

x_label = xlabel('Medium pH');
y_label = ylabel('ATP invested [molecs/hour/cell]');
c_label = ylabel(h, '\Delta G_H / \Delta G_K' , 'rot' , -90);

set(c_label, 'Units', 'Normalized', 'Position', [4 , 0.5, 0])
%set(c_label , 'ylim' , [0 10] * 1e10)

set(gca,'XTick',      v.pHe)
set(gca,'XTickLabel', v.pHe)

set(y_label ,'FontSize',18);
set(x_label ,'FontSize',18);
set(c_label ,'FontSize',18);
set(gca , 'FontSize' , 18)

xlim([5 7])
ylim([0 20] * 1e9)


grid off

print(gcf , 'Figures/Cmap_DeltaG_H_ratio_DeltaG_K_pHe_ATPFlow.eps' , '-dpsc2')

%% Figure 5: Ratio [Ion]_i/[Ion]_o for different [Z]_i given pHe, at equilibrium
% Also V_m associated

figure(5)
subplot(2 , 1 , 1) 
hold all
h1 = plot(v.Z * 1e3 , v.H_i  / k.H_e  , 'cyan'  , 'LineWidth' , 3);
h2 = plot(v.Z * 1e3 , v.K_i  / k.K_e  , 'green' , 'LineWidth' , 3);
h3 = plot(v.Z * 1e3 , v.Na_i / k.Na_e , 'blue'  , 'LineWidth' , 3);
h4 = plot(v.Z * 1e3 , v.Cl_i / k.Cl_e , 'red'   , 'LineWidth' , 3);

y_label = ylabel('Ratio [Ion]_i / [Ion]_o');

[hleg1, hobj1] = legend([h4 , h3], 'Cl^-' , 'H^+, K^+, Na^+');
set(hleg1, 'position' , [0.1 0.8 0.4 0.17])

set(y_label ,'FontSize',18);
set(gca , 'FontSize' , 18)

ylim([0 2.5])

grid on

subplot(2 , 1 , 2)
plot(v.Z * 1e3 , v.V_m * 1e3 , 'LineWidth' , 3)

grid on

x_label = xlabel('Intracellular Non Permeable Anions [mM] ');
y_label = ylabel('Membrane Potential [mV]');

set(y_label ,'FontSize',18);
set(x_label ,'FontSize',18);
set(gca , 'Fontsize' , 18);

print(gcf , 'Figures/Ratio_Ion_in_out_Different_Z.eps' , '-dpsc2')