%% ################ PLOT LEARNING
%% calc FF for all syls, save next to song file
clear all; close all;

ListOfDirs_UNDIR = {...
    '/bluejay5/lucas/birds/wh6pk36/NEURAL/033017_LMANlearn2'};

ListOfDirs_DIR = {};

ListOfDirs_ALL = [ListOfDirs_UNDIR ListOfDirs_DIR];

ListOfBatch = {...
    'BatchAll'};

FFparams.cell_of_freqwinds={'c', [2100 3100], 'h', [3200 3700], 'b', [2840 3410], ...
    'a', [1520 1820], 's', [4166 4950], 'd', [950 1800],  ...
    'n', [3350 4200], 'v', [2700 3800]};
FFparams.cell_of_FFtimebins={'c', [0.039 0.05], 'h', [0.027 0.036], 'b', [0.034 0.038], ...
    'a', [0.065 0.08], 's', [0.021 0.023], 'd', [0.021 0.028],  ...
    'n', [0.032 0.045], 'v', [0.027 0.031]};
plotAllPC = 0;
plotEachSyl = 0;
overwrite = 1;

% ==================== CALCULATE AND SAVE FF
lt_batchsong_calcFF(ListOfDirs_ALL, ListOfBatch, FFparams, plotAllPC, plotEachSyl, ...
    overwrite);

%% ==== EXTRACT FF
MotifsToExtract = {'mk(s)d', 'mks(d)', ...
    '(v)bga', 'v(b)ga', 'vbg(a)',...
    'm(n)l', ...
    '(c)hb', 'c(h)b', 'ch(b)', ...
    'kl(c)', 'nl(c)'};
DATSTRUCT = lt_batchsong_extractFF(ListOfDirs_UNDIR, ListOfDirs_DIR, ListOfBatch, MotifsToExtract);


%% ============== PLOT
close all;
TrainON = '30Mar2017-1123';
SwitchTimes = {'31Mar2017-1224'};
subtractMean = 1;
dozscore = 0;

lt_batchsong_plotFF(DATSTRUCT, MotifsToExtract, TrainON, SwitchTimes, ...
    subtractMean, dozscore);