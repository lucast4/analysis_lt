%% 1) Gather raw data for this day
clear all; close all;

Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.all';
Params.DayRawDat.syllables={'a','b','c', 'd'};
Params.DayRawDat.frequency_range={[1300 2200], [2800 4000],[2100 2950], [900 2200]};
Params.DayRawDat.pc_dur=[0.13,0.105,0.12, 0.1];
Params.DayRawDat.pc_time_window={[385 500],[65 150],[60 430],[235 310]};

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
Params.DayRawDat.Musc_On_Time='1445'; % time given muscimol - will plot data with temporal lag after this.
Params.DayRawDat.Musc_Off_Time='1916';

[Params, RawDatStruct]=lt_seq_dep_pitch_DayRawDat(Params,1,1,'',plotLMANinact);


%% TESTING TEMPLATE

% Target: b2 (not after d)
clear all; close all;
batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'jb';
syl_post = '';
% config='/bluejay3/lucas/birds/gr41gr90/config_081115_2.evconfig2'; 
config='/bluejay3/lucas/birds/gr41gr90/081215_SeqDepPitchLMAN2_durWN_day1/config.evconfig2';
% config='/bluejay3/lucas/birds/gr41gr90/081815_SeqDepPitchLMAN2_TwoTarg_durWN_day1/config.evconfig2'; % 8/18, two targs
NoteNum =0; 
check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);


% cbB (both d and j)
clear all; close all;
batchf= 'batch.labeled.all';
% batchf= 'batch.labeled.all.PBS';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'jbbacb';
syl_post = '';
% config='/bluejay3/lucas/birds/gr41gr90/081815_SeqDepPitchLMAN2_TwoTarg_durWN_day1/config.evconfig2'; % 8/18, two targs
% config='/bluejay3/lucas/birds/gr41gr90/config_081815_2.evconfig2'; % 8/18, two targs
% config='/bluejay3/lucas/birds/gr41gr90/config_FDDFDS.evconfig2'; % 8/18, two targs
% config='/bluejay3/lucas/birds/gr41gr90/config_081815_usinga.evconfig2'; % 8/18, two targs
config='/bluejay3/lucas/birds/gr41gr90/081815_SeqDepPitchLMAN2_TwoTarg_durWN_day1/config_UpdateTempl.evconfig2'; % 8/18, two targs
NoteNum =1; 
check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);



%% ACROSS DAYS
%% 1) GATHER RAW DATA ACROSS DAYS
% --- BASELINE
clear all; close all
first_day= '08Aug2015';
last_day= '11Aug2015';
Params.DayRawDat.batch='batch.labeled.all';

% ----- WN DAYS
first_day= '12Aug2015';
last_day= '24Aug2015';
Params.DayRawDat.batch='batch.labeled.catch';



% ---- RUN
phrase = 'SeqDepPitchLMAN2';
save_results=0;
% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.

% Params.DayRawDat.syllables={'a','b','c', 'd'};
% Params.DayRawDat.frequency_range={[1300 2200], [2800 4000],[2100 2950], [900 2200]};
% Params.DayRawDat.pc_dur=[0.13,0.105,0.12, 0.1];
% Params.DayRawDat.pc_time_window={[385 500],[65 150],[60 430],[235 310]};

Params.DayRawDat.syllables={'a','b','c', 'd', 'j', 'g'};
Params.DayRawDat.frequency_range={[1300 2200], [2800 4000],[2100 2950], [900 2200], [3600 4300], [700 1000]};
Params.DayRawDat.pc_dur=[0.135,0.11,0.125, 0.105, 0.12, 0.12];
Params.DayRawDat.pc_time_window={[385 500],[65 150],[60 430],[235 310], [70 250], [50 150]};


Params.DayRawDat.pc_sigma=1;

plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);



%% 2) Seq filter, remove outliers, and compile raw data, and enter experiment info into params
cd seq_dep_pitch_SeqDepPitchLMAN2 
clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=1000;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

% Params.SeqFilter.SeqPreList={'','','c','cb'}; [OLD, combined d and j motifs]
% Params.SeqFilter.SylTargList={'b','b','b','b'};
% Params.SeqFilter.SeqPostList={'ba','a','',''};

Params.SeqFilter.SeqPreList={'','j','jb', 'jbb', 'jbba', 'jbbac','jbbacb', ...
    '','d','db', 'dbb', 'dbba', 'dbbac','dbbacb'};
Params.SeqFilter.SylTargList={'j','b','b', 'a', 'c','b','b', ...
    'd','b','b', 'a', 'c','b','b'};
Params.SeqFilter.SeqPostList={'bba','ba','a','','', '', '', ...
    'bba', 'ba','a','','', '', ''};


% 2) experiment info
Params.SeqFilter.WNTimeON='12Aug2015-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '24Aug2015-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:4;

Params.SeqFilter.SylLists.FieldsInOrder{1}={'Jbba','jBba','jbBa','jbbA', 'jbbaC','jbbacB','jbbacbB'};
Params.SeqFilter.SylLists.FieldsInOrder{2}={'Dbba','dBba','dbBa','dbbA', 'dbbaC','dbbacB','dbbacbB'};

Params.SeqFilter.SylLists.FieldsToPlot=Params.SeqFilter.SylLists.FieldsInOrder;

Params.SeqFilter.SylLists.TargetSyls={'jbBa'};
Params.SeqFilter.SylLists.SylsSame={'jBba','jbbacB','jbbacbB', 'dBba','dbBa','dbbacB','dbbacbB'};
Params.SeqFilter.SylLists.SylsDifferent={'Jbba','Dbba','jbbA','jbbaC', 'dbbA','dbbaC'};

Params.SeqFilter.DaysForSnapshot{1}={'15Aug2015','17Aug2015'};
Params.SeqFilter.DaysToMark= {'17Aug2015-2400'}; % will mark all plots with lines here;

% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);

%% Recalculate FF using new time windows
% % 
% % Params.RecalculateFF.pc_time_window_list=Params.SeqFilter.pc_time_window_list{1}; % list is the same as specified for seq filter, except one change:
% % Params.RecalculateFF.pc_time_window_list(:,6)=[27 47]; % bccb should have different time window.
% % % Params.RecalculateFF.pc_time_window_list(:,9)=[30 50]; % dccb should have different time window.
% % plotON=0;
% % 
% % [Params, AllDays_RawDatStruct] = lt_seq_dep_pitch_RecalculateFF(Params, AllDays_RawDatStruct, plotON);
% % 
% % 

%% 3) Perform various analyses on that data structure
close all; 

Params.PlotLearning.MuscimolSchedule={...
    {'09Aug2015', '1445', '1916'}, ...
    {'11Aug2015', '1442', '1839'}, ...
    {'15Aug2015', '1434', '1831'}, ...
    {'17Aug2015', '1445', '1918'}, ...
    {'21Aug2015', '1407', '1900'}};

    
% Params.PlotLearning.MuscimolDaysToThrowout={'07Jul2015'};

Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;

[Params, AllDays_PlotLearning, AllDays_RawDatStruct]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);

%% 4) PLOT - looking at effects of LMAN inactivation
close all;
Params.PlotLearning.Lag_time=2; % time from switch to musc
Params.PlotLearning.PBS_window=[-7 4]; % time before switch for PBS
saveON=1;

Params.PlotLearning.timeline.consolid_start='15Aug2015';
Params.PlotLearning.timeline.consolid_end='17Aug2015';
Params.PlotLearning.timeline.bidir_start='18Aug2015';
% Params.PlotLearning.timeline.bidir_end='16Jun2015';

[Params, AllDays_PlotLearning]= lt_seq_dep_pitch_PlotLearning_Musc(Params, AllDays_PlotLearning);

% %% ========================== Use regular expressions to sort data from Raw data
% % Params.RegExpr.expressions={'acb+g', 'acb+'};
% % Params.RegExpr.expressions={'[dgj]bbacbb', 'bb[^a]'};
% Params.RegExpr.expressions={'jbbacbb'};
% DoLMAN=1;
% saveON=1;
% [Params, AllDays_RegExpr] = lt_seq_dep_pitch_RegExpr(Params, AllDays_RawDatStruct, saveON, DoLMAN, AllDays_PlotLearning);
% 
% 
% % ========================== PLOT REG EXPR DATA
% Params.PlotRegExpr.plotWNdays=1;
% saveON=1;
% LMANon=1;
% [Params, AllDays_RegExpr]=lt_seq_dep_pitch_PlotRegExpr(Params, AllDays_RegExpr ,saveON, LMANon);

