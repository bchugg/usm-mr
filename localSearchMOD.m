function [val, sol] = localSearchMOD(F,U,eps)
%
% Run modified local search for submodular function F 
% on universe U. 
% 
% Modification:
% Look for all additions, then look for all removals, don't repeat. 

n = length(U);
alpha = 1+eps/n^2;

% Find maximum marginal
v = maxMarg(F,U);
S = [v];

gain = true;
while gain == true
    C = setdiff(U,S);
    flag = 0;
    for u = C
        % Look for additions
        if F([S,u]) >= alpha*F(S)
            S = [S,u];
            flag = 1;
        end
    end
    if flag ~= 1
        % Did not add anything, Look for removals
        gain = false;
        for u = S
            if F(setdiff(S,u)) >= alpha*F(S)
                S = setdiff(S,u);
                gain = true;
            end
        end
    end
    gain = false;
end

val = F(S);
sol = S;


