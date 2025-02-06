function ax= plot_residuos(pos, nrows, ncols, data, beta_fp_mord, beta_enkf_mord, curve, city)

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

ax = subplot(nrows, ncols, pos);

plot(date, beta_fp_mord(1:52,ref+i) - casos, '.', 'color', 'red', 'markersize', 12 )
hold on 
plot(date, beta_enkf_mord(:,ref+i) - casos, '.', 'color', 'blue', 'markersize', 12 )

title(year(data.data_iniSE(2)))

legend('FP - MSEI_1', 'EnKF - MSEI_2')

xlabel('Data')

end 