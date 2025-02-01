function [data_f] = filter_data_by_year(data, year)


start_date = datetime(sprintf('%d-01-01', year));
end_date = datetime(sprintf('%d-12-31', year));

columnName = 'data_iniSE';
isColumnPresent = ismember(columnName, data.Properties.VariableNames);

% Display the result
if isColumnPresent

    data_f = data((data.data_iniSE >= start_date) & (data.data_iniSE <= end_date), {'data_iniSE', ...
        'casos_41010', 'casos_41009','casos_41020' });
     
    data_f = data_f(1:52, :);

else

    data_f = data((data.date >= start_date) & (data.date <= end_date), {'date', ...
        'temp_med_41010', 'temp_med_41009','temp_med_41020' });
     
    data_f = data_f(1:52, :);
end 