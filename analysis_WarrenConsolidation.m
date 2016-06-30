clear all; close all;

PBS= ...
    [140 210;
    3.1 2.85;
    2.8 3.15;
    4.1 3.1;
    3.2 2.7;
    3.35 3.1;
    240 310;
    2.8 2.7];  % [earlyPBS earlyMUSC]


MUSC = ...
    [55 180;
    2 3;
    1.85 2.25;
    3.6 3.1;
    2.6 2.95;
    2.3 2.55;
    150 185;
    2.05 2.5];  % [latePBS lateMUSC]


%% ==== plot

lt_figure; hold on;

% first normalize all values to PBS early value

NormVect=PBS(:,1);

for i=1:2
    PBS(:,i)=PBS(:,i)./NormVect;
    MUSC(:,i)=MUSC(:,i)./NormVect;
end



plot([1 2], PBS, 'ob');
plot([1 2], MUSC, 'or');

% plot means
lt_plot_bar([0.8 1.8], mean(PBS), {'Errors',lt_sem(PBS), 'BarWidth', 0.3, 'Color','b'})
lt_plot_bar([1.2 2.2], mean(MUSC), {'Errors',lt_sem(MUSC), 'BarWidth', 0.3, 'Color','r'})


xlim([0 3])


%% ==== plot each expt separately

lt_figure;
hold on;

numexpts=size(PBS, 1);

for i=1:numexpts;
    lt_subplot(numexpts/2,2,i); hold on;
    
    plot([1 2], PBS(i, :), '-ob');
    plot([1 2], MUSC(i, :), '-or');
    
    xlim([0 3]);
    
    ylim([0 1.5]);
    line(xlim, [1 1], 'Color','k')
end
    
    
    
    
    
    
    