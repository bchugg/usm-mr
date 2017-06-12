function P = randomPartition(V,p)
%
% Randomly partition data into p groups of size 
% n/p, where n is the size of V
%

n = length(V);
perm = randperm(n);
i = 1;
j = 1;
P = cell(p,1);
while i < n
    next = min(i+floor(n/p)-1, n);
    if next <= i; next = i+1; end
    P{j} = perm(i:next);
    j = j+1;
    i = next + 1;
end
    

