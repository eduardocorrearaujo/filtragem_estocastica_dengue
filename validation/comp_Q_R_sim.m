function [Q, R] = comp_Q_R_sim(a, XHat1, noise_samples, beta_var)

run('variables.m')

if isequal(beta_var,'cos')
    var_noise = VAR_NOISE_COS; 
elseif isequal(beta_var,'mord')
    var_noise = VAR_NOISE_MORD; 
end 

diag_R = max([5 5 5], (0.1*XHat1(a-1, 4:6)).^2 );

sigma = cat(2, [1000, 1000, 1000], diag_R, diag_R, var_noise);

Q = diag(sigma);

diag_R = max([5 5 5],  (0.2*table2array(noise_samples(a,:))).^2  );

R = diag(diag_R);