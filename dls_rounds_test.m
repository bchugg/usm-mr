% 
% Testing script to test rounds versus number of machines
clear all; clc;

n = 600;
V = 1:n;
machines = 2:3:n^0.75;
eps = 0.1;
num_reps = 3;

rounds = zeros(1,length(machines));
for m = 1:length(machines)
    A = randi([0 1],n,n);        
    F = sfo_fn_cutfun(A);
    ave_rounds = 0;
    for i = 1:num_reps
        [num_rounds,~,~] = LocalSearchDist(F,V,eps,machines(m));
        ave_rounds = ave_rounds + num_rounds;
    end 
    rounds(m) = ave_rounds / num_reps;
end

% Plot

figure; hold on;
fit = polyfit(machines,rounds,2);
plot(machines, rounds, 'o-');
plot(machines,polyval(fit,machines),'g');
t = sprintf('Number of rounds vs number of machines,n=%d,eps=%1.3f',n,eps);
title(t);
xlabel('Number of machines');
ylabel('Number of rounds');
filename = sprintf('CUTFUNC_roundstest_n=%d_reps=%d.png',n,num_reps);
saveas(gcf,filename);


