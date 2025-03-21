function [Xi, P_K_K, X_ens_i_k] = filter_ekf(beta_pars, epsilon, X0, P0, Q, R, measures, nEns)

run("variables.m")

s = size(X0);
z_k_i = NaN(nEns, 3);
X_ens_i = NaN(nEns,s(2)); 
X_ens_i_k = NaN(nEns,s(2));

for n = 1:nEns
  
    X_ens_i_k_1 = mvnrnd(X0, P0);

    X_K_1 = msei(GAMMA, TAU, CAPA, epsilon, N, X_ens_i_k_1, beta_pars);  
    
    Q_noise =  mvnrnd(zeros(s(2),1), Q);

    X_ens_i(n,:) = X_K_1 + Q_noise;

    X_ens_i(n, 4:6) = max([0,0,0], X_ens_i(n,4:6)); 
    X_ens_i(n, 7:9) = max([0,0,0], X_ens_i(n,7:9)); 

    if s(2) ==12
        X_ens_i(n, 10:12) = max([0,0,0], X_ens_i(n,10:12)); 
    end 
    
end 

for n = 1:nEns
    % calculando as medidas a partir do estado 
    z_k_i(n,:) = TAU.*X_ens_i(n, 4:6);
end 

% cálculo da matrix K
[K_K, ~] = comp_K(TAU, R, X_ens_i, s(2));  

% inovação da medida
z_dado = measures; 

%atualização das medidas
for n = 1:nEns
    %R_noise =  mvnrnd(zeros(3,1), R);
    %z_dado = measures + R_noise; 
    X_ens_i_k(n, :) = X_ens_i(n, :) +  (K_K*((z_dado - z_k_i(n, :))'))';  

end 

% atualização do vetor P 
P_K_K = update_P(X_ens_i_k, s(2));

% salva os valores corrigidos 
Xi(:) = mean(X_ens_i_k);

% Garante que os valores não serão negativos 
Xi(4:6) = max([0,0,0], Xi(4:6)); 

Xi(7:9) = max([0,0,0], Xi(7:9));

if s(2) ==12 
   Xi(10:12) = max([0,0,0], Xi(10:12)); 
end 
