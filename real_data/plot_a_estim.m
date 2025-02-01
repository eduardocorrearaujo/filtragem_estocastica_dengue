
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

%% 

figure(1)
subplot(2,3,1)
plot(beta_fp_mord_2019(:, 10))
hold on 
plot(beta_enkf_mord_2019(:, 10))

subplot(2,3,2)
plot(beta_fp_mord_2020(:, 10))
hold on 
plot(beta_enkf_mord_2020(:, 10))

subplot(2,3,3)
plot(beta_fp_mord_2021(:, 10))
hold on 
plot(beta_enkf_mord_2021(:, 10))

subplot(2,3,4)
plot(beta_fp_mord_2022(:, 10))
hold on 
plot(beta_enkf_mord_2022(:, 10))

subplot(2,3,5)
plot(beta_fp_mord_2023(:, 10))
hold on 
plot(beta_enkf_mord_2023(:, 10))

subplot(2,3,6)
plot(beta_fp_mord_2024(:, 10))
hold on 
plot(beta_enkf_mord_2024(:, 10))


figure(2)
figure(1)
subplot(2,3,1)
plot(beta_fp_cos_2019(:, 10))
hold on 
plot(beta_enkf_cos_2019(:, 10))

subplot(2,3,2)
plot(beta_fp_cos_2020(:, 10))
hold on 
plot(beta_enkf_cos_2020(:, 10))

subplot(2,3,3)
plot(beta_fp_cos_2021(:, 10))
hold on 
plot(beta_enkf_cos_2021(:, 10))

subplot(2,3,4)
plot(beta_fp_cos_2022(:, 10))
hold on 
plot(beta_enkf_cos_2022(:, 10))

subplot(2,3,5)
plot(beta_fp_cos_2023(:, 10))
hold on 
plot(beta_enkf_cos_2023(:, 10))

subplot(2,3,6)
plot(beta_fp_cos_2024(:, 10))
hold on 
plot(beta_enkf_cos_2024(:, 10))