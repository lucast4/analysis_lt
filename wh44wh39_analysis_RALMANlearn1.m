%% MATCHING TEMPLATE - getting all b

clear all; close all;
batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'cb';
syl_post = '';
config = '/bluejay5/lucas/birds/wh44wh39/config_021918.evconfig2'; % to get all b
config = '/bluejay5/lucas/birds/wh44wh39/config_021918_2.evconfig2'; % to get all b
config = '/bluejay5/lucas/birds/wh44wh39/config_021918_3.evconfig2'; % to get all b
config = '/bluejay5/lucas/birds/wh44wh39/config_021918_4.evconfig2'; % to get all b
NoteNum = 0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);

%% MATCHING TEMPLATE - getting all b

clear all; close all;
batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'c';
syl_post = '';
config = '/bluejay5/lucas/birds/wh44wh39/config_021918_5.evconfig2'; % to get all b
NoteNum = 0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);


%% ################################################### DIR VS. UNDIR
% TO COMPARE FIRING, DIR VS. UNDIR

%% TO CHANGE NAME OF SONG (APPEND "DIR")
% in folder in which all songs are DIR

lt_batchsong_ChangeSongFname('DIR');



%% ##############################################################
%% ##############################################################
%% ####################### CALC FF during learning

%% calc FF for all syls, save next to song file
clear all; close all;

ListOfDirs_UNDIR = {...
    '/bluejay5/lucas/birds/wh44wh39/NEURAL/021918_RALMANlearn1/', ...
    '/bluejay5/lucas/birds/wh44wh39/NEURAL/022218_RALMANlearn1', ...
    '/bluejay5/lucas/birds/wh44wh39/NEURAL/022518_RALMANlearn1'};


ListOfDirs_DIR = {...
    '/bluejay5/lucas/birds/wh44wh39/NEURAL/021918_RALMANlearn1/', ...
    '/bluejay5/lucas/birds/wh44wh39/NEURAL/022218_RALMANlearn1', ...
    '/bluejay5/lucas/birds/wh44wh39/NEURAL/022518_RALMANlearn1'};

ListOfDirs_ALL = [ListOfDirs_UNDIR ListOfDirs_DIR];

ListOfBatch = {...
    'batchUNDIR', ...
    'batchallUNDIR', ...
    'batchUNDIR', ...
    'batchDIR', ...
    'batchDIR', ...
    'batchDIR'};

FFparams.cell_of_freqwinds={'b', [2600 4100], 'h', [2700 4000], 'c', [2100 2800], ...
    'n', [1600 2600], 'k', [1600 2600]}; % 'j', [950 1450], 'l', [1200 1600], 't', [3590 4960]
FFparams.cell_of_FFtimebins={'b', [0.033 0.043], 'h', [0.04 0.05], 'c', [0.045 0.082], ...
     'n', [0.045 0.052], 'k', [0.038 0.045]}; % 'j', [0.04 0.045], 'l', [0.035 0.039], 't', [0.026 0.033], ...

plotAllPC = 1;
plotEachSyl = 0;
overwrite = 1;

% ==================== CALCULATE AND SAVE FF
lt_batchsong_calcFF(ListOfDirs_ALL, ListOfBatch, FFparams, plotAllPC, plotEachSyl, ...
    overwrite);

%% ==== EXTRACT FF
MotifsToExtract = {'c(b)', 'cb(b)', '(k)', 'k(c)', 'kc(c)', '(n)', ...
    'n(h)', 'nh(h)'};
gethitsyls = 0;
DATSTRUCT = lt_batchsong_extractFF(ListOfDirs_UNDIR, ListOfDirs_DIR, ListOfBatch, ...
    MotifsToExtract, gethitsyls);


%% ============== PLOT
close all;
TrainON = '19Feb2018-1146';
SwitchTimes = {'19Feb2018-1827', '19Feb2018-2400', '24Feb2018-1421'};
subtractMean = 1;
dozscore = 1;

lt_batchsong_plotFF(DATSTRUCT, MotifsToExtract, TrainON, SwitchTimes, ...
    subtractMean, dozscore);
