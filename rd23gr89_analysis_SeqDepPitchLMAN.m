%% ==== calculating each day pitch by hand. used this fro day 1, when there was no catch
% for "HAMISH" analysis in seq dep pitch - i.e. needed to get metric of
% learning on day 1. Run below within each day.

syl_target = 'b';
syl_pre = {'d'};
phrase = 'SeqDepPitchLMAN';
freq_range = {[3130 4000]};
pc_time_window = {0};
plot_result = 1;
batch='batch.labeled.all'; 


day_pitch=lt_calc_day_pitch_v2_FUNCTION(syl_target, ...
    syl_pre, phrase, freq_range, pc_time_window, plot_result,'',batch);


%% ++++++++++++++++++++++++++++++++++++++++++++++++++
%% MATCHING TEMPLATE - dB

% ============ Note 0 (dB)
clear all; close all;
batchf= 'batch.labeled.all';
% batchf= 'batch.labeled.catch.PBS';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'd';
syl_post = '';
% config='/bluejay4/lucas/birds/rd23gr89/config_100115.evconfig2'; % SeqDepPitch (good with no FP)
% config='/bluejay4/lucas/birds/rd23gr89/100215_SeqDepPitchLMAN_durWN_day1/config.evconfig2'; % SeqDepPitch (good with no FP)
% config='/bluejay4/lucas/birds/rd23gr89/config_100315.evconfig2'; % SeqDepPitch (good with no FP)
% config='/bluejay4/lucas/birds/rd23gr89/100315_SeqDepPitchLMAN_durWN_day2/config_100315.evconfig2'; % SeqDepPitch (good with no FP)
config='/bluejay4/lucas/birds/rd23gr89/100715_SeqDepPitchLMAN_TwoTargs_durWN_day1/config.evconfig2'; % bidir

NoteNum = 0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);

 
% ============ Note 1 (dbB)
clear all; close all;
batchf= 'batch.labeled.all';
batchf= 'batch.labeled.all.PBS';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'db';
syl_post = '';
config='/bluejay4/lucas/birds/rd23gr89/100715_SeqDepPitchLMAN_TwoTargs_durWN_day1/config.evconfig2'; % bidir
NoteNum = 1;
check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);



%% 1) Gather raw data for this day
clear all; close all;

Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.all';

Params.DayRawDat.syllables={'n','a','h','k','d','b','g','c'};
Params.DayRawDat.frequency_range={[1750 1950], [1200 2250], [900 1600], [700 2800], [900 2300], [3000 4000], [1100 1700], [2250 3150]};
Params.DayRawDat.pc_dur=[0.1, 0.11, 0.12, 0.09, 0.11, 0.11, 0.16, 0.125];
Params.DayRawDat.pc_time_window={[30 345], [270 395], [40 280], [15 230], [190 318], [40 161], [130 380], [140 370]};

Params.DayRawDat.pc_sigma=1;

% plot and save?
plotON=1;
saveON=1;

% Related to LMAN inactivation
plotLMANinact=1;
Params.DayRawDat.Musc_On_Time='1127'; % time given muscimol - will plot data with temporal lag after this.
Params.DayRawDat.Musc_Off_Time='1452';

[Params, RawDatStruct]=lt_seq_dep_pitch_DayRawDat(Params,1,1,'',plotLMANinact);




%% === EXTRACT DATA FOR ONE DAY (WITHOUT LABELING, USING EVTAFSIM)
clear all; close all;
% -- SINGLE DAY DATA EXTRACTION
% 1) what batch and config file to use to run evtafsim.  if needed, make a batch.
Params.batch='batch.keep';
Params.config='/bluejay4/lucas/birds/rd23gr89/100715_SeqDepPitchLMAN_TwoTargs_durWN_day1/config.evconfig2'; % SeqDepPitch (good with no FP)
Params.NoteNum_to_plot=1;

[AllSongsData_toplot, AllData]=lt_check_hit_templ_freq_NoLabelRequired(Params);


%% ==== ANALYSIS ALL DAYS [NEW - params]
clear all; close all
phrase = 'SeqDepPitchLMAN';
first_day= '25Sep2015';
last_day= '01Oct2015';
Params.DayRawDat.batch='batch.labeled.all';

save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.pc_sigma=1;

% OLD - changed 11/6/15 
% Params.DayRawDat.syllables={'a','h','k','d','b','g','c'};
% Params.DayRawDat.frequency_range={[1200 2050], [1100 1300], [1000 2550], [1050 2200], [3130 4000], [1200 1500], [2360 3100]};
% Params.DayRawDat.pc_dur=[0.11, 0.12, 0.09, 0.11, 0.11, 0.16, 0.125];
% Params.DayRawDat.pc_time_window={[270 395], [150 280], [1 150], [190 290], [80 150], [165 350], [140 290]};

Params.DayRawDat.syllables={'a','h','k','d','b','g','c'};
Params.DayRawDat.frequency_range={[1200 2050], [1100 1300], [1575 2320], [1050 2200], [3130 4000], [1200 1500], [2360 3100]};
Params.DayRawDat.pc_dur=[0.11, 0.12, 0.09, 0.11, 0.11, 0.16, 0.125];
Params.DayRawDat.pc_time_window={[270 395], [150 280], [40 93], [190 290], [80 150], [165 350], [140 290]};


plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);


%% ==== ANALYSIS ALL DAYS [OLD]
% clear all; close all
% phrase = 'SeqDepPitchLMAN';
% first_day= '25Sep2015';
% last_day= '25Sep2015';
% Params.DayRawDat.batch='batch.labeled.all';
% 
% save_results=1;
% 
% % functions to run (SAME FOR ALL MOTIFS)
% FcnAll={'seq_dep_pitch_2'};
% 
% % Parameters for functions within
% Params.DayRawDat.fs=32000;
% Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
% Params.DayRawDat.pc_sigma=1;
% 
% % OLD - changed 11/6/15 - looked at PC
% % Params.DayRawDat.syllables={'n','a','h','k','d','b','g','c'};
% % Params.DayRawDat.frequency_range={[1750 1950], [1200 2250], [900 1600], [700 2800], [900 2300], [3000 4000], [1100 1700], [2250 3150]};
% % Params.DayRawDat.pc_dur=[0.1, 0.11, 0.12, 0.09, 0.11, 0.11, 0.16, 0.125];
% % Params.DayRawDat.pc_time_window={[30 345], [270 395], [40 280], [15 230], [190 318], [40 161], [130 380], [140 370]};
% 
% 
% Params.DayRawDat.syllables={'a','h','k','d','b','g','c'};
% Params.DayRawDat.frequency_range={[1200 2050], [1100 1400], [1000 2550], [1050 2200], [3000 4000], [1120 1600], [2250 3150]};
% Params.DayRawDat.pc_dur=[0.11, 0.12, 0.09, 0.11, 0.11, 0.16, 0.125];
% Params.DayRawDat.pc_time_window={[270 395], [40 280], [15 230], [190 318], [40 161], [130 380], [140 370]};
% 
% 
% plotON=0;
% saveON=1;
% 
% WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};
% 
% [filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);


%% Seq compile - NOTE, redo to compress 
clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=5000;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

Params.SeqFilter.SeqPreList={'','','d','db','c'}; % To skip seq filter, keep blank. (i.e. {})
Params.SeqFilter.SylTargList={'a','a','b','b','b'};
Params.SeqFilter.SeqPostList={'h','k','','',''};


% 2) experiment info
Params.SeqFilter.WNTimeON='02Oct2015-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '14Oct2015-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:7;

Params.SeqFilter.SylLists.FieldsInOrder{1}={'Ah','h'};
Params.SeqFilter.SylLists.FieldsInOrder{2}={'Ak','k'};
Params.SeqFilter.SylLists.FieldsInOrder{3}={'d','dB','dbB','g','c','cB'};

Params.SeqFilter.SylLists.TargetSyls={'dB'};
Params.SeqFilter.SylLists.SylsSame={'dbB','cB'};
Params.SeqFilter.SylLists.SylsDifferent={'d','Ah','h','g','c','Ak','k'};

Params.SeqFilter.SylLists.FieldsToPlot{1}=[Params.SeqFilter.SylLists.TargetSyls Params.SeqFilter.SylLists.SylsSame];
Params.SeqFilter.SylLists.FieldsToPlot{2}=Params.SeqFilter.SylLists.SylsDifferent;

% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);


%% === PLOT LEARNING
close all;

Params.PlotLearning.MuscimolSchedule={...
    {'25Sep2015', '1122', '1504'}, ...
    {'30Sep2015', '1114', '1544'}, ...
    {'05Oct2015', '1138', '1504'}, ... % 1138 1504 1151', '1504'
    {'06Oct2015', '1205', '1521'}, ... % 1205 1521 '1208', '1521'
    {'10Oct2015', '1127', '1451'}, ...
    {'12Oct2015', '1129', '1453'}, ...
    {'14Oct2015', '1140', '1514'}}; 


% Params.PlotLearning.MuscimolDaysToThrowout={'08May2015', '10May2015'};


Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;

[Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);


%%  MUSC PLOT LEARNING
close all;
Params.PlotLearning.Lag_time=0.8; % time from switch to musc
    Params.PlotLearning.PBS_window=[-3.25 3]; % time before switch for PBS
      Params.PlotLearning.MUSC_end_time=3;
      
     
 %       Params.PlotLearning.Dur_of_PBS_dat_that_counts_as_MUSC=0; 


% MUSCIMOL TIMELINES
Params.PlotLearning.timeline.consolid_start='05Oct2015';
Params.PlotLearning.timeline.consolid_end='06Oct2015';
Params.PlotLearning.timeline.bidir_start='07Oct2015';
Params.PlotLearning.timeline.bidir_end='14Oct2015';

   saveON=1;


[Params, AllDays_PlotLearning]= lt_seq_dep_pitch_PlotLearning_Musc(Params, AllDays_PlotLearning, saveON);




