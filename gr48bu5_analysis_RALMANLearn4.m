%% CHECKING TEMPLATE MATCHING; [klb only]

clear all; close all;
batchf='batch.labeled.all';
% config='/bluejay2/lucas/birds/gr48bu5/config011519_v6.evconfig2';
config='/bluejay2/lucas/birds/gr48bu5/config011719.evconfig2'; % [just note 0, need to replace note 0 for config011519_v6 if want to use] few params change - to avoid getting FP on jb and jb(h) - don't need to use if drivign a(b) up.
config='/bluejay2/lucas/birds/gr48bu5/config012019.evconfig2'; % [just note 0, need to replace note 0 for config011519_v6 if want to use] few params change - to avoid getting FP on jb and jb(h) - don't need to use if drivign a(b) up.

% === Note 0 
syl='b';
syl_pre='jj';
syl_post='';
get_WN_hits=0;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% === Note 1
syl='h';
syl_pre='jjb';
syl_post='';
get_WN_hits=0;
get_offline_match=1;
get_FF=1;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


%% calc FF for all syls, save next to song file
clear all; close all;

ListOfDirs_UNDIR = {...
    '/bluejay0/bluejay2/lucas/birds/gr48bu5/NEURAL/012019_RALMANLearn4', ...
    };

ListOfDirs_DIR = {};

ListOfDirs_ALL = [ListOfDirs_UNDIR ListOfDirs_DIR];

ListOfBatch = {...
    'Batch1057to2006', ...
    };

FFparams.cell_of_freqwinds={'b', [3000 3950], 'h', [2950 4000], 'a', [950 2250],...
     'd', [1300 2450]}; %
FFparams.cell_of_FFtimebins={'b', [0.041 0.0475], 'h', [0.026 0.03], 'a', [0.078 0.085], ...
    'd', [0.039 0.052]}; %

plotAllPC = 1;
plotEachSyl = 0;
overwrite = 1;

% ==================== CALCULATE AND SAVE FF
lt_batchsong_calcFF(ListOfDirs_ALL, ListOfBatch, FFparams, plotAllPC, plotEachSyl, ...
    overwrite);

%% ==== EXTRACT FF
% MotifsToExtract = {'(a)rd', 'r(d)', '(a)b', 'a(b)', 'ab(h)', ...
%                         '(a)j', 'j(b)h', 'jb(h)'};
MotifsToExtract = {'j(b)'};
DATSTRUCT = lt_batchsong_extractFF(ListOfDirs_UNDIR, ListOfDirs_DIR, ...
    ListOfBatch, MotifsToExtract, 0);


%% ============== PLOT
close all;
TrainON = '20Jan2019-1144';
SwitchTimes = {};
subtractMean = 1;
dozscore = 1;

lt_batchsong_plotFF(DATSTRUCT, MotifsToExtract, TrainON, SwitchTimes, ...
    subtractMean, dozscore);
