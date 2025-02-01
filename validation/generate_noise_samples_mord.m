addpath('../utils');

%% init 
close all 
clear all 
run("variables.m")

year = 2024; 
start_date = datetime(sprintf('%d-01-01', year));
end_date = datetime(sprintf('%d-12-31', year));

data_temp = readtable('../data/clima_regions_rw.csv');
data_temp.date = datetime(data_temp.date, 'InputFormat', 'yyyy-MM-dd');

data_temp = data_temp((data_temp.date >= start_date) & (data_temp.date <= end_date), {'date', ...
    'temp_med_41010', 'temp_med_41009','temp_med_41020' });

data_temp = table2array(data_temp(:, {'temp_med_41010', 'temp_med_41009', 'temp_med_41020' }));

data_temp = data_temp(1:52, :); 
%% Beta cos 
[Xi] = model_meta_pop(TFINAL, I0, N, 'mord', data_temp); 
Xi = Xi(1:52, :);
Ei = Xi(:, 4:6);
Ii = Xi(:, 7:9); 

% Generate Gaussian noise for each column
Ii_noise = TAU*Ei;
for t = 2:52
    Q = mvnrnd(zeros(3,1), diag( (0.1*Ii_noise(t-1,:)).^2 ));
    Ii_noise(t,:) = Ii_noise(t,:) + Q; 
end 

Ii_noise = abs(Ii_noise); 

colors = [
    1 0 0;      % Red
    0 1 0;      % Green
    0 0 1;      % Blue
];

% Set the color order for the current axes
%set(gca, 'ColorOrder', colors, 'NextPlot', 'replacechildren');


figure(1)
%subplot(2,1,1)
yyaxis left;
%plot(temp, tau*Ei)

for i = 1:3
    plot(TEMP, TAU*Ei(:, i),'-', 'Color', colors(i, :));
    hold on 
end

for i = 1:3
    plot(TEMP, Ii_noise(:, i),'o', 'Color', colors(i, :));
    hold on 
end

xlabel('Semanas')
ylabel('Novos casos')
grid on 
ax = gca; % Obter os eixos
ax.YAxis(1).Color = 'black';

yyaxis right;
plot(TEMP, data_temp(1:52, :), color = [0.8500, 0.3250, 0.0980])
ylabel('Temperatura média (°C)')

ax.YAxis(2).Color = [0.8500, 0.3250, 0.0980];

legend('Cascavel', 'Foz do Iguaçu', 'Toledo',  'Location', 'northwest')
title('Novos casos simulados por regional (\beta^{2}_{k})')

set(gcf,'PaperUnits','inches','PaperPosition',[0 0 8 5])

print('../figures/sim_noise_mord','-dpng')

writematrix(Ii_noise, '../simulations/noise_samples_mord.csv');

