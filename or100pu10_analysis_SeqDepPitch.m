%% ANALYZING ACROSS DAYS - NEW REG EXPR METHOD FOR REPEATS (9/1/15)



%% 6/5 - checking template (b2)

% ============= USING TEMPLATE (OLD, NOT ACCURATE)
batchf='batch.labeled.all';
syl='b';
syl_pre='cb';
syl_post='';
syl_refract=0.008;
freq_range=[2800 3800];
evtaf_ver='v4';
get_WN_hits=0;
get_offline_match=1;
get_FF=1;


template_name='or100pu10b_all_v1_5';
cntrng_values{1}={[2 4 2] 'or' 'n' 'n'};
cntrng_values{2}={[2 4 2] 'or' 'n' 'n'};
cntrng_values{3}={[2 4 2] 'or' 'n' 'n'};
cntrng_values{4}={[2 4 2] 'or' 'n' 'n'};
cntrng_values{5}={[2 4 2] 'or' 'n' 'n'};
col_logic='(a+b+c+d+e)';

check_stuff=lt_check_hit_templ_freq_FUNCTION(batchf, syl, syl_pre, syl_post, syl_refract, freq_range, ...
    evtaf_ver,get_WN_hits,get_offline_match,get_FF,template_name,cntrng_values,col_logic);



% % ============== USING CONFIG FILE (all b)
% config='/bluejay4/lucas/birds/or100pu10/config_noC.evconfig2';
% batchf='batch.labeled.all';
% 
% get_WN_hits=0;
% get_offline_match=1; % do offline matching using template? (ADDX=1)
% get_FF=1; % Analyze FF using offline matching?
% syl = 'b';
% syl_pre = 'cb';
% syl_post = '';
% NoteNum = 0; 
% 
% 
% check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, ...
%     get_offline_match, get_FF, config, NoteNum);


% ============== USING CONFIG FILE (using NOT c) (USE THIS)
% config='/bluejay4/lucas/birds/or100pu10/060615_SeqDepPitch_durWN_day1/config.evconfig2'; % bad, 6/6 early, when getting cbb[b] becuase of template params problem
% config= '/bluejay4/lucas/birds/or100pu10/060615_SeqDepPitch_durWN_day1/config_correct.evconfig2'; % good, getting b2 started 6/6/ 2pm;
config='/bluejay4/lucas/birds/or100pu10/060715_SeqDepPitch_durWN_day2/config_newtempl.evconfig2'; % 6/7 and +, using v1_7 template
config='/bluejay4/lucas/birds/or100pu10/config_061115.evconfig2'; % 6/7 and +, using v1_7 template
batchf='batch.labeled.all';

get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'cb';
syl_post = '';
NoteNum = 0; 


check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, ...
    get_offline_match, get_FF, config, NoteNum);




% =====================
% 6/15/16 - Two Targets (here is b3)
config='/bluejay4/lucas/birds/or100pu10/061615_SeqDepPitch_durWN_TwoTargs_day/config.evconfig2';
config='/bluejay4/lucas/birds/or100pu10/config_061515_2.evconfig2';
batchf='batch.labeled.catch';

get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'cbb';
syl_post = '';
NoteNum = 1; 


check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, ...
    get_offline_match, get_FF, config, NoteNum);


%% 6/6 - CHECKING MATCHING, no labeling needed

Params.batch='batch.rand.keep';
% Params.config='/bluejay4/lucas/birds/or100pu10/060615_SeqDepPitch_durWN_day1/config_correct.evconfig2'; 
% Params.config='/bluejay4/lucas/birds/or100pu10/060715_SeqDepPitch_durWN_day2/config_newtempl.evconfig2'; % 6/7 and +, using v1_7 template
Params.config='/bluejay4/lucas/birds/or100pu10/config_061515_2.evconfig2';

Params.NoteNum_to_plot=0; % for target 1 (b2)
Params.NoteNum_to_plot=1; % for target 2 (b3)

lt_check_hit_templ_freq_NoLabelRequired(Params)



%% ==================================================================
%% ACROSS DAYS ==================================================================

%% TO DO OVER ALL DAYS
% -- BASELINE
clear all; close all
phrase = 'SeqDepPitch';
first_day= '03Jun2015';
last_day= '05Jun2015';
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
Params.DayRawDat.pc_dur=[0.105, 0.105, 0.12, 0.24];

Params.DayRawDat.pc_time_window={[140 350],[85 245],[175 455],[655 1190]};
Params.DayRawDat.pc_sigma=1;


plotON=1;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);

% ==== DURING WN (catch)
phrase = 'SeqDepPitch';
first_day= '08Jun2015';
last_day= '09Jun2015';
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
Params.DayRawDat.pc_dur=[0.105, 0.105, 0.12, 0.24];

Params.DayRawDat.pc_time_window={[140 350],[85 245],[175 455],[655 1190]};
Params.DayRawDat.pc_sigma=1;


plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);



%% COMPILE
%% 2) Seq filter, remove outliers, and compile raw data, and enter experiment info into params

clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=10000;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

Params.SeqFilter.SeqPreList={}; % To skip seq filter, keep blank. (i.e. {})
Params.SeqFilter.SylTargList={};
Params.SeqFilter.SeqPostList={};

% repeats?
Params.SeqFilter.Repeats={'acB'}; % to skip repeat filter, don't even define the field "repeats"

% Regular expressions
% Params.SeqFilter.RegExpr.expressions={'acb+g', 'acb+'}; 

% 2) experiment info
Params.SeqFilter.WNTimeON='06Jun2015-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '15Jun2015-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:3;

Params.SeqFilter.SylLists.TargetSyls={'acbB'};

Params.SeqFilter.SylLists.FieldsInOrder{1}={'a', 'c', 'acB','acbB','acbbB','acbbbB', 'acbbbbB', 'g'};
Params.SeqFilter.SylLists.SylsSame={'acB', 'acbbB','acbbbB', 'acbbbbB'};
Params.SeqFilter.SylLists.SylsDifferent={'a','c','g'};
 
Params.SeqFilter.DaysForSnapshot{1}={'13Jun2015','15Jun2015'};
Params.SeqFilter.DaysToMark= {'15Jun2015-2400'}; % will mark all plots with lines here;

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


%% ========================== Use regular expressions to sort data from Raw data

Params.RegExpr.expressions={'acb+g', 'acb+'};
[Params, AllDays_RegExpr] = lt_seq_dep_pitch_RegExpr(Params, AllDays_RawDatStruct);


% ========================== PLOT REG EXPR DATA
Params.PlotRegExpr.plotWNdays=1;
saveON=1;
[Params, AllDays_RegExpr]=lt_seq_dep_pitch_PlotRegExpr(Params, AllDays_RegExpr ,saveON);

