%% calc FF for all syls, save next to song file
clear all; close all;

    ListOfDirs_ALL = {...
        '/bluejay5/lucas/birds/or74bk35/NEURAL/051217_LMANneural2'};
    ListOfBatch = {...
        'BatchAll'};

FFparams.cell_of_freqwinds={'a', [1350 2400], 'g', [1370 1900], ...
    'n', [3000 4300], 'b', [2750 3900]};
FFparams.cell_of_FFtimebins={'a', [0.05 0.063], 'g', [0.1 0.106], ...
    'n', [0.04 0.05], 'b', [0.033 0.041]};

plotAllPC = 0;
plotEachSyl = 0;
overwrite = 1;

% ==================== CALCULATE AND SAVE FF
lt_batchsong_calcFF(ListOfDirs_ALL, ListOfBatch, FFparams, plotAllPC, plotEachSyl, ...
    overwrite);

%% ==== EXTRACT FF
    MotifsToExtract = {'ja(b)', 'ba(b)', 'an(b)', 'h(b)', ...
                        'ja(n)', 'ba(n)', ...
                        'm(a)', 'a(a)', 'j(a)'}; % NOTE: could potentially add g (but is after WN, but long gap)
DATSTRUCT = lt_batchsong_extractFF(ListOfDirs_ALL, {}, ListOfBatch, MotifsToExtract);

%% ======= PLOT 
close all;
TrainON = '12May2017-1616';
SwitchTimes = {};
subtractMean = 1;
dozscore = 1;

lt_batchsong_plotFF(DATSTRUCT, MotifsToExtract, TrainON, SwitchTimes, ...
    subtractMean, dozscore);
