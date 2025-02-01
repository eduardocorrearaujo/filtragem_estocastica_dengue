function beta_vec = beta_cos(temp, beta_0, eta, zita, phi)
% equação 8 do capítulo 2
beta_vec = NaN(length(temp),3); 

for i = 1:3
    
    beta = beta_0(i)*(1 + eta(i)*cos(zita(i)*(temp + phi(i))));

    beta_vec(:, i) = max(0.005, beta);

end 