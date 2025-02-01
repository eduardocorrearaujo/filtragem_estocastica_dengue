function [erro] = rmse(data, filtro)

validIndices = ~isnan(data) & ~isnan(filtro);
    
% Filter the data and filtro arrays
data = data(validIndices);
filtro = filtro(validIndices);
    
n = numel(filtro);
erro = sqrt(sum((data - filtro)).^2) / n;
