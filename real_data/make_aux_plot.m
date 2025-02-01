function make_plot(noise_samples, XHat1, year, beta)

tau =1;
nAmostras = length(noise_samples);

colors = [
    1, 0, 0;      % Red
    0, 1, 0;      % Green
    0, 0, 1;      % Blue
    0, 1, 1;      % Cyan
    1, 0, 1       % Magenta
];

% Set the color order for the current axes

set(0, 'DefaultAxesColorOrder', colors)

% if isnan(wp) == false 
% figure(1)
% 
% subplot(3, 1, 1)
% 
% plot(noise_samples, 'o')
% hold on 
% plot( tau.*XHat1(:, 4:6));
% title(sprintf('Medidas (pontos) vs curvas estimadas (linhas) - %d', year))
% hold off
% 
% grid on
% 
% subplot(3, 1, 2)
% 
% plot(1:nAmostras, wp', 'Color', [0.4660 0.6740 0.1880]);
% hold on
% title('Pesos por importância')
% ylabel('Pesos {w^i}_{k}')
% xlabel('Iteração')
% grid on
% 
% subplot(3, 1, 3)
% 
% plot(var(wp))
% grid on 
% title('Variância dos pesos')
% 
% end 
figure(1)

for i=1:3

    subplot(4, 1, i)
    
    plot(noise_samples(:, i), 'o')
    hold on 
    plot( tau.*XHat1(:, 3+i));
    title(sprintf('Medidas (pontos) vs curvas estimadas (linhas) - %d', year))
    %hold off

end 
subplot(4, 1, 4)
plot(XHat1(:, 10:12))


if isequal(beta, 'mord')

    data_temp = readtable('../data/clima_regions_rw.csv');
    data_temp.date = datetime(data_temp.date, 'InputFormat', 'yyyy-MM-dd');
    
    start_date = datetime(sprintf('%d-01-01', year));
    end_date = datetime(sprintf('%d-12-31', year));
    
    data_temp_f = data_temp((data_temp.date >= start_date) & (data_temp.date <= end_date), {'date', ...
        'temp_med_41010', 'temp_med_41009','temp_med_41020' });
    
    temp = table2array(data_temp_f(:, 2:4)); 

    beta_est = NaN(52, 3);

    b_ = 14;
    BS = [b_,b_,b_];    
    c_ = 36;
    CS = [c_,c_,c_];

    for t = 1:52

        beta_est(t,:) = beta_mord(temp(t,:), XHat1(t,10:12), BS,  CS);
    end 

    figure(2)

    plot(beta_est)

    title('\beta_{k}^{2} estimado')

else 
    zita_ =  0.16;
    ZITAS = [zita_, zita_, zita_]; 
    phi_ = -6;
    PHIS = [phi_, phi_, phi_];  

    figure(2)

    beta_vec = NaN(52, 3); 
    for t=1:52 
        beta_vec(t,:) = beta_cos(t, XHat1(t, 10:12), XHat1(t, 13:15), ZITAS, PHIS);
    end 
    

    plot(beta_vec)
    
    title('\beta_{k}^{1} estimado')

    

end 