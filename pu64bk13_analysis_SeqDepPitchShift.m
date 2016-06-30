%% -----------------------------------------------
%% -----------------------------------------------
%% 1/6/15 - compile and analyze data in new way [USE THIS]
% NOTE: Modified 9/16 to also extract "d"

% EXTRACT DATA
clear all; close all
phrase = 'SeqDepPitchShift';
first_day= '14Dec2014';
last_day= '28Dec2014';
Params.DayRawDat.batch='batch.labeled.catch';

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.syllables={'b','d'};
Params.DayRawDat.frequency_range={[2900 4000], [800 2250]};
Params.DayRawDat.pc_dur=[0.12, 0.11];

Params.DayRawDat.pc_time_window={[45 125], [247 308]};
Params.DayRawDat.pc_sigma=1;


plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};
save_results=0;
[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);




%% SEQ FILTER (new, only looking at dbbb) - modified 9/16 to also include d
clear all; close all;
% 0) keep?
Params.SeqFilter.AmplThr=4500;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

Params.SeqFilter.SeqPreList={'d','db','dbb'};
Params.SeqFilter.SylTargList={'b','b','b'};
Params.SeqFilter.SeqPostList={'','',''};


% 2) experiment info
Params.SeqFilter.WNTimeON='14Dec2014-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '28Dec2014-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:4;

Params.SeqFilter.SylLists.FieldsToPlot{1}={'d','dB','dbB','dbbB'};
Params.SeqFilter.SylLists.FieldsInOrder{1}={'d','dB','dbB','dbbB'};

Params.SeqFilter.SylLists.TargetSyls={'dbB'};

Params.SeqFilter.SylLists.SylsSame={'dB','dbB','dbbB'};
Params.SeqFilter.SylLists.SylsDifferent={'d'};

Params.SeqFilter.DaysForSnapshot{1}={'19Dec2014','21Dec2014'};
Params.SeqFilter.DaysToMark= {'21Dec2014-2400'}; % will mark all plots with lines here;


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
DaysWanted=40:41; % either baseline (astring) or array
lt_seq_dep_pitch_Correlations(Params, AllDays_StructStatsStruct,DaysWanted);



% SEQ FILTER (OLD, using both jbbb and dbbb.)
% % 0) keep?
% Params.SeqFilter.AmplThr=4500;
% 
% % 1) Seq filter and remove outliers and compile into one struct
% Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
% Params.SeqFilter.FirstDay='';
% Params.SeqFilter.LastDay='';
% 
% Params.SeqFilter.SeqPreList={'j','jb','jbb','d','db','dbb'};
% Params.SeqFilter.SylTargList={'b','b','b','b','b','b'};
% Params.SeqFilter.SeqPostList={'','','','','',''};
% 
% 
% % 2) experiment info
% Params.SeqFilter.WNTimeON='14Dec2014-0000'; % Time WN turned on (1st WN day)
% Params.SeqFilter.WNTimeOFF= '28Dec2014-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
% Params.SeqFilter.BaselineDays=1:4;
% 
% Params.SeqFilter.SylLists.FieldsToPlot{1}={'jB','jbB','jbbB','dB','dbB','dbbB'};
% 
% Params.SeqFilter.SylLists.FieldsInOrder{1}={'jB','jbB','jbbB'};
% Params.SeqFilter.SylLists.FieldsInOrder{2}={'dB','dbB','dbbB'};
% 
% Params.SeqFilter.SylLists.TargetSyls={'dbB'};
% 
% Params.SeqFilter.SylLists.SylsSame={'jB','jbB','jbbB','dB','dbB','dbbB'};
% Params.SeqFilter.SylLists.SylsDifferent={};
% 
% Params.SeqFilter.DaysForSnapshot{1}={'19Dec2014','21Dec2014'};
% Params.SeqFilter.DaysToMark= {'21Dec2014-2400'}; % will mark all plots with lines here;
% 
% 
% % 3) RUN
% plotON=0;
% [Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);




%% ++++++++++++[ OLD WAY]  12/13/14 - to check template

% TARGET: b(2)
clear all; close all;
batchf='batch.labeled.catch';
config='/bluejay3/lucas/birds/pu64bk13/122214_SeqDepPitchShift_UpAndDn_durWN_day9/config_122214_fixed.evconfig2';

syl='b';
syl_pre='dbb';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;


check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


% TARGET (any b);
% NOTE - DIFFICULT SOMETIMES TO GET JBBB BECAUSE TEMPL CAN GET 1ST SYL AND
% THEN WILL GET ERROR, SINCE NO PRE SYL.

clear all; close all;
batchf='batch.labeled.all';
config='/bluejay3/lucas/birds/pu64bk13/config_b3.evconfig2';

syl='b';
syl_pre='jbb';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

%% 1/5/15 - ACROSS ALL DAYS

% BASELINE - not just catch
clear all; close all
phrase = 'SeqDepPitchShift';
first_day= '11Dec2014';
last_day= '11Dec2014';
% last_day= '30Nov2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch'};

% Parameters
batchSDP='batch.labeled.all';
syllables_SDP={'b'};
frequency_range_SDP ={[2900 4000]}; % for findwnote
pc_window_SDP =[0.055]; % size of syl data window (in sec); (how much data to get for each rend (relative to onset), in sec)
pc_time_window ={[42 130]}; %for pitch contour (time bins to avg).


SeqPreList_SDP={'j','jb','jbb','d','db','dbb'}; % format: 1st elem of all three lists should combine
SylTargList_SDP={'b','b','b','b','b','b'}; % these must already have raw data compiled above
SeqPostList_SDP={'','','','','',''};

WithinParams={'batchSDP',batchSDP,'syllables_SDP',syllables_SDP,'frequency_range_SDP',frequency_range_SDP,'pc_window_SDP',pc_window_SDP,...
    'pc_time_window',pc_time_window,'SeqPreList_SDP',SeqPreList_SDP,'SylTargList_SDP',SylTargList_SDP,'SeqPostList_SDP',SeqPostList_SDP};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION_pu64bk13(phrase,first_day,last_day,FcnAll,WithinParams,save_results);


% DURING WN
clear all; close all
phrase = 'SeqDepPitchShift';
first_day= '15Dec2014';
last_day= '15Dec2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch'};

% Parameters
batchSDP='batch.labeled.catch';
syllables_SDP={'b'};
frequency_range_SDP ={[2900 4000]}; % for findwnote
pc_window_SDP =[0.055]; % size of syl data window (in sec); (how much data to get for each rend (relative to onset), in sec)
pc_time_window ={[42 130]}; %for pitch contour (time bins to avg).


SeqPreList_SDP={'j','jb','jbb','d','db','dbb'}; % format: 1st elem of all three lists should combine
SylTargList_SDP={'b','b','b','b','b','b'}; % these must already have raw data compiled above
SeqPostList_SDP={'','','','','',''};

WithinParams={'batchSDP',batchSDP,'syllables_SDP',syllables_SDP,'frequency_range_SDP',frequency_range_SDP,'pc_window_SDP',pc_window_SDP,...
    'pc_time_window',pc_time_window,'SeqPreList_SDP',SeqPreList_SDP,'SylTargList_SDP',SylTargList_SDP,'SeqPostList_SDP',SeqPostList_SDP};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION_pu64bk13(phrase,first_day,last_day,FcnAll,WithinParams,save_results);




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
%% COMPILE ALL DAYS - in SEQFILTER folder

lt_compile_seq_dep_pitch_data_LOADSAVEFILES(1);

%% PLOT - (ONCE HAVE COMPILED DIR AND UNDIR INTO SINGLE STRUCTURES)
clear all; close all;

plotDIR=0;
DirFilename='';
UndirFilename='/bluejay3/lucas/birds/pu64bk13/compile_seq_dep_pitch_data_SeqDepPitchShift/SEQFILTER/AllDays_Compiled/AllDays_Compiled_10Dec2014_to_28Dec2014';

SylLists.FieldsToPlot{1}={'jB','jbB','jbbB','dB','dbB','dbbB'};

SylLists.FieldsInOrder{1}={'jB','jbB','jbbB'};
SylLists.FieldsInOrder{2}={'dB','dbB','dbbB'};

SylLists.TargetSyls={'dbB'};

BaselineDays=1:4;

plotWNdays=1; % 1 is on, 0 is off.
WNTimeON='14Dec2014-0000'; % Time WN turned on
WNTimeOFF= '28Dec2014-2400'; % Time WN turned off ( use 0000 and 2400 if only plotting days)

DaysForSnapshot{1}={'19Dec2014','21Dec2014'};

SylLists.SylsSame={'jB','jbB','jbbB','dB','dbB','dbbB'};
SylLists.SylsDiff={};


lt_compile_seq_dep_pitch_data_PLOTDirUndir(DirFilename,UndirFilename,plotDIR,...
    BaselineDays,plotWNdays,WNTimeON,WNTimeOFF,SylLists,DaysForSnapshot)



