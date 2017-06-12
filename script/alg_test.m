%
% Testing Script for Distributed Local Search Algorithm
%

% Global Values
% Range of universe sizes
N = 100:50:600;
% Range of approximate factors
epsilons = [0.1];
% Number of machines
machines = {@(x) floor(log(x))}; % @(x)ceil(log(x)), @(x)ceil(sqrt(x))};

% Plot toggles
plt_vals = 1;
plt_rounds = 1;
plt_gains = 1;

rounds = zeros(1,length(N));
for m = 1:length(machines)
    f = machines{m};
    if m == 1; mchn = 'log(n)'; 
    elseif m==2; mchn = 'sqrt(n)';
    else mchn = 'n^(1-eps)'; 
    end
    for eps = epsilons
        for j = 1:length(N)
            % Local Parameters
            n = N(j);
            V = 1:n;
            
%             A = randi([0 1],n,n);        
%             F = sfo_fn_cutfun(A);
            sigma = rand(n);
            sigma = sigma'*sigma;
            F = sfo_fn_mi(sigma,1:n);
            p = f(n);
            % Run algorithm
            [num_rounds,funcValues,imprvmts] = LocalSearchDist(F,V,eps,p);
            rounds(j) = num_rounds;
            if plt_vals == 1 && j == length(N)
                % Run centralized local search
                LSCval = localSearch(F,V,eps);
                % Plot function Values 
                params = {num_rounds,funcValues,LSCval,mchn,eps,n,'MI'};
                generatePlots(1,params);
            end
            if plt_gains == 1 && j == length(N)
                params = {num_rounds,imprvmts,mchn,eps,n,'MI'};
                generatePlots(3,params);
            end
        end

        if plt_rounds == 1
            % plot number of Rounds 
            params = {rounds,mchn,eps,N,'MI'};
            generatePlots(2,params)
        end
    end
end

