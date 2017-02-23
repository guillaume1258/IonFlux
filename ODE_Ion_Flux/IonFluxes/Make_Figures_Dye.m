%% Figure 1: Time dynamics of the dye as function of external concentration

figure(1)

hold all
for i = 1 : 5
    
    h(i) = plot(TimeDynamics(i).t / 60 , TimeDynamics(i).Dye * 1e3 , 'LineWidth' , 3);
    
end


x_label = xlabel('Time [minutes]' , 'fontsize' , 18);
y_label = ylabel('Internal Dye concentration [mM]' , 'fontsize' , 18); 

xlim([0 20])

[hleg1, hobj1] = legend(h, '[Dye]_e = 1\muM' , '[Dye]_e = 5\muM' , ...
    '[Dye]_e = 10\muM' , '[Dye]_e = 20\muM' , '[Dye]_e = 50\muM');
set(hleg1, 'position' , [0.1 0.6 0.5 0.35])

grid on

set(gca , 'fontsize' , 18)

print(gcf , 'Figures/Dyei_Dynamics_Various_ExternalConcentrations.eps' , '-dpsc2')

%% Figure 2: Time dynamics of the dye as function of conductance for external concentration of 10 micromolar

figure(2)

hold all
for i = 1 : 5
    
    h(i) = plot(TimeDynamics(i).t / 60 , TimeDynamics(i).Dye * 1e3 , 'LineWidth' , 3);
    
end


x_label = xlabel('Time [minutes]' , 'fontsize' , 18);
y_label = ylabel('Internal Dye concentration [mM]' , 'fontsize' , 18); 

xlim([0 20])

ylim([0 22])

[hleg1, hobj1] = legend(h, 'g_{Dye} = 0.1 S/m^2' , 'g_{Dye} = 1 S/m^2' , ...
    'g_{Dye} = 5 S/m^2' , 'g_{Dye} = 10 S/m^2' , 'g_{Dye} = 25 S/m^2');
set(hleg1, 'position' , [0.1 0.45 0.45 0.6])

grid on

set(gca , 'fontsize' , 18)

print(gcf , 'Figures/Dyei_Dynamics_Various_conductance.eps' , '-dpsc2')
