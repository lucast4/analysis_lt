%% 1) TO GATHER RAW DATA for one day
% clear all; close all;
% 
% Params.DayRawDat.fs=32000;
% Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
% Params.DayRawDat.batch='batch.labeled.all.subset';
% Params.DayRawDat.syllables={'a','b','c'};
% Params.DayRawDat.frequency_range={[1300 2200], [2800 3950],[2150 3150]};
% % Params.DayRawDat.dat_dur;
% Params.DayRawDat.pc_dur=[0.12,0.09,0.11];
% Params.DayRawDat.pc_time_window={[375 525],[60 220],[55 320]};
% Params.DayRawDat.pc_sigma=1;
% 
% % plot and save?
% plotON=1;
% saveON=0;
% 
% [Params, RawDatStruct]=lt_seq_dep_pitch_DayRawDat(Params,1,1);
% 
%% TO DO OVER ALL DAYS [latest, adding d, 9/14/15]
clear all; close all
phrase = 'SeqDepPitchShift2';
first_day= '23Nov2014';
last_day= '20Dec2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.catch';
Params.DayRawDat.syllables={'a','b','c', 'd'};
Params.DayRawDat.frequency_range={[1300 2200], [2800 3950],[2150 3150], [1100 2700]};
Params.DayRawDat.pc_dur=[0.12,0.11,0.10, 0.10];

Params.DayRawDat.pc_time_window={[375 525],[60 220],[55 320], [10 180]};
Params.DayRawDat.pc_sigma=1;


plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);


% =-===================================
clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=2200;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

Params.SeqFilter.SeqPreList={'a','ab','c','cb','bcc','bccb','dcc','dccb','b','bc','d','dc'};
Params.SeqFilter.SylTargList={'b','b','b','b','b','b','b','b','c','c','c','c'};
Params.SeqFilter.SeqPostList={'','','','','','','','','','','',''};


% 2) experiment info
Params.SeqFilter.WNTimeON='23Nov2014-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '20Dec2014-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:6;


Params.SeqFilter.SylLists.FieldsInOrder{1}={'a','aB','abB','bC','bcC','bccB','bccbB'};
Params.SeqFilter.SylLists.FieldsInOrder{2}={'d','dC','dcC','dccB','dccbB'};

Params.SeqFilter.SylLists.FieldsToPlot{1}={'aB','abB','bccB','bccbB','dccB','dccbB'};
Params.SeqFilter.SylLists.FieldsToPlot{2}={'d','bC','bcC','dC','dcC'};

Params.SeqFilter.SylLists.TargetSyls={'dccB'};
Params.SeqFilter.SylLists.SylsSame={'aB','abB','bccB','bccbB','dccbB'};
Params.SeqFilter.SylLists.SylsDifferent={'a','d','bC','bcC','dC','dcC'};

Params.SeqFilter.DaysForSnapshot{1}={'09Dec2014','11Dec2014'};
Params.SeqFilter.DaysToMark= {'11Dec2014-2400'}; % will mark all plots with lines here;

% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);


%% TO DO OVER ALL DAYS [OLD, without "d"]
clear all; close all
phrase = 'SeqDepPitchShift2';
first_day= '23Nov2014';
last_day= '20Dec2014';
% first_day= '19Nov2014';
% last_day= '22Nov2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.catch';
Params.DayRawDat.syllables={'a','b','c'};
Params.DayRawDat.frequency_range={[1300 2200], [2800 3950],[2150 3150]};
Params.DayRawDat.pc_dur=[0.12,0.11,0.10];

Params.DayRawDat.pc_time_window={[375 525],[60 220],[55 320]};
Params.DayRawDat.pc_sigma=1;


plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);



% ============== 2) Seq filter, remove outliers, and compile raw data, and enter experiment info into params

clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=2200;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

Params.SeqFilter.SeqPreList={'a','ab','c','cb','bcc','bccb','dcc','dccb','b','bc','d','dc'};
Params.SeqFilter.SylTargList={'b','b','b','b','b','b','b','b','c','c','c','c'};
Params.SeqFilter.SeqPostList={'','','','','','','','','','','',''};


% 2) experiment info
Params.SeqFilter.WNTimeON='23Nov2014-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '20Dec2014-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:4;

Params.SeqFilter.SylLists.FieldsToPlot{1}={'aB','abB','bccB','bccbB','dccB','dccbB'};
Params.SeqFilter.SylLists.FieldsToPlot{2}={'bC','bcC','dC','dcC'};
Params.SeqFilter.SylLists.FieldsInOrder{1}={'a','aB','abB','bC','bcC','bccB','bccbB'};
Params.SeqFilter.SylLists.FieldsInOrder{2}={'dC','dcC','dccB','dccbB'};
Params.SeqFilter.SylLists.TargetSyls={'dccB'};
Params.SeqFilter.SylLists.SylsSame={'aB','abB','bccB','bccbB','dccbB'};
Params.SeqFilter.SylLists.SylsDifferent={'a','bC','bcC','dC','dcC'};

Params.SeqFilter.DaysForSnapshot{1}={'09Dec2014','11Dec2014'};
Params.SeqFilter.DaysToMark= {'11Dec2014-2400'}; % will mark all plots with lines here;

% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);


%% === PLOT
Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;

[Params, AllDays_PlotLearning, AllDays_RawDatStruct]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);





% %% 3) Perform various analyses on that data structure
% 
% plotDIR=0;
% DirFilename='';
% UndirFilename='/bluejay3/lucas/birds/pu11wh87/compile_seq_dep_pitch_data_SeqDepPitchShift2/SEQFILTER/AllDays_Compiled/AllDays_Compiled_18Nov2014_to_20Dec2014';
% 
% [Params, AllDays_PlotLearningDatStruct]=lt_seq_dep_pitch_PlotLearning(Params_UNDIR, Params_DIR, AllDays_RawDatStruct_UNDIR, AllDays_RawDatStruct_DIR);
% 
% 
% 
% %% 3) Extract structure statistics
% 
% 
% % to extract data
% [Params, AllDays_StructStatsStruct]=lt_seq_dep_pitch_StructureStats(Params, AllDays_RawDatStruct);
% 
% % to process data
% [Params, AllDays_StructStatsStruct]=lt_seq_dep_pitch_StructureStats_SylSimilarity(Params, AllDays_StructStatsStruct);
% 
% 
% % to plot and perform PCA on syl structure
% % Params.epoch='baseline'; % will look at baseline
% Params.PCA.epoch=[21 24]; % days 21 to 24
% 
% [Params, PCA_Struct]=lt_seq_dep_pitch_StructureStats_featurePCA(Params, AllDays_StructStatsStruct,1)
% 
% 
% 



%% CHECKING TEMPLATE -  WHEN TWO TEMPLATES USED SIMULTANEOUSLY (dccb and bccb)

clear all; close all;
batchf='batch.labeled.catch';
config='/bluejay3/lucas/birds/pu11wh87/121214_SeqDepPitchShift2_UpAndDn_durWN_day20/config_121114_Start.evconfig2';

syl='b';
syl_pre='bcc';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


%% NEW TEMPLATE

% FOR TARGET DCCB
clear all; close all;
batchf='batch.labeled.all';
syl='b';
syl_pre='dcc';
syl_post='';
syl_refract=0.2;
freq_range=[2800 3800];
evtaf_ver='v4';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;


template_name='pu11wh87dccb_SeqDepPitchShift2_v1_6';
cntrng_values{1}={[35 55 2.4] 'and' 'n' 'y'};
cntrng_values{2}={[2 14 2.4] 'and' 'n' 'y'};
cntrng_values{3}={[1 4 2.2] 'or' 'n' 'n'};
cntrng_values{4}={[1 4 2.2] 'or' 'n' 'n'};
cntrng_values{5}={[1 4 2.2] 'or' 'n' 'n'};
cntrng_values{6}={[1 4 2.2] 'or' 'n' 'n'};
col_logic='(a*b)*(c+d+e+f)';

check_stuff=lt_check_hit_templ_freq_FUNCTION(batchf, syl, syl_pre, syl_post, syl_refract, freq_range, ...
    evtaf_ver,get_WN_hits,get_offline_match,get_FF,template_name,cntrng_values,col_logic);


%% TARGETING dccB (and avoiding accB)
% START, Single day check - pitch

% FOR TARGET DCCB
clear all; close all;
batchf='batch.labeled.catch';
syl='b';
syl_pre='dcc';
syl_post='';
syl_refract=0.2;
freq_range=[2800 3800];
evtaf_ver='v4';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;

% old params
% template_name='pu11wh87dccb_SeqDepPitchShift2_v1_3';
% cntrng_values{1}={[35 55 2.5] 'and' 'n' 'y'};
% cntrng_values{2}={[2 14 2.5] 'and' 'n' 'y'};
% cntrng_values{3}={[1 4 2.2] 'or' 'n' 'n'};
% col_logic='(a*b*c)';
% 

template_name='pu11wh87dccb_SeqDepPitchShift2_v1_3';
cntrng_values{1}={[35 55 2.4] 'and' 'n' 'y'};
cntrng_values{2}={[2 14 2.4] 'and' 'n' 'y'};
cntrng_values{3}={[1 4 2.2] 'or' 'n' 'n'};
col_logic='(a*b*c)';

check_stuff=lt_check_hit_templ_freq_FUNCTION(batchf, syl, syl_pre, syl_post, syl_refract, freq_range, ...
    evtaf_ver,get_WN_hits,get_offline_match,get_FF,template_name,cntrng_values,col_logic);


% TO NONTARGET BCCB
clear all; close all;
batchf='batch.labeled.catch';
syl='b';
syl_pre='bcc';
syl_post='';
syl_refract=0.2;
freq_range=[2800 3800];
evtaf_ver='v4';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;

template_name='pu11wh87dccb_SeqDepPitchShift2_v1_3';
cntrng_values{1}={[35 55 2.2] 'and' 'y' 'y'};
cntrng_values{2}={[2 14 2.4] 'and' 'n' 'y'};
cntrng_values{3}={[1 4 1.8] 'or' 'n' 'n'};
col_logic='(a*b*c)';

% template_name='pu11wh87dccb_SeqDepPitchShift2_v1_6';
% cntrng_values{1}={[35 55 2.4] 'and' 'y' 'y'};
% cntrng_values{2}={[2 14 2.2] 'and' 'n' 'y'};
% cntrng_values{3}={[1 4 2.0] 'or' 'n' 'n'};
% cntrng_values{4}={[1 4 2.0] 'or' 'n' 'n'};
% cntrng_values{5}={[1 4 2.0] 'or' 'n' 'n'};
% cntrng_values{6}={[1 4 2.0] 'or' 'n' 'n'};
% col_logic='(a*b)*(c+d+e+f)';


check_stuff=lt_check_hit_templ_freq_FUNCTION(batchf, syl, syl_pre, syl_post, syl_refract, freq_range, ...
    evtaf_ver,get_WN_hits,get_offline_match,get_FF,template_name,cntrng_values,col_logic);

%% TO ANALYZE ACROSS DAYS
%% OLD VERSION BELOW - IGNORE!!




%% 11/18/14 - USING NEW METHOD - UNDIR SONGS
clear all; close all
phrase = 'SeqDepPitchShift2';
first_day= '16Dec2014';
last_day= '20Dec2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch'};

% Parameters for functions within
batchSDP='batch.labeled.catch';
syllables_SDP={'a','b','c'};
frequency_range_SDP ={[1300 2200], [2800 3950],[2150 3150]}; % for findwnote
pc_window_SDP =[0.12,0.07,0.11]; % size of syl data window (in sec); (how much data to get for each rend (relative to onset), in sec)
pc_time_window ={[375 525],[60 220],[55 320]}; %for pitch contour (time bins to avg).


SeqPreList_SDP={'a','ab','c','cb','bcc','bccb','dcc','dccb','b','bc','d','dc'}; % format: 1st elem of all three lists should combine
SylTargList_SDP={'b','b','b','b','b','b','b','b','c','c','c','c'}; % these must already have raw data compiled above
SeqPostList_SDP={'','','','','','','','','','','',''};

WithinParams={'batchSDP',batchSDP,'syllables_SDP',syllables_SDP,'frequency_range_SDP',frequency_range_SDP,'pc_window_SDP',pc_window_SDP,...
    'pc_time_window',pc_time_window,'SeqPreList_SDP',SeqPreList_SDP,'SylTargList_SDP',SylTargList_SDP,'SeqPostList_SDP',SeqPostList_SDP};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);


% TO DO BASELINE (i.e. not just catch songs) -----------------------------------
clear all; close all
phrase = 'SeqDepPitchShift2';
first_day= '18Nov2014';
last_day= '22Nov2014';
% last_day= '30Nov2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch'};

% Parameters
batchSDP='batch.labeled.all';
syllables_SDP={'a','b','c'};
frequency_range_SDP ={[1300 2200], [2800 3950],[2150 3150]}; % for findwnote
pc_window_SDP =[0.12,0.07,0.11]; % size of syl data window (in sec); (how much data to get for each rend (relative to onset), in sec)
pc_time_window ={[375 525],[60 220],[55 320]}; %for pitch contour (time bins to avg).


SeqPreList_SDP={'a','ab','c','cb','bcc','bccb','dcc','dccb','b','bc','d','dc'}; % format: 1st elem of all three lists should combine
SylTargList_SDP={'b','b','b','b','b','b','b','b','c','c','c','c'}; % these must already have raw data compiled above
SeqPostList_SDP={'','','','','','','','','','','',''};

WithinParams={'batchSDP',batchSDP,'syllables_SDP',syllables_SDP,'frequency_range_SDP',frequency_range_SDP,'pc_window_SDP',pc_window_SDP,...
    'pc_time_window',pc_time_window,'SeqPreList_SDP',SeqPreList_SDP,'SylTargList_SDP',SylTargList_SDP,'SeqPostList_SDP',SeqPostList_SDP};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);

%% (OPTIONAL) - TO FILTER OUT SEQUENCES IN (SINGLE SYL) DATA THAT HAVE ALREADY BEEN STORED INTO STRUCTURES
% Run in the folder containing the data structures (e.g. % Run in folder: 
% e.g.
% /bluejay3/lucas/birds/pu11wh87/compile_seq_dep_pitch_data_SeqDepPitchShift,
% containing structures:
% e.g. DataStruct_02Nov2014);

all_days=1;
FirstDay='';
LastDay='';
SeqPreList={'a','ab','c','cb','bcc','bccb','dcc','dccb','b','bc','d','dc'}; % format: 1st elem of all three lists should combine
SylTargList={'b','b','b','b','b','b','b','b','c','c','c','c'}; % these must already have raw data compiled above
SeqPostList={'','','','','','','','','','','',''};

lt_compile_seq_dep_pitch_data_SEQFILTER_MULTDAYS(all_days,FirstDay,LastDay,SeqPreList,SylTargList,SeqPostList)


%% COMPILE ALL DAYS - in SEQFILTER folder

lt_compile_seq_dep_pitch_data_LOADSAVEFILES(1);

%% PLOT - (ONCE HAVE COMPILED DIR AND UNDIR INTO SINGLE STRUCTURES)
clear all; close all;

plotDIR=0;
DirFilename='';
UndirFilename='/bluejay3/lucas/birds/pu11wh87/compile_seq_dep_pitch_data_SeqDepPitchShift2/SEQFILTER/AllDays_Compiled/AllDays_Compiled_18Nov2014_to_20Dec2014';

SylLists.FieldsToPlot{1}={'aB','abB','bccB','bccbB','dccB','dccbB'};
SylLists.FieldsToPlot{2}={'bC','bcC','dC','dcC'};

SylLists.FieldsInOrder{1}={'a','aB','abB','bC','bcC','bccB','bccbB'};
SylLists.FieldsInOrder{2}={'dC','dcC','dccB','dccbB'};

SylLists.TargetSyls={'dccB'};

SylLists.SylsSame={'aB','abB','bccB','bccbB','dccbB'};
SylLists.SylsDifferent={'a','bC','bcC','dC','dcC'};

BaselineDays=1:4;

plotWNdays=1; % 1 is on, 0 is off.
WNTimeON='23Nov2014-0000'; % Time WN turned on
WNTimeOFF= '20Dec2014-2400'; % Time WN turned off ( use 0000 and 2400 if only plotting days)
DaysToMark= {'11Dec2014-2400'}; % will mark all plots with lines here;

DaysForSnapshot{1}={'09Dec2014','11Dec2014'};

lt_compile_seq_dep_pitch_data_PLOTDirUndir(DirFilename,UndirFilename,plotDIR,...
    BaselineDays,plotWNdays,WNTimeON,WNTimeOFF,SylLists,DaysForSnapshot,DaysToMark)




%% 2/5/15 - LATEST WAY TO ANALYZE - fits into structure analysis stuff




%% ###################################################################
%% ################################################# AUTOLABEL

% STRATEGY for complete labeling:
% first label all c(b) as dccb, then overwrite those that are bccb

%% =============== TEST CONFIGS
clear all; close all;


% ===== MOTIF 1 - bccB
% NOTE: good, hits almost all, but some FP.
batchf = 'BatchAll.LABELED';
% config='/bluejay4/lucas/birds/pu11wh87/config_111715.evconfig2'; 
config='/bluejay5/lucas/birds/pu11wh87/config_AL_bccB.evconfig2'; 

syl='b';
syl_pre='bcc';
syl_post='';
get_WN_hits=0;
get_offline_match=1;
get_FF=0;

NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


% ===== MOTIF 1 - bccB
% MATCHED ALL
batchf = 'BatchAll.LABELED';
% config='/bluejay4/lucas/birds/pu11wh87/config_111715.evconfig2'; 
% config='/bluejay5/lucas/birds/pu11wh87/config_AL_dccB_2.evconfig2'; 
% config='/bluejay5/lucas/birds/pu11wh87/config_AL_dccB_3.evconfig2'; % modified template
% config='/bluejay5/lucas/birds/pu11wh87/config_AL_dccB_3.evconfig2'; % modified template
config='/bluejay5/lucas/birds/pu11wh87/config_AL_dccb.evconfig2'; % modified template

syl='b';
syl_pre='dcc';
syl_post='';
get_WN_hits=0;
get_offline_match=1;
get_FF=0;

NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


%% ================ AUTOLABLE
% AND ITERATION OVER DAY
clear all; close all;

% ========================= 0) ECTRACT DIRECTORIRES
basedir = '/bluejay5/lucas/birds/pu11wh87';
% date_range_base={'10Feb2015','12Feb2015'};
% date_range_WN={'14Feb2015','16Feb2015'};
% experiment = 'SeqDepPitchShift3';

    
% -------- COLLECT METADAT
% cd(basedir);
% MetadataStruct=lt_metadata_collect;
% 
% condition='';
% notes='';
% only_labeled_dirs=0;
% 
% % ----- BASELINE
% ListOfDirs1=lt_metadata_find_dirs(MetadataStruct, experiment, condition, ...
%     notes, date_range_base, only_labeled_dirs, 2);
% 
% % ------ WN
% ListOfDirs2=lt_metadata_find_dirs(MetadataStruct, experiment, condition, ...
%     notes, date_range_WN, only_labeled_dirs, 2);
% 
% % ------- COMBINE
% ListOfDirs = [ListOfDirs1 ListOfDirs2];
% 
ListOfDirs = {...
    '/bluejay5/lucas/birds/pu11wh87/112014_SeqDepPitchShift2_pre', ...
    '/bluejay5/lucas/birds/pu11wh87/112114_SeqDepPitchShift2_pre', ...
    '/bluejay5/lucas/birds/pu11wh87/112214_SeqDepPitchShift2_pre', ...
    '/bluejay5/lucas/birds/pu11wh87/112314_SeqDepPitchShift2_durWN_day1', ...
    '/bluejay5/lucas/birds/pu11wh87/112414_SeqDepPitchShift2_durWN_day2', ...
    '/bluejay5/lucas/birds/pu11wh87/112514_SeqDepPitchShift2_durWN_day3'};
% ListOfDirs = {...
%     '/bluejay5/lucas/birds/pu11wh87/112314_SeqDepPitchShift2_durWN_day1', ...
%     '/bluejay5/lucas/birds/pu11wh87/112414_SeqDepPitchShift2_durWN_day2', ...
%     '/bluejay5/lucas/birds/pu11wh87/112514_SeqDepPitchShift2_durWN_day3'};

% ============================== RUN, ITERATE OVER DAYS
for j=1:length(ListOfDirs)

    % ==================== 0) go to day folder
    cd(ListOfDirs{j});
    
    % ==================== 1) extract all s
    !ls *.cbin > BatchAll
    lt_cleandirAuto('BatchAll', 1000, 5, 5);
    batch = 'BatchAll.keep';
%     batch = 'BatchPBS.rand';
    
    % ==================== 2) move old .notmat
    if ~exist('OLDNOTMAT_SeqDepPitch', 'dir')
        mkdir OLDNOTMAT_SeqDepPitch
        !cp *.not.mat* OLDNOTMAT_SeqDepPitch
    else
        disp('not making OLDNOTMAT_SeqDepPitch, since already made!!');
    end
    
    
    % ==================== 3) run autolabeli
    if (1)
    % ---- GENERAL PARAMS
    ampThresh=2200;
    min_dur=30;
    min_int=5;
    
    % ---- MOTIF 1 - first do dccB. this will label all dccB as well as
    % match B on abbccb(b) (i.e. FP). Next will overwrite so is ok.
    config='/bluejay5/lucas/birds/pu11wh87/config_AL_dccb.evconfig2'; % modified template
    syl.targ='b';
    syl.pre='dcc';
    syl.post='';
    NoteNum=0;
    overwrite_notmat=1; % will always make backup folder
    
    [fnames, sylnum, vlsorfn, vlsorind]=lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat);
    
    
    % ------ MOTIF 2 - abbcc(b)b. since this b is target, will replace
    % following syls with dash. this is also important because dcc(b) above
    % replaces abbccb(b) with dcc(b)b, so there will be one b jutting
    % out...
    config='/bluejay5/lucas/birds/pu11wh87/config_AL_bccB.evconfig2'; 
    syl.targ='b';
    syl.pre='abbcc';
    syl.post='b';
    NoteNum=0;
    overwrite_notmat=0; % will always make backup folder
    
    [fnames, sylnum, vlsorfn, vlsorind]=lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat);
    
    else
    % ---- GENERAL PARAMS
    ampThresh=2200;
    min_dur=30;
    min_int=5;
    
    % ---- MOTIF 1 - first do dccB. this will label all dccB as well as
    % match B on abbccb(b) (i.e. FP). Next will overwrite so is ok.
    config='/bluejay5/lucas/birds/pu11wh87/config_AL_dccb.evconfig2'; % modified template
    syl.targ='b';
    syl.pre='dcc';
    syl.post='';
    NoteNum=0;
    overwrite_notmat=0; % will always make backup folder
    
    [fnames, sylnum, vlsorfn, vlsorind]=lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat);
    end

end




%% === check

% syl = 'c';
% presyl = '';
% [fnames, sylnum]=lt_jc_chcklbl(batch, syl, 0.025,0.025, presyl,'','');
% [vlsorfn vlsorind]=jc_vlsorfn(batch, syl, presyl,'');

syl = 'd';
presyl = '';
[fnames, sylnum]=lt_jc_chcklbl(batch, syl, 0.025,0.025, presyl,'','');
[vlsorfn vlsorind]=jc_vlsorfn(batch, syl, presyl,'');

syl = 'a';
presyl = '';
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


%% ###########################################################
%% ########################################## CALC FF
%% calc FF for all syls, save next to song file
clear all; close all;

ListOfDirs_UNDIR = {...
    '/bluejay5/lucas/birds/pu11wh87/112014_SeqDepPitchShift2_pre', ...
    '/bluejay5/lucas/birds/pu11wh87/112114_SeqDepPitchShift2_pre', ...
    '/bluejay5/lucas/birds/pu11wh87/112214_SeqDepPitchShift2_pre', ...
    '/bluejay5/lucas/birds/pu11wh87/112314_SeqDepPitchShift2_durWN_day1', ...
    '/bluejay5/lucas/birds/pu11wh87/112414_SeqDepPitchShift2_durWN_day2', ...
    '/bluejay5/lucas/birds/pu11wh87/112514_SeqDepPitchShift2_durWN_day3'};


ListOfDirs_DIR = {};

ListOfDirs_ALL = [ListOfDirs_UNDIR ListOfDirs_DIR];

ListOfBatch = {...
    'BatchAll.LABELED', ...
    'BatchAll.LABELED', ...
    'BatchAll.LABELED', ...
    'BatchAll.LABELED', ...
    'BatchAll.LABELED', ...
    'BatchAll.LABELED', ...
    };

FFparams.cell_of_freqwinds={'c', [2000 3200], 'b', [2800 3800], ...
    'a', [1300 2200], 'd', [1200 2700]};
FFparams.cell_of_FFtimebins={'c', [0.036 0.065], 'b', [0.03 0.034], ...
    'a', [0.07 0.085], 'd', [0.028 0.036]};
plotAllPC = 0;
plotEachSyl = 0;
overwrite = 1;

% ==================== CALCULATE AND SAVE FF
lt_batchsong_calcFF(ListOfDirs_ALL, ListOfBatch, FFparams, plotAllPC, plotEachSyl, ...
    overwrite);

%% ==== EXTRACT FF
MotifsToExtract = {'(d)ccb', 'd(c)cb', 'dc(c)b', 'dcc(b)', ...
    '(a)bbccb', 'a(b)bccb', 'ab(b)ccb', 'abb(c)cb', 'abbc(c)b', 'abbcc(b)', 'abbccb(b)'};
DATSTRUCT = lt_batchsong_extractFF(ListOfDirs_UNDIR, ListOfDirs_DIR, ListOfBatch, MotifsToExtract);


%% ============== PLOT
close all;
TrainON = '23Nov2014-0000';
SwitchTimes = {};
subtractMean = 1;
dozscore = 0;

lt_batchsong_plotFF(DATSTRUCT, MotifsToExtract, TrainON, SwitchTimes, ...
    subtractMean, dozscore);


