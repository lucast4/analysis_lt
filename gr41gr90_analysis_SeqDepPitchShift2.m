%% TO CHECK - b1 (after c)


clear all; close all;
batchf='batch.labeled.all';
% config='/bluejay3/lucas/birds/gr41gr90/041515_SeqDepPitchShift2_durWN_day1/config.evconfig2'; 
config='/bluejay3/lucas/birds/gr41gr90/042315_SeqDepPitchShift2_durWN_day9/c.evconfig2'; % post 4/23 (start of day)
syl='b';
syl_pre='c';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);



%% TO CHECK - Four Targets
%     Motif: bbacbb (gives me b1 to b4)
%     Note 0 = b3 UP (unchanged)
%     Note 1 = b1 DN (gr41gr90bB_v1_10)
%     Note 2 = b2 UP (gr41gr90bB_v1_10)
%     Note 3 = b4 DN 

% === USING UIEVTAFSIM
batch='batch.rand.keep';
config='/bluejay3/lucas/birds/gr41gr90/051015_SeqDepPitchShift2_FourTargets_day0/config.evconfig2';

uievtafsim(batch,config);


% ==== USING evtafsim
batchf='batch.labeled.all';
config='/bluejay3/lucas/birds/gr41gr90/051115_SeqDepPitchShift2_FourTargets_day1/config.evconfig2';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;


% Note 0
syl='b';
syl_pre='c';
syl_post='';
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% Note 1
syl='b';
syl_pre='';
syl_post='ba';
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% Note 2
syl='b';
syl_pre='b';
syl_post='a';
NoteNum=2;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% Note 3
syl='b';
syl_pre='cb';
syl_post='';
NoteNum=3;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


%% 2/9/15 - Seq dep pitch all days 

clear all; close all
phrase = 'SeqDepPitchShift2';
first_day= '06May2015';
last_day= '25May2015';
Params.DayRawDat.batch='batch.labeled.catch';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
% OLD
% Params.DayRawDat.syllables={'a','b','c','d'};
% Params.DayRawDat.frequency_range={[1200 2500], [2600 4200],[2000 3000], [700 2200]};
% Params.DayRawDat.pc_dur=[0.12,0.11,0.13,0.105];
% Params.DayRawDat.pc_time_window={[300 500],[37 140],[65 460],[250 330]};
% change last one to [255 340]
Params.DayRawDat.syllables={'a','b','c','d', 'j', 'g'};
Params.DayRawDat.frequency_range={[1200 2500], [2600 4200],[2000 3000], [700 2200], [3600 4400], [700 1000]};
Params.DayRawDat.pc_dur=[0.125,0.115,0.135,0.11, 0.12, 0.12];
Params.DayRawDat.pc_time_window={[300 500],[37 140],[65 460],[250 330], [70 250], [50 150]};
Params.DayRawDat.pc_sigma=1;


plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);

%% Seq filter, remove outliers, and compile raw data, and enter experiment info into params [NEW, just jbbacbb]
cd seq_dep_pitch_SeqDepPitchShift2
clear all; 
% 0) keep?
Params.SeqFilter.AmplThr=10000;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

% Params.SeqFilter.SeqPreList={'','b','c','cb'};
% Params.SeqFilter.SylTargList={'b','b','b','b'};
% Params.SeqFilter.SeqPostList={'ba','a','',''};
Params.SeqFilter.SeqPreList={'','j','jb', 'jbb', 'jbba', 'jbbac','jbbacb'};
Params.SeqFilter.SylTargList={'j','b','b', 'a', 'c','b','b'};
Params.SeqFilter.SeqPostList={'bba','ba','a','','', '', ''};


% 2) experiment info
Params.SeqFilter.WNTimeON='15Apr2015-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '25May2015-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:6;

Params.SeqFilter.SylLists.FieldsInOrder{1}={'Jbba', 'jBba','jbBa','jbbA', 'jbbaC','jbbacB','jbbacbB'};
Params.SeqFilter.SylLists.FieldsInOrder{2}={'d'};

Params.SeqFilter.SylLists.TargetSyls={'jbbacB'};
Params.SeqFilter.SylLists.SylsSame={'jBba','jbBa','jbbacbB'};
Params.SeqFilter.SylLists.SylsDifferent={'Jbba','jbbA', 'jbbaC','d'};

Params.SeqFilter.DaysForSnapshot{1}={'27Apr2015','29Apr2015'}; % end of targ 1

Params.SeqFilter.DaysToMark= {'19Apr2015-0000','21Apr2015-2400','30Apr2015-0000', '10May2015-2400', '19May2015-2400'}; % will mark all plots with lines here;


% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);

%% Seq filter, remove outliers, and compile raw data, and enter experiment info into params [OLD - combining all motifs]
% 
% cd seq_dep_pitch_SeqDepPitchShift2
% clear all; 
% % 0) keep?
% Params.SeqFilter.AmplThr=10000;
% 
% % 1) Seq filter and remove outliers and compile into one struct
% Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
% Params.SeqFilter.FirstDay='';
% Params.SeqFilter.LastDay='';
% 
% % Params.SeqFilter.SeqPreList={'g','gb','gbb','gbba','gbbac','gbbacb','d','db','dbb','dbba','dbbac','dbbacb','j','jb','jbb','jbba','jbbac','jbbacb'};
% % Params.SeqFilter.SylTargList={'b','b','a','c','b','b','b','b','a','c','b','b','b','b','a','c','b','b'};
% % Params.SeqFilter.SeqPostList={'','','','','','','','','','','','','','','','','',''};
% Params.SeqFilter.SeqPreList={'','b','c','cb'};
% Params.SeqFilter.SylTargList={'b','b','b','b'};
% Params.SeqFilter.SeqPostList={'ba','a','',''};
% 
% 
% % 2) experiment info
% Params.SeqFilter.WNTimeON='15Apr2015-0000'; % Time WN turned on (1st WN day)
% Params.SeqFilter.WNTimeOFF= '25May2015-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
% Params.SeqFilter.BaselineDays=1:6;
% 
% Params.SeqFilter.SylLists.FieldsInOrder{1}={'Bba','bBa','a','c','cB','cbB'};
% % Params.SeqFilter.SylLists.FieldsInOrder{2}={'jBb-','jbB-'};
% 
% Params.SeqFilter.SylLists.FieldsToPlot=Params.SeqFilter.SylLists.FieldsInOrder;
% 
% Params.SeqFilter.SylLists.TargetSyls={'cB'};
% Params.SeqFilter.SylLists.SylsSame={'Bba','bBa','cbB'};
% Params.SeqFilter.SylLists.SylsDifferent={'a','c','d'};
% 
% Params.SeqFilter.DaysForSnapshot{1}={'27Apr2015','29Apr2015'}; % end of targ 1
% 
% Params.SeqFilter.DaysToMark= {'19Apr2015-0000','21Apr2015-2400','30Apr2015-0000', '10May2015-2400', '19May2015-2400'}; % will mark all plots with lines here;
% 
% 
% % 3) RUN
% plotON=0;
% [Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);

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

[Params, PCA_Struct]=lt_seq_dep_pitch_StructureStats_featurePCA(Params, AllDays_StructStatsStruct,1);



%% ========================== Use regular expressions to sort data from Raw data
% Params.RegExpr.expressions={'bb[^a]', 'bbacbb'}; % have not coded yet for sequences that don't actually have extracted data.
Params.RegExpr.expressions={'bbacbb'};
DoLMAN=0;
saveON=1;
[Params, AllDays_RegExpr] = lt_seq_dep_pitch_RegExpr(Params, AllDays_RawDatStruct, saveON, DoLMAN);


% ========================== PLOT REG EXPR DATA
Params.PlotRegExpr.plotWNdays=1;
saveON=1;
LMANon=0;
[Params, AllDays_RegExpr]=lt_seq_dep_pitch_PlotRegExpr(Params, AllDays_RegExpr ,saveON);
