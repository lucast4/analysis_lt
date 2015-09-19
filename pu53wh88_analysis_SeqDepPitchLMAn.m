%% Analyzing template (ab[b])
close all;

batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;

syl = 'b';
syl_pre = 'ab';
syl_post = '';
% config= '/bluejay3/lucas/birds/pu53wh88/config.evconfig2'; % before 2/16 templ change
% config= '/bluejay3/lucas/birds/pu53wh88/c_test.evconfig2';
config= '/bluejay3/lucas/birds/pu53wh88/config_061115.evconfig2';

NoteNum = 0;


check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, ...
    syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);


%% ANALYZE - NO NEED TO LABEL

Params.batch='batch.rand.keep';
Params.config= '/bluejay3/lucas/birds/pu53wh88/config_061115.evconfig2'; 
Params.NoteNum_to_plot=0; % for the note you want to analyze

[AllSongsData_toplot, AllData]=lt_check_hit_templ_freq_NoLabelRequired(Params);


%% 1) Gather raw data for this day
clear all; close all;

Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.all';
Params.DayRawDat.syllables={'a','b','c'};
Params.DayRawDat.frequency_range={[1000 2250], [2700 4100],[2250 3000]};
Params.DayRawDat.pc_dur=[0.125,0.115,0.125];

Params.DayRawDat.pc_time_window={[300 425],[65 228],[80 405]};
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
Params.DayRawDat.Musc_On_Time='1244'; % time given muscimol - will plot data with temporal lag after this.
Params.DayRawDat.Musc_Off_Time='1746';

[Params, RawDatStruct]=lt_seq_dep_pitch_DayRawDat(Params,plotON,saveON,'',plotLMANinact);



%% 2) ACROSS DAYS

clear all; close all
phrase = 'SeqDepPitchLMAN';
first_day= '01Jul2015';
last_day= '02Jul2015';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.all';
Params.DayRawDat.syllables={'a','b','c'};
Params.DayRawDat.frequency_range={[1000 2250], [2700 4100],[2250 3000]};
Params.DayRawDat.pc_dur=[0.125,0.115,0.125];

Params.DayRawDat.pc_time_window={[300 425],[65 228],[80 405]};
Params.DayRawDat.pc_sigma=1;


plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);



%% 3) 
cd seq_dep_pitch_SeqDepPitchLMAN/
clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=1500;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

Params.SeqFilter.SeqPreList={'','','a','ab','abb','c','cb','a','ac'};
Params.SeqFilter.SylTargList={'a','a','b','b','b','b','b','c','c'};
Params.SeqFilter.SeqPostList={'b','c','','','','','','',''};


% 2) experiment info
Params.SeqFilter.WNTimeON='12Jun2015-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '02Jul2015-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:7;

Params.SeqFilter.SylLists.FieldsToPlot{1}={'cB','cbB','aB','abB','abbB'};
Params.SeqFilter.SylLists.FieldsToPlot{2}={'Ab','Ac','aC','acC'};

Params.SeqFilter.SylLists.FieldsInOrder{1}={'Ab','aB','abB','abbB'};
Params.SeqFilter.SylLists.FieldsInOrder{2}={'Ac','aC','acC','cB','cbB'};

Params.SeqFilter.SylLists.TargetSyls={'abB'};
Params.SeqFilter.SylLists.SylsSame={'cB','cbB','aB','abbB'};
Params.SeqFilter.SylLists.SylsDifferent={'Ab','Ac','aC','acC'};

% Params.SeqFilter.DaysForSnapshot{1}={'05Mar2015','07Mar2015'};
% Params.SeqFilter.DaysToMark= {'07Mar2015-2400'}; % will mark all plots with lines here;

% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);


%% Recalculate FF using new time windows

Params.RecalculateFF.pc_time_window_list=Params.SeqFilter.pc_time_window_list{1}; % list is the same as specified for seq filter, except one change:
Params.RecalculateFF.pc_time_window_list(:,7)=[21 37]; % abB should have different time window.
plotON=0;

[Params, AllDays_RawDatStruct] = lt_seq_dep_pitch_RecalculateFF(Params, AllDays_RawDatStruct, plotON);


%% 3) Perform various analyses on that data structure
close all; 

Params.PlotLearning.MuscimolSchedule={...
    {'06Jun2015', '1252', '1704'},... 
    {'07Jun2015', '1203', '1511'}, ...
    {'09Jun2015', '1240', '1635'}, ...
    {'10Jun2015', '1229', '1659'}, ...
    {'15Jun2015', '1236', '1728'}, ...
    {'17Jun2015', '1238', '1743'}, ...
    {'19Jun2015', '1242', '1736'}, ...
    {'21Jun2015', '1240', '1723'}, ...
    {'23Jun2015', '1231', '1700'}, ...
    {'25Jun2015', '1203', '1658'}, ...
    {'27Jun2015', '1243', '1705'}, ...
    {'29Jun2015', '1327', '1814'}, ... 
    {'30Jun2015', '1244', '1746'}, ... 
    {'02Jul2015', '1251', '1745'}}; 


Params.PlotLearning.MuscimolDaysToThrowout={'07Jun2015'};

Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;


[Params, AllDays_PlotLearning, AllDays_RawDatStruct]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);


%% 4) PLOT - looking at effects of LMAN inactivation
close all;
    Params.PlotLearning.Lag_time=3.5; % time from switch to musc
    Params.PlotLearning.PBS_window=[-2.5 0]; % time before switch for PBS
    Params.PlotLearning.Dur_of_PBS_dat_that_counts_as_MUSC=0.5; % in hours;
    
    Params.PlotLearning.timeline.consolid_start='30Jun2015';
%     Params.PlotLearning.timeline.consolid_end='02Jul2015';

    
[Params, AllDays_PlotLearning]= lt_seq_dep_pitch_PlotLearning_Musc(Params, AllDays_PlotLearning);


%% ========================== Use regular expressions to sort data from Raw data
% Params.RegExpr.expressions={'acb+g', 'acb+'};
Params.RegExpr.expressions={'abbb', 'accbb'};
DoLMAN=1;
saveON=1;
[Params, AllDays_RegExpr] = lt_seq_dep_pitch_RegExpr(Params, AllDays_RawDatStruct, saveON, DoLMAN, AllDays_PlotLearning);


% ========================== PLOT REG EXPR DATA
Params.PlotRegExpr.plotWNdays=1;
saveON=1;
LMANon=1;
[Params, AllDays_RegExpr]=lt_seq_dep_pitch_PlotRegExpr(Params, AllDays_RegExpr ,saveON, LMANon);






%% ===============================
%% [OPTIONAL] Script to change name of all song files in a day to stick "PBS" or "MUSC" right after bird name

StringToAdd='PBS';

FilesInFolder=dir('*'); % get all cbins, cbinnotmat, and rec

% copy all stuff to backup folder
mkdir OldSongFiles
!cp * OldSongFiles;

% continue
for i=1:length(FilesInFolder);
    fn=FilesInFolder(i).name;
    
    if any(strfind(fn,'.cbin')) || any(strfind(fn,'.rec')) || any(strfind(fn,'.not.mat'));
    
        fn_new=[fn(1:9) StringToAdd '_' fn(10:end)];
        
        eval(['!mv ' fn ' ' fn_new]);
        
    end
end


%% [ASIDE] = looking at pitch contours and troubleshooting FFval extraction
day=11;
syl='abB';

% extract PCmat
PCmat=cell2mat(AllDays_RawDatStruct{day}.






