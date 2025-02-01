function [X_K_1] = msei(gamma, tau, capa, epsilon, N, ...
                                                    X_K, beta_pars)

S_K = X_K(1:3);
E_K = X_K(4:6);
I_K = X_K(7:9);

if beta_pars.estimate == 0
    if isequal(beta_pars.name, 'constante')
        beta = beta_pars.beta; 
    
    elseif isequal(beta_pars.name, 'beta_cos') 
        beta_0 = beta_pars.beta;
        eta = beta_pars.eta;
        zita = beta_pars.zita;
        phi = beta_pars.phi;
        temp = beta_pars.temp;

        beta = beta_cos(temp, beta_0, eta, zita, phi);

    elseif isequal(beta_pars.name, 'beta_mord')

        T = beta_pars.T;
        a = beta_pars.a;
        b = beta_pars.b;
        c = beta_pars.c;

        beta = beta_mord(T, a, b, c);
    end 

else 
    if isequal(beta_pars.name, 'constante') 
        beta_0 = X_K(10:12);
        beta = beta_0; 
    
    elseif isequal(beta_pars.name, 'beta_cos')
        beta_0 = X_K(10:12);

        eta_1 = X_K(13);
        eta_2 = X_K(14);
        eta_3 = X_K(15);
        
        eta = [eta_1, eta_2, eta_3];
        zita = beta_pars.zita;
        phi = beta_pars.phi;
        temp = beta_pars.temp;

        beta = beta_cos(temp, beta_0, eta, zita, phi);
        
    elseif isequal(beta_pars.name, 'beta_mord')
        beta_0 = X_K(10:12);

        T = beta_pars.T;
        b = beta_pars.b;
        c = beta_pars.c;

        beta = beta_mord(T, beta_0, b, c);

    end
   
end

% equação 16 do capítulo 2 
lambda_i_K = beta.*(I_K./N);
    
% atualização dos valores 
% segue o modelo definido pela equação 15 do capítulo 2 com a exclusão do
% estado R 
S_K_1 = S_K + capa*N - lambda_i_K.*S_K  - lambda_ij(beta,epsilon, I_K, N).*S_K - capa*S_K; 

E_K_1 = E_K + lambda_i_K.*S_K  + lambda_ij(beta,epsilon, I_K, N).*S_K - tau*E_K - capa*E_K; 
    
I_K_1 = I_K + tau*E_K - gamma*I_K - capa*I_K; 

E_K_1 = max([0,0,0], E_K_1); 

I_K_1 = max([0,0,0], I_K_1); 

if beta_pars.estimate == true
    if isequal(beta_pars.name, 'beta_cos') 
        X_K_1 = cat(2, S_K_1, E_K_1, I_K_1, beta_0, eta);
    else
        X_K_1 = cat(2, S_K_1, E_K_1, I_K_1, beta_0);
    end 
else 
    X_K_1 = cat(2, S_K_1, E_K_1, I_K_1);
end

if any(isinf(X_K_1))
    disp(beta)
    keyboard
end 