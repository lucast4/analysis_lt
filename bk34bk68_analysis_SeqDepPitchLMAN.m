%% check template
% ====== jlbB
clear all; close all;
batchf= 'batch.labeled.all';

get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'ljb';
syl_post = '';
% config= '/bluejay4/lucas/birds/bk34bk68/config_121515.evconfig2';
% config= '/bluejay4/lucas/birds/bk34bk68/121515_SeqDepPitchLMAN_durWN_day1/config.evconfig2';
% config= '/bluejay4/lucas/birds/bk34bk68/121615_SeqDepPitchLMAN_durWN_day2/config_121615.evconfig2';
% config= '/bluejay4/lucas/birds/bk34bk68/config_121715.evconfig2';
% config='/bluejay4/lucas/birds/bk34bk68/122215_SeqDepPitchLMAN_durWN_TwoTarg_day1/config.evconfig2';
% config='/bluejay4/lucas/birds/bk34bk68/122815_SeqDepPitchLMAN_durWN_TwoTarg_day7/config_122815.evconfig2';
% config='/bluejay4/lucas/birds/bk34bk68/122915_SeqDepPitchLMAN_durWN_TwoTarg_day8/config_122915.evconfig2';
config='/bluejay4/lucas/birds/bk34bk68/config_123015.evconfig2';


NoteNum = 0; 

lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum)


% ========== jjbB
clear all; close all;
batchf= 'batch.labeled.all';
batchf= 'batch.labeled.all.PBS';

get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'jjb';
syl_post = '';
% config= '/bluejay4/lucas/birds/bk34bk68/config_122115.evconfig2';
% config='/bluejay4/lucas/birds/bk34bk68/122215_SeqDepPitchLMAN_durWN_TwoTarg_day1/config.evconfig2';
% config='/bluejay4/lucas/birds/bk34bk68/122815_SeqDepPitchLMAN_durWN_TwoTarg_day7/config_122815.evconfig2';
% config='/bluejay4/lucas/birds/bk34bk68/122915_SeqDepPitchLMAN_durWN_TwoTarg_day8/config_122915.evconfig2';
config='/bluejay4/lucas/birds/bk34bk68/config_123015.evconfig2';

NoteNum = 1; 

lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum)

%% 1) Gather raw data for this day
clear all; close all;

Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.all';

Params.DayRawDat.syllables={'a','b'};
Params.DayRawDat.frequency_range={[1400 2200], [3000 4000]};
Params.DayRawDat.pc_dur=[0.12, 0.12];
Params.DayRawDat.pc_time_window={[260 330],[85 185]}; %
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
plotLMANinact=0;
Params.DayRawDat.Musc_On_Time='1320'; % time given muscimol - will plot data with temporal lag after this.
Params.DayRawDat.Musc_Off_Time='1908';

[Params, RawDatStruct]=lt_seq_dep_pitch_DayRawDat(Params,1,1,'',plotLMANinact);


%% TO DO OVER ALL DAYS
clear all; close all
phrase = 'SeqDepPitchLMAN';
first_day= '11Dec2015';
last_day= '14Dec2015';
Params.DayRawDat.batch='batch.labeled.all';
% first_day= '19Nov2014';
% last_day= '22Nov2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
% OLD:
% Params.DayRawDat.syllables={'a','b'};
% Params.DayRawDat.frequency_range={[1400 2200], [3000 4000]};
% Params.DayRawDat.pc_dur=[0.12, 0.12];
% Params.DayRawDat.pc_time_window={[260 330],[85 185]}; %
Params.DayRawDat.syllables={'a','b', 'n', 'j', 'g', 'k', 'l'};
Params.DayRawDat.frequency_range={[1600 1980], [3140 3870], [750 1100], [3575 4500], [3200 4200], [3550 4450], [3450 4250]};
Params.DayRawDat.pc_dur=[0.12, 0.12, 0.105, 0.12, 0.22, 0.11, 0.1];
Params.DayRawDat.pc_time_window={[290 340],[120 170], [100 200], [210 300], [20 70], [90 220], [115 185]}; %

Params.DayRawDat.pc_sigma=1;

plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);

%% 
clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=2200;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

% Params.SeqFilter.SeqPreList={'jj','jjb','lj','ljb','jjbbg','ljbbg'}; % To skip seq filter, keep blank. (i.e. {})
% Params.SeqFilter.SylTargList={'b','b','b','b','a','a'};
% Params.SeqFilter.SeqPostList={'','','','','',''};

Params.SeqFilter.SeqPreList={'n', 'nj','njj','jj','jjb', 'jjbb','jjbbg',...
    'l', 'lj','ljb', 'ljbb', 'ljbbg'}; % To skip seq filter, keep blank. (i.e. {})

Params.SeqFilter.SylTargList={'j', 'j', 'j', 'b','b', 'g', 'a',...
    'j', 'b','b','g','a'};

Params.SeqFilter.SeqPostList={'', '', '', '','', '','',...
    '', '','','','',''};


% 2) experiment info
Params.SeqFilter.WNTimeON='15Dec2015-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '31Dec2015-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:4;

% Params.SeqFilter.SylLists.FieldsInOrder{1}={'jjB','jjbB', 'jjbbgA'};
% Params.SeqFilter.SylLists.FieldsInOrder{2}={'ljB','ljbB', 'ljbbgA'};
Params.SeqFilter.SylLists.FieldsInOrder{1}={'n', 'nJ', 'njJ', 'njjJ', 'jjB','jjbB', 'jjbbG', 'jjbbgA'};
Params.SeqFilter.SylLists.FieldsInOrder{2}={'k','l','lJ','ljB','ljbB', 'ljbbG', 'ljbbgA'};


Params.SeqFilter.SylLists.TargetSyls={'ljbB'};
Params.SeqFilter.SylLists.SylsSame={'jjB', 'jjbB','ljB'};
Params.SeqFilter.SylLists.SylsDifferent={'n', 'nJ', 'njJ', 'njjJ', 'jjbbG', 'jjbbgA', 'k','l','lJ','ljbbG', 'ljbbgA'};


% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);


%% 3) Perform various analyses on that data structure
close all;
% Extra params, for muscimol only.  do not specific this field if don't care about muscimol.  
% below, times of muscimol in and out (2 times per day)

% Params.PlotLearning.MuscimolSchedule={...
%     {'05Dec2015', '1400', '1822'}, ...
%     {'07Dec2015', '1340', '1809'}, ...
%     {'08Dec2015', '1320', '1838'}, ...
%     {'10Dec2015', '1400', '1907'}, ...
%     {'11Dec2015', '1320', '1908'}, ... 
%     {'14Dec2015', '1254', '1818'}, ...
%     {'19Dec2015', '1308', '1819'}};
    
Params.PlotLearning.MuscimolSchedule={...
    {'11Dec2015', '1320', '1908'}, ... 
    {'14Dec2015', '1254', '1818'}, ...
    {'19Dec2015', '1308', '1819'}, ...
    {'21Dec2015', '1308', '1809'}, ...
    {'25Dec2015', '1304', '1801'}, ...
    {'27Dec2015', '1303', '1758'}, ...
    {'28Dec2015', '1302', '1820'}, ...
    {'30Dec2015', '1306', '1807'}, ...
    {'31Dec2015', '1317', '1801'}};



% params
Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;


[Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);



%% 4) PLOT - looking at effects of LMAN inactivation
close all
Params.PlotLearning.Lag_time=1.32; % time from switch to musc
%       Params.PlotLearning.MUSC_end_time=2.5; % hours from PBS to musc switch [OPTIONAL]
    Params.PlotLearning.PBS_window=[-3.5 1]; % time before switch for PBS
%       Params.PlotLearning.Dur_of_PBS_dat_that_counts_as_MUSC=0.5; half
%       hour from musc to pbs, still call musc data.
    saveON=1;
    
Params.PlotLearning.timeline.consolid_start='19Dec2015';
Params.PlotLearning.timeline.consolid_end='21Dec2015';
Params.PlotLearning.timeline.bidir_start='22Dec2015';
Params.PlotLearning.timeline.bidir_end='31Dec2015';


[Params, AllDays_PlotLearning]= lt_seq_dep_pitch_PlotLearning_Musc(Params, AllDays_PlotLearning);


