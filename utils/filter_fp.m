function [Xp_k_1, XHat, wp_new, Ls, n_end] = filter_fp(beta_pars, epsilon, Xp_k, Q, R, wp_old, measures, numParticulas, ...
    nEffThreshold)

%------------------------- Constantes e dados ----------------------------%

run("variables.m")

z_dado = measures; 
%---------------------- Aplicação do filtro por amostra ---------------------------%
s = size(Xp_k);
Xp_k_1 = NaN(numParticulas, s(2));
wp_new = NaN(numParticulas,1);
Ls =  NaN(numParticulas,1);

n_end = NaN(numParticulas, 1); 

%------------ Filtro de particulas SIS com Reamostragem --------------%
for n = 1:numParticulas
    L = 0; 
    n_ = 1;
    while (L < 10^(-200)) && n_ < 10 
       
    [X_K_1] = msei(GAMMA, TAU, CAPA, epsilon, N, Xp_k(n,:), beta_pars);

    Q_noise =  mvnrnd(zeros(s(2),1), Q);
    
    Xp_k_1(n,:) = X_K_1 + Q_noise;
      
    Xp_k_1(n, 4:6) = max([0,0,0], Xp_k_1(n,4:6)); 
    Xp_k_1(n, 7:9) = max([0,0,0], Xp_k_1(n,7:9)); 

    if s(2) ==12
        Xp_k_1(n, 10:12) = max([0.0005,0.0005,0.0005], Xp_k_1(n,10:12)); 
    end 

    % medida com base no estado estimado       
    z_cal = TAU.*Xp_k_1(n,4:6); 

    %função de verossimilhança
    % quand L < 10^(-200) o valor de R é inflado
    L =  mvnpdf(z_cal, z_dado, n_*R);

    n_ = n_ + 0.5;

    Ls(n, :) = L; 
        
    % atualização dos pesos
    wp_new(n,:) = L*wp_old(n,:);

    end 

    n_end(n, 1) = n_; 

end
 
%------------------------- Reamostragem --------------------------%

wp_new = wp_new/sum(wp_new);  % normalizacao dos pesos

XHat = sum(wp_new.*Xp_k_1); % estimativa global

nEff = 1/sum(wp_new.^2); 
if nEff < nEffThreshold
    % cálculo da reamostragagem 
    [Xp_k_1, wp_new,~] = resample(Xp_k_1, wp_new); 
   
end
wp_new = wp_new/sum(wp_new);  % normalizacao dos pesos

n_end = mean(n_end);