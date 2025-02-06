function [noise_samples, XHat1, wp, Ls_v, n_] = fn_fp_cos(year)

addpath('../utils');
warning('off', 'MATLAB:table:ModifiedAndSavedVarNames');
run("variables.m")

%------------------------- Constantes e dados ----------------------------%

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

beta_= BETA_0_REAL ; 

eta_ = ETA_0_REAL; 

% condições iniciais e matrizes de inicialização
Ii0 = noise_samples(1,:);
Ei_K = Ii0;
Ii_K = Ii0; 
Si_K = N - Ei_K - Ii_K - sum(table2array(data_s(:, 2:4)));

%%

Xi_K = cat(2, Si_K, Ei_K, Ii_K, beta_, eta_);

XHat1 = NaN(nAmostras,15);
XHat1(1, :) = Xi_K; 

numParticulas = NPARTS;

Xp1 = repmat(Xi_K, numParticulas, 1); 

wp_new = ones(numParticulas,1)/numParticulas;
wp = zeros(numParticulas,nAmostras);
wp(:,1) = ones(numParticulas,1)/numParticulas;

Ls_v = NaN(numParticulas,nAmostras);

n_ = NaN(nAmostras, 1); 
  
n_(1,1) = 1.5; 

for a = 2:nAmostras
    %disp(a)
    [Q, R] = comp_Q_R_real(a, XHat1, noise_samples, 'cos');

    measures = noise_samples(a,:);

    beta_pars = struct('estimate', true, 'name', 'beta_cos',  'zita', ZITAS, 'phi', PHIS, 'temp', a-1);

    [Xp1, XHat, wp_new, Ls_, n_end] = filter_fp(beta_pars, EPSILON,  Xp1, Q, R, wp_new, measures, numParticulas,NTHR);
        
    XHat1(a, :) = XHat;

    wp(:,a) = wp_new;

    Ls_v(:, a) = Ls_;

    n_(a, 1) = n_end; 


end 


