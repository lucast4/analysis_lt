%% 6/26 - checking template (b1)
% ============== USING CONFIG FILE (using NOT c) (USE THIS)
% config='/bluejay4/lucas/birds/or100pu10/config_062615.evconfig2'; % 6/7 and +, using v1_7 template
% config='/bluejay4/lucas/birds/or100pu10/config_062615b1.evconfig2'; % 6/7 and +, using v1_7 template
% config='/bluejay4/lucas/birds/or100pu10/062715_SeqDepPitch2_durWN_day1/config.evconfig2';
% config='/bluejay4/lucas/birds/or100pu10/config_062715.evconfig2'; % 6/27, new template
config='/bluejay4/lucas/birds/or100pu10/config_063015_2.evconfig2'; % 6/27, new template

batchf='batch.labeled.all';

get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'c';
syl_post = '';
NoteNum = 0; 


check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, ...
    get_offline_match, get_FF, config, NoteNum);


%% 6/6 - CHECKING MATCHING, no labeling needed

Params.batch='batch.rand.keep';
% Params.config='/bluejay4/lucas/birds/or100pu10/060615_SeqDepPitch_durWN_day1/config_correct.evconfig2'; 
% Params.config='/bluejay4/lucas/birds/or100pu10/060715_SeqDepPitch_durWN_day2/config_newtempl.evconfig2'; % 6/7 and +, using v1_7 template
% Params.config='/bluejay4/lucas/birds/or100pu10/config_061515_2.evconfig2';
Params.config='/bluejay4/lucas/birds/or100pu10/config_062715.evconfig2'; % 6/27, new template

Params.NoteNum_to_plot=0; % for target 1 (b2)
% Params.NoteNum_to_plot=1; % for target 2 (b3)

lt_check_hit_templ_freq_NoLabelRequired(Params)




%% ==================================================================
%% ACROSS DAYS ==================================================================

%% TO DO OVER ALL DAYS
% -- 
clear all; close all
phrase = 'SeqDepPitch2';
first_day= '27Jun2015';
last_day= '02Jul2015';
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
cd seq_dep_pitch_SeqDepPitch2/
clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=10500;

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
Params.SeqFilter.WNTimeON='27Jun2015-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '02Jul2015-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:3;

Params.SeqFilter.SylLists.TargetSyls={'acB'};

Params.SeqFilter.SylLists.FieldsInOrder{1}={'a', 'acB','acbB','acbbB','acbbbB'};
Params.SeqFilter.SylLists.SylsSame={'acbB', 'acbbB','acbbbB'};
Params.SeqFilter.SylLists.SylsDifferent={'a', 'g'};
 
% Params.SeqFilter.DaysForSnapshot{1}={'09Dec2014','11Dec2014'};
% Params.SeqFilter.DaysToMark= {'11Dec2014-2400'}; % will mark all plots with lines here;

% Params.SeqFilter.SylLists.FieldsToPlot{1}=[Params.SeqFilter.SylLists.TargetSyls Params.SeqFilter.SylLists.SylsSame];
% Params.SeqFilter.SylLists.FieldsToPlot{2}=Params.SeqFilter.SylLists.SylsDifferent;

% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);



%% 3) Perform various analyses on that data structure
Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;


[Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);

% Use this for repeats
[Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearningREPEATS(Params, AllDays_RawDatStruct,saveON);


%% ========================== Use regular expressions to sort data from Raw data
close all;
Params.RegExpr.expressions={'acb+'};
[Params, AllDays_RegExpr] = lt_seq_dep_pitch_RegExpr(Params, AllDays_RawDatStruct);


% ========================== PLOT REG EXPR DATA
Params.PlotRegExpr.plotWNdays=1;
saveON=1;
[Params, AllDays_RegExpr]=lt_seq_dep_pitch_PlotRegExpr(Params, AllDays_RegExpr ,saveON);

