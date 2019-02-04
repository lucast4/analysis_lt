%% CHECKING TEMPLATE MATCHING; [klb only]

clear all; close all;
batchf='batch.labeled.all';
config='/bluejay2/lucas/birds/wh72pk12/config_011119.evconfig2';
config='/bluejay2/lucas/birds/wh72pk12/config_011119_2.evconfig2';

% === Note 0 
syl='b';
syl_pre='ajkl';
syl_post='';
get_WN_hits=0;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% === Note 1
syl='h';
syl_pre='ajklb';
syl_post='';
get_WN_hits=0;
get_offline_match=1;
get_FF=1;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


%% calc FF for all syls, save next to song file
clear all; close all;

ListOfDirs_UNDIR = {...
    '/bluejay0/bluejay2/lucas/birds/wh72pk12/NEURAL/011119_RALMANLearn7', ...
    '/bluejay0/bluejay2/lucas/birds/wh72pk12/NEURAL/011219_RALMANLearn7', ...
    };

ListOfDirs_DIR = {};

ListOfDirs_ALL = [ListOfDirs_UNDIR ListOfDirs_DIR];

ListOfBatch = {...
    'Batch1057to2256', ...
    'Batch1705to2305', ...
    };

FFparams.cell_of_freqwinds={'b', [3050 3950], 'h', [3050 3950], 'g', ...
    [900 1600], 'a', [1400 1900], 'k', [3200 4400], 'l', [3600 5000], 'd', ...
    [4000 5500]}; %
FFparams.cell_of_FFtimebins={'b', [0.028 0.033], 'h', [0.035 0.045], 'g', ...
    [0.049 0.068], 'a', [0.053 0.079], 'k', [0.03 0.042], 'l', [0.024 0.028], 'd', ...
    [0.023 0.028]}; %

plotAllPC = 0;
plotEachSyl = 0;
overwrite = 0;

% ==================== CALCULATE AND SAVE FF
lt_batchsong_calcFF(ListOfDirs_ALL, ListOfBatch, FFparams, plotAllPC, plotEachSyl, ...
    overwrite);

%% ==== EXTRACT FF
MotifsToExtract = {'jr(b)', 'kl(b)', 'io(b)', 'rb(h)', 'ob(h)', 'lb(h)', ...
    '(g)', '(a)', 'm(k)', 'j(k)', 'k(l)', 'k(d)'};
DATSTRUCT = lt_batchsong_extractFF(ListOfDirs_UNDIR, ListOfDirs_DIR, ...
    ListOfBatch, MotifsToExtract, 0);


%% ============== PLOT
close all;
TrainON = '11Jan2019-1142';
SwitchTimes = {};
subtractMean = 1;
dozscore = 0;

lt_batchsong_plotFF(DATSTRUCT, MotifsToExtract, TrainON, SwitchTimes, ...
    subtractMean, dozscore);
