close all 
clear all

% inicjalizacja 
do_boundries = 1; no_boundries = 0;
n_size = 16;
upper_limit = 0.2; lower_limit = 0.2;
do_chart = 1; no_chart = 0;
noise_level = 0.1;
% TABLES FOR FUSION AL.
% preparing tables for results with boundries
y_noise_b = []; y_oryg_b = []; y_final_b = []; y_notCut_b = [];
rank_real_b = []; rank_opt_b = []; rank_optCut_b = [];
MAE_b = []; MSE_b = []; RMSE_b = [];
h_final_b = []; h_oryginal_b = [];

% preparing tables for results without boundries
y_noise_nb = []; y_oryg_nb = []; y_final_nb = []; y_notCut_nb = [];
rank_real_nb = []; rank_opt_nb = []; rank_optCut_nb = [];
MAE_nb = []; MSE_nb = []; RMSE_nb = [];
h_final_nb = []; h_oryginal_nb = [];

% TABLES FOR ERA AL.
% rank 5
y_noise_era = []; y_oryg_era = []; y_final_era = []; y_notCut_era = [];
rank_real_era = []; rank_opt_era = []; rank_optCut_era = [];
MAE_era = []; MSE_era = []; RMSE_era = [];
h_final_era = []; h_oryginal_era= [];

n_epsilon = 0;
n = 0;
% uruchomienie dla uk³adu z ograniczeniami
% losowanie testowanego uk³adu 
for random_seed_sys = 10:10
    rng(random_seed_sys)
    sys = drss(5);
    % zmiana seedu do losowania zaszumienia 
    for random_sys_noise = 1:1
        % zmiana wag optymalizacyjnych 
        n_epsilon = 0;
        for epsilon = 1:0.1:1
            n_epsilon = n_epsilon + 1;
            % zmiana rank uk³adu finalnego
            for iden_sysRank = 5:5
                n = n + 1;
                % printing actuall settings
                f_format = ['####################### \n random_seed_sys = %d \n random_sys_noise = %d \n '...
                    'epsilon = %1.1f \n iden_sysRank = %d \n####################### \n BOUNDRIES \n#######################'];   
                fprintf(f_format, random_seed_sys, random_sys_noise, epsilon, iden_sysRank);
                
                % Fusion algotithm with boundries
                [y_oryg_temp, y_noise_temp, y_final_temp, y_notCut_temp, rank_real_temp,...
                     rank_opt_temp, rank_optCut_temp, h_o_temp, h_temp, MAE_temp, MSE_temp, RMSE_temp] = ...
                    Fusion_identyfication(do_boundries, n_size, sys, 1, random_sys_noise,...
                    1, noise_level, upper_limit, lower_limit, epsilon, iden_sysRank, do_chart);
                
                % saving predicted data       
                y_noise_b(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = y_oryg_temp; 
                y_oryg_b(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = y_noise_temp; 
                y_final_b(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = y_final_temp; 
                y_notCut_b(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = y_notCut_temp;
                rank_real_b(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = rank_real_temp; 
                rank_opt_b(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = rank_opt_temp; 
                rank_optCut_b(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = rank_optCut_temp;
                MAE_b(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank) = MAE_temp;
                MSE_b(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank) = MSE_temp;
                RMSE_b(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank) = RMSE_temp;
                h_oryginal_b(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = h_o_temp;
                h_final_b(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = h_temp;
                
%                 % Fusion algotithm with NO boundries
%                 f_format = ['####################### \n random_seed_sys = %d \n random_sys_noise = %d \n '...
%                     'epsilon = %1.1f \n iden_sysRank = %d \n####################### \n NO BOUNDRIES \n#######################'];
%                 fprintf(f_format, random_seed_sys, random_sys_noise, epsilon, iden_sysRank);
%                 
%                 [y_oryg_temp, y_noise_temp, y_final_temp, y_notCut_temp, rank_real_temp,...
%                     rank_opt_temp, rank_optCut_temp, MAE_temp, MSE_temp, RMSE_temp] = ...
%                     Fusion_identyfication(no_boundries, n_size, sys, 1, random_sys_noise,...
%                     1, noise_level, upper_limit, lower_limit, epsilon, iden_sysRank, do_chart);
%                 
%                 % saving predicted data   
%                 y_noise_nb(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = y_oryg_temp; 
%                 y_oryg_nb(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = y_noise_temp; 
%                 y_final_nb(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = y_final_temp; 
%                 y_notCut_nb(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = y_notCut_temp;
%                 rank_real_nb(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = rank_real_temp; 
%                 rank_opt_nb(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = rank_opt_temp; 
%                 rank_optCut_nb(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = rank_optCut_temp;
%                 MAE_nb(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank) = MAE_temp;
%                 MSE_nb(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank) = MSE_temp;
%                 RMSE_nb(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank) = RMSE_temp;
%                 h_oryginal_nb(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = h_o_temp;
%                 h_final_nb(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = h_temp;
                
                % Plain ERA
                f_format = ['####################### \n random_seed_sys = %d \n random_sys_noise = %d \n '...
                    'epsilon = %1.1f \n iden_sysRank = %d \n####################### \n ERA \n#######################'];
                fprintf(f_format, random_seed_sys, random_sys_noise, epsilon, iden_sysRank);
                
                [y_oryg_temp, y_noise_temp, y_final_temp, y_notCut_temp, rank_real_temp,...
                    rank_opt_temp, rank_optCut_temp, h_o_temp, h_temp1, MAE_temp, MSE_temp, RMSE_temp] =...
                    ERA_identyfication(sys, n_size, 1, 10, 1, noise_level*random_sys_noise, iden_sysRank, no_chart);
                                
                % saving predicted data
                y_noise_era(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = y_oryg_temp; 
                y_oryg_era(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = y_noise_temp; 
                y_final_era(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = y_final_temp; 
                y_notCut_era(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = y_notCut_temp;
                rank_real_era(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = rank_real_temp; 
                rank_opt_era(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = rank_opt_temp; 
                rank_optCut_era(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = rank_optCut_temp;
                MAE_era(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank) = MAE_temp;
                MSE_era(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank) = MSE_temp;
                RMSE_era(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank) = RMSE_temp;
                h_oryginal_era(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = h_o_temp;
                h_final_era(random_seed_sys, random_sys_noise, n_epsilon, iden_sysRank,:) = h_temp1;
                 
            end
        end
    end
end
