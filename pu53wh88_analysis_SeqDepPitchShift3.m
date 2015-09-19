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
config= '/bluejay3/lucas/birds/pu53wh88/c_test.evconfig2';

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
