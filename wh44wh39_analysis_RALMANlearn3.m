%% MATCHING TEMPLATE - getting all b (targeting b1 and b2)

clear all; close all;
batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
config = '/bluejay5/lucas/birds/wh44wh39/config_032118.evconfig2'; % to get all b
config = '/bluejay5/lucas/birds/wh44wh39/config_032118_2.evconfig2'; % to get all b
config = '/bluejay5/lucas/birds/wh44wh39/config_032118_3.evconfig2'; % to get all b
config = '/bluejay5/lucas/birds/wh44wh39/config_032118_4.evconfig2'; % to get all b

% ================ H1
NoteNum = 0;
syl = 'h';
syl_pre = 'n';
syl_post = '';
check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);

% ======== h2
NoteNum = 0;
syl = 'h';
syl_pre = 'nh';
syl_post = '';
check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);


%% MATCHING TEMPLATE - targeting only b2)

clear all; close all;
batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
config = '/bluejay5/lucas/birds/wh44wh39/config_032118_5.evconfig2'; %
config = '/bluejay5/lucas/birds/wh44wh39/config_032218.evconfig2'; %
config = '/bluejay5/lucas/birds/wh44wh39/config_032318.evconfig2'; %
config = '/bluejay5/lucas/birds/wh44wh39/config_032418.evconfig2'; %

% ======== h2
NoteNum = 0;
syl = 'h';
syl_pre = 'nh';
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



%% ======= plot learning
%% calc FF for all syls, save next to song file
clear all; close all;

ListOfDirs_UNDIR = {...
    '/bluejay5/lucas/birds/wh44wh39/NEURAL/032118_RALMANlearn3', ...
    '/bluejay5/lucas/birds/wh44wh39/NEURAL/032418_RALMANlearn3', ...
    '/bluejay5/lucas/birds/wh44wh39/NEURAL/040118_RALMANlearn3_audioonly'};


ListOfDirs_DIR = {...
    '/bluejay5/lucas/birds/wh44wh39/NEURAL/032418_RALMANlearn3', ...
    '/bluejay5/lucas/birds/wh44wh39/NEURAL/040118_RALMANlearn3_audioonly'};

ListOfDirs_ALL = [ListOfDirs_UNDIR ListOfDirs_DIR];

ListOfBatch = {...
    'BatchAll', ...
    'BatchAllUNDIR',...
    'BatchAllUNDIR',...
    'BatchAllDIR',...
    'BatchAllDIR'};

FFparams.cell_of_freqwinds={'b', [2600 4100], 'h', [2700 4000], 'c', [2100 2800], ...
    'n', [1600 2600], 'k', [1600 2600]}; % 'j', [950 1450], 'l', [1200 1600], 't', [3590 4960]
FFparams.cell_of_FFtimebins={'b', [0.033 0.043], 'h', [0.04 0.05], 'c', [0.045 0.082], ...
     'n', [0.045 0.052], 'k', [0.038 0.045]}; % 'j', [0.04 0.045], 'l', [0.035 0.039], 't', [0.026 0.033], ...

plotAllPC = 0;
plotEachSyl = 0;
overwrite = 0;

% ==================== CALCULATE AND SAVE FF
lt_batchsong_calcFF(ListOfDirs_ALL, ListOfBatch, FFparams, plotAllPC, plotEachSyl, ...
    overwrite);

%% ==== EXTRACT FF
MotifsToExtract = {'c(b)', 'cb(b)', '(k)', 'k(c)', 'kc(c)', '(n)', ...
    'n(h)', 'nh(h)'};
gethitsyls=0;
DATSTRUCT = lt_batchsong_extractFF(ListOfDirs_UNDIR, ListOfDirs_DIR, ...
    ListOfBatch, MotifsToExtract, gethitsyls);


%% ============== PLOT
close all;
TrainON = '21Mar2018-1215';
SwitchTimes = {'21Mar2018-1314', '21Mar2018-1325', '21Mar2018-2347'};
subtractMean = 0;
dozscore = 1;

lt_batchsong_plotFF(DATSTRUCT, MotifsToExtract, TrainON, SwitchTimes, ...
    subtractMean, dozscore);
