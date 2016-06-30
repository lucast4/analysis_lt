%% MATCHING TEMPLATE - b2
clear all; close all;
% config='/bluejay4/lucas/birds/or100pu10/config_100115_oldtempl.evconfig2';
% config='/bluejay4/lucas/birds/or100pu10/100215_SeqDepPitchLMAN_durWN_day1/config.evconfig2';
% config='/bluejay4/lucas/birds/or100pu10/101015_SeqDepPitchLMAN_TwoTargs_durWN_day1/config.evconfig2';
config='/bluejay4/lucas/birds/or100pu10/101215_SeqDepPitchLMAN_TwoTargs_durWN_day3/config_101215.evconfig2';
batchf='batch.labeled.all';
% batchf='batch.labeled.all.PBS';

get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'cb';
syl_post = '';
NoteNum = 0; 


check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, ...
    get_offline_match, get_FF, config, NoteNum);

%  b3
clear all; close all;
% config='/bluejay4/lucas/birds/or100pu10/config_101015.evconfig2';
% config='/bluejay4/lucas/birds/or100pu10/101015_SeqDepPitchLMAN_TwoTargs_durWN_day1/config.evconfig2';
config='/bluejay4/lucas/birds/or100pu10/101215_SeqDepPitchLMAN_TwoTargs_durWN_day3/config_101215.evconfig2';
batchf='batch.labeled.all';
% batchf='batch.labeled.all.PBS';

get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'cbb';
syl_post = '';
NoteNum = 1; 


check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, ...
    get_offline_match, get_FF, config, NoteNum);


%% === check, no label required
clear all; close all;
Params.batch='batch.rand.keep';
Params.config='/bluejay4/lucas/birds/or100pu10/101015_SeqDepPitchLMAN_TwoTargs_durWN_day1/config.evconfig2'; 
Params.NoteNum_to_plot=1; % for the note you want to analyze
lt_check_hit_templ_freq_NoLabelRequired(Params)

%% 9/18/15 - DAY ANALYSIS
clear all; close all;

Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.all';

Params.DayRawDat.syllables={'a','b','c','g'};
% OLD
% Params.DayRawDat.frequency_range={[1000 2600], [2800 3950], [1000 1750], [1200 1900]};
% Params.DayRawDat.pc_time_window={[384 414],[103 235],[235 405],[710 1180]};

Params.DayRawDat.frequency_range={[1415 2530], [2935 3860], [1134 1595], [1460 1800]};
Params.DayRawDat.pc_time_window={[290 362],[120 215],[308 396],[790 845]};


Params.DayRawDat.pc_dur=[0.12, 0.12, 0.125, 0.245];
Params.DayRawDat.pc_sigma=1;


% plot and save?
plotON=0;
saveON=1;

% Related to LMAN inactivation
plotLMANinact=1;
Params.DayRawDat.Musc_On_Time='1119'; % time given muscimol - will plot data with temporal lag after this.
Params.DayRawDat.Musc_Off_Time='1500';

[Params, RawDatStruct]=lt_seq_dep_pitch_DayRawDat(Params,1,1,'',plotLMANinact);

%% ACROSS DAYS ==================================================================

%% TO DO OVER ALL DAYS
% -- BASELINE
clear all; close all
phrase = 'SeqDepPitchLMAN';
first_day= '02Oct2015';
last_day= '14Oct2015';
Params.DayRawDat.batch='batch.labeled.catch';

save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.syllables={'a','b','c','g'};

% OLD
% Params.DayRawDat.frequency_range={[1000 2600], [2800 3950], [1000 1750], [1200 1900]};
% Params.DayRawDat.pc_time_window={[384 414],[103 235],[235 405],[710 1180]};

Params.DayRawDat.frequency_range={[1415 2530], [2935 3860], [1134 1595], [1460 1800]};
Params.DayRawDat.pc_time_window={[290 362],[120 215],[308 396],[790 845]};

Params.DayRawDat.pc_dur=[0.12, 0.12, 0.125, 0.245];
Params.DayRawDat.pc_sigma=1;

plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);




%% COMPILE - Seq filter, remove outliers, and compile raw data, and enter experiment info into params
clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=7000;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

Params.SeqFilter.SeqPreList={'ac','acb','acbb','acbbb', 'acbbbb','acbbbbb','acbbbbbb'}; % To skip seq filter, keep blank. (i.e. {})
Params.SeqFilter.SylTargList={'b','b','b','b', 'b', 'b','b'};
Params.SeqFilter.SeqPostList={'','','','','', '',''};

% repeats?
% Params.SeqFilter.Repeats={'acB'}; % to skip repeat filter, don't even define the field "repeats"

% Regular expressions
% Params.SeqFilter.RegExpr.expressions={'acb+g', 'acb+'}; 

% 2) experiment info
Params.SeqFilter.WNTimeON='02Oct2015-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '14Oct2015-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:3;

Params.SeqFilter.SylLists.TargetSyls={'acbB'};

Params.SeqFilter.SylLists.FieldsInOrder{1}={'a', 'c', 'acB','acbB','acbbB','acbbbB', 'acbbbbB', 'acbbbbbB', 'acbbbbbbB','g'};

Params.SeqFilter.SylLists.SylsSame={'acB','acbbB','acbbbB', 'acbbbbB', 'acbbbbbB', 'acbbbbbbB'};
Params.SeqFilter.SylLists.SylsDifferent={'a', 'c', 'g'};
 
Params.SeqFilter.DaysForSnapshot{1}={'07Oct2015','09Oct2015'};
Params.SeqFilter.DaysToMark= {'09Oct2015-2400'}; % will mark all plots with lines here;


% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);

%% PLOT LEARNING
close all;
% Params.PlotLearning.MuscimolSchedule={...
%     {'25Sep2015', '1119', '1500'}, ...
%     {'30Sep2015', '1346', '1802'}, ...
%     {'05Oct2015', '1335', '1806'}};

% Params.PlotLearning.MuscimolSchedule={...
%     {'25Sep2015', '1119', '1500'}, ...
%     {'30Sep2015', '1346', '1802'}, ...
%     {'05Oct2015', '1335', '1806'}, ...
%     {'07Oct2015', '1346', '1803'}, ...
%     {'09Oct2015', '1329', '1817'}, ...
%     {'14Oct2015', '1349', '1818'}};

Params.PlotLearning.MuscimolSchedule={...
    {'30Sep2015', '1346', '1802'}, ...
    {'05Oct2015', '1335', '1806'}, ...
    {'07Oct2015', '1346', '1803'}, ...
    {'09Oct2015', '1329', '1817'}, ...
    {'14Oct2015', '1349', '1818'}};

% Params.PlotLearning.MuscimolDaysToThrowout={'08May2015', '10May2015'};

Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;

[Params, AllDays_PlotLearning, AllDays_RawDatStruct]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct, saveON);

%%  MUSC PLOT LEARNING
close all;

Params.PlotLearning.Lag_time=2.5; % time from switch to musc
Params.PlotLearning.PBS_window=[-4 2]; % time before switch for PBS
saveON=1;


[Params, AllDays_PlotLearning]= lt_seq_dep_pitch_PlotLearning_Musc(Params, AllDays_PlotLearning, saveON);


%% Script to replace PBS with MUSC (or vice versa) in file names of all songs in day
StringToRemove='MUSC';
StringToAdd='PBS';

FilesInFolder=dir('*'); % get all cbins, cbinnotmat, and rec

% copy all stuff to backup folder
mkdir OldSongFiles
!cp * OldSongFiles;

% continue
for i=1:length(FilesInFolder);
    fn=FilesInFolder(i).name;
    
    if any(strfind(fn,'.cbin')) || any(strfind(fn,'.rec')) || any(strfind(fn,'.not.mat'));
    
        length_remove=length(StringToRemove);
        
        fn_new=[fn(1:10) StringToAdd fn(11+length_remove:end)];

        eval(['!mv ' fn ' ' fn_new]);
    end
end
%% 8/3/15 - checking template (b1 and b3)

% ========== b1 (note 1)
% clear all; close all;
% % config='/bluejay4/lucas/birds/or100pu10/config_063015_2.evconfig2'; % 6/27, new template
% config='/bluejay4/lucas/birds/or100pu10/config_080315.evconfig2'; % 6/27, new template
% batchf='batch.labeled.all';
% 
% get_WN_hits=1;
% get_offline_match=1; % do offline matching using template? (ADDX=1)
% get_FF=1; % Analyze FF using offline matching?
% syl = 'b';
% syl_pre = 'c';
% syl_post = '';
% NoteNum = 1; 
% 
% check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, ...
%     get_offline_match, get_FF, config, NoteNum);
% 
% 
% 
% % ========= b3 (note 0)
% clear all; close all;
% % config='/bluejay4/lucas/birds/or100pu10/config_072515.evconfig2'; % start WN 7/14
% config='/bluejay4/lucas/birds/or100pu10/config_080315.evconfig2'; % 6/27, new template
% batchf='batch.labeled.all';
% 
% get_WN_hits=1;
% get_offline_match=1; % do offline matching using template? (ADDX=1)
% get_FF=1; % Analyze FF using offline matching?
% syl = 'b';
% syl_pre = 'cbb';
% syl_post = '';
% NoteNum = 0; 
% 
% 
% check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, ...
%     get_offline_match, get_FF, config, NoteNum);
% 
% 
% 
% 
% %% 7/13 - checking template  (b2 and b3)
% % ============== b3
% % config='/bluejay4/lucas/birds/or100pu10/config_071315_b3_old.evconfig2'; % 6/27, new template
% % config='/bluejay4/lucas/birds/or100pu10/config_071315_b3_new.evconfig2'; % 7/13 - good template (based on seq2
% % config='/bluejay4/lucas/birds/or100pu10/071415_SeqDepPitch3_durWN_day1/config.evconfig2'; % start WN 7/14
% % config='/bluejay4/lucas/birds/or100pu10/config_071615.evconfig2'; % start WN 7/14
% % config='/bluejay4/lucas/birds/or100pu10/config_071615.evconfig2'; % start WN 7/14
% clear all; close all;
% config='/bluejay4/lucas/birds/or100pu10/config_072515.evconfig2'; % start WN 7/14
% batchf='batch.labeled.all';
% 
% get_WN_hits=1;
% get_offline_match=1; % do offline matching using template? (ADDX=1)
% get_FF=1; % Analyze FF using offline matching?
% syl = 'b';
% syl_pre = 'cbb';
% syl_post = '';
% NoteNum = 0; 
% 
% 
% check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, ...
%     get_offline_match, get_FF, config, NoteNum);
% 
% 
% % ============== b2
% clear all; close all;
% config='/bluejay4/lucas/birds/or100pu10/config_072515.evconfig2'; % start WN 7/14
% batchf='batch.labeled.all';
% 
% get_WN_hits=1;
% get_offline_match=1; % do offline matching using template? (ADDX=1)
% get_FF=1; % Analyze FF using offline matching?
% syl = 'b';
% syl_pre = 'cb';
% syl_post = '';
% NoteNum = 1; 
% 
% 
% check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, ...
%     get_offline_match, get_FF, config, NoteNum);
% 
% 
% 
% 
% 
% %% 7/17 - CHECKING MATCHING, no labeling needed
% 
% Params.batch='batch.rand.keep';
% Params.config='/bluejay4/lucas/birds/or100pu10/config_071615.evconfig2'; % start WN 7/14
% 
% Params.NoteNum_to_plot=0; % for target 1 (b2)
% % Params.NoteNum_to_plot=1; % for target 2 (b3)
% 
% lt_check_hit_templ_freq_NoLabelRequired(Params)
% 
% 
% 
% 
% %% ==================================================================

% %% COMPILE
% %% 2) Seq filter, remove outliers, and compile raw data, and enter experiment info into params
% cd seq_dep_pitch_SeqDepPitch3/
% clear all; close all;
% 
% % 0) keep?
% Params.SeqFilter.AmplThr=13000;
% 
% % 1) Seq filter and remove outliers and compile into one struct
% Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
% Params.SeqFilter.FirstDay='';
% Params.SeqFilter.LastDay='';
% 
% Params.SeqFilter.SeqPreList={}; % To skip seq filter, keep blank. (i.e. {})
% Params.SeqFilter.SylTargList={};
% Params.SeqFilter.SeqPostList={};
% 
% % repeats?
% Params.SeqFilter.Repeats={'acB'}; % to skip repeat filter, don't even define the field "repeats"
% 
% % Regular expressions
% % Params.SeqFilter.RegExpr.expressions={'acb+g', 'acb+'}; 
% 
% % 2) experiment info
% Params.SeqFilter.WNTimeON='14Jul2015-0000'; % Time WN turned on (1st WN day)
% Params.SeqFilter.WNTimeOFF= '24Jul2015-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
% Params.SeqFilter.BaselineDays=1:2;
% 
% Params.SeqFilter.SylLists.TargetSyls={'acbB'};
% 
% Params.SeqFilter.SylLists.FieldsInOrder{1}={'a', 'acB','acbB','acbbB','acbbbB'};
% Params.SeqFilter.SylLists.SylsSame={'acB', 'acbbB','acbbbB'};
% Params.SeqFilter.SylLists.SylsDifferent={'a', 'g'};
%  
% % Params.SeqFilter.DaysForSnapshot{1}={'09Dec2014','11Dec2014'};
% % Params.SeqFilter.DaysToMark= {'11Dec2014-2400'}; % will mark all plots with lines here;
% 
% % Params.SeqFilter.SylLists.FieldsToPlot{1}=[Params.SeqFilter.SylLists.TargetSyls Params.SeqFilter.SylLists.SylsSame];
% % Params.SeqFilter.SylLists.FieldsToPlot{2}=Params.SeqFilter.SylLists.SylsDifferent;
% 
% % 3) RUN
% plotON=0;
% [Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);
% 
% 
% %% 3) Perform various analyses on that data structure
% Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
% Params.PlotLearning.DayBinSize=3; % 3 day running avg.
% saveON=1;
% 
% 
% [Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);
% 
% % Use this for repeats
% [Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearningREPEATS(Params, AllDays_RawDatStruct,saveON);
% 
% 
% %% ========================== Use regular expressions to sort data from Raw data
% close all;
% Params.RegExpr.expressions={'acb+'};
% [Params, AllDays_RegExpr] = lt_seq_dep_pitch_RegExpr(Params, AllDays_RawDatStruct);
% 
% 
% % ========================== PLOT REG EXPR DATA
% Params.PlotRegExpr.plotWNdays=1;
% saveON=1;
% [Params, AllDays_RegExpr]=lt_seq_dep_pitch_PlotRegExpr(Params, AllDays_RegExpr ,saveON);

