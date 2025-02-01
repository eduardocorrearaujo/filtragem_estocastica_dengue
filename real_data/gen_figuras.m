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
plot_comp_filters(1, 2, 3, data_2019, ...
    beta_fp_cos_2019, beta_fp_mord_2019, ...
    beta_enkf_cos_2019, beta_enkf_mord_2019, 'casos', cities{i})

plot_comp_filters(2, 2, 3, data_2020, ...
    beta_fp_cos_2020, beta_fp_mord_2020, ...
    beta_enkf_cos_2020, beta_enkf_mord_2020, 'casos', cities{i})

plot_comp_filters(3, 2, 3, data_2021, ...
    beta_fp_cos_2021, beta_fp_mord_2021, ...
    beta_enkf_cos_2021, beta_enkf_mord_2021, 'casos', cities{i})

plot_comp_filters(4, 2, 3, data_2022, ...
    beta_fp_cos_2022, beta_fp_mord_2022, ...
    beta_enkf_cos_2022, beta_enkf_mord_2022, 'casos', cities{i})

plot_comp_filters(5, 2, 3, data_2023, ...
    beta_fp_cos_2023, beta_fp_mord_2023, ...
    beta_enkf_cos_2023, beta_enkf_mord_2023, 'casos', cities{i})

plot_comp_filters(6, 2, 3, data_2024, ...
    beta_fp_cos_2024, beta_fp_mord_2024, ...
    beta_enkf_cos_2024, beta_enkf_mord_2024, 'casos', cities{i})

sgtitle(sprintf('Regional de saúde de %s', cities{i}));

%title('Estimate parameters')
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 18 8])
print(gcf, sprintf('../figures/results_curves_%s.png', cities{i}), '-dpng'); % Saves tightly


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

plot_beta_filters(1, 2, 3, data_temp_2019, betas_cos_fp_2019, ...
     betas_mord_fp_2019, betas_cos_enkf_2019, betas_mord_enkf_2019, cities{i})

plot_beta_filters(2, 2, 3, data_temp_2020, betas_cos_fp_2020, ...
     betas_mord_fp_2020, betas_cos_enkf_2020, betas_mord_enkf_2020, cities{i})

plot_beta_filters(3, 2, 3, data_temp_2021, betas_cos_fp_2021, ...
     betas_mord_fp_2021, betas_cos_enkf_2021, betas_mord_enkf_2021, cities{i})

plot_beta_filters(4, 2, 3, data_temp_2022, betas_cos_fp_2022, ...
     betas_mord_fp_2022, betas_cos_enkf_2022, betas_mord_enkf_2022, cities{i})

plot_beta_filters(5, 2, 3, data_temp_2023, betas_cos_fp_2023, ...
     betas_mord_fp_2023, betas_cos_enkf_2023, betas_mord_enkf_2023, cities{i})

plot_beta_filters(6, 2, 3, data_temp_2024, betas_cos_fp_2024, ...
     betas_mord_fp_2024, betas_cos_enkf_2024, betas_mord_enkf_2024, cities{i})

sgtitle(sprintf('Regional de saúde de %s', cities{i}));

%title('Estimate parameters')
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 18 8])
print(gcf, sprintf('../figures/results_beta_%s.png', cities{i}), '-dpng'); % Saves tightly

end 
