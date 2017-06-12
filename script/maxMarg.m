function val = maxMarg(F,U)
% 
% Return the element with maximum marginal 
% in U with respect to submodular function F
% 

max_marg = [0,0];
for i = U   
    marg = F(i);
    if marg > max_marg(1)
        max_marg(1) = marg;
        max_marg(2) = i;
    end
end

val = max_marg(2);
