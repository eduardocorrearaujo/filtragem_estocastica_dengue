addpath('../utils');
warning('off', 'MATLAB:table:ModifiedAndSavedVarNames');
clear
close all
clc

run("variables.m")

tic; % Start timer
%------------------------- Constantes e dados ----------------------------%
% valores com a série temporal das temperaturas 
year = 2024; 
start_date = datetime(sprintf('%d-01-01', year));
end_date = datetime(sprintf('%d-12-31', year));

data_temp = readtable('../data/clima_regions_rw.csv');
data_temp.date = datetime(data_temp.date, 'InputFormat', 'yyyy-MM-dd');

data_temp = data_temp((data_temp.date >= start_date) & (data_temp.date <= end_date), {'date', ...
    'temp_med_41010', 'temp_med_41009','temp_med_41020' });

data_temp = table2array(data_temp(:, {'temp_med_41010', 'temp_med_41009', 'temp_med_41020' }));


% Carregando o vetor com as medidas
noise_samples = readtable('../simulations/noise_samples_mord.csv'); 
noise_samples = noise_samples(1:52, :); 

nAmostras = height(noise_samples);

beta_ = A_0_SIM; 

% condições iniciais e matrizes de inicialização
Ii0 = [10, 0,0 ];
Ei_K = Ii0;
Ii_K = Ii0; 
Ri_K = [0, 0, 0];
Si_K = N - Ei_K - Ii_K - Ri_K;

Xi_K = cat(2, Si_K, Ei_K, Ii_K, beta_);

Xi = NaN(TFINAL,12);
Xi(1, :) = Xi_K; 

P_K_K = P_K_K_MORD;

nEns = NENS; 

for a = 2:nAmostras
    
    [Q, R] = comp_Q_R_sim(a, Xi, noise_samples, 'mord');

    measures = table2array(noise_samples(a,:));
    
    beta_pars = struct('estimate', true, 'name', 'beta_mord', 'b', BS, 'c', CS, ...
                           'T', data_temp(a-1,:));

    [Xi_K, P_K_K] = filter_ekf(beta_pars, EPSILON, Xi(a-1,:), P_K_K, Q, R, measures, nEns);

    Xi(a, :) = Xi_K; 

end 
elapsedTime = toc; % Stop timer and get elapsed time
fprintf('Elapsed time: %.4f seconds\n', elapsedTime);

writematrix(Xi, '../simulations/sim_EKF_mord.csv');

%% MAKE PLOTS
% colors = [
%     1, 0, 0;      % Red
%     0, 1, 0;      % Green
%     0, 0, 1;      % Blue
% ];
% 
% % Set the color order for the current axes
% set(gca, 'ColorOrder', colors, 'NextPlot', 'replacechildren');
% %%
% figure(1)
% 
% %noise_samples = readtable('noise_samples.csv'); 
% 
% plot(table2array(noise_samples), 'o')
% hold on 
% plot( TAU.*Xi(:, 4:6));
% hold on
% grid on 
% %legend('Dados', 'Estimado')
% 
% %%
% figure(2)
% plot(Xi(:, 10:12))
% 
% 
% 
