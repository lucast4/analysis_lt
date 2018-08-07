%% 2/12/15 - targetting ab[b] DN

%% Analyzing template (b2)
close all;

batchf= 'batch.labeled.all';
get_WN_hits=0;
get_offline_match=1;
get_FF=1;

syl = 'b';
syl_pre = 'ab';
syl_post = '';
% config= '/bluejay3/lucas/birds/pu53wh88/config.evconfig2'; % before 2/16 templ change
config= '/bluejay5/lucas/birds/pu53wh88/c_test.evconfig2';

NoteNum = 0;


check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, ...
    syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);


%% Analyzing template (b3)
close all;

batchf= 'batch.labeled.catch';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;

syl = 'b';
syl_pre = 'abb';
syl_post = '';

syl_post = '';
% config= '/bluejay3/lucas/birds/pu53wh88/config.evconfig2'; % before 2/16 templ change
config= '/bluejay3/lucas/birds/pu53wh88/config_2templ.evconfig2';

NoteNum = 1;


check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, ...
    syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);


%% ANALYZING ACROSS DAYS

% TO DO OVER ALL DAYS
clear all; close all
phrase = 'SeqDepPitchShift3';
% first_day= '26Oct2014';
% last_day= '29Oct2014';
first_day= '01Mar2015';
last_day= '07Mar2015';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.catch';
Params.DayRawDat.syllables={'a','b','c'};
Params.DayRawDat.frequency_range={[950 2100], [2550 4000],[2150 2950]};
Params.DayRawDat.pc_dur=[0.125,0.115,0.125];
Params.DayRawDat.pc_time_window={[297 420],[45 175],[60 385]};

Params.DayRawDat.pc_sigma=1;


plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);


% baseline/post
clear all; close all;
phrase = 'SeqDepPitchShift3';
% first_day= '26Oct2014';
% last_day= '29Oct2014';
first_day= '06Feb2015';
last_day= '06Feb2015';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.all';
Params.DayRawDat.syllables={'a','b','c'};
Params.DayRawDat.frequency_range={[950 2100], [2550 4000],[2150 2950]};
Params.DayRawDat.pc_dur=[0.125,0.115,0.125];

Params.DayRawDat.pc_time_window={[297 420],[45 175],[60 385]};
Params.DayRawDat.pc_sigma=1;


plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);

%% 2) Seq filter, remove outliers, and compile raw data, and enter experiment info into params
cd seq_dep_pitch_SeqDepPitchShift3;
clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=30000;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

Params.SeqFilter.SeqPreList={'','','a','ab','abb','c','cb','a','ac'};
Params.SeqFilter.SylTargList={'a','a','b','b','b','b','b','c','c'};
Params.SeqFilter.SeqPostList={'b','c','','','','','','',''};


% 2) experiment info
Params.SeqFilter.WNTimeON='13Feb2015-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '07Mar2015-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:7;

Params.SeqFilter.SylLists.FieldsToPlot{1}={'cB','cbB','aB','abB','abbB'};
Params.SeqFilter.SylLists.FieldsToPlot{2}={'Ab','Ac','aC','acC'};
Params.SeqFilter.SylLists.FieldsInOrder{1}={'Ab','aB','abB','abbB'};
Params.SeqFilter.SylLists.FieldsInOrder{2}={'Ac','aC','acC','cB','cbB'};
Params.SeqFilter.SylLists.TargetSyls={'abB'};
Params.SeqFilter.SylLists.SylsSame={'cB','cbB','aB','abbB'};
Params.SeqFilter.SylLists.SylsDifferent={'Ab','Ac','aC','acC'};

Params.SeqFilter.DaysForSnapshot{1}={'27Feb2015','01Mar2015'};
Params.SeqFilter.DaysToMark= {'25Feb2015-0000','01Mar2015-2400'}; % will mark all plots with lines here;

% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);


%% 3) Perform various analyses on that data structure

Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;


[Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);


%% 3) Extract structure statistics

% to extract data
[Params, AllDays_StructStatsStruct]=lt_seq_dep_pitch_StructureStats(Params, AllDays_RawDatStruct);

% to look at syllable similarity - being replaced by "Correlations" below
% [Params, AllDays_StructStatsStruct]=lt_seq_dep_pitch_StructureStats_SylSimilarity(Params, AllDays_StructStatsStruct);

% to plot and perform PCA on syl structure
Params.PCA.epoch='baseline'; % will look at baseline
% Params.PCA.epoch=[21 24]; % days 21 to 24

[Params, PCA_Struct]=lt_seq_dep_pitch_StructureStats_featurePCA(Params, AllDays_StructStatsStruct,1);



%% 4) Look at correlations between syllables
% work in progress
DaysWanted=20:22; % either baseline (astring) or array
lt_seq_dep_pitch_Correlations(Params, AllDays_StructStatsStruct,DaysWanted);



%% ############################### EXTRACTION OF PC AND FF 
% INDEPENDENT OF SEQ DEP PITCH ANALYSIS
% use for generalization analyses

%% ################ PLOT LEARNING
%% calc FF for all syls, save next to song file
clear all; close all;

% ListOfDirs_UNDIR = {...
%     '/bluejay5/lucas/birds/pu53wh88/021015_SeqDepPitchShift3_pre', ...
%     '/bluejay5/lucas/birds/pu53wh88/021115_SeqDepPitchShift3_pre', ...
%     '/bluejay5/lucas/birds/pu53wh88/021215_SeqDepPitchShift3_pre', ...
%     '/bluejay5/lucas/birds/pu53wh88/021415_SeqDepPitchShift3_durWN_day2', ...
%     '/bluejay5/lucas/birds/pu53wh88/021515_SeqDepPitchShift3_durWN_day3', ...
%     '/bluejay5/lucas/birds/pu53wh88/021615_SeqDepPitchShift3_durWN_day4'};
ListOfDirs_UNDIR = {...
    '/bluejay5/lucas/birds/pu53wh88/021215_SeqDepPitchShift3_pre', ...
    '/bluejay5/lucas/birds/pu53wh88/021615_SeqDepPitchShift3_durWN_day4'};

ListOfDirs_DIR = {};

ListOfDirs_ALL = [ListOfDirs_UNDIR ListOfDirs_DIR];
% 
% ListOfBatch = {...
%     'BatchAll.LABELED', ...
%     'BatchAll.LABELED', ...
%     'BatchAll.LABELED', ...
%     'BatchAll.LABELED', ...
%     'BatchAll.LABELED', ...
%     'BatchAll.LABELED', ...
%     };
ListOfBatch = {...
    'BatchAll.LABELED', ...
    'BatchAll.LABELED', ...
    };

FFparams.cell_of_freqwinds={'c', [2200 2950], 'b', [2650 4150], ...
    'a', [1200 2200]};
FFparams.cell_of_FFtimebins={'c', [0.034 0.067], 'b', [0.03 0.033], ...
    'a', [0.064 0.077]};
plotAllPC = 0;
plotEachSyl = 0;
overwrite = 1;

% ==================== CALCULATE AND SAVE FF
lt_batchsong_calcFF(ListOfDirs_ALL, ListOfBatch, FFparams, plotAllPC, plotEachSyl, ...
    overwrite);

%% ==== EXTRACT FF
MotifsToExtract = {'(a)b', 'a(b)', 'ab(b)', ...
    '(a)c', 'a(c)', 'ac(c)', 'c(b)', 'cb(b)'};
DATSTRUCT = lt_batchsong_extractFF(ListOfDirs_UNDIR, ListOfDirs_DIR, ListOfBatch, MotifsToExtract);


%% ============== PLOT
close all;
TrainON = '13Feb2015-0000';
SwitchTimes = {};
subtractMean = 1;
dozscore = 0;

lt_batchsong_plotFF(DATSTRUCT, MotifsToExtract, TrainON, SwitchTimes, ...
    subtractMean, dozscore);


%% ########################################################################
%% ######################################### AUTOLABEL
%% ================ TeSTING CONFIG FILE
if (0)
    close all;
    batchf= 'BatchAll.LABELED';
    get_WN_hits=0;
    get_offline_match=1;
    get_FF=0;
    
    syl = 'b';
    syl_pre = 'ab';
    syl_post = '';
    % config= '/bluejay3/lucas/birds/pu53wh88/config.evconfig2'; % before 2/16 templ change
    config= '/bluejay5/lucas/birds/pu53wh88/config_AL_aB.evconfig2';
    NoteNum = 0;
    
    
    check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, ...
        syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);
end

% ================ TeSTING CONFIG FILE
if (0)
    close all;
    batchf= 'BatchAll.LABELED';
    get_WN_hits=0;
    get_offline_match=1;
    get_FF=0;
    
    syl = 'b';
    syl_pre = 'c';
    syl_post = '';
    % config= '/bluejay3/lucas/birds/pu53wh88/config.evconfig2'; % before 2/16 templ change
    config= '/bluejay5/lucas/birds/pu53wh88/config_AL_cB.evconfig2';
    NoteNum = 0;
    
    
    check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, ...
        syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);
end



%% ##################################### AUTOLABEL 
clear all; close all;

% ========================= 0) ECTRACT DIRECTORIRES
basedir = '/bluejay5/lucas/birds/pu53wh88';
date_range_base={'10Feb2015','12Feb2015'};
date_range_WN={'14Feb2015','16Feb2015'};
experiment = 'SeqDepPitchShift3';

% -------- COLLECT METADAT
cd(basedir);
MetadataStruct=lt_metadata_collect;

condition='';
notes='';
only_labeled_dirs=0;

% ----- BASELINE
ListOfDirs1=lt_metadata_find_dirs(MetadataStruct, experiment, condition, ...
    notes, date_range_base, only_labeled_dirs, 2);

% ------ WN
ListOfDirs2=lt_metadata_find_dirs(MetadataStruct, experiment, condition, ...
    notes, date_range_WN, only_labeled_dirs, 2);

% ------- COMBINE
ListOfDirs = [ListOfDirs1 ListOfDirs2];


% ============================== RUN, ITERATE OVER DAYS
for j=1:length(ListOfDirs)

    % ==================== 0) go to day folder
    cd([basedir '/' ListOfDirs(j).dirname]);
    
    
    % ==================== 1) extract all s
    lt_make_batch(3);
    lt_cleandirAuto('batch', 1000, 5, 5);
    % randsamp('batch.keep', 0.1);
    % batch = 'batch.keep.rand';
%     randsamp('batch.keep', 0.05);
    batch = 'batch.keep';
    
    % ==================== 2) move old .notmat
    if ~exist('OLDNOTMAT_SeqDepPitch', 'dir')
        mkdir OLDNOTMAT_SeqDepPitch
        !cp *.not.mat* OLDNOTMAT_SeqDepPitch
    else
        disp('not making OLDNOTMAT_SeqDepPitch, since already made!!');
    end
    
    
    % ==================== 3) run autolabel
    % ---- GENERAL PARAMS
    ampThresh=30000;
    min_dur=30;
    min_int=3;
    
    % ---- MOTIF 1 [abB] [not labeling abb(b) % since WN target is ab(b)]
    config= '/bluejay5/lucas/birds/pu53wh88/config_AL_aB.evconfig2';
    syl.targ='b';
    syl.pre='ab';
    syl.post='';
    NoteNum=0;
    overwrite_notmat=1; % will always make backup folder
    
    [fnames, sylnum, vlsorfn, vlsorind]=lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat);
    
    
    % ------ MOTIF 2 [accBb]
    config= '/bluejay5/lucas/birds/pu53wh88/config_AL_cB.evconfig2';
    syl.targ='b';
    syl.pre='acc';
    syl.post='b';
    NoteNum=0;
    overwrite_notmat=0; % will always make backup folder
    
    [fnames, sylnum, vlsorfn, vlsorind]=lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat);
    
    
    
end

%% ============ MAKE WAVE FILES TO LOOK FOR FALSE POSITIVES

syl = 'b';
presyl = 'a';
[fnames, sylnum]=lt_jc_chcklbl(batch, syl, 0.025,0.025, presyl,'','');
[vlsorfn vlsorind]=jc_vlsorfn(batch, syl, presyl,'');

syl = 'c';
presyl = 'c';
[fnames, sylnum]=lt_jc_chcklbl(batch, syl, 0.025,0.025, presyl,'','');
[vlsorfn vlsorind]=jc_vlsorfn(batch, syl, presyl,'');

syl = 'b';
presyl = 'cb';
[fnames, sylnum]=lt_jc_chcklbl(batch, syl, 0.025,0.025, presyl,'','');
[vlsorfn vlsorind]=jc_vlsorfn(batch, syl, presyl,'');

%% ============ 2) Use evsonganaly manually on the .wav file created above
% (contains only the syls you chose)
% INSTRUCTIONS: 
% 1) open .wav file using evsonganaly
% 2) change threshold to segment all syls indivudally
% 3) any syl labeled "-" (default) will remain unchanged (i.e. will stay autolabeled). 
%     give a new label to any mislabeled syl - that will be its new actual label
evsonganaly


%% ============ 3) Replace hand-checekd mislabeld syls 
lt_autolabel_FixHandCheckedSyls(fnames, sylnum, vlsorfn, vlsorind)
