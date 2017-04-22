function [rounds,funcValues,imprvmts] = LocalSearchDist(F,U,eps,p)
% 
% Perform distributed local Search on submodular 
% function F with universe U
% 
% - p is number of machines
% - eps is local-optimum factor, i.e., marginals grow by factor
%   of (1+eps/n^2)

v = maxMarg(F,U);
n = length(U);
% Algorithm
gain = true;
S = [v];
rounds = 0;
funcValues = [F(v)];
imprvmts = [];

while gain == true
    fprintf('Starting Round %d for n=%d, p=%d\n',rounds,n,p)
    % Randomly partition data
    P = randomPartition(setdiff(U,S),p);

    % Simulate running local search on each machine
    best_val = -inf;
    best_sol = [];
    for i = 1:length(P)
        [val,sol] = localSearch(F,P{i},eps,S);
        if val >= best_val
            best_val = val;
            best_sol = sol;
        end
    end
    if isequal(best_sol,S)
        % Stop if no progress made
        gain = false;
    end
    imprvmts = [imprvmts, length(setdiff(best_sol,S))];
    S = best_sol;
    rounds = rounds + 1;
    funcValues = [funcValues best_val];
end


