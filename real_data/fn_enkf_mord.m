function [noise_samples, Xi] = fn_enkf_mord(year)


addpath('../utils');
warning('off', 'MATLAB:table:ModifiedAndSavedVarNames');
run("variables.m")

%------------------------- Constantes e dados ----------------------------%

data_temp = readtable('../data/clima_regions_rw.csv');
data_temp.date = datetime(data_temp.date, 'InputFormat', 'yyyy-MM-dd');

start_date = datetime(sprintf('%d-01-01', year));
end_date = datetime(sprintf('%d-12-31', year));

data_temp_f = data_temp((data_temp.date >= start_date) & (data_temp.date <= end_date), {'date', ...
    'temp_med_41010', 'temp_med_41009','temp_med_41020' });

temp = table2array(data_temp_f(:, 2:4));

data = readtable('../data/susp_data_regions_rw.csv');

data.data_iniSE = datetime(data.data_iniSE, 'InputFormat', 'yyyy-MM-dd');

start_date = datetime(sprintf('%d-01-01', year));
end_date = datetime(sprintf('%d-12-31', year));


data_f = data((data.data_iniSE >= start_date) & (data.data_iniSE <= end_date), {'data_iniSE', ...
    'casos_41010', 'casos_41009','casos_41020' });

data_s = data((data.data_iniSE < start_date), {'data_iniSE', ...
    'casos_41010', 'casos_41009', 'casos_41020' });

noise_samples = table2array(data_f(1:52, 2:4)); 
nAmostras = height(noise_samples);

beta_ = A_0_REAL ; 

% condições iniciais e matrizes de inicialização
Ii0 = noise_samples(1,:);
Ei_K = Ii0;
Ii_K = Ii0; 
Si_K = N - Ei_K - Ii_K  - sum(table2array(data_s(:, 2:4)));

Xi_K = cat(2, Si_K, Ei_K, Ii_K, beta_);

Xi = NaN(TFINAL,12);
Xi(1, :) = Xi_K; 

P_K_K = P_K_K_MORD;

nEns = NENS; 

for a = 2:nAmostras
    
    [Q, R] = comp_Q_R_real(a, Xi, noise_samples, 'mord');

    measures = noise_samples(a,:);
    
    beta_pars = struct('estimate', true, 'name', 'beta_mord', 'b', BS, 'c', CS, ...
                           'T', temp(a-1,:));

    [Xi_K, P_K_K] = filter_ekf(beta_pars, EPSILON, Xi(a-1,:), P_K_K, Q, R, measures, nEns);

    Xi(a, :) = Xi_K; 

end 
