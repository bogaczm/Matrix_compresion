t = [1:31];

for size = 4:5
    for random_seed_sys = 10:12
        rng(random_seed_sys)
        sys = drss(size);
        
        signal= step(sys, t);
        
        figure()
        hold on
        scatter(t,signal,'MarkerFaceColor','g');
        title(strcat('Step response for model rank:  ', string(size), ' and randomseed:  ', string(random_seed_sys)))
        legend('Model step response');xlabel('Sample');ylabel('Response');
        grid on

    end
end
