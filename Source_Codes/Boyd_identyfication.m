function [y_oryg, y_noise, y_final, rank_real, rank_final] = Boyd(sys, n, signal_type, noise_type, random_seed, upper_limit, lower_limit, do_charts)
    % entry system rank
    rank_real = rank(sys.A);
    % number of collected samples
    n_size = n; % usually 16
    
    % generating base signal
    if signal_type == 1
        [y_oryg, t] = step(sys, 2*n_size);
    elseif signal_type == 2
        [y_oryg, t] = impulse(sys, 2*n_size);
    end
    
    % optional noise
    rng(random_seed);
    if noise_type == 1
        y_noise = y_oryg + 0.1*randn(size(y_oryg));
    elseif noise_type == 2
        y_noise = y_oryg + 0.1*randi(size(y_oryg));
    elseif noise_type == 3
        y_noise = y_oryg + 0.1*sin(size(y_oryg));
    elseif noise_type == 4
        y_noise = y_oryg;
    end
    
    % creating boundries for optimalization function 
    UB = y_noise + upper_limit;
    LB = y_noise - lower_limit;

    % plotting the starting characteristics\
    if do_charts == 1
        figure()
        title('Generated optimized response')
        grid on
        xlabel('Time')
        ylabel('Signal value')
        hold on
        scatter(t, y_oryg, 'o', 'MarkerFaceColor', 'm', 'MarkerEdgeColor', 'm')
        scatter1 = scatter(t, y_noise, 'o', 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k')
        scatter1.MarkerFaceAlpha = 0.2;
        plot(t(1:20), UB(1:20), 'r--', 'LineWidth', 0.5)
        plot(t(1:20), LB(1:20), 'b--', 'LineWidth', 0.5)
    end
    
    % Heuristic
    % preparing optimization data
    n_size = 16;
    n = n_size;
    d = 1e-6;
    Yk = eye(n_size);
    Zk = eye(n_size);
    
    % using heuristics to lower the matrix rank
    N = 2;
    for k = 1:N
        Q = inv(blkdiag(Yk,Zk) + d*eye(2*n));

        cvx_clear
        cvx_begin
            variable X(n,n) symmetric 
            variable Y(n,n) 
            variable Z(n,n)
            minimize ( trace(Q*[Y zeros(n,n); zeros(n,n) Z]) )
            subject to
            [Y X; X' Z] == hermitian_semidefinite( 2*n )
            LB(1:n) <= cumsum(X(:,1)) <= UB(1:n)
        cvx_end
        Yk = Y;
        Zk = Z;
    end
    
    rank_final = rank(X)
    
    h = [X(:,1); X(2:end,n)];
    N = length(t);
    y_final = cumsum(h(1:min(N,2*n-1)));
        
    if do_charts == 1
        plot(t(1:min(N,2*n-1)), cumsum(h(1:min(N,2*n-1))),'s','MarkerSize',6,'MarkerEdgeColor','b','MarkerFaceColor','b')
    end
        legend('Original response','Response with added noise', 'Upper bound','Lower bound','Optimizedsystem response', 'Location', 'southeast')
end
