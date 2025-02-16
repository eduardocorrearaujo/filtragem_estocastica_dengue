close all;
clear all;
clc 

run("variables.m")

beta_fp = readtable('../simulations/sim_FP_cos.csv'); 
beta_fp = table2array(beta_fp);

beta_ekf = readtable('../simulations/sim_EKF_cos.csv'); 
beta_ekf = table2array(beta_ekf);

nAmostras = 52; 

betas = 0.7*ones(nAmostras, 3);
etas = 0.7*ones(nAmostras, 3);


beta_vec_ref = NaN(52, 3);
beta_vec_fp = NaN(52, 3); 
beta_vec_ekf = NaN(52, 3); 

for t=1:52 
    beta_vec_ref(t,:) = beta_cos(t, [0.7, 0.7, 0.7], [0.7, 0.7, 0.7], ZITAS, PHIS);
    beta_vec_fp(t,:) = beta_cos(t, beta_fp(t, 10:12), beta_fp(t, 13:15), ZITAS, PHIS);
    beta_vec_ekf(t,:) = beta_cos(t, beta_ekf(t, 10:12), beta_ekf(t, 13:15), ZITAS, PHIS);

end


n= nAmostras;

%%
noise_samples = readtable('../simulations/noise_samples_cos.csv'); 
noise_samples = table2array(noise_samples(1:52, :)); 


figure(1)

cities = {'Cascavel', 'Foz do Iguaçu', 'Toledo'}; 

for i =1:3

% série temporal dos novos casos 
subplot(3,3,i)

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

legend([h1, h2, h3], {'Dados', legend_ekf, legend_fp}, 'Location', 'best'); 
title(cities{i})
ylabel('Novos casos')
xlabel('Semana')

% serie temporal dos valores de beta estimados 
subplot(3,3, 3+i)

plot(betas(:, i), 'Color','black')
hold on 
plot(beta_ekf(:, 9+i), 'Color','blue')
hold on 
plot(beta_fp(:, 9+i), 'Color', 'red')
grid on 
hold on 
ylabel(sprintf('\\beta_0^{%d}', i))

rmse_ekf = sqrt(sum((betas(:,i)- beta_ekf(:, 9+i)).^2) / n);
rmse_fp = sqrt(sum((betas(:,i)- beta_fp(:, 9+i)).^2) / n);

legend_ekf= sprintf('EnKF (RMSE = %.2f)', rmse_ekf);
legend_fp= sprintf('FP (RMSE = %.2f)', rmse_fp);

legend('Real', legend_ekf, legend_fp, 'Location', 'best'); 
title(sprintf('\\beta_{0}^{%d} estimado', i), 'Interpreter', 'tex');
xlabel('Semana')

% serie temporal dos valores de eta estimados 
subplot(3,3, 6+i)

plot(etas(:, i), 'Color','black')
hold on 
plot(beta_ekf(:, 12+i), 'Color','blue')
hold on 
plot(beta_fp(:, 12+i), 'Color', 'red')
grid on 
hold on 

rmse_ekf = sqrt(sum((etas(:,i)- beta_ekf(:, 12+i)).^2) / n);
rmse_fp = sqrt(sum((etas(:,i)- beta_fp(:, 12+i)).^2) / n);

legend_ekf= sprintf('EnKF (RMSE = %.2f)', rmse_ekf);
legend_fp= sprintf('FP (RMSE = %.2f)', rmse_fp);

legend('Real', legend_ekf, legend_fp, 'Location', 'best'); 
title(sprintf('$\\eta^{%d}$ estimado', i), 'Interpreter','latex')
title(sprintf('\\eta^{%d} %s', i, 'estimado'), 'Interpreter', 'tex');

xlabel('Semana')
ylabel(sprintf('\\eta^{%d}', i))
end 

%title('Estimate parameters')
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 20 12.5])
print(gcf, '../figures/results_sim_cos.png', '-dpng'); % Saves tightly


%%

figure(2)
% serie temporal do beta final no tempo estimados
for i =1:3

subplot(1,3, i)

plot(beta_vec_ref(:, i), 'Color','black')
hold on 
plot(beta_vec_ekf(:, i), 'Color','blue')
hold on 
plot(beta_vec_fp(:, i), 'Color', 'red')
grid on 
hold on 

rmse_ekf = sqrt(sum((beta_vec_ref(:,i)- beta_vec_ekf(:, i)).^2) / n);
rmse_fp = sqrt(sum((beta_vec_ref(:,i)- beta_vec_fp(:, i)).^2) / n);

legend_ekf= sprintf('EnKF (RMSE = %.2f)', rmse_ekf);
legend_fp= sprintf('FP (RMSE = %.2f)', rmse_fp);

legend('Real', legend_ekf, legend_fp, 'Location', 'best'); 
%title('\beta_{k}^{1} estimado')
title(strcat(cities{i}, '-', 'MSEI_1'))
xlabel('Semana')
ylabel('\beta')
end 

%title('Estimate parameters')
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 18 4])
print(gcf, '../figures/results_beta_sim_cos.png', '-dpng'); % Saves tightly


% %% 
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
% %h4 = plot(beta_llfp(:, 3+i) - noise_samples(:, i), 'Color', 'cyan');
% %hold on 
% grid on 
% 
% rmse_ekf = sqrt(sum((noise_samples(:,i)- beta_ekf(:, 3+i)).^2) / n);
% rmse_fp = sqrt(sum((noise_samples(:,i)- beta_fp(:, 3+i)).^2) / n);
% %rmse_llfp = sqrt(sum((noise_samples(:,i)- beta_llfp(:, 3+i)).^2) / n);
% 
% legend_ekf= sprintf('EnKF (RMSE = %.2f)', rmse_ekf);
% legend_fp= sprintf('FP (RMSE = %.2f)', rmse_fp);
% %legend_llfp= sprintf('LLFP (RMSE = %.2f)', rmse_llfp);
% 
% legend([h2, h3], {legend_ekf, legend_fp}, 'Location', 'northwest'); 
% %legend([h2, h3, h4], {legend_ekf, legend_fp, legend_llfp}, 'Location', 'northwest'); 
% 
% title(cities{i})
% 
% end 
% 
% sgtitle('Resíduos da curva de infectados estimada')
% 
% %title('Estimate parameters')
% set(gcf,'PaperUnits','inches','PaperPosition',[0 0 18 4])
% print(gcf, '../figures/error_estimate_sim_beta.png', '-dpng'); % Saves tightly
% 
