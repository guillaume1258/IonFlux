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