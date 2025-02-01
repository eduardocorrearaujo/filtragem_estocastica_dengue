function [Xi] = model_meta_pop(t, Ii0, Ni, beta_var, data_temp)
% SIRD model discretizando. Considerando que as amostras são realizadas na
% unidade de um dia.

run('variables.m');

Xi = NaN(t,9);

Ei_K = Ii0;
Ii_K = Ii0; 
Ri_K = [0, 0, 0];
Si_K = Ni - Ei_K - Ii_K - Ri_K;

Xi(1,1:3) = Si_K;
Xi(1,4:6) = Ei_K; 
Xi(1,7:9) = Ii_K; 

for k = 2:t

    if isequal(beta_var,'cos')

        beta_pars = struct('estimate', false, 'name', 'beta_cos', 'beta', BETAS_0, 'eta', ETAS, 'zita', ZITAS, ...
                           'phi', PHIS, 'temp', k-1);

    end 

    if isequal(beta_var,'mord')
    
        beta_pars = struct('estimate', false, 'name', 'beta_mord', 'a', AS, 'b', BS, 'c', CS, ...
                           'T', data_temp(k-1,:));

    end 

    Xi(k,:) = msei(GAMMA, TAU, CAPA, EPSILON, Ni, ...
                                                    Xi(k-1,:), beta_pars);

end