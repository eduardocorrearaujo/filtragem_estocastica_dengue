function plot_comp_filters(pos, nrows, ncols, data, beta_fp_cos, beta_fp_mord, beta_enkf_cos, beta_enkf_mord, curve, city)

date = data.data_iniSE; 

if isequal(city, 'Cascavel')
    
    casos = data.casos_41010; 
    i =1; 

elseif isequal(city, 'Foz do Iguaçu')
    
    casos = data.casos_41009; 
    i = 2; 

elseif isequal(city, 'Toledo')

    casos = data.casos_41020; 
    i = 3; 

end 

if isequal(curve, 'casos')
    ref = 3;
    ylabel_ = 'Novos casos';

end 

subplot(nrows, ncols, pos)

if isequal(curve, 'casos')
    plot(date, casos, '.', 'color', 'black', 'markersize', 12 )
    hold on 

end

plot(date, beta_fp_cos(:,ref+i), 'Color','red')
hold on 

plot(date, beta_fp_mord(1:52,ref+i), 'Color','red', 'LineStyle','-.')
plot(date, beta_enkf_cos(:,ref+i), 'Color','blue')
plot(date, beta_enkf_mord(:,ref+i), 'Color','blue', 'LineStyle','-.')

title(year(data.data_iniSE(2)))

xlabel('Data')
ylabel(ylabel_)

legend_ekf_cos = ['EnKF - \beta_{k}^{1} ', sprintf('(RMSE = %.2f)', rmse(casos,beta_enkf_cos(:,ref+i) ))];
legend_fp_cos = ['FP - \beta_{k}^{1} ', sprintf('(RMSE = %.2f)', rmse(casos,beta_fp_cos(:,ref+i)))]; 
legend_ekf_mord = ['EnKF - \beta_{k}^{2} ', sprintf('(RMSE = %.2f)', rmse(casos,beta_enkf_mord(:,ref+i)))];
legend_fp_mord = ['FP - \beta_{k}^{2} ', sprintf('(RMSE = %.2f)', rmse(casos,beta_fp_mord(1:52,ref+i)))]; 

if isequal(curve, 'casos')
    legend('Dados', legend_fp_cos, legend_fp_mord, legend_ekf_cos, legend_ekf_mord, 'Location','best');
else
    legend(legend_fp_cos, legend_fp_mord, legend_ekf_cos, legend_ekf_mord);
end 