function epsilon = comp_epsilon(theta, alpha)
% equação 14 do capítulo 2 
% Ordem das regiões:
% Cascavel
% Foz do Iguaçu
% Toledo 

% Define the variables 

dens_pop = [49.42, 109.37, 52.28]; 
% matrix com as distâncias
D = readtable('../data/dist_table_model.csv');
D = D(:, [2,3,4]); 

epsilon = zeros(3,3); 

n =3;
m = 3;
% Loop over all elements of the distance matrix to create the 
% epsilon matrix
for i = 1:n  % Loop over rows
    for j = 1:m  % Loop over columns
        % Access the element at row i and column j
        H_i = dens_pop(i);
        H_j = dens_pop(j);

        epsilon(i,j) = theta*H_i*H_j/((D{i,j})^(alpha));
        
    end
end

% substituindo os valores da diagonal principal 
epsilon(isinf(epsilon)) = 0;
