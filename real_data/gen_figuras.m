 addpath('../utils');

clear all 
clc 

%% DADOS
data = readtable('../data/susp_data_regions_rw.csv');

data.data_iniSE = datetime(data.data_iniSE, 'InputFormat', 'yyyy-MM-dd');

[data_2019] = filter_data_by_year(data, 2019); 
[data_2020] = filter_data_by_year(data, 2020); 
[data_2021] = filter_data_by_year(data, 2021); 
[data_2022] = filter_data_by_year(data, 2022); 
[data_2023] = filter_data_by_year(data, 2023); 
[data_2024] = filter_data_by_year(data, 2024); 

%% DADOS temperatura 

data_temp = readtable('../data/clima_regions_rw.csv');

data_temp.date = datetime(data_temp.date, 'InputFormat', 'yyyy-MM-dd');

[data_temp_2019] = filter_data_by_year(data_temp, 2019); 
[data_temp_2020] = filter_data_by_year(data_temp, 2020); 
[data_temp_2021] = filter_data_by_year(data_temp, 2021); 
[data_temp_2022] = filter_data_by_year(data_temp, 2022); 
[data_temp_2023] = filter_data_by_year(data_temp, 2023); 
[data_temp_2024] = filter_data_by_year(data_temp, 2024); 


%% SIMULAÇÕES

beta = 'cos';

beta_fp_cos_2019 = table2array(readtable(sprintf('../simulations/sim_FP_%s_real_2019.csv', beta))); 
beta_fp_cos_2020 = table2array(readtable(sprintf('../simulations/sim_FP_%s_real_2020.csv', beta))); 
beta_fp_cos_2021 = table2array(readtable(sprintf('../simulations/sim_FP_%s_real_2021.csv', beta))); 
beta_fp_cos_2022 = table2array(readtable(sprintf('../simulations/sim_FP_%s_real_2022.csv', beta))); 
beta_fp_cos_2023 = table2array(readtable(sprintf('../simulations/sim_FP_%s_real_2023.csv', beta))); 
beta_fp_cos_2024 = table2array(readtable(sprintf('../simulations/sim_FP_%s_real_2024.csv', beta))); 

beta_enkf_cos_2019 = table2array(readtable(sprintf('../simulations/sim_ENKF_%s_real_2019.csv', beta))); 
beta_enkf_cos_2020 = table2array(readtable(sprintf('../simulations/sim_ENKF_%s_real_2020.csv', beta))); 
beta_enkf_cos_2021 = table2array(readtable(sprintf('../simulations/sim_ENKF_%s_real_2021.csv', beta))); 
beta_enkf_cos_2022 = table2array(readtable(sprintf('../simulations/sim_ENKF_%s_real_2022.csv', beta))); 
beta_enkf_cos_2023 = table2array(readtable(sprintf('../simulations/sim_ENKF_%s_real_2023.csv', beta))); 
beta_enkf_cos_2024 = table2array(readtable(sprintf('../simulations/sim_ENKF_%s_real_2024.csv', beta))); 

beta = 'mord'; 

beta_fp_mord_2019 = table2array(readtable(sprintf('../simulations/sim_FP_%s_real_2019.csv', beta))); 
beta_fp_mord_2020 = table2array(readtable(sprintf('../simulations/sim_FP_%s_real_2020.csv', beta))); 
beta_fp_mord_2021 = table2array(readtable(sprintf('../simulations/sim_FP_%s_real_2021.csv', beta))); 
beta_fp_mord_2022 = table2array(readtable(sprintf('../simulations/sim_FP_%s_real_2022.csv', beta))); 
beta_fp_mord_2023 = table2array(readtable(sprintf('../simulations/sim_FP_%s_real_2023.csv', beta))); 
beta_fp_mord_2024 = table2array(readtable(sprintf('../simulations/sim_FP_%s_real_2024.csv', beta))); 

beta_enkf_mord_2019 = table2array(readtable(sprintf('../simulations/sim_ENKF_%s_real_2019.csv', beta))); 
beta_enkf_mord_2020 = table2array(readtable(sprintf('../simulations/sim_ENKF_%s_real_2020.csv', beta))); 
beta_enkf_mord_2021 = table2array(readtable(sprintf('../simulations/sim_ENKF_%s_real_2021.csv', beta))); 
beta_enkf_mord_2022 = table2array(readtable(sprintf('../simulations/sim_ENKF_%s_real_2022.csv', beta))); 
beta_enkf_mord_2023 = table2array(readtable(sprintf('../simulations/sim_ENKF_%s_real_2023.csv', beta))); 
beta_enkf_mord_2024 = table2array(readtable(sprintf('../simulations/sim_ENKF_%s_real_2024.csv', beta))); 

%% Make figures serie temporal 
close all 

%09ª Foz do Iguaçu
%10ª Cascavel
%20ª Toledo

cities = {'Cascavel', 'Foz do Iguaçu', 'Toledo'}; 
for i = 1:3
figure(i)
ax1 = plot_comp_filters(1, 2, 3, data_2019, ...
    beta_fp_cos_2019, beta_fp_mord_2019, ...
    beta_enkf_cos_2019, beta_enkf_mord_2019, 'casos', cities{i});

ax2 = plot_comp_filters(2, 2, 3, data_2020, ...
    beta_fp_cos_2020, beta_fp_mord_2020, ...
    beta_enkf_cos_2020, beta_enkf_mord_2020, 'casos', cities{i});

ax3 = plot_comp_filters(3, 2, 3, data_2021, ...
    beta_fp_cos_2021, beta_fp_mord_2021, ...
    beta_enkf_cos_2021, beta_enkf_mord_2021, 'casos', cities{i});

ax4 = plot_comp_filters(4, 2, 3, data_2022, ...
    beta_fp_cos_2022, beta_fp_mord_2022, ...
    beta_enkf_cos_2022, beta_enkf_mord_2022, 'casos', cities{i});

ax5 = plot_comp_filters(5, 2, 3, data_2023, ...
    beta_fp_cos_2023, beta_fp_mord_2023, ...
    beta_enkf_cos_2023, beta_enkf_mord_2023, 'casos', cities{i});

ax6 = plot_comp_filters(6, 2, 3, data_2024, ...
    beta_fp_cos_2024, beta_fp_mord_2024, ...
    beta_enkf_cos_2024, beta_enkf_mord_2024, 'casos', cities{i});

set(ax1, 'Position', [0.05, 0.55, 0.25, 0.35]); % [left, bottom, width, height]
set(ax2, 'Position', [0.35, 0.55, 0.25, 0.35]);
set(ax3, 'Position', [0.65, 0.55, 0.25, 0.35]);
set(ax4, 'Position', [0.05, 0.1, 0.25, 0.35]);
set(ax5, 'Position', [0.35, 0.1, 0.25, 0.35]);
set(ax6, 'Position', [0.65, 0.1, 0.25, 0.35]);

sgtitle(sprintf('Regional de saúde de %s', cities{i}));

%title('Estimate parameters')

set(gcf,'PaperUnits','inches','PaperPosition',[0 0 18 8])
print(gcf, sprintf('../figures/results_curves_%s.png', cities{i}), '-dpng'); % Saves tightly


end 

%% 
close all 

cities = {'Cascavel', 'Foz do Iguaçu', 'Toledo'}; 
for i = 1:3
figure(i)
ax1 = plot_residuos(1, 2, 3, data_2019, ...
    beta_fp_mord_2019, beta_enkf_mord_2019, 'casos', cities{i});

ax2 = plot_residuos(2, 2, 3, data_2020, ...
    beta_fp_mord_2019, beta_enkf_mord_2019, 'casos', cities{i});

ax3 = plot_residuos(3, 2, 3, data_2021, ...
    beta_fp_mord_2019, beta_enkf_mord_2019, 'casos', cities{i});

ax4 = plot_residuos(4, 2, 3, data_2022, ...
    beta_fp_mord_2019, beta_enkf_mord_2019, 'casos', cities{i});

ax5 = plot_residuos(5, 2, 3, data_2023, ...
    beta_fp_mord_2019, beta_enkf_mord_2019, 'casos', cities{i});

ax6 = plot_residuos(6, 2, 3, data_2024, ...
    beta_fp_mord_2019, beta_enkf_mord_2019, 'casos', cities{i});

set(ax1, 'Position', [0.05, 0.55, 0.25, 0.35]); % [left, bottom, width, height]
set(ax2, 'Position', [0.35, 0.55, 0.25, 0.35]);
set(ax3, 'Position', [0.65, 0.55, 0.25, 0.35]);
set(ax4, 'Position', [0.05, 0.1, 0.25, 0.35]);
set(ax5, 'Position', [0.35, 0.1, 0.25, 0.35]);
set(ax6, 'Position', [0.65, 0.1, 0.25, 0.35]);

sgtitle(sprintf('Regional de saúde de %s', cities{i}));

%title('Estimate parameters')

set(gcf,'PaperUnits','inches','PaperPosition',[0 0 18 8])
print(gcf, sprintf('../figures/curves_res_%s.png', cities{i}), '-dpng'); % Saves tightly
end
%% Make figures beta 
close all 

[betas_cos_fp_2019, betas_cos_enkf_2019, betas_mord_fp_2019, betas_mord_enkf_2019] = comp_betas(data_temp_2019, beta_fp_cos_2019, ...
     beta_fp_mord_2019, beta_enkf_cos_2019, beta_enkf_mord_2019);

[betas_cos_fp_2020, betas_cos_enkf_2020, betas_mord_fp_2020, betas_mord_enkf_2020] = comp_betas(data_temp_2020, beta_fp_cos_2020, ...
     beta_fp_mord_2020, beta_enkf_cos_2020, beta_enkf_mord_2020);

[betas_cos_fp_2021, betas_cos_enkf_2021, betas_mord_fp_2021, betas_mord_enkf_2021] = comp_betas(data_temp_2021, beta_fp_cos_2021, ...
     beta_fp_mord_2021, beta_enkf_cos_2021, beta_enkf_mord_2021);

[betas_cos_fp_2022, betas_cos_enkf_2022, betas_mord_fp_2022, betas_mord_enkf_2022] = comp_betas(data_temp_2022, beta_fp_cos_2022, ...
     beta_fp_mord_2022, beta_enkf_cos_2022, beta_enkf_mord_2022);

[betas_cos_fp_2023, betas_cos_enkf_2023, betas_mord_fp_2023, betas_mord_enkf_2023] = comp_betas(data_temp_2023, beta_fp_cos_2023, ...
     beta_fp_mord_2023, beta_enkf_cos_2023, beta_enkf_mord_2023);

[betas_cos_fp_2024, betas_cos_enkf_2024, betas_mord_fp_2024, betas_mord_enkf_2024] = comp_betas(data_temp_2024, beta_fp_cos_2024, ...
     beta_fp_mord_2024, beta_enkf_cos_2024, beta_enkf_mord_2024);


for i = 1:3
figure(i)

ax1 = plot_beta_filters(1, 2, 3, data_temp_2019, betas_cos_fp_2019, ...
     betas_mord_fp_2019, betas_cos_enkf_2019, betas_mord_enkf_2019, cities{i});

ax2 = plot_beta_filters(2, 2, 3, data_temp_2020, betas_cos_fp_2020, ...
     betas_mord_fp_2020, betas_cos_enkf_2020, betas_mord_enkf_2020, cities{i});

ax3 = plot_beta_filters(3, 2, 3, data_temp_2021, betas_cos_fp_2021, ...
     betas_mord_fp_2021, betas_cos_enkf_2021, betas_mord_enkf_2021, cities{i});

ax4 = plot_beta_filters(4, 2, 3, data_temp_2022, betas_cos_fp_2022, ...
     betas_mord_fp_2022, betas_cos_enkf_2022, betas_mord_enkf_2022, cities{i});

ax5 = plot_beta_filters(5, 2, 3, data_temp_2023, betas_cos_fp_2023, ...
     betas_mord_fp_2023, betas_cos_enkf_2023, betas_mord_enkf_2023, cities{i});

ax6 = plot_beta_filters(6, 2, 3, data_temp_2024, betas_cos_fp_2024, ...
     betas_mord_fp_2024, betas_cos_enkf_2024, betas_mord_enkf_2024, cities{i});

sgtitle(sprintf('Regional de saúde de %s', cities{i}));

set(ax1, 'Position', [0.05, 0.55, 0.25, 0.35]); % [left, bottom, width, height]
set(ax2, 'Position', [0.35, 0.55, 0.25, 0.35]);
set(ax3, 'Position', [0.65, 0.55, 0.25, 0.35]);
set(ax4, 'Position', [0.05, 0.1, 0.25, 0.35]);
set(ax5, 'Position', [0.35, 0.1, 0.25, 0.35]);
set(ax6, 'Position', [0.65, 0.1, 0.25, 0.35]);

%title('Estimate parameters')
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 18 8])
print(gcf, sprintf('../figures/results_beta_%s.png', cities{i}), '-dpng'); % Saves tightly

end 
