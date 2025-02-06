 addpath('../utils');

clear all 
clc 

%% DADOS
data = readtable('../data/susp_data_regions_rw.csv');

data.data_iniSE = datetime(data.data_iniSE, 'InputFormat', 'yyyy-MM-dd');

[data_2021] = filter_data_by_year(data, 2021); 

%% DADOS temperatura 

data_temp = readtable('../data/clima_regions_rw.csv');

data_temp.date = datetime(data_temp.date, 'InputFormat', 'yyyy-MM-dd');

[data_temp_2021] = filter_data_by_year(data_temp, 2021); 

beta = 'cos';

beta_fp_cos_2021 = table2array(readtable(sprintf('../simulations/sim_FP_%s_real_2021.csv', beta))); 
beta_enkf_cos_2021 = table2array(readtable(sprintf('../simulations/sim_ENKF_%s_real_2021.csv', beta))); 

beta_fp_cos_2021_Q = table2array(readtable(sprintf('../simulations/sim_FP_%s_real_2021_Q_2.csv', beta))); 
beta_enkf_cos_2021_Q = table2array(readtable(sprintf('../simulations/sim_ENKF_%s_real_2021_Q_2.csv', beta))); 


beta = 'mord'; 

beta_fp_mord_2021 = table2array(readtable(sprintf('../simulations/sim_FP_%s_real_2021.csv', beta))); 
beta_enkf_mord_2021 = table2array(readtable(sprintf('../simulations/sim_ENKF_%s_real_2021.csv', beta))); 

beta_fp_mord_2021_Q = table2array(readtable(sprintf('../simulations/sim_FP_%s_real_2021_Q_2.csv', beta))); 
beta_enkf_mord_2021_Q = table2array(readtable(sprintf('../simulations/sim_ENKF_%s_real_2021_Q_2.csv', beta))); 

%% 

figure(1)
ax1 = plot_comp_filters(1, 2, 3, data_2021, ...
    beta_fp_cos_2021, beta_fp_mord_2021, ...
    beta_enkf_cos_2021, beta_enkf_mord_2021, 'casos', 'Cascavel');
title(ax1, 'Cascavel - Q_1')

ax2 = plot_comp_filters(2, 2, 3, data_2021, ...
    beta_fp_cos_2021, beta_fp_mord_2021, ...
    beta_enkf_cos_2021, beta_enkf_mord_2021, 'casos', 'Foz do Iguaçu');
title(ax2, 'Foz do Iguaçu - Q_1')

ax3 = plot_comp_filters(3, 2, 3, data_2021, ...
    beta_fp_cos_2021, beta_fp_mord_2021, ...
    beta_enkf_cos_2021, beta_enkf_mord_2021, 'casos', 'Toledo');
title(ax3, 'Toledo - Q_1')

ax4 = plot_comp_filters(4, 2, 3, data_2021, ...
    beta_fp_cos_2021_Q, beta_fp_mord_2021_Q, ...
    beta_enkf_cos_2021_Q, beta_enkf_mord_2021_Q, 'casos', 'Cascavel');
title(ax4, 'Cascavel - Q_2')

ax5 = plot_comp_filters(5, 2, 3, data_2021, ...
    beta_fp_cos_2021_Q, beta_fp_mord_2021_Q, ...
    beta_enkf_cos_2021_Q, beta_enkf_mord_2021_Q, 'casos', 'Foz do Iguaçu');
title(ax5, 'Foz do Iguaçu - Q_2')

ax6 = plot_comp_filters(6, 2, 3, data_2021, ...
    beta_fp_cos_2021_Q, beta_fp_mord_2021_Q, ...
    beta_enkf_cos_2021_Q, beta_enkf_mord_2021_Q, 'casos', 'Toledo');
title(ax6, 'Toledo - Q_2')

set(ax1, 'Position', [0.05, 0.55, 0.25, 0.35]); % [left, bottom, width, height]
set(ax2, 'Position', [0.35, 0.55, 0.25, 0.35]);
set(ax3, 'Position', [0.65, 0.55, 0.25, 0.35]);
set(ax4, 'Position', [0.05, 0.1, 0.25, 0.35]);
set(ax5, 'Position', [0.35, 0.1, 0.25, 0.35]);
set(ax6, 'Position', [0.65, 0.1, 0.25, 0.35]);

sgtitle('Comparativo de performance com diferentes matrizes Q');

%title('Estimate parameters')

set(gcf,'PaperUnits','inches','PaperPosition',[0 0 18 8])
print(gcf, sprintf('../figures/results_curves_2021.png'), '-dpng'); % Saves tightly

