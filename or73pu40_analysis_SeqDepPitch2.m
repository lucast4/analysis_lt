%% CHECK TEMPLATE
clear all; close all;
% ==================== b2
batchf='batch.labeled.all';
% config='/bluejay4/lucas/birds/or73pu40/060615_SeqDepPitch_durWN_day1/config.evconfig2';
% config='/bluejay4/lucas/birds/or73pu40/config_062615.evconfig2';
% config='/bluejay4/lucas/birds/or73pu40/config_062615_2.evconfig2';
% config='/bluejay4/lucas/birds/or73pu40/062715_SeqDepPitch2_durWN_day1/config.evconfig2';
% config='/bluejay4/lucas/birds/or73pu40/config_070815.evconfig2'; % for targeting b2, b3, b4
config='/bluejay4/lucas/birds/or73pu40/070915_SeqDepPitch2_ThreeTargs_day1/config.evconfig2';



get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'cb';
syl_post = '';
NoteNum = 0; 

lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum)


% =============================== b3
batchf='batch.labeled.all';
config='/bluejay4/lucas/birds/or73pu40/070915_SeqDepPitch2_ThreeTargs_day1/config.evconfig2';



get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'cbb';
syl_post = '';
NoteNum = 1; 

lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum)


% =================================== b4
batchf='batch.labeled.all';
config='/bluejay4/lucas/birds/or73pu40/070915_SeqDepPitch2_ThreeTargs_day1/config.evconfig2';


get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'cbbb';
syl_post = '';
NoteNum = 2; 

lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum)


%% CHECK TEMPLATE, NO LABELING REQUIRED

% === b2
Params.batch='batch.rand.keep';
% Params.config='/bluejay4/lucas/birds/or73pu40/060615_SeqDepPitch_durWN_day1/config.evconfig2'; 
Params.config='/bluejay4/lucas/birds/or73pu40/070915_SeqDepPitch2_ThreeTargs_day1/config.evconfig2';

Params.NoteNum_to_plot=0; % for the note you want to analyze

lt_check_hit_templ_freq_NoLabelRequired(Params)


% === b3
Params.batch='batch.rand.keep';
% Params.config='/bluejay4/lucas/birds/or73pu40/060615_SeqDepPitch_durWN_day1/config.evconfig2'; 
Params.config='/bluejay4/lucas/birds/or73pu40/070915_SeqDepPitch2_ThreeTargs_day1/config.evconfig2';

Params.NoteNum_to_plot=1; % for the note you want to analyze

lt_check_hit_templ_freq_NoLabelRequired(Params)


% === b4
Params.batch='batch.rand.keep';
% Params.config='/bluejay4/lucas/birds/or73pu40/060615_SeqDepPitch_durWN_day1/config.evconfig2'; 
Params.config='/bluejay4/lucas/birds/or73pu40/070915_SeqDepPitch2_ThreeTargs_day1/config.evconfig2';

Params.NoteNum_to_plot=2; % for the note you want to analyze

lt_check_hit_templ_freq_NoLabelRequired(Params)

%% ==================================================================
%% ACROSS DAYS ==================================================================
% -- BASELINE
clear all; close all
phrase = 'SeqDepPitch2';
first_day= '25Jun2015';
last_day= '26Jun2015';
% first_day= '19Nov2014';
% last_day= '22Nov2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.all';
Params.DayRawDat.syllables={'a','b','c','g'};
Params.DayRawDat.frequency_range={[1300 2500], [2800 3950], [1000 1750], [1200 1900]};
Params.DayRawDat.pc_dur=[0.11, 0.11, 0.125, 0.285];

Params.DayRawDat.pc_time_window={[155 315],[85 245],[150 415],[455 1175]};
Params.DayRawDat.pc_sigma=1;


plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);

% ==== DURING WN (catch)
phrase = 'SeqDepPitch2';
first_day= '27Jun2015';
last_day= '30Jun2015';
% first_day= '19Nov2014';
% last_day= '22Nov2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.catch';
Params.DayRawDat.syllables={'a','b','c','g'};
Params.DayRawDat.frequency_range={[1300 2500], [2800 3950], [1000 1750], [1200 1900]};
Params.DayRawDat.pc_dur=[0.11, 0.11, 0.125, 0.285];

Params.DayRawDat.pc_time_window={[155 315],[85 245],[150 415],[455 1175]};
Params.DayRawDat.pc_sigma=1;

plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);



%% COMPILE
%% 2) Seq filter, remove outliers, and compile raw data, and enter experiment info into params
cd seq_dep_pitch_SeqDepPitch2
clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=5000;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

Params.SeqFilter.SeqPreList={}; % To skip seq filter, keep blank. (i.e. {})
Params.SeqFilter.SylTargList={};
Params.SeqFilter.SeqPostList={};

% repeats?
Params.SeqFilter.Repeats={'acB'}; % to skip repeat filter, don't even define the field "repeats"

% 2) experiment info
Params.SeqFilter.WNTimeON='27Jun2015-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '17Jul2015-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:3;

Params.SeqFilter.SylLists.TargetSyls={'acbB'};

Params.SeqFilter.SylLists.FieldsInOrder{1}={'a', 'acB','acbB','acbbB','acbbbB','acbbbbB','acbbbbbB','acbbbbbbB','acbbbbbbbB','acbbbbbbbbB','acbbbbbbbbbB','acbbbbbbbbbbB','g'}; % up to 11
Params.SeqFilter.SylLists.SylsSame={'acB','acbbB','acbbbB','acbbbbB','acbbbbbB','acbbbbbbB','acbbbbbbbB','acbbbbbbbbB','acbbbbbbbbbB','acbbbbbbbbbbB'};
Params.SeqFilter.SylLists.SylsDifferent={'a', 'c', 'g'};
 
% Params.SeqFilter.DaysForSnapshot{1}={'09Dec2014','11Dec2014'};
Params.SeqFilter.DaysToMark= {'08Jul2015-2400'}; % will mark all plots with lines here;

% Params.SeqFilter.SylLists.FieldsToPlot{1}=[Params.SeqFilter.SylLists.TargetSyls Params.SeqFilter.SylLists.SylsSame];
% Params.SeqFilter.SylLists.FieldsToPlot{2}=Params.SeqFilter.SylLists.SylsDifferent;

% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);



%% 3) Perform various analyses on that data structure
close all;
Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;


[Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);

% Use this for repeats
% [Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearningREPEATS(Params, AllDays_RawDatStruct,saveON);

%% ========================== Use regular expressions to sort data from Raw data
% Run on raw data

Params.RegExpr.expressions={'acb+'};
[Params, AllDays_RegExpr] = lt_seq_dep_pitch_RegExpr(Params, AllDays_RawDatStruct);


% ========================== PLOT REG EXPR DATA
Params.PlotRegExpr.plotWNdays=1;
saveON=1;
[Params, AllDays_RegExpr]=lt_seq_dep_pitch_PlotRegExpr(Params, AllDays_RegExpr, saveON);


