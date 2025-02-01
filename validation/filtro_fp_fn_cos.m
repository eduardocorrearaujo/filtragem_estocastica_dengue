addpath('../utils');
warning('off', 'MATLAB:table:ModifiedAndSavedVarNames');
clear
close all
clc

run("variables.m")

tic; % Start timer
%------------------------- Constantes e dados ----------------------------%

% Carregando o vetor com as medidas
noise_samples = readtable('../simulations/noise_samples_cos.csv'); 
noise_samples = noise_samples(1:52, :); 
nAmostras = height(noise_samples);

% Cascavel
% Foz do Iguaçu
% Toledo 

beta_ = BETA_0_SIM ; 

eta_ = ETA_0_SIM ;

% condições iniciais e matrizes de inicialização
Ii0 = [10, 0,0 ];
Ei_K = Ii0;
Ii_K = Ii0; 
Ri_K = [0, 0, 0];
Si_K = N - Ei_K - Ii_K - Ri_K;


Xi_K = cat(2, Si_K, Ei_K, Ii_K, beta_, eta_);

XHat1 = NaN(TFINAL,15);
XHat1(1, :) = Xi_K; 

numParticulas = NPARTS;

Xparts = NaN(numParticulas, 15, nAmostras); 

Xp1 = repmat(Xi_K, numParticulas, 1); 

Xparts(:, :, 1) = Xp1; 

wp_new = ones(numParticulas,1)/numParticulas;
wp = zeros(numParticulas,nAmostras);
wp(:,1) = ones(numParticulas,1)/numParticulas; 

Ls_ = NaN(numParticulas,nAmostras);

n_ = NaN(nAmostras, 1); 
  
n_(1,1) = 1.5; 

for a = 2:nAmostras
    
    [Q, R] = comp_Q_R_sim(a, XHat1, noise_samples, 'cos');

    measures = table2array(noise_samples(a,:));
    
    beta_pars = struct('estimate', true, 'name', 'beta_cos', 'zita', ZITAS, 'phi', PHIS, 'temp', a-1);

    [Xp1, XHat, wp_new, Ls, n_end] = filter_fp(beta_pars, EPSILON,  Xp1, Q, R, wp_new, measures, numParticulas,NTHR);
    
    n_(a, 1) = n_end; 

    Xparts(:, :, a) = Xp1; 

    XHat1(a, :) = XHat;

    wp(:,a) = wp_new;

    Ls_(:, a) = Ls; 

end 
elapsedTime = toc; % Stop timer and get elapsed time
fprintf('Elapsed time: %.4f seconds\n', elapsedTime);
writematrix(XHat1, '../simulations/sim_FP_cos.csv');

%% MAKE PLOTS 
% close all 
% colors = [
%     1, 0, 0;      % Red
%     0, 1, 0;      % Green
%     0, 0, 1;      % Blue
% ];
% 
% % Set the color order for the current axes
% 
% set(0, 'DefaultAxesColorOrder', colors)
% 
% figure(1)
% 
% subplot(3, 1, 1)
% 
% plot(table2array(noise_samples), 'o')
% hold on 
% plot( TAU.*XHat1(:, 4:6));
% title('Medidas (pontos) vs curvas estimadas (linhas)')
% hold off
% 
% grid on
% 
% subplot(3, 1, 2)
% 
% plot(1:nAmostras, wp', 'Color', [0.4660 0.6740 0.1880]);
% hold on
% title('Pesos por importância')
% ylabel('Pesos {w^i}_{k}')
% xlabel('Iteração')
% grid on
% 
% subplot(3, 1, 3)
% 
% plot(var(wp))
% grid on 
% title('Variância dos pesos')
% 
% writematrix(XHat1, '../simulations/sim_FP_cos.csv');
% writematrix(wp, '../simulations/wp_FP_cos.csv');
% 
% %% 
% figure(4)
% 
% plot(XHat1(:, 10:12))
