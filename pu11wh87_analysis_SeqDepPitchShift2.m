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











