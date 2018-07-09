%% calc FF for all syls, save next to song file
clear all; close all;

    ListOfDirs_ALL = {...
        '/bluejay5/lucas/birds/bu77wh13/NEURAL/020517_LMANlearn1'};
    ListOfBatch = {...
        'BatchAll'};

FFparams.cell_of_freqwinds={'b', [2750 3600], 'h', [2900 3490], 'a', [1250 2250], ...
    'k', [1450 2550], 'g', [2460 2950]};
FFparams.cell_of_FFtimebins={'b', [0.036 0.044], 'h', [0.037 0.045], ...
    'a', [0.062 0.081], 'k', [0.042 0.058], 'g', [0.036 0.048]};

plotAllPC = 0;
plotEachSyl = 0;
overwrite = 1;

% ==================== CALCULATE AND SAVE FF
lt_batchsong_calcFF(ListOfDirs_ALL, ListOfBatch, FFparams, plotAllPC, plotEachSyl, ...
    overwrite);

%% ==== EXTRACT FF
MotifsToExtract = {'pj(a)b','pja(b)', ...
    'ij(b)', 'ijb(h)', ...
    'n(k)', 'o(k)', 's(k)'};
% - below, including some that are end of same motif of target (pja(b))
% MotifsToExtract = {'pj(a)b','pja(b)', ...
%     'ij(b)', 'ijb(h)', ...
%     'h(g)', 'n(k)', 'o(k)', 'g(k)', 's(k)'};
DATSTRUCT = lt_batchsong_extractFF(ListOfDirs_ALL, {}, ListOfBatch, MotifsToExtract);

%% ======= PLOT 
close all;
TrainON = '05Feb2017-1718';
SwitchTimes = {'07Feb2017-1509', '12Feb2017-1309'};
subtractMean = 1;
dozscore = 1;

lt_batchsong_plotFF(DATSTRUCT, MotifsToExtract, TrainON, SwitchTimes, ...
    subtractMean, dozscore);
