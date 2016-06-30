%% MATCHING TEMPLATE - dB
% % ============ cB (note 0)
clear all; close all;
batchf= 'batch.labeled.all';
batchf= 'batch.labeled.all.PBS';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'c';
syl_post = '';
% config='/bluejay4/lucas/birds/rd23gr89/config_012016.evconfig2';
% config='/bluejay4/lucas/birds/rd23gr89/012116_SeqDepPitchLMAN2_durWN_day1/config.evconfig2';
% config='/bluejay4/lucas/birds/rd23gr89/config_012416.evconfig2'; % 1/24/16 change templ
config='/bluejay4/lucas/birds/rd23gr89/020416_SeqDepPitchLMAN2_ThreeSameDir_day1/config.evconfig2'; % three dir start
NoteNum = 0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);


% ================== dB (note 1)
clear all; close all;
batchf= 'batch.labeled.all';
batchf= 'batch.labeled.all.PBS';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'd';
syl_post = '';
config='/bluejay4/lucas/birds/rd23gr89/020416_SeqDepPitchLMAN2_ThreeSameDir_day1/config.evconfig2'; % three dir start
config='/bluejay4/lucas/birds/rd23gr89/020516_SeqDepPitchLMAN2_ThreeSameDir_day2/config_020516.evconfig2';
config='/bluejay4/lucas/birds/rd23gr89/config_021416.evconfig2';
config='/bluejay4/lucas/birds/rd23gr89/config_021416.evconfig2';

NoteNum = 1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);


% ================== dbB (note 2)
clear all; close all;
batchf= 'batch.labeled.all';
batchf= 'batch.labeled.all.PBS';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'db';
syl_post = '';
config='/bluejay4/lucas/birds/rd23gr89/020416_SeqDepPitchLMAN2_ThreeSameDir_day1/config.evconfig2'; % three dir start
config='/bluejay4/lucas/birds/rd23gr89/020516_SeqDepPitchLMAN2_ThreeSameDir_day2/config_020516.evconfig2';
config='/bluejay4/lucas/birds/rd23gr89/config_021116.evconfig2';
config='/bluejay4/lucas/birds/rd23gr89/config_021716.evconfig2';
NoteNum = 2;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);


%% 1) Gather raw data for this day
clear all; close all;

% Params.DayRawDat.fs=32000;
% Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
% Params.DayRawDat.batch='batch.labeled.all';
% 
% Params.DayRawDat.syllables={'n','a','h','k','d','b','g','c'};
% Params.DayRawDat.frequency_range={[1750 1950], [1200 2250], [900 1600], [700 2800], [900 2300], [3000 4000], [1100 1700], [2250 3150]};
% Params.DayRawDat.pc_dur=[0.1, 0.11, 0.12, 0.09, 0.11, 0.11, 0.16, 0.125];
% Params.DayRawDat.pc_time_window={[30 345], [270 395], [40 280], [15 230], [190 318], [40 161], [130 380], [140 370]};
% 
% Params.DayRawDat.pc_sigma=1;
% 
% % plot and save?
% plotON=1;
% saveON=1;
% 
% % Related to LMAN inactivation
% plotLMANinact=1;
% Params.DayRawDat.Musc_On_Time='1127'; % time given muscimol - will plot data with temporal lag after this.
% Params.DayRawDat.Musc_Off_Time='1452';
% 
% [Params, RawDatStruct]=lt_seq_dep_pitch_DayRawDat(Params,1,1,'',plotLMANinact);
% 
% 


%% === EXTRACT DATA FOR ONE DAY (WITHOUT LABELING, USING EVTAFSIM)
clear all; close all;
% -- SINGLE DAY DATA EXTRACTION
% % 1) what batch and config file to use to run evtafsim.  if needed, make a batch.
% Params.batch='batch.keep';
% Params.config='/bluejay4/lucas/birds/rd23gr89/100715_SeqDepPitchLMAN_TwoTargs_durWN_day1/config.evconfig2'; % SeqDepPitch (good with no FP)
% Params.NoteNum_to_plot=1;
% 
% [AllSongsData_toplot, AllData]=lt_check_hit_templ_freq_NoLabelRequired(Params);


%% ==== ANALYSIS ALL DAYS [NEW - params]
clear all; close all
phrase = 'SeqDepPitchLMAN2';
first_day= '25Jan2016';
last_day= '26Jan2016';
Params.DayRawDat.batch='batch.labeled.catch';

save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.pc_sigma=1;

% OLD
% Params.DayRawDat.syllables={'a','h','k','d','b','g','c'};
% Params.DayRawDat.frequency_range={[1550 2100], [1100 1350], [1575 2320], [1050 2200], [3130 4000], [1200 1500], [2360 3100]};
% Params.DayRawDat.pc_dur=[0.11, 0.12, 0.09, 0.11, 0.11, 0.16, 0.125];
% Params.DayRawDat.pc_time_window={[195 265], [40 140], [40 93], [170 215], [105 158], [190 268], [140 290]};
Params.DayRawDat.syllables={'a','h','k','d','b','g','c', 'n', 'j'};
Params.DayRawDat.frequency_range={[1550 2100], [1130 1330], [1730 2380], [1400 2160], [3290 4010], [1230 1455], [2425 2880], [600 1450], [3250 4000]};
Params.DayRawDat.pc_dur=[0.11, 0.12, 0.095, 0.11, 0.11, 0.16, 0.125, 0.095, 0.1];
Params.DayRawDat.pc_time_window={[222 265], [40 140], [40 93], [170 215], [105 158], [190 268], [172 220], [145 280], [112 200]};

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

Params.SeqFilter.SeqPreList={'','k','','h','', '','','d','db','c'}; % To skip seq filter, keep blank. (i.e. {})

Params.SeqFilter.SylTargList={'n','j','n','j','n','a','a','b','b','b'};

Params.SeqFilter.SeqPostList={'d','','ak','','ah','h','k','','',''};


% 2) experiment info
Params.SeqFilter.WNTimeON='21Jan2016-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '13Feb2016-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:7;

Params.SeqFilter.SylLists.FieldsInOrder{1}={'Nah', 'Ah', 'h', 'hJ'};
Params.SeqFilter.SylLists.FieldsInOrder{2}={'Nak', 'Ak','k', 'kJ'};
Params.SeqFilter.SylLists.FieldsInOrder{3}={'Nd', 'd','dB','dbB','g','c','cB'};

Params.SeqFilter.SylLists.TargetSyls={'cB'};
Params.SeqFilter.SylLists.SylsSame={'dbB','dB'};
Params.SeqFilter.SylLists.SylsDifferent={'Nah', 'Ah', 'h', 'hJ', 'Nak', 'Ak','k', 'kJ','Nd', 'd', 'g','c','cB'};

Params.SeqFilter.SylLists.FieldsToPlot{1}=[Params.SeqFilter.SylLists.TargetSyls Params.SeqFilter.SylLists.SylsSame];
Params.SeqFilter.SylLists.FieldsToPlot{2}=Params.SeqFilter.SylLists.SylsDifferent;

% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);


%% === PLOT LEARNING
close all;

Params.PlotLearning.MuscimolSchedule={...
    {'15Jan2016', '1254', '1759'}, ...
    {'18Jan2016', '1252', '1725'}, ...
    {'20Jan2016', '1254', '1800'}, ... 
    {'26Jan2016', '1238', '1724'}, ...
    {'28Jan2016', '1237', '1712'}, ...
    {'30Jan2016', '1251', '1727'}, ...
    {'01Feb2016', '1244', '1849'}, ...
    {'03Feb2016', '1242', '1627'}, ... % 1252
    {'08Feb2016', '1259', '1705'}, ...
    {'10Feb2016', '1255', '1709'}, ...
    {'12Feb2016', '1259', '1715'}, ...    
    {'13Feb2016', '1253', '1737'}};
    
    
Params.PlotLearning.MuscimolDaysToThrowout={'26Jan2016'};


Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;

[Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct, saveON);


%%  MUSC PLOT LEARNING
close all;
Params.PlotLearning.Lag_time=0.8; % time from switch to musc
Params.PlotLearning.Lag_time=0.6; % time from switch to musc
    Params.PlotLearning.PBS_window=[-4.5 3]; % time before switch for PBS
%       Params.PlotLearning.MUSC_end_time=3;
      
     
 %       Params.PlotLearning.Dur_of_PBS_dat_that_counts_as_MUSC=0; 


% MUSCIMOL TIMELINES
Params.PlotLearning.timeline.consolid_start='26Jan2016';
% Params.PlotLearning.timeline.consolid_end='06Oct2015';
% Params.PlotLearning.timeline.bidir_start='07Oct2015';
% Params.PlotLearning.timeline.bidir_end='14Oct2015';

   saveON=1;


[Params, AllDays_PlotLearning]= lt_seq_dep_pitch_PlotLearning_Musc(Params, AllDays_PlotLearning, saveON);




