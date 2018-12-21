%% CHECKING TEMPLATE MATCHING;

clear all; close all;
batchf='batch.labeled.all';
% config='/bluejay2/lucas/birds/wh72pk12/config112818.evconfig2';
% config='/bluejay2/lucas/birds/wh72pk12/config112818_2.evconfig2';
config='/bluejay2/lucas/birds/wh72pk12/config112818_3.evconfig2';
config='/bluejay2/lucas/birds/wh72pk12/config113018.evconfig2';

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



%% targeting all b and h

clear all; close all;
batchf='batch.labeled.all';
% config='/bluejay2/lucas/birds/wh72pk12/config112818.evconfig2';
% config='/bluejay2/lucas/birds/wh72pk12/config112818_2.evconfig2';
config='/bluejay2/lucas/birds/wh72pk12/config120418.evconfig2';
config='/bluejay2/lucas/birds/wh72pk12/config120518.evconfig2';
config='/bluejay2/lucas/birds/wh72pk12/config120518_2.evconfig2';
config='/bluejay2/lucas/birds/wh72pk12/config120518_3.evconfig2'; % gets all b, by having birdtaf for each context, combined.
config='/bluejay2/lucas/birds/wh72pk12/config120618.evconfig2'; % gets all b, by having birdtaf for each context, combined.
config='/bluejay2/lucas/birds/wh72pk12/config120718.evconfig2'; % gets all b, by having birdtaf for each context, combined.
config='/bluejay2/lucas/birds/wh72pk12/config120718_2.evconfig2'; % gets all b, by having birdtaf for each context, combined.
config='/bluejay2/lucas/birds/wh72pk12/config120918_2.evconfig2'; % gets all b, by having birdtaf for each context, combined.

% === Note 0 
syl='b';
syl_pre='';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% === Note 1
syl='h';
syl_pre='';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

%% targeting only jr(b) and jrb(h)

clear all; close all;
batchf='batch.labeled.all';
config='/bluejay2/lucas/birds/wh72pk12/121018_rb.evconfig2'; % gets all b, by having birdtaf for each context, combined.
config='/bluejay2/lucas/birds/wh72pk12/config121018_v2.evconfig2'; % gets all b, by having birdtaf for each context, combined.

% === Note 0 
syl='b';
syl_pre='r';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% === Note 1
syl='h';
syl_pre='rb';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


%% calc FF for all syls, save next to song file
clear all; close all;

ListOfDirs_UNDIR = {...
    '/bluejay0/bluejay2/lucas/birds/wh72pk12/NEURAL/120518_RALMANLearn3', ...
    '/bluejay0/bluejay2/lucas/birds/wh72pk12/NEURAL/120718_RALMANLearn3', ...
    '/bluejay0/bluejay2/lucas/birds/wh72pk12/NEURAL/121018_RALMANLearn3'};
% ListOfDirs_UNDIR = {...
%     '/bluejay0/bluejay2/lucas/birds/wh72pk12/NEURAL/120518_RALMANLearn3', ...
%     };

ListOfDirs_DIR = {};

ListOfDirs_ALL = [ListOfDirs_UNDIR ListOfDirs_DIR];

ListOfBatch = {...
    'Batch1041to2035', ...
    'Batch1153to2256', ...
    'Batch1102to2305', ...
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
gethitsyls = 1;
DATSTRUCT = lt_batchsong_extractFF(ListOfDirs_UNDIR, ListOfDirs_DIR, ...
    ListOfBatch, MotifsToExtract, gethitsyls);


%% ============== PLOT
close all;
TrainON = '05Dec2018-1222';
SwitchTimes = {'07Dec2018-1413', '10Dec2018-1225'};
subtractMean = 1;
dozscore = 0;

lt_batchsong_plotFF(DATSTRUCT, MotifsToExtract, TrainON, SwitchTimes, ...
    subtractMean, dozscore);
