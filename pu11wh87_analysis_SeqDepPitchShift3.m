%% 2/9/15 - check target dccb[b]
% IGNORE - OLD TARGET that aborted

% close all;
% batchf='batch.labeled.all';
% config='/bluejay3/lucas/birds/pu11wh87/config_AndNotA.evconfig2';
% 
% syl='b';
% syl_pre='dccb';
% syl_post='';
% get_WN_hits=0;
% get_offline_match=1;
% get_FF=0;
% NoteNum=0;
% 
% check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);
% 

%% read config file

test=ReadEvTAFv4ConfigFile('/bluejay3/lucas/birds/pu11wh87/config.evconfig2')


%% NOTES

% using btaf min - 36/41 matched (or less)
% using min of one, does not work.
% 
% for all days, works well, but get some fp (v1, 8)-
%     solution - make it depend on multiple ds.  
%     thresholds
%     49-76 (2nd d)
%     40-? (1st d)
%     
%     col 73 is good. 
%     
%     A - 
%     
%     
%     strategy 1 - add A, not, from 32 to 88 (WORKS!!!)
%     39/41 no FP, 2/8
%     
%     not really, 43/49 (4fp) for 2/9
%     
%     
%     strategy 2 - use from last night, but have c with birdtaf min. (DID NOT WORK)
%         improve by using d clsoer?  

% PROBLEM - none of the templates are working.



%% NEW TARGET: ab[b] UP

% Test target
close all;
batchf='batch.labeled.all';
% config='/bluejay3/lucas/birds/pu11wh87/021515_SeqDepPitchShift3_durWN_day1/config_021514_tempkl.evconfig2';
config='/bluejay3/lucas/birds/pu11wh87/021715_SeqDepPitchShift3_durWN_day3/config_021715_2.evconfig2'; % use this after 2/17 11am


syl='b';
syl_pre='ab';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

%% TARGET: a[b]

% Test target
close all;
batchf='batch.labeled.all';
% config='/bluejay3/lucas/birds/pu11wh87/021515_SeqDepPitchShift3_durWN_day1/config_021514_tempkl.evconfig2';
config='/bluejay3/lucas/birds/pu11wh87/config_ab1.evconfig2';


syl='b';
syl_pre='a';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);




%% ----------------------------------------------------------------------------------------------
%% ANALYZING ACROSS DAYS
clear all; close all
phrase = 'SeqDepPitchShift3';
first_day= '21Mar2015';
last_day= '21Mar2015';
Params.DayRawDat.batch='batch.labeled.all';

save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.syllables={'a','b','c', 'd'};
Params.DayRawDat.frequency_range={[1300 2200], [2800 3950],[2150 3150], [500 2800]};
Params.DayRawDat.pc_dur=[0.12,0.11,0.13, 0.11];

Params.DayRawDat.pc_time_window={[375 525],[60 205],[55 320], [28 217]};
Params.DayRawDat.pc_sigma=1;


plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);


%% 2) Seq filter, remove outliers, and compile raw data, and enter experiment info into params
cd seq_dep_pitch_SeqDepPitchShift3
clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=15000;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

Params.SeqFilter.SeqPreList={'a','ab','c','cb','bcc','bccb','dcc','dccb','b','bc','d','dc'};
Params.SeqFilter.SylTargList={'b','b','b','b','b','b','b','b','c','c','c','c'};
Params.SeqFilter.SeqPostList={'','','','','','','','','','','',''};


% 2) experiment info
Params.SeqFilter.WNTimeON='15Feb2015-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '11Mar2015-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:6;

Params.SeqFilter.SylLists.FieldsToPlot{1}={'aB','abB','bccB','bccbB','dccB','dccbB'};
Params.SeqFilter.SylLists.FieldsToPlot{2}={'d','bC','bcC','dC','dcC'};

Params.SeqFilter.SylLists.FieldsInOrder{1}={'a','aB','abB','bC','bcC','bccB','bccbB'};
Params.SeqFilter.SylLists.FieldsInOrder{2}={'d','dC','dcC','dccB','dccbB'};

Params.SeqFilter.SylLists.TargetSyls={'abB'};
Params.SeqFilter.SylLists.SylsSame={'aB','bccB','bccbB','dccB','dccbB'};
Params.SeqFilter.SylLists.SylsDifferent={'d','a','bC','bcC','dC','dcC'};

Params.SeqFilter.DaysForSnapshot{1}={'05Mar2015','07Mar2015'};
Params.SeqFilter.DaysToMark= {'07Mar2015-2400'}; % will mark all plots with lines here;

% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);



%% 3) Perform various analyses on that data structure

Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;


[Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);


%% Plot learning with manipulation (e.g. with LMAN inactivation) =======================


% First, update params with cell array holding times of all manipulations
% format for each entry in the cell array: {Date, Musc_On_Time, Musc_Off_Time};
% if only has date, then means that day did not have muscimol.

Muscimol_Schedule{1}={'05May2015', '1401','2036'};
Muscimol_Schedule{2}={'06May2015'};
Muscimol_Schedule{3}={'07May2015', '1125','1719'};
Muscimol_Schedule{4}={'08May2015', '1155','1636'};
Muscimol_Schedule{5}={'09May2015', '1404','1915'};
Muscimol_Schedule{6}={'10May2015', '1238','1831'};
Muscimol_Schedule{7}={'11May2015', '1215','1555'};


lt_seq_dep_pitch_UpdateParams_Muscimol(Muscimol_Schedule);




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
DaysWanted=21:23; % either baseline (astring) or array
lt_seq_dep_pitch_Correlations(Params, AllDays_StructStatsStruct,DaysWanted);