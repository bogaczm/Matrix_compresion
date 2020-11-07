% Function creating rank optimized system identified with Hankel matrix

% INPUT:
% do_boundries - use boundries in optimization
% n_size - the size of the initial Markov parameters matrix
% sys - identified system
% signal_type - 
% random_seed - random seed for generator, for creating noise in the system
% noise_type - 'natural' 'uniform' 'sinus' 'none'
% upper_limit, lower_limit - limits of boundries
% epsilon - optimalization factor
% iden_sysRank - how big should be final system
% do_charts - show chart [1/0]

% OUTPUT:
% y_oryg - original systems signal
% y_noise - signal with noise
% y_final - signal after optimization 
% y_notCut - signal straigth after optimization 
% rank_real - rank of real system 
% rank_opt - rank after optimization
% rank_optCut - rank after cutting'
% MAE - mean absolute error
% MSE - mean square error
% RMSE - Root mean square error

function [y_oryg, y_noise, y_final, y_notCut, rank_real, rank_opt, rank_optCut, h_oryginal, h_final, MAE, MSE, RMSE] = ...
    Fusion_identyfication(do_boundries, n_size, sys, signal_type, random_seed, noise_type, noise_level, upper_limit, lower_limit,...
    epsilon, iden_sysRank, do_charts)
    
    rank_real = rank(sys.A);
    
    % number of Markov parameters
    if signal_type == 1
        [y_oryg, t] = step(sys, 2*n_size-2);
    elseif signal_type == 2
        [y_oryg, t] = impulse(sys, 2*n_size-2);
    end
    % original Markov parameters 
    [h_oryginal, t] = impulse(sys, 2*n_size-2);
     
    % seeding the random generator
    % addind noise depending on seed
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
    % creating boundries for optimalization function 
    UB = y_noise + upper_limit;
    LB = y_noise - lower_limit;
    
    % plotting the starting characteristics
    if do_charts == 1
        figure()
        title('Hankel matrix identification')
        grid on
        xlabel('Time')
        ylabel('Signal value')
        hold on
        scatter(t, y_oryg, 'o', 'MarkerFaceColor', 'm', 'MarkerEdgeColor', 'm')
        scatter1 = scatter(t, y_noise, 'o', 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k')
        scatter1.MarkerFaceAlpha = 0.2;
        plot(t, UB, 'r--', 'LineWidth', 0.5)
        plot(t, LB, 'r--', 'LineWidth', 0.5)
    end
    
    % preparing optimization data
    n_size = 16;
    n = n_size;
    d = 1e-6;
    Yk = eye(n_size);
    Zk = eye(n_size);
    
    % creating Hankel matrix wieth noise
    % input in lower triangular matrix
    u_t = tril(ones(length(y_oryg)));
    H_noise = pinv(u_t).*y_noise';
    H_noise = H_noise(1:16, 1:16); 
    
    N = 2;
    % wage between optimization parts (0 - 1)
    epsilon_1 = 1 - epsilon;
    epsilon_2 = epsilon;
    
    if do_boundries == 1
        
        for k = 1:N
            Q = inv(blkdiag(Yk,Zk) + d*eye(2*n));
            cvx_clear
            cvx_begin
                variable H(n,n) symmetric 
                variable Y(n,n) 
                variable Z(n,n)
                minimize (epsilon_1 * trace(Q*[Y zeros(n,n); zeros(n,n) Z]) + epsilon_2 * norm(H-H_noise,'fro'))  % 
                subject to
                [Y H; H' Z] == hermitian_semidefinite( 2*n )
                LB(1:n) <= cumsum(H(:,1)) <= UB(1:n)
            cvx_end
            Yk = Y;
            Zk = Z;
        end
       
    else 
        
         for k = 1:N
            Q = inv(blkdiag(Yk,Zk) + d*eye(2*n));

            cvx_clear
            cvx_begin
                variable H(n,n) symmetric 
                variable Y(n,n) 
                variable Z(n,n)
                minimize (epsilon_1 * trace(Q*[Y zeros(n,n); zeros(n,n) Z])) %% 
                subject to
                [Y H; H' Z] == hermitian_semidefinite( 2*n )
                LB(1:n) <= cumsum(H(:,1)) <= UB(1:n)
            cvx_end
            Yk = Y;
            Zk = Z;
        end
        
        for k = 1:N
            Q = inv(blkdiag(Yk,Zk) + d*eye(2*n));

            cvx_clear
            cvx_begin
                variable H(n,n) symmetric 
                variable Y(n,n) 
                variable Z(n,n)
                minimize (epsilon_1 * trace(Q*[Y zeros(n,n); zeros(n,n) Z]) + epsilon_2 * norm(H-H_noise,'fro')) %% 
                subject to
                [Y H; H' Z] == hermitian_semidefinite( 2*n )
            cvx_end
            Yk = Y;
            Zk = Z;
        end
    end
        
    % rank of system straight from identyfication
    rank_opt = rank(H);
    % creating vector of markov parameters and displaying identivied system
    h = [H(:,1);H(2:end,n)];
    N = length(t);
    % chart after identyfication 
    y_notCut = cumsum(h(1:min(N,2*n-1)));
    if do_charts
        scatter2 = scatter(t(1:min(N,2*n-1)),cumsum(h(1:min(N,2*n-1))),'o','MarkerEdgeColor','b','MarkerFaceColor','b')
        scatter2.MarkerFaceAlpha = 0.2;
    end
    
    % Hankel
    n = 15;
    m = size(sys.b,2); % number of inputs
    p = size(sys.c,1); % number of outputs
    % creating Hankel matrix 
    H0 = hankel(h(1:n),h(n:2*n-1));
    H1 = hankel(h(2:n+1),h(n+1:2*n));
    H0_rank = rank(H0);
    [U,S,V] = svd(H0);
    U = U(:,1:H0_rank);
    V = V(:,1:H0_rank);
    sValFull = diag(S);
    sVal = sValFull(1:H0_rank);
    sValInv = 1./sVal;
    S = diag(sVal);
    
    % creating identivied sys
    Rc = S^(1/2)*V';
    Ro = U*S^(1/2);
    A = S^(-1/2)*U'*H1*V*S^(-1/2);
    B = Rc(:,1:m); 
    C = Ro(1:p,:);
    D = [];
    
    % cutting the matrices to right size
    A = A(1:iden_sysRank,1:iden_sysRank);
    B = B(1:iden_sysRank,1:m);
    C = C(1:p,1:iden_sysRank);
    
    rank_optCut = rank(A);
    
    % creating final system, plotting results
    sys_final = ss(A,B,C,0,[]);
    if signal_type == 1
        [y_final, t] = step(sys_final, 2*n_size-2);
    elseif signal_type == 2
        [y_final, t] = impulse(sys_final, 2*n_size-2);
    end
    % creating Markov parameter vector
    [h_final, t] = impulse(sys_final, 2*n_size-2);
    
    if do_charts
%         plot(t(1:(length(t)-2)),y_final(2:length(y_final)-1),'.','MarkerSize',16,'MarkerEdgeColor','g','MarkerFaceColor','g')
        axis('tight')
        legend('Original response','Response with added noise','LB','UB','Output before rank minimization','Output after rank minimization','Location', 'southeast')
        xlabel('k')
        if do_boundries
            title('System identyfication with rank computation (Hybrid with boundries)')
        else 
            title('System identyfication with rank computation (Hybrid no boundries)')
        end      
        ylabel('y_{k}')
    end
    
    y_final = y_final(2:length(y_final));
    
    MAE = sum(abs(y_final - y_oryg(1:(length(y_oryg)-1)))/(length(y_final)-1))
    MSE = sum((y_final- y_oryg(1:(length(y_oryg)-1))).^2)/(length(y_final)-1)
    RMSE = sqrt(sum((y_final)- y_oryg(1:(length(y_oryg)-1))).^2)/(length(y_final)-1)
    
%     if do_charts
%         figure()
%         scatter(t(1:length(t)-1), h_final(2:length(t)), 'o', 'MarkerFaceColor', 'g', 'MarkerEdgeColor', 'g')
%         hold on
%         scc = scatter(t, h_oryginal, 'o', 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k')
%         scc.MarkerFaceAlpha = 0.2;
%         xlabel('k')
%         title('Impulse response Hybrid')
%         ylabel('y_{k}')
%         legend('Identyfied', 'Original','Location', 'southeast')
%         grid on
%     end
end
