%% NEW METHOD - REGULAR EXPRESSIONS ACROSS DAYS (9/1/15) ==================================================================

%% TO DO OVER ALL DAYS
% -- BASELINE
clear all; close all
phrase = 'RepDepPitchShift';
first_day= '02Dec2014';
last_day= '21Dec2014';
% BASELINE
% first_day= '27Nov2014';
% last_day= '01Dec2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.catch';
Params.DayRawDat.syllables={'d','b','g'};
Params.DayRawDat.frequency_range={[1500 3000], [3000 4000],[1000 1900]};
Params.DayRawDat.pc_dur=[0.12,0.11,0.25];

Params.DayRawDat.pc_time_window={[95 225],[63 210],[113 290]};
Params.DayRawDat.pc_sigma=1;


plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);



%% 2) Seq filter, remove outliers, and compile raw data, and enter experiment info into params

clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=3000;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

% Params.SeqFilter.SeqPreList={'j','jb','jbb'};
% Params.SeqFilter.SylTargList={'b','b','b'};
% Params.SeqFilter.SeqPostList={'','',''};
Params.SeqFilter.SeqPreList={}; 
Params.SeqFilter.SylTargList={};
Params.SeqFilter.SeqPostList={};

Params.SeqFilter.Repeats={'jB'};


% 2) experiment info
Params.SeqFilter.WNTimeON='02Dec2014-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '21Dec2014-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:5;

Params.SeqFilter.SylLists.FieldsToPlot{1}={'jB','jbB','jbbB','jbbbB','jbbbbB','jbbbbbB'};
Params.SeqFilter.SylLists.FieldsInOrder{1}={'jB','jbB','jbbB','jbbbB','jbbbbB','jbbbbbB'};
Params.SeqFilter.SylLists.TargetSyls={'jbbB'};
Params.SeqFilter.SylLists.SylsSame={'jB','jbB','jbbbB','jbbbbB','jbbbbbB'};
Params.SeqFilter.SylLists.SylsDifferent={};

% Params.SeqFilter.DaysForSnapshot{1}={};
Params.SeqFilter.DaysToMark= {'08Dec2014-1952','11Dec2014-2200','14Dec2014-1750'}; % will mark all plots with lines here;
% 1) changed to b1
% 2) target allb/computer shut down and restarted (same time),
% 3) fixed problem of WN not getting 2 syls in a row


% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);


%% ========================== Use regular expressions to sort data from Raw data

Params.RegExpr.expressions={'jb+'};
[Params, AllDays_RegExpr] = lt_seq_dep_pitch_RegExpr(Params, AllDays_RawDatStruct);


% ========================== PLOT REG EXPR DATA
close all;
Params.PlotRegExpr.plotWNdays=1;
saveON=1;
[Params, AllDays_RegExpr]=lt_seq_dep_pitch_PlotRegExpr(Params, AllDays_RegExpr ,saveON);



%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% 12/1/14 - BEFORE WN, checking pitch and repeat histogram

% TO CHECK TARGET (jbb[b])
clear all; close all;
batchf='batch.labeled.notcatch';
config='/bluejay3/lucas/birds/bu11or68/120214_RepDepPitchShift_durWN_day1_WNbackOn/config-120214_threshCorrect.evconfig2';

syl='b';
syl_pre='jbb';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;


% syl_refract=0.04;
% freq_range=[3000 4000];
% evtaf_ver='v4';
% template_name='bu11or68b_v1_3';
% cntrng_values{1}={[2 4 2.2] 'or' 'n' 'n'};
% cntrng_values{2}={[2 4 2.2] 'or' 'n' 'n'};
% cntrng_values{3}={[2 4 2.2] 'or' 'n' 'n'};
% col_logic='(a+b+c)';


check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% check_stuff=lt_check_hit_templ_freq_FUNCTION(batchf, syl, syl_pre, syl_post, syl_refract, freq_range, ...
%     evtaf_ver,get_WN_hits,get_offline_match,get_FF,template_name,cntrng_values,col_logic);



% TO HIT FIRST B
% TO CHECK TARGET
clear all; close all;
batchf='batch.labeled.notcatch';
config='/bluejay3/lucas/birds/bu11or68/config_firstB.evconfig2';

syl='b';
syl_pre='j';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;


% syl_refract=0.04;
% freq_range=[3000 4000];
% evtaf_ver='v4';
% template_name='bu11or68b_v1_3';
% cntrng_values{1}={[2 4 2.2] 'or' 'n' 'n'};
% cntrng_values{2}={[2 4 2.2] 'or' 'n' 'n'};
% cntrng_values{3}={[2 4 2.2] 'or' 'n' 'n'};
% col_logic='(a+b+c)';


check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% check_stuff=lt_check_hit_templ_freq_FUNCTION(batchf, syl, syl_pre, syl_post, syl_refract, freq_range, ...
%     evtaf_ver,get_WN_hits,get_offline_match,get_FF,template_name,cntrng_values,col_logic);


% TO HIT ANY B
% TO CHECK TARGET
clear all; close all;
batchf='batch.labeled.all';
config='/bluejay3/lucas/birds/bu11or68/config_121114_start.evconfig2';

syl='b';
syl_pre='';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

%% TO ANALYZE ACROSS DAYS - IGNORE!!!!!!!!!!!!!!!!
% USING NEW METHOD - UNDIR SONGS


clear all; close all
phrase = 'RepDepPitchShift';
first_day= '27Nov2014';
last_day= '27Nov2014';
% last_day= '30Nov2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch'};

% Parameters
batchSDP='batch.labeled.all';
syllables_SDP={'d','b','g'};
frequency_range_SDP ={[1800 2800], [2800 3950],[1000 2000]}; % for findwnote
pc_window_SDP =[0.08,0.07,0.08]; % size of syl data window (in sec); (how much data to get for each rend (relative to onset), in sec)
pc_time_window ={[375 525],[60 220],[55 320]}; %for pitch contour (time bins to avg).


SeqPreList_SDP={'bb'}; % format: 1st elem of all three lists should combine
SylTargList_SDP={'b'}; % these must already have raw data compiled above
SeqPostList_SDP={''};

WithinParams={'batchSDP',batchSDP,'syllables_SDP',syllables_SDP,'frequency_range_SDP',frequency_range_SDP,'pc_window_SDP',pc_window_SDP,...
    'pc_time_window',pc_time_window,'SeqPreList_SDP',SeqPreList_SDP,'SylTargList_SDP',SylTargList_SDP,'SeqPostList_SDP',SeqPostList_SDP};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);


% TO DO BASELINE (i.e. not just catch songs)
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

% %% (OPTIONAL) - TO FILTER OUT SEQUENCES IN (SINGLE SYL) DATA THAT HAVE ALREADY BEEN STORED INTO STRUCTURES
% % Run in the folder containing the data structures (e.g. % Run in folder: 
% % e.g.
% % /bluejay3/lucas/birds/pu11wh87/compile_seq_dep_pitch_data_SeqDepPitchShift,
% % containing structures:
% % e.g. DataStruct_02Nov2014);
% 
% all_days=1;
% FirstDay='';
% LastDay='';
% SeqPreList={'a','ab','c','cb','bcc','bccb','dcc','dccb','b','bc','d','dc'}; % format: 1st elem of all three lists should combine
% SylTargList={'b','b','b','b','b','b','b','b','c','c','c','c'}; % these must already have raw data compiled above
% SeqPostList={'','','','','','','','','','','',''};
% 
% lt_compile_seq_dep_pitch_data_SEQFILTER_MULTDAYS(all_days,FirstDay,LastDay,SeqPreList,SylTargList,SeqPostList)
% 
% 
% %% COMPILE ALL DAYS - in SEQFILTER folder
% 
% lt_compile_seq_dep_pitch_data_LOADSAVEFILES(1);
% 
% %% PLOT - (ONCE HAVE COMPILED DIR AND UNDIR INTO SINGLE STRUCTURES)
% clear all; close all;
% 
% plotDIR=0;
% DirFilename='';
% UndirFilename='/bluejay3/lucas/birds/pu11wh87/compile_seq_dep_pitch_data_SeqDepPitchShift2/SEQFILTER/AllDays_Compiled/AllDays_Compiled_18Nov2014_to_30Nov2014';
% 
% % FieldsToPlot{2}={'aB','cB','abB','cbB'};
% % FieldsToPlot{3}={'bC','bcC','dC','dcC'};
% % FieldsToPlot{3}={'a','aB','cB'};
% 
% SylLists.FieldsToPlot{1}={'aB','abB','bccB','bccbB','dccB','dccbB'};
% SylLists.FieldsToPlot{2}={'bC','bcC','dC','dcC'};
% 
% SylLists.FieldsInOrder{1}={'a','aB','abB','bC','bcC','bccB','bccbB'};
% SylLists.FieldsInOrder{2}={'dC','dcC','dccB','dccbB'};
% 
% SylLists.TargetSyls={'dccB'};
% 
% SylLists.SylsSame={'aB','abB','bccB','bccbB','dccbB'};
% SylLists.SylsDifferent={'a','bC','bcC','dC','dcC'};
% 
% BaselineDays=1:4;
% 
% plotWNdays=1; % 1 is on, 0 is off.
% WNTimeON='23Nov2014-0000'; % Time WN turned on
% WNTimeOFF= '30Nov2014-2400'; % Time WN turned off ( use 0000 and 2400 if only plotting days)
% 
% 
% lt_compile_seq_dep_pitch_data_PLOTDirUndir(DirFilename,UndirFilename,plotDIR,...
%     BaselineDays,plotWNdays,WNTimeON,WNTimeOFF,SylLists)


%% 2/17/15 - ANALYZE ACROSS DAYS - NEW METHOD - params good.

% TO DO OVER ALL DAYS
clear all; close all
phrase = 'RepDepPitchShift';
first_day= '02Dec2014';
last_day= '21Dec2014';
Params.DayRawDat.batch='batch.labeled.catch';

% BASELINE
% first_day= '27Nov2014';
% last_day= '01Dec2014';
% Params.DayRawDat.batch='batch.labeled.all';


% last_day= '01Dec2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.syllables={'d','b','g'};
Params.DayRawDat.frequency_range={[1500 3000], [3000 4000],[1000 1900]};
Params.DayRawDat.pc_dur=[0.12,0.11,0.25];

Params.DayRawDat.pc_time_window={[95 225],[63 210],[113 290]};
Params.DayRawDat.pc_sigma=1;


plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);


%% 2) Seq filter, remove outliers, and compile raw data, and enter experiment info into params

clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=3000;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

% Params.SeqFilter.SeqPreList={'j','jb','jbb'};
% Params.SeqFilter.SylTargList={'b','b','b'};
% Params.SeqFilter.SeqPostList={'','',''};
Params.SeqFilter.SeqPreList={}; 
Params.SeqFilter.SylTargList={};
Params.SeqFilter.SeqPostList={};

Params.SeqFilter.Repeats={'jB'};


% 2) experiment info
Params.SeqFilter.WNTimeON='02Dec2014-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '21Dec2014-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:5;

Params.SeqFilter.SylLists.FieldsToPlot{1}={'jB','jbB','jbbB','jbbbB','jbbbbB','jbbbbbB'};
Params.SeqFilter.SylLists.FieldsInOrder{1}={'jB','jbB','jbbB','jbbbB','jbbbbB','jbbbbbB'};
Params.SeqFilter.SylLists.TargetSyls={'jbbB'};
Params.SeqFilter.SylLists.SylsSame={'jB','jbB','jbbbB','jbbbbB','jbbbbbB'};
Params.SeqFilter.SylLists.SylsDifferent={};

% Params.SeqFilter.DaysForSnapshot{1}={};
Params.SeqFilter.DaysToMark= {'08Dec2014-1952','11Dec2014-2200','14Dec2014-1750'}; % will mark all plots with lines here;



% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);

%% 3) Perform various analyses on that data structure
Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=0;


% [Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);

% Use this for repeats
[Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearningREPEATS(Params, AllDays_RawDatStruct,saveON);


