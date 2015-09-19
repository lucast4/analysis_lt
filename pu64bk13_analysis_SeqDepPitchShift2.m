%% 2/12/15 - Target: d[b] DN

%% 2/12/15 - to check template

% TARGET: b(1)
clear all; close all;
batchf='batch.labeled.all';
% config='/bluejay3/lucas/birds/pu64bk13/config_b1.evconfig2';
config='/bluejay3/lucas/birds/pu64bk13/config_newtempl_021615.evconfig2';


syl='b';
syl_pre='d';
syl_post='';
get_WN_hits=0;
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

%% TO TARGET 2nd templ

clear all; close all;
batchf='batch.labeled.all';
% config='/bluejay3/lucas/birds/pu64bk13/config_b1.evconfig2';
config='/bluejay3/lucas/birds/pu64bk13/config_2templ.evconfig2';


syl='b';
syl_pre='db';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=1;


check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


%% ANALYSIS
% NOTE: modified 9/18 to also analyze "d"

clear all; close all
phrase = 'SeqDepPitchShift2';
first_day= '06Mar2015';
last_day= '06Mar2015';
Params.DayRawDat.batch='batch.labeled.catch';
save_results=1;


% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;

Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.syllables={'b','d'};
Params.DayRawDat.frequency_range={[2800 4000], [500 1800]};
Params.DayRawDat.pc_dur=[0.12, 0.115];
Params.DayRawDat.pc_time_window={[34 115], [300 390]};
Params.DayRawDat.pc_sigma=1;


% old: before 9/18/15
% Params.DayRawDat.syllables={'b'};
% Params.DayRawDat.frequency_range={[2900 4000]};
% Params.DayRawDat.pc_dur=[0.09];
% Params.DayRawDat.pc_time_window={[42 130]};
% Params.DayRawDat.pc_sigma=1.5;


plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);



%% 2) Seq filter, remove outliers, and compile raw data, and enter experiment info into params (NEW, consolidating jbbb and dbbb)
cd seq_dep_pitch_SeqDepPitchShift2/
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
Params.SeqFilter.WNTimeON='13Feb2015'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '07Mar2015'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:5;

% Params.SeqFilter.SylLists.FieldsToPlot{1}={'d','dB','dbB','dbbB'};
Params.SeqFilter.SylLists.FieldsInOrder{1}={'d','dB','dbB','dbbB'};

Params.SeqFilter.SylLists.TargetSyls={'dB'};

Params.SeqFilter.SylLists.SylsSame={'dbB','dbbB'};
Params.SeqFilter.SylLists.SylsDifferent={'d'};

Params.SeqFilter.DaysForSnapshot{1}={'22Feb2015','24Feb2015'};
Params.SeqFilter.DaysToMark= {'23Feb2015-1200','24Feb2015-2400', '28Feb2015-2400'}; % evtaf crash, Wn changes (drive more and bidir)

% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);


%% 3) Perform various analyses on that data structure
close all;
Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;


[Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);



%% 2) Seq filter, remove outliers, and compile raw data, and enter experiment info into params 
%% (OLD, plotting both jbbb and dbbb)
% 
% clear all; close all;
% 
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
% Params.SeqFilter.WNTimeON='13Feb2015'; % Time WN turned on (1st WN day)
% Params.SeqFilter.WNTimeOFF= '07Mar2015'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
% Params.SeqFilter.BaselineDays=1:3;
% 
% Params.SeqFilter.SylLists.FieldsToPlot{1}={'jB','jbB','jbbB','dB','dbB','dbbB'};
% 
% Params.SeqFilter.SylLists.FieldsInOrder{1}={'jB','jbB','jbbB'};
% Params.SeqFilter.SylLists.FieldsInOrder{2}={'dB','dbB','dbbB'};
% 
% Params.SeqFilter.SylLists.TargetSyls={'dB'};
% 
% Params.SeqFilter.SylLists.SylsSame={'jB','jbB','jbbB','dbB','dbbB'};
% % Params.SeqFilter.SylLists.SylsDifferent={};
% 
% Params.SeqFilter.DaysForSnapshot{1}={'22Feb2015','24Feb2015'};
% Params.SeqFilter.DaysToMark= {'23Feb2015-1200','24Feb2015-2400', '28Feb2015-2400'}; % evtaf crash, Wn changes (drive more and bidir)
% 
% % 3) RUN
% plotON=0;
% [Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);
% 



%% 3) Extract structure statistics


% to extract data
[Params, AllDays_StructStatsStruct]=lt_seq_dep_pitch_StructureStats(Params, AllDays_RawDatStruct);

% to process data
[Params, AllDays_StructStatsStruct]=lt_seq_dep_pitch_StructureStats_SylSimilarity(Params, AllDays_StructStatsStruct);


% to plot and perform PCA on syl structure
% Params.PCA.epoch='baseline'; % will look at baseline
Params.PCA.epoch=[1]; % days 21 to 24

[Params, PCA_Struct]=lt_seq_dep_pitch_StructureStats_featurePCA(Params, AllDays_StructStatsStruct,1)
