function [] = generatePlots(whichPlot, params)
%
% Plot and save results. whichPlot specifies which plot
% to generate, params are specific to that plot
%
if whichPlot == 1
    plotFuncValues(params);
elseif whichPlot == 2
    plotNumRounds(params);
elseif whichPlot == 3
    plotNumImprovements(params);
end
end

function [] = plotFuncValues(params)
%
% Plot function values
% 
rnds = params{1};
vals = params{2};
LSCval = params{3};
p = params{4};
eps = params{5};
n = params{6};

clear title xlabel ylabel figure;
plot(1:(rnds+1),vals,'b',1:rnds,LSCval,'--*');
title(sprintf('Function Value After Each Eound, p=%s, epsilon=%1.4f, n=%d', p,eps,n));
xlabel('Round');
ylabel('Function Values');
legend('DLS Value', 'CLS Value');
if (length(params) >= 7); 
    savename = strcat(params{7},'_FUNCVALS');
    name = strcat(savename,'_rounds_',num2str(rnds),'_n_',num2str(n));
    name = strcat(name,'_eps_',num2str(eps),'_p_',p,'.png');
    saveas(gcf, name);
end
end

function [] = plotNumRounds(params)
%
% Plot number of rounds taken
%
rounds = params{1}; 
p=params{2}; 
eps=params{3};
N = params{4};

clear title xlabel ylabel figure;
plot(N,rounds,'o-', N,log(N), N,log(N).^2, N,log(N).^3);
title(sprintf('Number of Rounds Until Completion, p=%s, epsilon=%1.4f', p,eps));
xlabel('n');
ylabel('Number of Rounds');
legend('DLS', 'log(n)', 'log^2(n)', 'log^3(n)');
if (length(params) >= 5); 
    savename = strcat(params{5},'_ROUNDS');
    name = strcat(savename,'_N_',num2str(N(1)),':',num2str(N(2)-N(1)),':');
    name = strcat(name,num2str(N(length(N))),'_eps_',num2str(eps),'_p_',p,'.png');
    saveas(gcf, name);
end
end

function [] = plotNumImprovements(params)
%
% Plot number of improvements made each round
%
rnds = params{1};
improvements = params{2};
p=params{3}; 
eps=params{4};
n = params{5};

clear title xlabel ylabel figure;
plot(1:rnds,improvements,'o-');
title(sprintf('Progression of Improvements, p=%s, epsilon=%1.4f, n=%d', p,eps,n));
xlabel('Round');
ylabel('Number of Improvements made');
if (length(params) >= 5); 
    savename = strcat(params{6},'_IMPRVMTS');
    name = strcat(savename,'_rounds_',num2str(rnds),'_n_',num2str(n));
    name = strcat(name,'_eps_',num2str(eps),'_p_',p,'.png');
    saveas(gcf, name);
end
end


