function P_K = update_P(xhat_k_k_1, size_) 
% segue a equação da linha 10 do algoritmo 1 
s = size(xhat_k_k_1);

N = s(1);

mean_x = mean(xhat_k_k_1);

P1_sum = zeros(size_, size_);

for i=1:N

P1 = (xhat_k_k_1(i,:)' - mean_x'); 

P1_sum = P1_sum + P1*(P1');

end 

P_K = (1/(N-1))*P1_sum;
