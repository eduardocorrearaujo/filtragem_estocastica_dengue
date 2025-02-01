function [K_K, Pxby]  = comp_K(tau, R,xhat_k_k_1, size_) 
% equação 41 do capítulo 3 
s = size(xhat_k_k_1);

N = s(1);

P1_sum = zeros(size_, 3);

P2_sum = zeros(3, 3);

mean_x = mean(xhat_k_k_1);

y2 =  tau.*mean_x(4:6); 

for i=1:N

y1 =  tau.*xhat_k_k_1(i, 4:6);

Y_i = y1-y2; 

P1 = (xhat_k_k_1(i,:)' - mean_x')*Y_i; 

P2 = Y_i'*Y_i;


P1_sum = P1_sum + P1;

P2_sum = P2_sum + P2; 

end 

K_K = ((1/(N-1))*P1_sum)/((1/(N-1))*P2_sum + R );

Pxby = (1/N-1)*P1_sum; 





