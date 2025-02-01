function lmbda_end = lambda_ij(beta, epsilon, I, N)
% equação 17 do capítulo 2 
lmbda = NaN(3, 3);

for i = 1:3
    for j = 1:3
        lmbda(i, j) = epsilon(i,j)*beta(i)*I(j)/N(j);

    end 
end

lmbda_end = sum(lmbda, 2); 

lmbda_end = lmbda_end'; 