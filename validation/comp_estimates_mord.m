close all;
clear all;
clc 

beta_fp = readtable('../simulations/sim_FP_mord.csv'); 
beta_fp = table2array(beta_fp);

beta_ekf = readtable('../simulations/sim_EKF_mord.csv'); 
beta_ekf = table2array(beta_ekf);

nAmostras = 52; 

betas = 0.0012*ones(nAmostras, 3);

n= nAmostras;

%%
noise_samples = readtable('../simulations/noise_samples_mord.csv'); 
noise_samples = table2array(noise_samples(1:52, :)); 


figure(1)

cities = {'Cascavel', 'Foz do Iguaçu', 'Toledo'}; 

for i =1:3

subplot(2,3,i)

h1 = plot(noise_samples(:, i), '.', 'color', 'black', 'markersize', 12);
hold on 
h2 = plot(beta_ekf(:, 3+i), 'Color','blue');
hold on 
h3 = plot(beta_fp(:, 3+i), 'Color', 'red');
hold on 
grid on 
rmse_ekf = sqrt(sum((noise_samples(:,i)- beta_ekf(:, 3+i)).^2) / n);
rmse_fp = sqrt(sum((noise_samples(:,i)- beta_fp(:, 3+i)).^2) / n);

legend_ekf= sprintf('EnKF (RMSE = %.2f)', rmse_ekf);
legend_fp= sprintf('FP (RMSE = %.2f)', rmse_fp);

legend([h1, h2, h3], {'Dados', legend_ekf, legend_fp}, 'Location', 'northwest'); 
title(cities{i})
ylabel('Novos casos')
xlabel('Semana')
subplot(2,3, 3+i)

plot(betas(:, i), 'Color','black')
hold on 
plot(beta_ekf(:, 9+i), 'Color','blue')
hold on 
plot(beta_fp(:, 9+i), 'Color', 'red')
grid on 
hold on 

rmse_ekf = sqrt(sum((betas(:,i)- beta_ekf(:, 9+i)).^2) / n);
rmse_fp = sqrt(sum((betas(:,i)- beta_fp(:, 9+i)).^2) / n);

legend_ekf= sprintf('EnKF (RMSE = %.2f·10^{-3})', 1000*rmse_ekf);
legend_fp= sprintf('FP (RMSE = %.2f·10^{-3})', 1000*rmse_fp);

legend('real', legend_ekf, legend_fp); 
title(strcat(sprintf('$a^{%d}$', i), ' estimado'), 'Interpreter', 'latex')
ylabel(sprintf('$a$', i), 'Interpreter', 'latex', 'FontSize',14)
xlabel('Semana')
end 

set(gcf,'PaperUnits','inches','PaperPosition',[0 0 18 8])
print(gcf, '../figures/results_sim_mord.png', '-dpng'); % Saves tightly


%% 
% figure(2)
% 
% cities = {'Cascavel', 'Foz do Iguaçu', 'Toledo'}; 
% 
% for i =1:3
% 
% subplot(1,3,i)
% 
% h1 = yline(0, '.', 'color', 'black');
% hold on 
% h2 = plot(beta_ekf(:, 3+i) - noise_samples(:, i) , 'Color','blue');
% hold on 
% h3 = plot(beta_fp(:, 3+i) - noise_samples(:, i), 'Color', 'red');
% hold on 
% grid on 
% 
% rmse_ekf = sqrt(sum((noise_samples(:,i)- beta_ekf(:, 3+i)).^2) / n);
% rmse_fp = sqrt(sum((noise_samples(:,i)- beta_fp(:, 3+i)).^2) / n);
% 
% legend_ekf= sprintf('EnKF (RMSE = %.2f)', rmse_ekf);
% legend_fp= sprintf('FP (RMSE = %.2f)', rmse_fp);
% 
% legend([h2, h3], {legend_ekf, legend_fp}, 'Location', 'northwest'); 
% 
% title(cities{i})
% 
% end 
% 
% sgtitle('Resíduos da curva de infectados estimada')
% 
% set(gcf,'PaperUnits','inches','PaperPosition',[0 0 18 4])
% print(gcf, '../figures/error_estimate_sim_beta_mord.png', '-dpng'); % Saves tightly

