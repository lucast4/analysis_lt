% 12/10/14
% SeqDepPitchShift

%% TO CHECK DAY

% % FOR TARGET DCCB
% clear all; close all;
% batchf='batch.labeled.catch';
% syl='b';
% syl_pre='dcc';
% syl_post='';
% syl_refract=0.2;
% freq_range=[2800 3800];
% evtaf_ver='v4';
% get_WN_hits=1;
% get_offline_match=1;
% get_FF=1;
% 
% 
% template_name='pu11wh87dccb_SeqDepPitchShift2_v1_6';
% cntrng_values{1}={[35 55 2.4] 'and' 'n' 'y'};
% cntrng_values{2}={[2 14 2.4] 'and' 'n' 'y'};
% cntrng_values{3}={[1 4 2.2] 'or' 'n' 'n'};
% cntrng_values{4}={[1 4 2.2] 'or' 'n' 'n'};
% cntrng_values{5}={[1 4 2.2] 'or' 'n' 'n'};
% cntrng_values{6}={[1 4 2.2] 'or' 'n' 'n'};
% col_logic='(a*b)*(c+d+e+f)';
% 
% check_stuff=lt_check_hit_templ_freq_FUNCTION(batchf, syl, syl_pre, syl_post, syl_refract, freq_range, ...
%     evtaf_ver,get_WN_hits,get_offline_match,get_FF,template_name,cntrng_values,col_logic);


%% TO CHECK TARGET - target = cbB


clear all; close all;
batchf='batch.labeled.all';
config='/bluejay3/lucas/birds/gr41gr90/config10.evconfig2';

syl='b';
syl_pre='cb';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim_forRachel(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

%% TO CHECK TARGET - target = b(2) not after c


clear all; close all;
batchf='batch.labeled.all';
config='/bluejay3/lucas/birds/gr41gr90/030115_SeqDepPitchShift_durWN_UpAndDn_day1/config.evconfig2';

syl='b';
syl_pre='b';
syl_post='a';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


%% TO CHECK - b1 (after c)


clear all; close all;
batchf='batch.labeled.all';
config='/bluejay3/lucas/birds/gr41gr90/041515_SeqDepPitchShift2_durWN_day1/config.evconfig2';

syl='b';
syl_pre='c';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

%% 2/9/15 - Seq dep pitch all days

clear all; close all
phrase = 'SeqDepPitchShift';
first_day= '11Feb2015';
last_day= '12Feb2015';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.all';
Params.DayRawDat.syllables={'a','b','c','d'};
Params.DayRawDat.frequency_range={[1200 2500], [2600 4200],[2000 3000], [700 2200]};
Params.DayRawDat.pc_dur=[0.12,0.11,0.13,0.105];

Params.DayRawDat.pc_time_window={[300 500],[37 140],[65 460],[250 335]};
% change last one to [255 340]
Params.DayRawDat.pc_sigma=1;


plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);


%% Seq filter, remove outliers, and compile raw data, and enter experiment info into params
cd seq_dep_pitch_SeqDepPitchShift
clear all; close all; 
% 0) keep?
Params.SeqFilter.AmplThr=10000;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

% Params.SeqFilter.SeqPreList={'g','gb','gbb','gbba','gbbac','gbbacb','d','db','dbb','dbba','dbbac','dbbacb','j','jb','jbb','jbba','jbbac','jbbacb'};
% Params.SeqFilter.SylTargList={'b','b','a','c','b','b','b','b','a','c','b','b','b','b','a','c','b','b'};
% Params.SeqFilter.SeqPostList={'','','','','','','','','','','','','','','','','',''};
Params.SeqFilter.SeqPreList={'','b','','','c','cb'};
Params.SeqFilter.SylTargList={'b','b','a','c','b','b'};
Params.SeqFilter.SeqPostList={'ba','a','','','',''};


% 2) experiment info
Params.SeqFilter.WNTimeON='13Feb2015'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '07Mar2015'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:6;

Params.SeqFilter.SylLists.FieldsToPlot{1}={'Bba','bBa','a','c','cB','cbB'};
Params.SeqFilter.SylLists.FieldsInOrder{1}={'Bba','bBa','a','c','cB','cbB'};
Params.SeqFilter.SylLists.TargetSyls={'cbB'};
Params.SeqFilter.SylLists.SylsSame={'Bba','bBa','cB'};
Params.SeqFilter.SylLists.SylsDifferent={'a','c'};

Params.SeqFilter.DaysForSnapshot{1}={'22Feb2015','24Feb2015'}; % end of targ 1
Params.SeqFilter.DaysForSnapshot{2}={'26Feb2015','28Feb2015'}; % end of targ 1 drive up more

Params.SeqFilter.DaysToMark= {'24Feb2015-2400','28Feb2015-2400' }; % will mark all plots with lines here;



% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);

%% 3) Perform various analyses on that data structure
close all;
Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;


[Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);



%% 3) Extract structure statistics


% to extract data
[Params, AllDays_StructStatsStruct]=lt_seq_dep_pitch_StructureStats(Params, AllDays_RawDatStruct);

% to process data
[Params, AllDays_StructStatsStruct]=lt_seq_dep_pitch_StructureStats_SylSimilarity(Params, AllDays_StructStatsStruct);


% to plot and perform PCA on syl structure
Params.PCA.epoch='baseline'; % will look at baseline
% Params.PCA.epoch=[21 24]; % days 21 to 24

[Params, PCA_Struct]=lt_seq_dep_pitch_StructureStats_featurePCA(Params, AllDays_StructStatsStruct,1)


