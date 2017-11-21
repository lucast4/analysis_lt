%% ####################################### PATH TO BOS FILES

BOSdir = '/bluejay5/egret_data/lucas/Test_Songs/BOS/';

% ===  BOS and rBOS
'pu69wh78_031117_102806.9552.cbin_DigOnsOff';
'pu69wh78_031117_102806.9552.cbin_DigOnsOff_REV';

% === 4 variants with high and low syllables (ab(h) and jb(h)) spliced in
'pu69wh78_031117_102806.9552.cbin_aHI_jHI.wav'
'pu69wh78_031117_102806.9552.cbin_aHI_jLO.wav'
'pu69wh78_031117_102806.9552.cbin_aLO_jHI.wav'
'pu69wh78_031117_102806.9552.cbin_aLO_jLO.wav'

% ======= made files with this script
lt_neural_makeBOS_pu69wh78;


%% ####################################### quick analysis scripts

%% 1) DIR vs. UNDIR throughout leanring (comapring target to nontarg)
%% ====================== PREWN - WNON
clear all; close all;
% ----- different datasets, each with different batch/dir combination
basedir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111017_PreWN_DirUndir/';
subdirs = {'DIR', 'UNDIR'}; % these must be dirs within basedir. they will be used as fieldnames in extracted structure
Batchfiles = {'batchall', 'batchall'}; % must be one for each subdir;
Conditions = {'DIR', 'UNDIR'};

% ------ params for all subdirs
chanstoplot = [9 14 21]; % chip channels. leave empty to get all
motifstoplot = {'a(b)', 'ab(h)', 'anh(h)', 'j(b)', 'jb(h)', 'jbh(h)',...
    'abhh(g)', 'jbhh(g)'}; % cell arary of motifs, strings
% sylstoalign = [2 2 3 4 1]; % which syl in that motif? (one for each motif
pretime = 0.1; % sec, from onset
posttime = 0.1; % sec, from offset
plotRaw = 0; % plot each extracted trial (raw, smoothed, and spec)


DATSTRUCT = lt_neural_BatchSmthEXTRACT(basedir, subdirs, Batchfiles, chanstoplot, motifstoplot, ...
    '', pretime, posttime, plotRaw, Conditions);



close all;
fs = 30000;
lt_neural_BatchSmthPLOT(DATSTRUCT, chanstoplot, motifstoplot, ...
    '', pretime, posttime, plotRaw, fs)


%% A) midday neuron on 11/11/17 (see ppt for results)
clear all; close all;
DATSTRUCT = struct;

% ============== 1) UNDIR
songdir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/MorningDIRtest/UNDIR';
% where the songs and batch are located
batchf = 'batchall'; % contains .rhd names
chanstoplot = [9 14 21]; % chip channels. leave empty to get all
motifstoplot = {'abh', 'jbh', 'abhh', 'jbhh'}; % cell arary of motifs, strings
sylstoalign = [3 3 4 4]; % which syl in that motif? (one for each motif
pretime = 0.1; % sec, from onset
posttime = 0.15; % sec, from offset
plotRaw = 0; % plot each extracted trial (raw, smoothed, and spec)

DATSTRUCT.UNDIR = lt_neural_BatchSmth(songdir, batchf, chanstoplot, motifstoplot, ...
    sylstoalign, pretime, posttime, plotRaw);


% ================= DIR
songdir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/MorningDIRtest/DIR';
% where the songs and batch are located
batchf = 'batchall'; % contains .rhd names
chanstoplot = [9 14 21]; % chip channels. leave empty to get all
motifstoplot = {'abh', 'jbh', 'abhh', 'jbhh'}; % cell arary of motifs, strings
sylstoalign = [3 3 4 4]; % which syl in that motif? (one for each motif
pretime = 0.1; % sec, from onset
posttime = 0.15; % sec, from offset
plotRaw = 0; % plot each extracted trial (raw, smoothed, and spec)

DATSTRUCT.DIR = lt_neural_BatchSmth(songdir, batchf, chanstoplot, motifstoplot, ...
    sylstoalign, pretime, posttime, plotRaw);


% ========================= PLOT
close all;
fs = 30000;
lt_neural_BatchSmthPLOT(DATSTRUCT, chanstoplot, motifstoplot, ...
    sylstoalign, pretime, posttime, plotRaw, fs)


%% A) LATE neuron on 11/11/17 
clear all; close all;
DATSTRUCT = struct;

% ============== 1) UNDIR
songdir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/EveningDIRtest/UNDIR';
% where the songs and batch are located
batchf = 'batchall'; % contains .rhd names
chanstoplot = [9 14 21]; % chip channels. leave empty to get all
motifstoplot = {'abh', 'jbh', 'abhh', 'jbhh'}; % cell arary of motifs, strings
sylstoalign = [3 3 4 4]; % which syl in that motif? (one for each motif
pretime = 0.1; % sec, from onset
posttime = 0.15; % sec, from offset
plotRaw = 0; % plot each extracted trial (raw, smoothed, and spec)

DATSTRUCT.UNDIR = lt_neural_BatchSmth(songdir, batchf, chanstoplot, motifstoplot, ...
    sylstoalign, pretime, posttime, plotRaw);


% ================= DIR
songdir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/EveningDIRtest/DIR';
% where the songs and batch are located
batchf = 'batchall'; % contains .rhd names
chanstoplot = [9 14 21]; % chip channels. leave empty to get all
motifstoplot = {'abh', 'jbh', 'abhh', 'jbhh'}; % cell arary of motifs, strings
sylstoalign = [3 3 4 4]; % which syl in that motif? (one for each motif
pretime = 0.1; % sec, from onset
posttime = 0.15; % sec, from offset
plotRaw = 1; % plot each extracted trial (raw, smoothed, and spec)
plotSpecifics = {'abh', 14}; % {motif, chan}
DATSTRUCT.DIR = lt_neural_BatchSmth(songdir, batchf, chanstoplot, motifstoplot, ...
    sylstoalign, pretime, posttime, plotRaw, plotSpecifics);


% ========================= PLOT
close all;
fs = 30000;
lt_neural_BatchSmthPLOT(DATSTRUCT, chanstoplot, motifstoplot, ...
    sylstoalign, pretime, posttime, plotRaw, fs)


%% A) AM NEURONS ON 11/12
clear all; close all;
% ----- different datasets, each with different batch/dir combination
basedir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111217_Morning_DirUndir/';
subdirs = {'UNDIR', 'DIR'}; % these must be dirs within basedir. they will be used as fieldnames in extracted structure
Batchfiles = {'batchall', 'batchall'}; % must be one for each subdir;

% ------ params for all subdirs
chanstoplot = [9 14 21]; % chip channels. leave empty to get all
motifstoplot = {'abh', 'jbh', 'abhh', 'jbhh'}; % cell arary of motifs, strings
sylstoalign = [3 3 4 4]; % which syl in that motif? (one for each motif
pretime = 0.1; % sec, from onset
posttime = 0.15; % sec, from offset
plotRaw = 0; % plot each extracted trial (raw, smoothed, and spec)


DATSTRUCT = lt_neural_BatchSmthEXTRACT(basedir, subdirs, Batchfiles, chanstoplot, motifstoplot, ...
    sylstoalign, pretime, posttime, plotRaw);


% ======================== PLOT RAW
% go to:
lt_neural_BatchSmth_ALLPLOTS;

% ======================== XCOV OF FIRING BETWEEN CHANNELS
lt_neural_BatchSmthXCOV;

% ========================= PLOT
close all;
fs = 30000;
lt_neural_BatchSmthPLOT(DATSTRUCT, chanstoplot, motifstoplot, ...
    sylstoalign, pretime, posttime, plotRaw, fs)





%% AFTERNOON neurons, 11/13/17
clear all; close all;
% ----- different datasets, each with different batch/dir combination
basedir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111317_Afternoon_DirUndir/';
subdirs = {'UNDIR', 'DIR'}; % these must be dirs within basedir. they will be used as fieldnames in extracted structure
Batchfiles = {'batchall', 'batchall'}; % must be one for each subdir;

% ------ params for all subdirs
chanstoplot = [9 14 21]; % chip channels. leave empty to get all
motifstoplot = {'abh', 'jbh', 'abhh', 'jbhh'}; % cell arary of motifs, strings
sylstoalign = [3 3 4 4]; % which syl in that motif? (one for each motif
pretime = 0.1; % sec, from onset
posttime = 0.15; % sec, from offset
plotRaw = 0; % plot each extracted trial (raw, smoothed, and spec)


DATSTRUCT = lt_neural_BatchSmthEXTRACT(basedir, subdirs, Batchfiles, chanstoplot, motifstoplot, ...
    sylstoalign, pretime, posttime, plotRaw);


% ====== plot
close all;
fs = 30000;
lt_neural_BatchSmthPLOT(DATSTRUCT, chanstoplot, motifstoplot, ...
    sylstoalign, pretime, posttime, plotRaw, fs)


%% A) EVENING NEURONS ON 11/13
clear all; close all;
% ----- different datasets, each with different batch/dir combination
basedir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111317_Evening_DirUndir/';
subdirs = {'UNDIR', 'DIR'}; % these must be dirs within basedir. they will be used as fieldnames in extracted structure
Batchfiles = {'batchall', 'batchall'}; % must be one for each subdir;

% ------ params for all subdirs
chanstoplot = [9 14 21]; % chip channels. leave empty to get all
motifstoplot = {'abh', 'jbh', 'abhh', 'jbhh'}; % cell arary of motifs, strings
sylstoalign = [3 3 4 4]; % which syl in that motif? (one for each motif
pretime = 0.1; % sec, from onset
posttime = 0.15; % sec, from offset
plotRaw = 0; % plot each extracted trial (raw, smoothed, and spec)


DATSTRUCT = lt_neural_BatchSmthEXTRACT(basedir, subdirs, Batchfiles, chanstoplot, motifstoplot, ...
    sylstoalign, pretime, posttime, plotRaw);



% ====== plot
close all;
fs = 30000;
lt_neural_BatchSmthPLOT(DATSTRUCT, chanstoplot, motifstoplot, ...
    sylstoalign, pretime, posttime, plotRaw, fs)



%% ################################################ SET 2
%% ################################################ 

%% ====================== PREWN - WNON
clear all; close all;
% ----- different datasets, each with different batch/dir combination
basedir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111017_PreWN_DirUndir/';
subdirs = {'DIR', 'UNDIR'}; % these must be dirs within basedir. they will be used as fieldnames in extracted structure
Batchfiles = {'batchall', 'batchall'}; % must be one for each subdir;
Conditions = {'DIR', 'UNDIR'};

% ------ params for all subdirs
chanstoplot = [9 14 21]; % chip channels. leave empty to get all
motifstoplot = {'a(b)', 'ab(h)', 'j(b)', 'jb(h)', 'jbh(h)',...
    'h(g)'}; % cell arary of motifs, strings
motifstoplot = {'a(b)', 'ab(h)', 'j(b)', 'jb(h)', 'jbh(h)',...
    'h(g)'}; % cell arary of motifs, strings
% sylstoalign = [2 2 3 4 1]; % which syl in that motif? (one for each motif
pretime = 0.1; % sec, from onset
posttime = 0.1; % sec, from offset
plotRaw = 0; % plot each extracted trial (raw, smoothed, and spec)


DATSTRUCT = lt_neural_BatchSmthEXTRACT(basedir, subdirs, Batchfiles, chanstoplot, motifstoplot, ...
    '', pretime, posttime, plotRaw, Conditions);


%% A) AFTERNOON NEURONS ON 11/18
close all;
% ----- different datasets, each with different batch/dir combination
basedir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111817_Afternoon_DirUndir/';
subdirs = {'UNDIR', 'DIR'}; % these must be dirs within basedir. they will be used as fieldnames in extracted structure
Batchfiles = {'batchall', 'batchall'}; % must be one for each subdir;
Conditions = {'UNDIR', 'DIR'};


DATSTRUCT = lt_neural_BatchSmthEXTRACT(basedir, subdirs, Batchfiles, chanstoplot, motifstoplot, ...
    '', pretime, posttime, plotRaw);



%% AFTERNOON NEURONS (SU ONLY) ON 11/18

close all;
% ----- different datasets, each with different batch/dir combination
basedir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111817_RAsingleunit_DirUndir/';
subdirs = {'UNDIR', 'DIR'}; % these must be dirs within basedir. they will be used as fieldnames in extracted structure
Batchfiles = {'batchall', 'batchall'}; % must be one for each subdir;
Conditions = {'UNDIR', 'DIR'};


DATSTRUCT = lt_neural_BatchSmthEXTRACT(basedir, subdirs, Batchfiles, chanstoplot, motifstoplot, ...
    '', pretime, posttime, plotRaw);


%% ##################################### 2) COMBINE MULTIPLE SWITCHES BY HAND
clear all; close all;

basedir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/';
ListOfDatstructs = {...
    '111017_PreWN_DirUndir/DATSTRUCT_BatchSm_18Nov2017_1740.mat',...
    '111817_Afternoon_DirUndir/DATSTRUCT_BatchSm_18Nov2017_1744.mat'};
    '111817_RAsingleunit_DirUndir/DATSTRUCT_BatchSm_18Nov2017_2046.mat'};


DATAllSwitches = lt_neural_BatchSmthCOMPILE(basedir, ListOfDatstructs);


%% #############################################
%% #############################################
%% ================================ JUST THE SINGLE UNIT ON 11/18

clear all; close all;

basedir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/';
ListOfDatstructs = {...
    '111817_RAsingleunit_DirUndir/DATSTRUCT_BatchSm_18Nov2017_2046.mat'};


DATAllSwitches = lt_neural_BatchSmthCOMPILE(basedir, ListOfDatstructs);



%% ############################################# JUST AFTERNOON MU ON 11/18
%% #############################################
%% A) AFTERNOON NEURONS ON 11/18
clear all; close all;
% ----- different datasets, each with different batch/dir combination
basedir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111817_Afternoon_DirUndir/';
subdirs = {'DIR', 'UNDIR'}; % these must be dirs within basedir. they will be used as fieldnames in extracted structure
Batchfiles = {'batchall', 'batchall'}; % must be one for each subdir;
Conditions = {'DIR', 'UNDIR'};

% ------ params for all subdirs
chanstoplot = [14 21]; % chip channels. leave empty to get all
% motifstoplot = {'a(b)', 'ab(h)', 'j(b)', 'jb(h)', 'jbh(h)',...
%     'h(g)'}; % cell arary of motifs, strings
motifstoplot = {'a(b)', 'ab(h)', 'j(b)', 'jb(h)','jbh(h)',...
    'h(g)'}; % cell arary of motifs, strings
% sylstoalign = [2 2 3 4 1]; % which syl in that motif? (one for each motif
pretime = 0.1; % sec, from onset
posttime = 0.1; % sec, from offset
plotRaw = 0; % plot each extracted trial (raw, smoothed, and spec)

DATSTRUCT = lt_neural_BatchSmthEXTRACT(basedir, subdirs, Batchfiles, chanstoplot, motifstoplot, ...
    '', pretime, posttime, plotRaw);



clear all; close all;
basedir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/';
ListOfDatstructs = {...
    '111817_Afternoon_DirUndir/DATSTRUCT_BatchSm_20Nov2017_1349.mat'};
suffix = 'AfternoonMU';

DATAllSwitches = lt_neural_BatchSmthCOMPILE(basedir, ListOfDatstructs, suffix);


%% ############################################# JUST AFTERNOON ON 11/20
%% #############################################
clear all; close all;
% ----- different datasets, each with different batch/dir combination
basedir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/112017_Afternoon_DirUndir/';
subdirs = {'DIR', 'UNDIR'}; % these must be dirs within basedir. they will be used as fieldnames in extracted structure
Batchfiles = {'batchall', 'batchall'}; % must be one for each subdir;
Conditions = {'DIR', 'UNDIR'};

% ------ params for all subdirs
chanstoplot = [11 14 18 23]; % chip channels. leave empty to get all
% motifstoplot = {'a(b)', 'ab(h)', 'j(b)', 'jb(h)', 'jbh(h)',...
%     'h(g)'}; % cell arary of motifs, strings
motifstoplot = {'a(b)', 'ab(h)', 'j(b)', 'jb(h)','jbh(h)',...
    'h(g)'}; % cell arary of motifs, strings
% sylstoalign = [2 2 3 4 1]; % which syl in that motif? (one for each motif
pretime = 0.1; % sec, from onset
posttime = 0.1; % sec, from offset
plotRaw = 0; % plot each extracted trial (raw, smoothed, and spec)

DATSTRUCT = lt_neural_BatchSmthEXTRACT(basedir, subdirs, Batchfiles, chanstoplot, motifstoplot, ...
    '', pretime, posttime, plotRaw);



    clear all; close all;
    basedir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/';
    ListOfDatstructs = {...
        '112017_Afternoon_DirUndir/DATSTRUCT_BatchSm_20Nov2017_1642.mat'};
    suffix = '112017Afternoon';

    DATAllSwitches = lt_neural_BatchSmthCOMPILE(basedir, ListOfDatstructs, suffix);



%% ############################################ FF CALCULATION
%% ############################################ FF CALCULATION
%% calc FF for all syls, save next to song file
clear all; close all;

% ListOfDirs_UNDIR = {...
%     '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111217_Morning_DirUndir/UNDIR'};
% 
% ListOfDirs_DIR = {...
%     '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111217_Morning_DirUndir/DIR'};

ListOfDirs_UNDIR = {...
        '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111017_PreWN_DirUndir/UNDIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111017_Evening_DirUndir/UNDIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111117_Morning_DirUndir/UNDIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111117_Evening_DirUndir/UNDIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111217_Morning_DirUndir/UNDIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111317_Afternoon_DirUndir/UNDIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111317_Evening_DirUndir/UNDIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111817_Afternoon_DirUndir/UNDIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111817_Afternoon_BeforeDirUndir/UNDIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111817_RAsingleunit_DirUndir/UNDIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/112017_Afternoon_DirUndir/UNDIR'};


ListOfDirs_DIR = {...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111017_PreWN_DirUndir/DIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111017_Evening_DirUndir/DIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111117_Morning_DirUndir/DIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111117_Evening_DirUndir/DIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111217_Morning_DirUndir/DIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111317_Afternoon_DirUndir/DIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111317_Evening_DirUndir/DIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111817_Afternoon_DirUndir/DIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111817_RAsingleunit_DirUndir/DIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/112017_Afternoon_DirUndir/DIR'};

ListOfDirs_ALL = [ListOfDirs_UNDIR ListOfDirs_DIR];

ListOfBatch = {...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall'};

FFparams.cell_of_freqwinds={'a', [1000 2600], 'g', [2000 3400], ...
    'h', [2900 3800], 'b', [2900 3800]}; % 'j', [950 1450], 'l', [1200 1600], 't', [3590 4960]
FFparams.cell_of_FFtimebins={'a', [0.068 0.078], 'g', [0.04 0.06], ...
    'h', [0.033 0.042], 'b', [0.033 0.04]}; % 'j', [0.04 0.045], 'l', [0.035 0.039], 't', [0.026 0.033], ...

plotAllPC = 1;
plotEachSyl = 0;
overwrite = 0;

% ==================== CALCULATE AND SAVE FF
lt_batchsong_calcFF(ListOfDirs_ALL, ListOfBatch, FFparams, plotAllPC, plotEachSyl, ...
    overwrite);

%% ==== EXTRACT FF
% MotifsToExtract = {'a(b)n', 'ab(h)', 'jb(h)',  'jbh(h)', 'a(b)h', 'j(b)'};
MotifsToExtract = {'ab(h)', 'jb(h)',  'jbh(h)', 'a(b)h', 'j(b)', 'h(g)'};
DATSTRUCT = lt_batchsong_extractFF(ListOfDirs_UNDIR, ListOfDirs_DIR, ListOfBatch, MotifsToExtract);


%% ============== PLOT
close all; 
TrainON = '10Nov2017-1157';
SwitchTimes = {};
subtractMean = 1;

lt_batchsong_plotFF(DATSTRUCT, MotifsToExtract, TrainON, SwitchTimes, subtractMean);
