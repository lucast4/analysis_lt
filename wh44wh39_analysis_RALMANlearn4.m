%% MATCHING TEMPLATE - getting c2
clear all; close all;
batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
config = '/bluejay5/lucas/birds/wh44wh39/config_041718.evconfig2'; % to get all b

% ================ C2
NoteNum = 0;
syl = 'c';
syl_pre = 'c';
syl_post = '';
check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);

%% MATCHING TEMPLATE - getting both c1 and c2
clear all; close all;
batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
config = '/bluejay5/lucas/birds/wh44wh39/config_041718_2.evconfig2'; % to get all b

% ================ C2
NoteNum = 0;
syl = 'c';
syl_pre = 'c';
syl_post = '';

% ============== C1
NoteNum = 0;
syl = 'c';
syl_pre = 'k';
syl_post = '';

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);


%% ################ PLOT LEARNING
%% calc FF for all syls, save next to song file
clear all; close all;

ListOfDirs_UNDIR = {...
    '/bluejay5/lucas/birds/wh44wh39/NEURAL/041718_RALMANlearn4'};

ListOfDirs_DIR = {};

ListOfDirs_ALL = [ListOfDirs_UNDIR ListOfDirs_DIR];

ListOfBatch = {...
    'Batch1108to2226'};

FFparams.cell_of_freqwinds={'b', [2600 4100], 'h', [2700 4000], 'c', [2100 2800], ...
    'n', [1600 2600], 'k', [1600 2600]}; % 'j', [950 1450], 'l', [1200 1600], 't', [3590 4960]
FFparams.cell_of_FFtimebins={'b', [0.033 0.043], 'h', [0.04 0.05], 'c', [0.045 0.06], ...
     'n', [0.045 0.052], 'k', [0.038 0.045]}; % 'j', [0.04 0.045], 'l', [0.035 0.039], 't', [0.026 0.033], ...

plotAllPC = 0;
plotEachSyl = 0;
overwrite = 1;

% ==================== CALCULATE AND SAVE FF
lt_batchsong_calcFF(ListOfDirs_ALL, ListOfBatch, FFparams, plotAllPC, plotEachSyl, ...
    overwrite);

%% ==== EXTRACT FF
MotifsToExtract = {'c(b)', 'cb(b)', '(k)', 'k(c)', 'kc(c)', '(n)', ...
    'n(h)', 'nh(h)'};
DATSTRUCT = lt_batchsong_extractFF(ListOfDirs_UNDIR, ListOfDirs_DIR, ListOfBatch, MotifsToExtract);


%% ============== PLOT
close all;
TrainON = '17Apr2018-1211';
SwitchTimes = {'17Apr2018-1556'};
subtractMean = 1;
dozscore = 0;

lt_batchsong_plotFF(DATSTRUCT, MotifsToExtract, TrainON, SwitchTimes, ...
    subtractMean, dozscore);