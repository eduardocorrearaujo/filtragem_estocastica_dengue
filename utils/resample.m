function [Xp_new, wp_new,ij] = resample(Xp, wp)
% Algoritmo 3 do capítulo 3
s = size(Xp);
numParticulas = s(1);
dim = s(2);

% Coloque sua logica de reamostragem aqui
Xp_new = zeros(numParticulas, dim); 
wp_new = zeros(numParticulas, 1);
ij = NaN(numParticulas, 1); 

% soma acumulativa dos pesos
c = NaN(numParticulas, 1);

c(1) = wp(1);

for m = 2:numParticulas

    c(m) = c(m-1) + wp(m);

end

%sorteio do ponto inicial
u1 = rand(1)/numParticulas;

i = 1;
    
% dúvida se estou fazendo a iteração de j e i corretamente. 
for j = 1:numParticulas 

    u = u1 + (j-1)/numParticulas;
    while u > c(i) && i < numParticulas

        i = i + 1;

    end

    Xp_new(j,:) = Xp(i, :);

    wp_new(j) =  1/numParticulas;

    ij(j) = i;
      
end
  

