% MATCHING TEMPLATE - b2
clear all; close all;
% config='/bluejay4/lucas/birds/or100pu10/config_111215.evconfig2';
% config='/bluejay4/lucas/birds/or100pu10/config_111215_2.evconfig2';
% config='/bluejay4/lucas/birds/or100pu10/111315_SeqDepPitchLMAN2_durWN_day1/config.evconfig2';
config='/bluejay4/lucas/birds/or100pu10/config_111515.evconfig2';


batchf='batch.labeled.all';
% batchf='batch.labeled.all.PBS';

get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'cbbb';
syl_post = '';
NoteNum = 0; 


check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, ...
    get_offline_match, get_FF, config, NoteNum);


%% === check, no label required
% clear all; close all;
% Params.batch='batch.rand.keep';
% Params.config='/bluejay4/lucas/birds/or100pu10/101015_SeqDepPitchLMAN_TwoTargs_durWN_day1/config.evconfig2'; 
% Params.NoteNum_to_plot=1; % for the note you want to analyze
% lt_check_hit_templ_freq_NoLabelRequired(Params)
% 
%% 9/18/15 - DAY ANALYSIS
clear all; close all;

Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.catch';

Params.DayRawDat.syllables={'a','b','c','g'};
% Params.DayRawDat.frequency_range={[1000 2600], [2800 3950], [1000 1750], [1200 1900]};
% Params.DayRawDat.pc_dur=[0.12, 0.12, 0.125, 0.245];
% Params.DayRawDat.pc_time_window={[75 310],[140 245],[260 430],[650 1100]};
% Params.DayRawDat.pc_sigma=1;

Params.DayRawDat.frequency_range={[1400 2550], [2850 3900], [1150 1600], [1400 1850]};
Params.DayRawDat.pc_dur=[0.12, 0.12, 0.125, 0.245];
Params.DayRawDat.pc_time_window={[120 300],[110 200],[260 400],[680 930]};
Params.DayRawDat.pc_sigma=1;

% plot and save?
plotON=1;
saveON=1;

% Related to LMAN inactivation
plotLMANinact=1;
Params.DayRawDat.Musc_On_Time='1352'; % time given muscimol - will plot data with temporal lag after this.
Params.DayRawDat.Musc_Off_Time='1815';

[Params, RawDatStruct]=lt_seq_dep_pitch_DayRawDat(Params,1,1,'',plotLMANinact);

%% ACROSS DAYS ==================================================================

%% TO DO OVER ALL DAYS
% -- BASELINE
clear all; close all
phrase = 'SeqDepPitchLMAN2';
first_day= '09Nov2015';
last_day= '11Nov2015';
Params.DayRawDat.batch='batch.labeled.all';

save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.syllables={'a','b','c','g'};

% OLD
% Params.DayRawDat.frequency_range={[1400 2550], [2850 3900], [1150 1600], [1400 1850]};
% Params.DayRawDat.pc_time_window={[120 300],[110 200],[260 400],[680 930]};

Params.DayRawDat.frequency_range={[1400 2550], [2965 3901], [1160 1550], [1425 1812]};
Params.DayRawDat.pc_time_window={[120 300],[160 200],[280 301],[717 908]};

Params.DayRawDat.pc_dur=[0.12, 0.12, 0.125, 0.245];

Params.DayRawDat.pc_sigma=1;

plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);




%% COMPILE - Seq filter, remove outliers, and compile raw data, and enter experiment info into params

clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=9000;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

Params.SeqFilter.SeqPreList={'ac','acb','acbb','acbbb','acbbbb'}; % To skip seq filter, keep blank. (i.e. {})
Params.SeqFilter.SylTargList={'b','b','b','b','b'};
Params.SeqFilter.SeqPostList={'','','','',''};

% repeats?
% Params.SeqFilter.Repeats={'acB'}; % to skip repeat filter, don't even define the field "repeats"

% Regular expressions
% Params.SeqFilter.RegExpr.expressions={'acb+g', 'acb+'}; 

% 2) experiment info
Params.SeqFilter.WNTimeON='13Nov2015-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '21Nov2015-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:2;

Params.SeqFilter.SylLists.TargetSyls={'acbbbB'};

Params.SeqFilter.SylLists.FieldsInOrder{1}={'a', 'c', 'acB','acbB','acbbB','acbbbB', 'acbbbbB', 'g'};

Params.SeqFilter.SylLists.SylsSame={'acB','acbB', 'acbbB', 'acbbbbB'};
Params.SeqFilter.SylLists.SylsDifferent={'a', 'c', 'g'};
 
% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);

%% PLOT LEARNING
close all;
% Params.PlotLearning.MuscimolSchedule={...
%     {'09Nov2015', '1329', '1902'}, ...
%     {'11Nov2015', '1347', '1824'}, ...
%     {'17Nov2015', '1352', '1815'}, ...
%     {'21Nov2015', '1349', '1748'}};

Params.PlotLearning.MuscimolSchedule={...
    {'09Nov2015', '1329', '1902'}, ...
    {'11Nov2015', '1347', '1824'}, ...
    {'17Nov2015', '1352', '1815'}};

% Params.PlotLearning.MuscimolDaysToThrowout={'08May2015', '10May2015'};

Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;

[Params, AllDays_PlotLearning, AllDays_RawDatStruct]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct, saveON);

%%  MUSC PLOT LEARNING
close all;

Params.PlotLearning.Lag_time=2; % time from switch to musc
Params.PlotLearning.PBS_window=[-6 2]; % time before switch for PBS
saveON=1;


[Params, AllDays_PlotLearning]= lt_seq_dep_pitch_PlotLearning_Musc(Params, AllDays_PlotLearning, saveON);


%% Script to replace PBS with MUSC (or vice versa) in file names of all songs in day
% StringToRemove='MUSC';
% StringToAdd='PBS';
% 
% FilesInFolder=dir('*'); % get all cbins, cbinnotmat, and rec
% 
% % copy all stuff to backup folder
% mkdir OldSongFiles
% !cp * OldSongFiles;
% 
% % continue
% for i=1:length(FilesInFolder);
%     fn=FilesInFolder(i).name;
%     
%     if any(strfind(fn,'.cbin')) || any(strfind(fn,'.rec')) || any(strfind(fn,'.not.mat'));
%     
%         length_remove=length(StringToRemove);
%         
%         fn_new=[fn(1:10) StringToAdd fn(11+length_remove:end)];
% 
%         eval(['!mv ' fn ' ' fn_new]);
%     end
% end

