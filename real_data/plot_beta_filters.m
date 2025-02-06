function ax = plot_beta_filters(pos, nrows, ncols, data_clima, beta_fp_cos, beta_fp_mord, beta_enkf_cos, beta_enkf_mord, city)


date = data_clima.date; 

if isequal(city, 'Cascavel')
    
    i =1; 

elseif isequal(city, 'Foz do Iguaçu')
    
    i = 2; 

elseif isequal(city, 'Toledo')

    i = 3; 

end 


ylabel_ = '\beta';


ax = subplot(nrows, ncols, pos);


plot(date, beta_fp_cos(:,i), 'Color','red')
hold on 

plot(date, beta_fp_mord(1:52, i), 'Color','red', 'LineStyle','-.')
plot(date, beta_enkf_cos(:,i), 'Color','blue')
plot(date, beta_enkf_mord(:,i), 'Color','blue', 'LineStyle','-.')

title(year(data_clima.date(2)))

xlabel('Data')
ylabel(ylabel_, 'FontSize',14)

legend_ekf_cos = 'EnKF - MSEI_1';
legend_fp_cos = 'FP - MSEI_1'; 
legend_ekf_mord = 'EnKF - MSEI_2';
legend_fp_mord = 'FP - MSEI_1'; 

legend(legend_fp_cos, legend_fp_mord, legend_ekf_cos, legend_ekf_mord, 'Location','best');
 
