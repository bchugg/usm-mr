function [val, sol] = localSearch(F,U,eps,S)
%
% Run local search for submodular function F 
% on universe U

n = length(U);
alpha = 1+eps/n^2;

% If no seed solution specified, find max marginal
if nargin < 4
    v = maxMarg(F,U);
    S = [v];
end

gain = true;
while gain == true
    C = setdiff(U,S);
    flag = 0;
    for u = C
        % Look for additions
        if F([S,u]) >= alpha*F(S)
            S = [S,u];
            flag = 1;
            break;
        end
    end
    if flag ~= 1
        % Did not add anything, Look for removals
        gain = false;
        for u = S
            if F(setdiff(S,u)) >= alpha*F(S)
                S = setdiff(S,u);
                gain = true;
                break;
            end
        end
    end
end

val = max(F(S),F(setdiff(U,S)));
if val == F(S); sol = S; else sol = setdiff(U,S); end


