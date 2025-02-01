addpath('../utils');

%% init 
close all 
clear all 
run("variables.m")
%% Beta cos 
[Xi] = model_meta_pop(TFINAL, I0, N, 'cos'); 
Ei = Xi(:, 4:6); 
Ii = Xi(:, 7:9);
%% add noise 
Ii_noise = TAU*Ei;
for t = 2:52
    Q = mvnrnd(zeros(3,1), diag( (0.1*Ii_noise(t-1,:)).^2 ));
    Ii_noise(t,:) = Ii_noise(t,:) + Q; 
end 

Ii_noise = abs(Ii_noise); 
%%
colors = [
    1, 0, 0;      % Red
    0, 1, 0;      % Green
    0, 0, 1;      % Blue
];

% Set the color order for the current axes
set(gca, 'ColorOrder', colors, 'NextPlot', 'replacechildren');


figure(1)
%subplot(2,1,1)
plot(TEMP, TAU*Ei)
hold on 
plot(TEMP, Ii_noise, 'o')
legend('Cascavel', 'Foz do Iguaçu', 'Toledo', 'Location', 'northwest')
title('Novos casos por regional (\beta_{k}^{1})')
xlabel('Semanas')
ylabel('Novos casos')
%legend('Cascavel', 'Foz do Iguaçu', 'Francisco Beltrão', 'Pato Branco', 'Toledo')
grid on 
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 8 5])

print('../figures/sim_noise_cos','-dpng')

writematrix(Ii_noise, '../simulations/noise_samples_cos.csv');

