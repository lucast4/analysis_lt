%% check template [ SINGLE DIR AND TWO DIR PHASES]
clear all; close all;
batchf= 'batch.labeled.all.late';
batchf= 'batch.labeled.all';

get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'cb';
syl_post = '';
% config= '/bluejay4/lucas/birds/wh4wh77/011116_SeqDepPitchLMAN_durWN_day1/config.evconfig2';
% config= '/bluejay4/lucas/birds/wh4wh77/011216_SeqDepPitchLMAN_durWN_day2/config2.evconfig2';
% config= '/bluejay4/lucas/birds/wh4wh77/config_011716.evconfig2'; % 1/17, chnged template
% config= '/bluejay4/lucas/birds/wh4wh77/config_012216_new.evconfig2'; % 1/17, chnged template
% config='/bluejay4/lucas/birds/wh4wh77/012316_SeqDepPitchLMAN_durWN_TwoTarg_day1/config.evconfig2';
% config='/bluejay4/lucas/birds/wh4wh77/012416_SeqDepPitchLMAN_durWN_TwoTarg_day2/config_012416.evconfig2';
% config='/bluejay4/lucas/birds/wh4wh77/config_012816.evconfig2';
% config='/bluejay4/lucas/birds/wh4wh77/config_012916.evconfig2';
config='/bluejay4/lucas/birds/wh4wh77/020416_SeqDepPitchLMAN_durWN_TwoSameDir_day1/config.evconfig2'; % two same dir start
config='/bluejay4/lucas/birds/wh4wh77/config_020916.evconfig2'; % two same dir start
config='/bluejay4/lucas/birds/wh4wh77/config_021416.evconfig2'; % two same dir start
NoteNum = 0; 

lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum)


% ==== note 1 (DIFF DIR PHASE) (cB)
clear all; close all;
batchf= 'batch.labeled.all.PBS';
batchf= 'batch.labeled.all';

get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'c';
syl_post = '';
% config= '/bluejay4/lucas/birds/wh4wh77/config_012216_new.evconfig2'; % 1/17, chnged template
% config='/bluejay4/lucas/birds/wh4wh77/012316_SeqDepPitchLMAN_durWN_TwoTarg_day1/config.evconfig2';
% config='/bluejay4/lucas/birds/wh4wh77/012416_SeqDepPitchLMAN_durWN_TwoTarg_day2/config_012416.evconfig2';
% config='/bluejay4/lucas/birds/wh4wh77/config_012816.evconfig2';
% config='/bluejay4/lucas/birds/wh4wh77/config_012916.evconfig2';
config='/bluejay4/lucas/birds/wh4wh77/020416_SeqDepPitchLMAN_durWN_TwoSameDir_day1/config.evconfig2'; % two same dir start
config='/bluejay4/lucas/birds/wh4wh77/config_021016.evconfig2'; % two same dir start
config='/bluejay4/lucas/birds/wh4wh77/config_021416.evconfig2'; % two same dir start

NoteNum = 1; 

lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum)




%% 1) Gather raw data for this day
clear all; close all;

Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.all';

Params.DayRawDat.syllables={'a','b', 'c', 'd', 'g', 'k', 'h','n'};
Params.DayRawDat.frequency_range={[1350 2250], [3100 3900], [2350 2850], [2000 2450], [2550 3050], [1600 2800], [1600 2440], [1240 1850]};
Params.DayRawDat.pc_dur=[0.12, 0.12, 0.14, 0.09, 0.2, 0.09, 0.085, 0.105];
Params.DayRawDat.pc_time_window={[277 323],[125 170], [240 397], [110 160], [170 225], [5 35], [270 300], [300 345]}; %
Params.DayRawDat.pc_sigma=1;

% --- trying to get all syllables - look at code to check
% Params.DayRawDat.syllables={'a','ab','cb','bb','cc','bc','dc'};
% Params.DayRawDat.frequency_range={[1300 2200], [2800 3950],[2800 3950],[2800 3950],[2150 3150],[2150 3150],[2150 3150]};
% Params.DayRawDat.pc_dur=[0.12,0.09,0.09,0.09,0.11,0.11,0.11];
% Params.DayRawDat.pc_time_window={[375 525],[60 220],[60 220],[60 220],[55 320],[55 320],[55 320]};

% plot and save?
plotON=1;
saveON=1;

% Related to LMAN inactivation
plotLMANinact=1;
Params.DayRawDat.Musc_On_Time='1348'; % time given muscimol - will plot data with temporal lag after this.
Params.DayRawDat.Musc_Off_Time='1830';

[Params, RawDatStruct]=lt_seq_dep_pitch_DayRawDat(Params,1,1,'',plotLMANinact);


%% TO DO OVER ALL DAYS
clear all; close all
phrase = 'SeqDepPitchLMAN';
first_day= '07Feb2016';
last_day= '16Feb2016';
Params.DayRawDat.batch='batch.labeled.all';
% first_day= '19Nov2014';
% last_day= '22Nov2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.syllables={'a','b', 'c', 'd', 'g', 'k', 'h','n'};
% Params.DayRawDat.frequency_range={[1350 2250], [3100 3900], [2350 2850],
% [2000 2450], [2550 3050], [1600 2800], [1600 2440], [1240 1850]}; OLD
% Params.DayRawDat.pc_time_window={[277 323],[125 170], [240 397], [110 160], [170 225], [5 35], [270 300], [300 345]}; %
Params.DayRawDat.frequency_range={[1416 2205], [3125 3875], [2475 2810], [2060 2450], [2560 3030], [1860 2710], [1650 2370], [1200 1780]};
Params.DayRawDat.pc_time_window={[277 323],[130 160], [250 330], [115 150], [140 185], [15 33], [250 310], [320 330]}; %
Params.DayRawDat.pc_dur=[0.125, 0.125, 0.145, 0.095, 0.25, 0.095, 0.09, 0.11];
Params.DayRawDat.pc_sigma=1;

Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.

plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);

%% seq filter
cd seq_dep_pitch_SeqDepPitchLMAN
clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=25000;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

Params.SeqFilter.SeqPreList={'d', 'db', 'dbb', 'dbbg', 'dbbgh', ...
    'k','kc' , 'c','cb', 'cbb', 'cbbg', 'cbbgh'}; % To skip seq filter, keep blank. (i.e. {})
Params.SeqFilter.SylTargList={'b','b','g', 'h','n', ...
    'c','c', 'b','b' ,'g', 'h','n'};
Params.SeqFilter.SeqPostList={'','','','','', ...
    '','' ,'','', '', '',''};



% 2) experiment info
Params.SeqFilter.WNTimeON='11Jan2016-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '16Feb2016-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:4;

Params.SeqFilter.SylLists.FieldsInOrder{1}={'d', 'dB','dbB', 'dbbG', 'dbbgH', 'dbbghN'};
Params.SeqFilter.SylLists.FieldsInOrder{2}={'a', 'k','kC','kcC','cB','cbB','cbbG', 'cbbgH','cbbghN'};

Params.SeqFilter.SylLists.TargetSyls={'cbB'};
Params.SeqFilter.SylLists.SylsSame={'dB','dbB', 'cB'};
Params.SeqFilter.SylLists.SylsDifferent={'d', 'dbbG','a', 'k','kC','kcC','cbbG','dbbgH', 'dbbghN', 'cbbgH','cbbghN'};


% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);


%% 3) Perform various analyses on that data structure
close all;
% Extra params, for muscimol only.  do not specific this field if don't care about muscimol.  
% below, times of muscimol in and out (2 times per day)
    
% Params.PlotLearning.MuscimolSchedule={...
%     {'18Dec2015', '1300', '1850'}, ... 
%     {'20Dec2015', '1234', '1744'}, ...
%     {'22Dec2015', '1315', '1816'}, ...
%     {'23Dec2015', '1354', '1858'}, ...
%     {'24Dec2015', '1439', '2130'}};

Params.PlotLearning.MuscimolSchedule={...
    {'08Jan2016', '1318', '1830'}, ... % 1348 1830
    {'10Jan2016', '1341', '1809'}, ... % 1331 1809
    {'14Jan2016', '1303', '1807'}, ...
    {'16Jan2016', '1312', '1825'}, ...
    {'18Jan2016', '1311', '1726'}, ... % 1301 1726
    {'20Jan2016', '1257', '1800'}, ...
    {'22Jan2016', '1307', '1722'}, ...
    {'26Jan2016', '1303', '1755'}, ...
    {'28Jan2016', '1258', '1710'}, ...
    {'30Jan2016', '1255', '1725'}, ...
    {'01Feb2016', '1304', '1850'}, ...
    {'03Feb2016', '1305', '1719'}, ...
    {'09Feb2016', '1303', '1738'}, ...
    {'11Feb2016', '1303', '1743'}, ...
    {'13Feb2016', '1257', '1740'}, ...
    {'15Feb2016', '1301', '1743'}, ...
    {'16Feb2016', '1306', '1730'}};


% params
Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;


[Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);



%% 4) PLOT - looking at effects of LMAN inactivation
close all
Params.PlotLearning.Lag_time=1.7; % time from switch to musc
      Params.PlotLearning.MUSC_end_time=3.8; % hours from PBS to musc switch [OPTIONAL]
    Params.PlotLearning.PBS_window=[-6 2]; % time before switch for PBS
    Params.PlotLearning.PBS_window=[-3.5 2]; % time before switch for PBS
%       Params.PlotLearning.Dur_of_PBS_dat_that_counts_as_MUSC=0.5; half
%       hour from musc to pbs, still call musc data.
    saveON=1;

Params.PlotLearning.timeline.consolid_start='14Jan2016';
Params.PlotLearning.timeline.consolid_end='22Jan2016';
Params.PlotLearning.timeline.bidir_start='23Jan2016';
% Params.PlotLearning.timeline.bidir_end='25Jul2015';


[Params, AllDays_PlotLearning]= lt_seq_dep_pitch_PlotLearning_Musc(Params, AllDays_PlotLearning);


