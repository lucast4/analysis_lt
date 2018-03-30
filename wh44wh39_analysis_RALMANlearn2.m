%% MATCHING TEMPLATE - getting all b

clear all; close all;
batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
config = '/bluejay5/lucas/birds/wh44wh39/config_021918_5.evconfig2'; % to get all b
config = '/bluejay5/lucas/birds/wh44wh39/config_031418.evconfig2'; % to get all b

% ================ B1
NoteNum = 0;
syl = 'b';
syl_pre = 'c';
syl_post = '';
check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);

% =================== B2
NoteNum = 1;
syl = 'b';
syl_pre = 'cb';
syl_post = '';
check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);

%% updating config file
clear all ; close all;

config_source = '/bluejay5/lucas/birds/wh44wh39/config_031418.evconfig2';
notenum_source = 1; % 1, 2, ...

config_targ = '/bluejay5/lucas/birds/wh44wh39/config_031418.evconfig2';
notenum_targ = [2]; % array (1, 2. ...)

[config_fname] = lt_evconfig_replaceNotes(config_targ, notenum_targ, config_source, ...
    notenum_source);


%% ##############################################################
%% ##############################################################
%% ####################### CALC FF during learning

%% calc FF for all syls, save next to song file
clear all; close all;

ListOfDirs_UNDIR = {...
    '/bluejay5/lucas/birds/wh44wh39/NEURAL/031418_RALMANlearn2'};
ListOfDirs_DIR = {};

ListOfDirs_ALL = [ListOfDirs_UNDIR ListOfDirs_DIR];

ListOfBatch = {...
    'Batch1139to2028'};

FFparams.cell_of_freqwinds={'b', [2600 4100], 'h', [2800 4000], 'c', [2100 2800], ...
    'n', [1700 2600], 'd', [800 2200], 'k', [1600 2600]}; % 'j', [950 1450], 'l', [1200 1600], 't', [3590 4960]
FFparams.cell_of_FFtimebins={'b', [0.033 0.043], 'h', [0.04 0.05], 'c', [0.045 0.09], ...
     'n', [0.045 0.052], 'd', [0.068 0.074], 'k', [0.038 0.045]}; % 'j', [0.04 0.045], 'l', [0.035 0.039], 't', [0.026 0.033], ...

plotAllPC = 1;
plotEachSyl = 0;
overwrite = 1;

% ==================== CALCULATE AND SAVE FF
lt_batchsong_calcFF(ListOfDirs_ALL, ListOfBatch, FFparams, plotAllPC, plotEachSyl, ...
    overwrite);

%% ==== EXTRACT FF
MotifsToExtract = {'c(b)', 'cb(b)', '(d)', '(k)', 'k(c)', 'kc(c)', '(n)', ...
    'n(h)', 'nh(h)'};
DATSTRUCT = lt_batchsong_extractFF(ListOfDirs_UNDIR, ListOfDirs_DIR, ListOfBatch, MotifsToExtract);


%% ============== PLOT
close all;
TrainON = '14Mar2018-1338';
SwitchTimes = {};
subtractMean = 1;
dozscore =1 ;

lt_batchsong_plotFF(DATSTRUCT, MotifsToExtract, TrainON, SwitchTimes, subtractMean, ...
    dozscore);
