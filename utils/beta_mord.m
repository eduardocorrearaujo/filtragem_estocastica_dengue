function [b_end] = beta_mord(T, a, b, c)
% equação 9 capítulo 2 
b_end =  NaN(1, 3); 

for i = 1:3
    b_end(1, i) = real(a(i)*T(i)*(T(i)-b(i))*((c(i)- T(i))^(1/2)));
    
    b_end(1, i) = max(0.005, b_end(1, i) );
    
    b_end(1, i) = min(4, b_end(1, i) );


end

 
