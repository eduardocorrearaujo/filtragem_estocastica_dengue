function [beta_cos_fp, beta_cos_enkf, beta_mord_fp, beta_mord_enkf] = comp_betas(data_temp, X_fp_cos, X_fp_mord, X_enkf_cos, X_enkf_mord)

temp = table2array(data_temp(:, 2:4)); 

b_ = 14;
BS = [b_,b_,b_];    
c_ = 36;
CS = [c_,c_,c_];
zita_ =  0.16;
ZITAS = [zita_, zita_, zita_]; 
phi_ = -6.01;
PHIS = [phi_, phi_, phi_];  

beta_mord_fp = NaN(52, 3);
beta_mord_enkf = NaN(52, 3);

beta_cos_fp = NaN(52, 3); 
beta_cos_enkf = NaN(52, 3);

for t = 1:52
    beta_mord_fp(t,:) = beta_mord(temp(t,:), X_fp_mord(t,10:12), BS,  CS);
    beta_mord_enkf(t,:) = beta_mord(temp(t,:), X_enkf_mord(t,10:12), BS,  CS);
    
    beta_cos_fp(t,:) = beta_cos(t, X_fp_cos(t, 10:12), X_fp_cos(t, 13:15), ZITAS, PHIS);
    beta_cos_enkf(t,:) = beta_cos(t, X_enkf_cos(t, 10:12), X_enkf_cos(t, 13:15), ZITAS, PHIS);

end 


