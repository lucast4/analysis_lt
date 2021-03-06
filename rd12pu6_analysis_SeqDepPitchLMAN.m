%% TESTING TEMPLATE

% % Target: b1(after j)
% clear all; close all;
% batchf= 'batch.labeled.all';
% get_WN_hits=1;
% get_offline_match=1; % do offline matching using template? (ADDX=1)
% get_FF=1; % Analyze FF using offline matching?
% syl = 'b';
% syl_pre = 'j';
% syl_post = '';
% % config='/bluejay4/lucas/birds/rd12pu6/config_080115.evconfig2';
% % config='/bluejay4/lucas/birds/rd12pu6/config_080215.evconfig2';
% % config='/bluejay4/lucas/birds/rd12pu6/config_new.evconfig2';
% % config='/bluejay4/lucas/birds/rd12pu6/080315_SeqDepPitch_durWN_day1/config.evconfig2';
% % config='/bluejay4/lucas/birds/rd12pu6/config_081015_newparams.evconfig2';
% % config='/bluejay4/lucas/birds/rd12pu6/081215_SeqDepPitch_TwoTargs_durWN_day1/config.evconfig2';
% config='/bluejay4/lucas/birds/rd12pu6/081215_SeqDepPitch_TwoTargs_durWN_day1/config_081315_templupdate.evconfig2';
% 
% NoteNum =0; 
% check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);
% 
% 
% % Target: aaB
% clear all; close all;
% batchf= 'batch.labeled.all';
% get_WN_hits=1;
% get_offline_match=1; % do offline matching using template? (ADDX=1)
% get_FF=1; % Analyze FF using offline matching?
% syl = 'b';
% syl_pre = 'aa';
% syl_post = '';
% % config='/bluejay4/lucas/birds/rd12pu6/config_081015_twotempl_2.evconfig2';
% % config='/bluejay4/lucas/birds/rd12pu6/081215_SeqDepPitch_TwoTargs_durWN_day1/config.evconfig2';
% config='/bluejay4/lucas/birds/rd12pu6/081215_SeqDepPitch_TwoTargs_durWN_day1/config_081315_templupdate.evconfig2';
% 
% NoteNum =1; 
% check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);
% 
% %% check, no label
% Params.batch='batch.rand.keep';
% Params.config='/bluejay4/lucas/birds/rd12pu6/080315_SeqDepPitch_durWN_day1/config.evconfig2'; 
% Params.NoteNum_to_plot=0; % for the note you want to analyze
% 
% [AllSongsData_toplot, AllData]=lt_check_hit_templ_freq_NoLabelRequired(Params);


%% 1) Gather raw data for this day
clear all; close all;

Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.all';

Params.DayRawDat.syllables={'a','b','d','g','h','k'};
Params.DayRawDat.frequency_range={[1000 2150], [3000 4300],[800 2500], [1000 2000], [3100 4600], [800 2400]};
Params.DayRawDat.pc_dur=[0.13, 0.12, 0.125, 0.2, 0.21, 0.11];
Params.DayRawDat.pc_time_window={[310 372],[60 210],[152 242],[528 618], [116 168], [200 297]};
Params.DayRawDat.pc_sigma=1;

% plot and save?
plotON=1;
saveON=1;

% Related to LMAN inactivation
plotLMANinact=1;
Params.DayRawDat.Musc_On_Time='1511'; % time given muscimol - will plot data with temporal lag after this.
Params.DayRawDat.Musc_Off_Time='1934';

[Params, RawDatStruct]=lt_seq_dep_pitch_DayRawDat(Params,1,1,'',plotLMANinact);



%% ACROSS DAYS
%% 1) GATHER RAW DATA ACROSS DAYS

clear all; close all
phrase = 'SeqDepPitchLMAN';
first_day= '07Sep2015';
last_day= '11Sep2015';
save_results=0;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.all';

Params.DayRawDat.syllables={'a','b','d','g','h','k'};
Params.DayRawDat.frequency_range={[1000 2150], [3000 4300],[800 2500], [1000 2000], [3100 4600], [800 2400]};
Params.DayRawDat.pc_dur=[0.13, 0.12, 0.125, 0.2, 0.21, 0.11];
Params.DayRawDat.pc_time_window={[310 372],[60 210],[152 242],[528 618], [116 168], [200 297]};
Params.DayRawDat.pc_sigma=1;

plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);



%% 2) Seq filter, remove outliers, and compile raw data, and enter experiment info into params
cd seq_dep_pitch_SeqDepPitchLMAN
clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=4300;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='07Sep2015';
Params.SeqFilter.LastDay='14Sep2015';


Params.SeqFilter.SeqPreList={'','a','ab','abb','h','j', 'jb','bd','da','aa','ab','d','g'};
Params.SeqFilter.SylTargList={'a','b','b','b','k', 'b', 'd', 'a', 'a',  'b', 'd', 'g','g'};
Params.SeqFilter.SeqPostList={'bb','b','','','','','','','','','','',''};


% 2) experiment info
Params.SeqFilter.WNTimeON='14Sep2015-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '14Sep2015-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:7;

Params.SeqFilter.SylLists.FieldsInOrder{1}={'Abb','aBb','abB','abbB','h','hK'};
Params.SeqFilter.SylLists.FieldsInOrder{2}={'jB','jbD','bdA','daA','aaB','abD','dG','gG'};

Params.SeqFilter.SylLists.FieldsToPlot=Params.SeqFilter.SylLists.FieldsInOrder;


Params.SeqFilter.SylLists.TargetSyls={'jB'};
Params.SeqFilter.SylLists.SylsSame={'aBb','abB','abbB','aaB'};
Params.SeqFilter.SylLists.SylsDifferent={'Abb','h','hK','jbD','bdA','daA','abD','dG','gG'};

% Params.SeqFilter.DaysForSnapshot{1}={'06Jun2015','08Jun2015'};
% Params.SeqFilter.DaysToMark= {'08Jun2015-2400', '16Jun2015-2400', '18Jun2015-2400'}; % will mark all plots with lines here;

% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);

%% 3) Perform various analyses on that data structure
close all; 

Params.PlotLearning.MuscimolSchedule={...
    {'29Aug2015', '1132', '1526'}, ...
    {'31Aug2015', '1433', '1913'}, ...
    {'01Sep2015', '1206', '1904'}, ...
    {'02Sep2015', '1331', '2028'}, ...
    {'03Sep2015', '1442', '1810'}, ...
    {'06Sep2015', '1512', '1942'}, ...
    {'07Sep2015', '1442', '1844'}, ...
    {'09Sep2015', '1144', '1739'}, ...
    {'11Sep2015', '1511', '1934'}};

% Params.PlotLearning.MuscimolDaysToThrowout={'08May2015', '10May2015'};

Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;

[Params, AllDays_PlotLearning, AllDays_RawDatStruct]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);


%% 4) PLOT - looking at effects of LMAN inactivation
close all;
Params.PlotLearning.Lag_time=1; % time from switch to musc
Params.PlotLearning.PBS_window=[-6 0]; % time before switch for PBS
saveON=1;

% Params.PlotLearning.timeline.consolid_start='24Jul2015';
% Params.PlotLearning.timeline.consolid_end='25Jul2015';
% Params.PlotLearning.timeline.bidir_start='09Jun2015';
% Params.PlotLearning.timeline.bidir_end='16Jun2015';

[Params, AllDays_PlotLearning]= lt_seq_dep_pitch_PlotLearning_Musc(Params, AllDays_PlotLearning);

%% ========================== Use regular expressions to sort data from Raw data
% % Params.RegExpr.expressions={'acb+g', 'acb+'};
% Params.RegExpr.expressions={'[dgj]bbacbb', 'bb[^a]'};
% DoLMAN=0;
% saveON=0;
% [Params, AllDays_RegExpr] = lt_seq_dep_pitch_RegExpr(Params, AllDays_RawDatStruct, saveON, DoLMAN, AllDays_PlotLearning);
% 
% 
% % ========================== PLOT REG EXPR DATA
% Params.PlotRegExpr.plotWNdays=1;
% saveON=1;
% LMANon=0;
% [Params, AllDays_RegExpr]=lt_seq_dep_pitch_PlotRegExpr(Params, AllDays_RegExpr ,saveON, LMANon);
% 

%% 3) Extract structure statistics

% % to extract data
% [Params, AllDays_StructStatsStruct]=lt_seq_dep_pitch_StructureStats(Params, AllDays_RawDatStruct);
% 
% % to look at syllable similarity - being replaced by "Correlations" below
% % [Params, AllDays_StructStatsStruct]=lt_seq_dep_pitch_StructureStats_SylSimilarity(Params, AllDays_StructStatsStruct);
% 
% % to plot and perform PCA on syl structure
% Params.PCA.epoch='baseline'; % will look at baseline
% % Params.PCA.epoch=[21 24]; % days 21 to 24
% 
% [Params, PCA_Struct]=lt_seq_dep_pitch_StructureStats_featurePCA(Params, AllDays_StructStatsStruct,1);
% 



%% Script to change name of all song files in a day to stick "PBS" or "MUSC" right after bird name

StringToAdd='PBS';

FilesInFolder=dir('*'); % get all cbins, cbinnotmat, and rec

% copy all stuff to backup folder
mkdir OldSongFiles
!cp * OldSongFiles;

% continue
for i=1:length(FilesInFolder);
    fn=FilesInFolder(i).name;
    
    if any(strfind(fn,'.cbin')) || any(strfind(fn,'.rec')) || any(strfind(fn,'.not.mat'));
    
        fn_new=[fn(1:8) StringToAdd '_' fn(9:end)];
        
        eval(['!mv ' fn ' ' fn_new]);
        
    end
end

