%% CHECKING TEMPLATE MATCHING (ab[b]);

% === GETTING kjB
clear all; close all;
batchf='batch.labeled.all';
% config='/bluejay4/lucas/birds/rd28pu64/111215_SeqDepPitch_durWN_day1/config2.evconfig2';
% config='/bluejay4/lucas/birds/rd28pu64/111215_SeqDepPitch_durWN_day1/config_LATEST.evconfig2';
% config='/bluejay4/lucas/birds/rd28pu64/111315_SeqDepPitch_durWN_day2/config_111315_2.evconfig2';
% config='/bluejay4/lucas/birds/rd28pu64/config_111515.evconfig2';
% config='/bluejay4/lucas/birds/rd28pu64/config_112215_good.evconfig2'; % start two targs
% config='/bluejay4/lucas/birds/rd28pu64/112315_SeqDepPitch_durWN_TwoTargs_day1/config.evconfig2';
% config='/bluejay4/lucas/birds/rd28pu64/112315_SeqDepPitch_durWN_TwoTargs_day1/config_112315.evconfig2';
config='/bluejay4/lucas/birds/rd28pu64/112415_SeqDepPitch_durWN_TwoTargs_day2/config_112415.evconfig2';

syl='b';
syl_pre='kj';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);



% === GETTING jjB
clear all; close all;
batchf='batch.labeled.all';
% config='/bluejay4/lucas/birds/rd28pu64/config_112215_good.evconfig2';
% config='/bluejay4/lucas/birds/rd28pu64/112315_SeqDepPitch_durWN_TwoTargs_day1/config.evconfig2';
% config='/bluejay4/lucas/birds/rd28pu64/config_112315.evconfig2';
% config='/bluejay4/lucas/birds/rd28pu64/112315_SeqDepPitch_durWN_TwoTargs_day1/config_112315.evconfig2';
config='/bluejay4/lucas/birds/rd28pu64/112415_SeqDepPitch_durWN_TwoTargs_day2/config_112415.evconfig2';

syl='b';
syl_pre='jj';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


%% 

% Params.batch='batch.rand.keep.SUB';
% Params.config='/bluejay3/lucas/birds/pu11wh87/config_100715.evconfig2'; 
% Params.NoteNum_to_plot=1; % for the note you want to analyze
% 
% [AllSongsData_toplot, AllData]=lt_check_hit_templ_freq_NoLabelRequired(Params);

%% AUTOLABEL - 
% 
% batch = 'batch.keep';
% config = '/bluejay3/lucas/birds/pu11wh87/051815_SeqDepPitchLMAN_durWN_MUSC_day7/config.evconfig2';
% syl.targ='b';
% syl.pre='bcc';
% syl.post='';
% 
% NoteNum=1;
% ampThresh=17000;
% min_dur=30;
% min_int=5;
% overwrite_notmat=1;
% 
% 
% lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat)


%% 1) Gather raw data for this day
% clear all; close all;
% 
% Params.DayRawDat.fs=32000;
% Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
% Params.DayRawDat.batch='batch.labeled.all';
% % Params.DayRawDat.syllables={'a','b','c'};
% % Params.DayRawDat.frequency_range={[1300 2200], [2800 3950],[2150 3150]};
% % Params.DayRawDat.pc_dur=[0.12,0.11,0.10];
% % % Params.DayRawDat.pc_time_window={[375 525],[60 220],[55 320]};
% % Params.DayRawDat.pc_time_window={[375 525],[30 50],[55 320]}; % WN over b
% Params.DayRawDat.syllables={'a','b','c', 'd'};
% Params.DayRawDat.frequency_range={[1300 2200], [2800 3950],[2150 3150], [1100 2700]};
% Params.DayRawDat.pc_dur=[0.135,0.125,0.125, 0.115];
% Params.DayRawDat.pc_time_window={[365 485],[50 165],[48 310],[10 180]};
% 
% Params.DayRawDat.pc_sigma=1;
% 
% 
% % plot and save?
% plotON=1;
% saveON=1;
% 
% % Related to LMAN inactivation
% plotLMANinact=1;
% Params.DayRawDat.Musc_On_Time='1412'; % time given muscimol - will plot data with temporal lag after this.
% Params.DayRawDat.Musc_Off_Time='1854';
% 
% [Params, RawDatStruct]=lt_seq_dep_pitch_DayRawDat(Params,1,1,'',plotLMANinact);
% 
% 
% 
% %% Script to change name of all song files in a day to stick "PBS" or "MUSC" right after bird name
% 
% % StringToAdd='PBS';
% % 
% % FilesInFolder=dir('*'); % get all cbins, cbinnotmat, and rec
% % 
% % % copy all stuff to backup folder
% % mkdir OldSongFiles
% % !cp * OldSongFiles;
% % 
% % % continue
% % for i=1:length(FilesInFolder);
% %     fn=FilesInFolder(i).name;
% %     
% %     if any(strfind(fn,'.cbin')) || any(strfind(fn,'.rec')) || any(strfind(fn,'.not.mat'));
% %     
% %         fn_new=[fn(1:9) StringToAdd '_' fn(10:end)];
% %         
% %         eval(['!mv ' fn ' ' fn_new]);
% %         
% %     end
% % end
% 
% 
% 
%% ANALYSIS ACROSS DAYS ============================================================
%% 1) GATHER RAW DATA ACROSS DAYS

clear all; close all
phrase = 'SeqDepPitch';
first_day= '12Nov2015';
last_day= '27Nov2015';
Params.DayRawDat.batch='batch.labeled.catch';

save_results=0;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
% Params.DayRawDat.syllables={'a','b','d', 'g','k'};
% Params.DayRawDat.frequency_range={[1200 2100], [3000 4000],[1100 2000], [1250 1750], [1200 2600]};
% Params.DayRawDat.pc_dur=[0.12, 0.12, 0.11, 0.3, 0.1];
% Params.DayRawDat.pc_time_window={[297 360],[105 170],[130 180], [490 670], [55 185]};

Params.DayRawDat.syllables={'a','b','d', 'g','k', 'j'};
Params.DayRawDat.frequency_range={[1200 2100], [3000 4000],[1100 2000], [1250 1750], [1200 2600], [3500 4500]};
Params.DayRawDat.pc_dur=[0.125, 0.125, 0.115, 0.3, 0.105, 0.11];
Params.DayRawDat.pc_time_window={[297 360],[105 170],[130 180], [490 670], [55 185], [20 100]};


Params.DayRawDat.pc_sigma=1;

plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);



%% 2) Seq filter, remove outliers, and compile raw data, and enter experiment info into params
clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=4000;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

% Params.SeqFilter.SeqPreList={'jj', 'jjb', 'jjbb', 'jjbbb', 'jjbbbb', ...
%     'a','d', 'kj', 'kjb', 'kjbb', 'kjbbb', 'kjbbbb', 'j'}; %
% 
% Params.SeqFilter.SylTargList={'b', 'b', 'b', 'b', 'b', ...
%     'b','g', 'b', 'b', 'b', 'b', 'b', 'a'};
% 
% Params.SeqFilter.SeqPostList={'', '', '', '', '', ...
%     '','', '', '', '', '', '', ''};

Params.SeqFilter.SeqPreList={'','j', 'jj', 'jjb', ...
    '','a','d', 'k','kj', 'kjb', 'j'}; % motif 1, motif 2, diff lines
Params.SeqFilter.SylTargList={'j', 'j','b', 'b', ...
    'j','b','g', 'j','b', 'b', 'a'};
Params.SeqFilter.SeqPostList={'jb','b', '', '', ...
    'a','','', '', '', '', ''};


% 2) experiment info
Params.SeqFilter.WNTimeON='12Nov2015-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '29Nov2015-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:3;


% Params.SeqFilter.SylLists.FieldsInOrder{1}={'jjB', 'jjbB', 'jjbbB', 'jjbbbB', 'jjbbbbB'};
% Params.SeqFilter.SylLists.FieldsInOrder{2}={'jA','aB','d','dG','k','kjB', 'kjbB', 'kjbbB', 'kjbbbB', 'kjbbbbB'};
Params.SeqFilter.SylLists.FieldsInOrder{1}={'Jjb','jJb','jjB', 'jjbB'};
Params.SeqFilter.SylLists.FieldsInOrder{2}={'Ja','jA','aB','d','dG','k','kJ','kjB', 'kjbB'};


Params.SeqFilter.SylLists.TargetSyls={'kjB'};
% Params.SeqFilter.SylLists.SylsSame={'jjB', 'jjbB', 'jjbbB', 'jjbbbB', 'jjbbbbB', 'aB', 'kjbB', 'kjbbB', 'kjbbbB', 'kjbbbbB'};
Params.SeqFilter.SylLists.SylsSame={'jjB', 'jjbB', 'aB', 'kjbB'};
Params.SeqFilter.SylLists.SylsDifferent={'Jjb','jJb','Ja','jA','d','dG', 'k','kJ'};

Params.SeqFilter.DaysForSnapshot{1}={'20Nov2015','22Nov2015'};
Params.SeqFilter.DaysToMark= {'22Nov2015-2400'}; % will mark all plots with lines here;

% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);



%% 3) Perform various analyses on that data structure
close all; 

Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;


[Params, AllDays_PlotLearning, AllDays_RawDatStruct]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);


%% 4) PLOT - looking at effects of LMAN inactivation
% close all;
% Params.PlotLearning.Lag_time=2;
% Params.PlotLearning.PBS_window=[-6.5 0];
% 
% Params.PlotLearning.timeline.consolid_start='05Oct2015';
% Params.PlotLearning.timeline.consolid_end='07Oct2015';
% Params.PlotLearning.timeline.bidir_start='08Oct2015';
% Params.PlotLearning.timeline.bidir_end='14Oct2015';
% 
% [Params, AllDays_PlotLearning]= lt_seq_dep_pitch_PlotLearning_Musc(Params, AllDays_PlotLearning);
% 
