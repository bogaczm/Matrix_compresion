% Function creating rank optimized system identified with Hankel matrix

% INPUT:
% n_size - the size of the initial Markov parameters matrix
% sys - identified system
% signal_type - 1-'impulse' 2-'step'
% random_seed - random seed for generator, for creating noise in the system
% noise_type - 1-'natural' 2-'uniform' 3-'sinus' 4-'none'
% iden_sysRank - how big should be final system
% do_charts - show chart [1/0]

% OUTPUT:
% y_oryg - original systems signal
% y_noise - signal with noise
% y_final - signal after optimization 
% y_notCut - signal straigth after optimization 
% rank_real - rank of real system 
% rank_iden - rank after optimization
% rank_opt - rank after cutting'
% MAE - mean absolute error
% MSE - mean square error
% RMSE - Root mean square error
% inicjalizacja 

function [y_oryg, y_noise, y_final, y_not_cut, rank_real, rank_iden, rank_opt, h_oryginal, h_final, MAE, MSE, RMSE] = ...
    ERA(sys, n, signal_type, random_seed, noise_type, noise_level, sysRank, do_charts)
    
    rank_real = rank(sys.A);

    % setting matrix sizes
    m = size(sys.b,2); % number of inputs
    p = size(sys.c,1); % number of outputs
    sys.d = zeros(p,m); % we consider a strictly proper system, i.e., D = 0
    % number of collected samples
    n_size = n; % usually 16
    
     % original Markov parameters 
    [h_oryginal, t] = impulse(sys, 2*n_size-2);
    
    % generating base signal
    if signal_type == 1
        [y_oryg, t] = step(sys, 2*n_size);
    elseif signal_type == 2
        [y_oryg, t] = impulse(sys, 2*n_size);
    end
     
    % optional noise
    rng(random_seed);
    if noise_type == 1
        y_noise = y_oryg + noise_level*randn(size(y_oryg));
    elseif noise_type == 2
        y_noise = y_oryg + noise_level*randi(size(y_oryg));
    elseif noise_type == 3
        y_noise = y_oryg + noise_level*sin(size(y_oryg));
    elseif noise_type == 4
        y_noise = y_oryg;
    end
    
    % plotting the starting characteristics\
    if do_charts == 1
        figure()
        title('Hankel matrix identification')
        grid on
        xlabel('Time')
        ylabel('Signal value')
        hold on
        scatter(t, y_oryg, 'o', 'MarkerFaceColor', 'm', 'MarkerEdgeColor', 'm')
        scatter1 = scatter(t, y_noise, 'o', 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k');
        scatter1.MarkerFaceAlpha = 0.2;
        plot(ones(2*n_size-1, 1), 'k')
    end
     
    % applaying algorithm
    % creating Markov parameter vector 
    h = zeros(length(y_noise(2:end)), 1);
    for i = 1:length(y_noise(2:end))    
        h(i+1) = y_noise(i+1) - sum(h(1:i));
    end
    
    H0 = hankel(h(1:n),h(n:2*n-1));
    H1 = hankel(h(2:n+1),h(n+1:2*n));
    [U,S,V] = svd(H0);
    H0rank = rank(H0);
    U = U(:,1:H0rank);
    V = V(:,1:H0rank);
    sValFull = diag(S);
    sVal = sValFull(1:H0rank);
    S = diag(sVal);

    Rc = S^(1/2)*V';
    Ro = U*S^(1/2);
    A = S^(-1/2)*U'*H1*V*S^(-1/2);
    B = Rc(:,1:m);
    C = Ro(1:p,:);
    
    sys_not_cut = ss(A,B,C,0,[]);
    rank_iden = rank(A);
    
    % applaying without rank cut
    if signal_type == 1
        [y_not_cut, t] = step(sys_not_cut, 2*n_size-2);
    elseif signal_type == 2
        [y_not_cut, t] = impulse(sys_not_cut, 2*n_size-2);
    end
    
    if do_charts
        scatter2 = scatter(t,y_not_cut,'o','MarkerEdgeColor','b','MarkerFaceColor','b')
        scatter2.MarkerFaceAlpha = 0.2;
    end
    
    % decresing rank of matrix
    A = A(1:sysRank,1:sysRank);
    B = B(1:sysRank,1:m);
    C = C(1:p,1:sysRank);
    
    rank_opt = rank(A);
    
    % creating systems after cutting
    sys_cut = ss(A,B,C,0,[]);
    
    if signal_type == 1
        [y_final, t] = step(sys_cut, 2*n_size-2);
    elseif signal_type == 2
        [y_final, t] = impulse(sys_cut, 2*n_size-2);
    end
    % creating Markov parameter vector
    [h_final, t] = impulse(sys_cut, 2*n_size-2);

    if do_charts
        plot(t,y_final,'.','MarkerSize',16,'MarkerEdgeColor','g','MarkerFaceColor','g')
        axis('tight')
        legend('Original response','Response with added noise', 'Input signal','Output before rank minimization','Output after rank minimization','Location', 'southeast') %,'Przed zmniejszeniem rzêdu', 'Po zmniejszeniu rzêdu',
        xlabel('k')
        title('System identification')
        ylabel('y_{k}')
     end
    
    MAE = sum(abs(y_final - y_oryg(1:(length(y_oryg)-2)))/(length(y_final)));
    MSE = sum((y_final- y_oryg(1:(length(y_oryg)-2))).^2)/(length(y_final));
    RMSE = sqrt(sum((y_final)- y_oryg(1:(length(y_oryg)-2))).^2)/(length(y_final));

    if do_charts
        figure()
        scatter(t(1:length(t)-1), h_final(2:length(t)), 'o', 'MarkerFaceColor', 'g', 'MarkerEdgeColor', 'g')
        hold on
        scc = scatter(t, h_oryginal, 'o', 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k')
        scc.MarkerFaceAlpha = 0.2;
        xlabel('k')
        title('Impulse response ERA')
        ylabel('y_{k}')
        legend('Identyfied', 'Original','Location', 'southeast')
        grid on
    end
end