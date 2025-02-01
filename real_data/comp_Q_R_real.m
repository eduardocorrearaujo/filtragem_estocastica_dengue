function [Q, R] = comp_Q_R_real(a, XHat1, noise_samples, beta_var)


if isequal(beta_var,'cos')

    var_noise = [(0.02)^2, (0.02)^2, (0.02)^2, (0.02)^2, (0.02)^2, (0.02)^2]; 

elseif isequal(beta_var,'mord')
    
    var_noise = [(0.0002)^2, (0.0002)^2, (0.0002)^2]; 
    
end 
 
aux_ = max([5 5 5],(0.2*XHat1(a-1, 4:6)).^2);

sigma = cat(2, [1000, 1000, 1000], aux_, aux_, var_noise);

Q = diag(sigma);

diag_R = max([5 5 5],  (0.25*noise_samples(a,:)).^2) ;

R = diag(diag_R);