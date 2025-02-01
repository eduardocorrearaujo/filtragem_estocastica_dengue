addpath('../utils');
warning('off', 'MATLAB:table:ModifiedAndSavedVarNames');
clear
close all
clc

for year = 2019:2024
    % ensemble
    % cos
    [noise_samples, Xi] = fn_enkf_cos(year);
    writematrix(Xi, sprintf('../simulations/sim_ENKF_cos_real_%d.csv', year));
    % mord
    [noise_samples, Xi] = fn_enkf_mord(year);
    writematrix(Xi, sprintf('../simulations/sim_ENKF_mord_real_%d.csv', year));

    % FP 
    % cos
    [noise_samples, XHat1, wp, Ls_v, n_] = fn_fp_cos(year);
    writematrix(XHat1, sprintf('../simulations/sim_FP_cos_real_%d.csv', year));

    % mord 
    [noise_samples, XHat1, wp, Ls_v, n_] = fn_fp_mord(year);
    writematrix(XHat1, sprintf('../simulations/sim_FP_mord_real_%d.csv', year));

end 

