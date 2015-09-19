%% 4/27/15 - analyze all songs
% -- TO DO OVER ALL DAYS
% -- baseline
clear all; close all
phrase = 'SeqDepPitchShift';
first_day= '26Oct2014';
last_day= '29Oct2014'; 
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.all';
Params.DayRawDat.syllables={'a','b','c','d'};
Params.DayRawDat.frequency_range={[1300 2200], [2800 3950],[2150 3150],[1200 3000]};
Params.DayRawDat.pc_dur=[0.135,0.117,0.127,0.1];

Params.DayRawDat.pc_time_window={[365 490],[60 220],[55 320],[30 145]};
Params.DayRawDat.pc_sigma=1;


plotON=1;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);

% -- durWN
first_day= '30Oct2014';
last_day= '06Nov2014'; 
Params.DayRawDat.batch='batch.labeled.catch';

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);


% -- postWN
first_day= '07Nov2014';
last_day= '17Nov2014'; 
Params.DayRawDat.batch='batch.labeled.all';

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);


%% SEQ FILTER AND COMPILE DATA

clear all; close all;
Params.SeqFilter.AmplThr=2200;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

Params.SeqFilter.SeqPreList={'a','ab','bcc','bccb','b','bc'};
Params.SeqFilter.SylTargList={'b','b','b','b','c','c'};
Params.SeqFilter.SeqPostList={'','','','','',''};
% 
% Params.SeqFilter.SeqPreList={'a','ab','bcc','bccb','dcc','dccb','b','bc','d','dc'};
% Params.SeqFilter.SylTargList={'b','b','b','b','b','b','c','c','c','c'};
% Params.SeqFilter.SeqPostList={'','','','','','','','','','','',''};


% 2) experiment info
Params.SeqFilter.WNTimeON='30Oct2014-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '06Nov2014-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:4;

Params.SeqFilter.SylLists.FieldsInOrder{1}={'a','aB','abB','bC','bcC','bccB','bccbB'};

Params.SeqFilter.SylLists.TargetSyls={'aB', 'bccB'};
Params.SeqFilter.SylLists.SylsSame={'aB','abB','bccbB'};
Params.SeqFilter.SylLists.SylsDifferent={'a','bC','bcC', 'd'};

Params.SeqFilter.SylLists.FieldsToPlot{1}=[Params.SeqFilter.SylLists.SylsSame Params.SeqFilter.SylLists.TargetSyls];
Params.SeqFilter.SylLists.FieldsToPlot{2}=Params.SeqFilter.SylLists.SylsDifferent;

% PREVIOUSLY ANALYZED both abbccbb and dccbb (below); now just do abbccbb.
% Params.SeqFilter.SylLists.FieldsToPlot{1}={'aB','abB','bccB','bccbB','dccB','dccbB'};
% Params.SeqFilter.SylLists.FieldsToPlot{2}={'d','bC','bcC','dC','dcC'};
% Params.SeqFilter.SylLists.FieldsInOrder{1}={'a','aB','abB','bC','bcC','bccB','bccbB'};
% Params.SeqFilter.SylLists.FieldsInOrder{2}={'d','dC','dcC','dccB','dccbB'};

% Params.SeqFilter.SylLists.TargetSyls={'aB','dccB','bccB'};
% Params.SeqFilter.SylLists.SylsSame={'abB','bccbB','dccbB'};
% Params.SeqFilter.SylLists.SylsDifferent={'a','d','bC','bcC','dC','dcC'};


% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);


% -- 3) Perform various analyses on that data structure

Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;


[Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);
close all;

% -- 3) Extract structure statistics

% to extract data
[Params, AllDays_StructStatsStruct]=lt_seq_dep_pitch_StructureStats(Params, AllDays_RawDatStruct);

% to plot and perform PCA on syl structure
Params.PCA.epoch='baseline'; % will look at baseline
% Params.PCA.epoch=[21 24]; % days 21 to 24
[Params, PCA_Struct]=lt_seq_dep_pitch_StructureStats_featurePCA(Params, AllDays_StructStatsStruct,1);

% to look at syllable similarity - being replaced by "Correlations" below
% [Params, AllDays_StructStatsStruct]=lt_seq_dep_pitch_StructureStats_SylSimilarity(Params, AllDays_StructStatsStruct);




% --- 4) Look at correlations between syllables
% work in progress
DaysWanted='baseline'; % either baseline (astring) or array
lt_seq_dep_pitch_Correlations(Params, AllDays_StructStatsStruct,DaysWanted);




%% 4/27/15 - BELOW IS OLD METHOD -- OBSELETE 

%% _-------------------------------

%% TO FILTER OUT SEQUENCES IN (SINGLE SYL) DATA THAT HAVE ALREADY BEEN STORED INTO STRUCTURES
% Run in the folder containing the data structures (e.g. % Run in folder: 
% e.g.
% /bluejay3/lucas/birds/pu11wh87/compile_seq_dep_pitch_data_SeqDepPitchShift,
% containing structures:
% e.g. DataStruct_02Nov2014);

all_days=1;
FirstDay='';
LastDay='';
SeqPreList={'a','ab','c','cb','bcc','bccb','dcc','dccb','b','bc','d','dc'}; % format: 1st elem of all three lists should combine
SylTargList={'b','b','b','b','b','b','b','b','c','c','c','c'}; % these must already have raw data compiled above
SeqPostList={'','','','','','','','','','','',''};

lt_compile_seq_dep_pitch_data_SEQFILTER_MULTDAYS(all_days,FirstDay,LastDay,SeqPreList,SylTargList,SeqPostList)


%% PLOT - ONCE HAVE COMPILED DIR AND UNDIR INTO SINGLE STRUCTURES, use this to plot
clear all; close all;

plotDIR=1;
DirFilename='/bluejay3/lucas/birds/pu11wh87/compile_seq_dep_pitch_data_SeqDepPitchShiftDIR/SEQFILTER/AllDays_Compiled/AllDays_Compiled_26Oct2014_to_20Nov2014';
UndirFilename='/bluejay3/lucas/birds/pu11wh87/compile_seq_dep_pitch_data_SeqDepPitchShift/SEQFILTER/AllDays_Compiled/AllDays_Compiled_26Oct2014_to_20Nov2014';

% FieldsToPlot{1}={'aB','abB','bccB','bccbB','dccB','dccbB'};
% FieldsToPlot{2}={'aB','cB','abB','cbB'};
% FieldsToPlot{3}={'bC','bcC','dC','dcC'};
% FieldsToPlot{3}={'a','aB','cB'};

SylLists.FieldsToPlot{1}={'aB','abB','bccB','bccbB','dccB','dccbB'};

SylLists.FieldsInOrder{1}={'a','aB','abB','bC','bcC','bccB','bccbB'};
SylLists.FieldsInOrder{2}={'dC','dcC','dccB','dccbB'};


BaselineDays=1:4;

plotWNdays=1; % 1 is on, 0 is off.
WNTimeON='30Oct2014-0000'; % Time WN turned on
WNTimeOFF= '06Nov2014-2400'; % Time WN turned off ( use 0000 and 2400 if only plotting days)

SylLists.TargetSyls={'aB','cB'};

SylLists.SylsSame={'abB','bccbB','dccbB'};
SylLists.SylsDifferent={'bC','bcC','dC','dcC'};


lt_compile_seq_dep_pitch_data_PLOTDirUndir(DirFilename,UndirFilename,plotDIR,...
    BaselineDays,plotWNdays,WNTimeON,WNTimeOFF,SylLists)

%% THEN GO TO THE SAVED FOLDER AND RUN FOLLOWING
lt_compile_seq_dep_pitch_data_LOADSAVEFILES(1);

lt_compile_seq_dep_pitch_data_LOADSAVEFILES(0,'26Oct2014','20Nov2014');


%% NEW METHOD - DIR SONGS

clear all; close all
phrase = 'SeqDepPitchShiftDIR';
first_day= '27Oct2014';
last_day= '16Nov2014';
save_results=0;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch'};

% Parameters
batchSDP='batch.labeled.all';
syllables_SDP={'a','b','c'};
frequency_range_SDP ={[1300 2200], [2900 3950],[2000 3300]}; % for findwnote
pc_window_SDP =[0.12,0.07,0.11]; % size of syl data window (in sec); (how much data to get for each rend (relative to onset), in sec)
pc_time_window ={[310 510],[70 230],[15 325]}; %for pitch contour (time bins to avg).


SeqPreList_SDP={'a','ab','c','cb','bcc','bccb','dcc','dccb','b','bc','d','dc'}; % format: 1st elem of all three lists should combine
SylTargList_SDP={'b','b','b','b','b','b','b','b','c','c','c','c'}; % these must already have raw data compiled above
SeqPostList_SDP={'','','','','','','','','','','',''};

WithinParams={'batchSDP',batchSDP,'syllables_SDP',syllables_SDP,'frequency_range_SDP',frequency_range_SDP,'pc_window_SDP',pc_window_SDP,...
    'pc_time_window',pc_time_window,'SeqPreList_SDP',SeqPreList_SDP,'SylTargList_SDP',SylTargList_SDP,'SeqPostList_SDP',SeqPostList_SDP};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);

%% 11/18/14 - USING NEW METHOD - UNDIR SONGS
clear all; close all
phrase = 'SeqDepPitchShift';
first_day= '17Nov2014';
last_day= '20Nov2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch'};

% Parameters
batchSDP='batch.labeled.all';
syllables_SDP={'a','b','c'};
frequency_range_SDP ={[1300 2200], [2800 3950],[2150 3150]}; % for findwnote
pc_window_SDP =[0.12,0.07,0.11]; % size of syl data window (in sec); (how much data to get for each rend (relative to onset), in sec)
pc_time_window ={[375 525],[60 220],[55 320]}; %for pitch contour (time bins to avg).


SeqPreList_SDP={'a','ab','c','cb','bcc','bccb','dcc','dccb','b','bc','d','dc'}; % format: 1st elem of all three lists should combine
SylTargList_SDP={'b','b','b','b','b','b','b','b','c','c','c','c'}; % these must already have raw data compiled above
SeqPostList_SDP={'','','','','','','','','','','',''};

WithinParams={'batchSDP',batchSDP,'syllables_SDP',syllables_SDP,'frequency_range_SDP',frequency_range_SDP,'pc_window_SDP',pc_window_SDP,...
    'pc_time_window',pc_time_window,'SeqPreList_SDP',SeqPreList_SDP,'SylTargList_SDP',SylTargList_SDP,'SeqPostList_SDP',SeqPostList_SDP};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);







%% ------------------------------------------------
%% OLD METHOD BELOW
%% COMBINE DIR AND UNDIR

clear all; close all;
UNDIRfilename='/bluejay3/lucas/birds/pu11wh87/all_days_various_calculations/all_days_various_MOTIF_COMPILED_08Nov2014_1334';
DIRfilename='/bluejay3/lucas/birds/pu11wh87/all_days_various_calculations/all_days_various_MOTIF_COMPILED_08Nov2014_1347';

baseline_days=1:4; % for calculate DIR/UNDIR difference, 1 is first day for UNDIR.


analysis_SyntaxDepPitchShift_DIRandUNDIR


%% 11/6 - MULTIPLE DAYS, using pitch contour, taken from SyntaxDep... [[[DIRECTED SONG!!!!]

% GENERAL INPUTS
clear all; close all
phrase = 'SeqDepPitchShiftDIR';
first_day= '27Oct2014';
last_day= '06Nov2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
% FcnAll={'check_HTF','calcdaypitch'};
FcnAll={'calcdaypitch'};

% INPUTS specifically for motif switches:
% i.e. each entry is for a separate motif (if want to get both ab(b) and
% ab(c), then syl_targ_list would be {'b','c'}). function will run
% separately for each motif.
% IMPORTANT:  labels will temporarily be changed to syl_replace. has to be unused (e.g. all caps).motif_pre_list={'ab','cb','a','c'};

% OLD VERSION, HAS MORE VARIANTS
% motif_pre_list={'abb','ab','cb','a','c'};
% syl_targ_list={'b','b','b','b','b'};
% motif_post_list={'','','','',''};
% syl_replace_list={'Z','M','X','A','D'};

motif_pre_list={'a','c','b',''};
syl_targ_list={'b','b','b','b'};
motif_post_list={'','','',''};
syl_replace_list={'A','C','R','b'};


% INPUTS FOR analysis (lt_all_days_various)
% enter as normally would, for each syl target (each cell entry is for separate motif switch)
% i.e. first cell is for first replaced syl

% lt_calc_pitch...:
freq_rangeDP_list={{[2800 4100]},{[2700 4000]},{[2800 4000]},{[2800 4000]}};
pc_time_windowDP_list={{[70 155]},{[55 150]},{[40 145]},{[50 150]}};
plot_resultDP=0;
pc_windowDP=2000;

% lt_check_HTF...:
freq_rangeHTF={{[3050 3750]},{[3050 3750]},{[3050 3750]},{[3050 3750]},{[3050 3750]},{[3050 4200]},{[2800 4200]}};
evtaf_verHTF='v4';
get_WN_hitsHTF=0;
get_offline_matchHTF=0;
get_FFHTF=0;
if get_offline_matchHTF==1; % template params if also doing offline check
    template_name='pu11wh87ab_SyntaxDepPitchShift_v1_6';
    cntrng_values{1}={[5 14 1] 'or' 'n' 'y'};
    cntrng_values{2}={[5 14 0.1] 'or' 'n' 'y'};
    cntrng_values{3}={[5 14 1.1] 'and' 'n' 'y'};
    cntrng_values{4}={[1 4 1.5] 'or' 'n' 'n'};
    cntrng_values{5}={[1 4 1.5] 'or' 'n' 'n'};
    cntrng_values{6}={[1 4 1.5] 'or' 'n' 'n'};
    col_logic='(a+b+c)*(d+e+f)';
end


% INPUT: WITHIN FUNCTION VARIABLES SETTING (DIFFERENT FOR ALL MOTIFS)
% DO not change the values within each function, but add and subtract Vs if you need.
num_motifs=size(syl_targ_list,2);
for i=1:num_motifs;
    % lt_check_HTF...:
    if get_offline_matchHTF==1;
        V1_mot{i}={'sylHTF',{syl_replace_list{i}},'syl_preHTF',{''},'syl_postHTF',{''},'freq_rangeHTF',freq_rangeHTF{i},'evtaf_verHTF',evtaf_verHTF,'get_WN_hitsHTF',get_WN_hitsHTF,'get_offline_matchHTF',...
            get_offline_matchHTF,'get_FFHTF',get_FFHTF,'template_name',template_name,'cntrng_values',cntrng_values,'col_logic',col_logic};
    else
        V1_mot{i}={'sylHTF',{syl_replace_list{i}},'syl_preHTF',{''},'syl_postHTF',{''},'freq_rangeHTF',freq_rangeHTF{i},'evtaf_verHTF',evtaf_verHTF,'get_WN_hitsHTF',get_WN_hitsHTF,'get_offline_matchHTF',...
            get_offline_matchHTF,'get_FFHTF',get_FFHTF};
    end
    
    % lt_calc_pitch...:
    V2_mot{i}={'syl_targetDP',syl_replace_list{i}, 'syl_preDP',{''},'phraseDP',phrase,'freq_rangeDP',freq_rangeDP_list{i},'pc_time_windowDP',...
        pc_time_windowDP_list{i},'plot_resultDP',plot_resultDP,'pc_windowDP',pc_windowDP,'batchDP','batch.labeled.all'};
    
    % combine
    Vall_mot{i}=[V1_mot{i},V2_mot{i}];
end



lt_all_days_various_calculations_COMBINE_Motif_and_Normal


% TO PLOT, set params here and run script below:
% INPUTS
% Save?
close all
save_plots=1;
% What to get? (1 = get , 0 = skip)
get_thr=0;
plot_baseline=0;
baseline_days=1:3;
plot_WN=0;
    WN_dates={'08Jul2014-1232','21Jul2014-1624','31Jul2014-1618','07Aug2014-1048'};
plot_lesions=0;
%     lesion_dates={''};
%     lesionEvents=lt_convert_EventTimes_to_RelTimes(first_day_str,lesion_dates);
%     lesion_days=lesionEvents.FinalValue;
plot_pitch_thresholds=0;    
%     threshold_switch_RealTimes={'20Mar2014-0029','20Mar2014-1739','21Mar2014-1234','24Mar2014-1651','25Mar2014-1808',...
%         '26Mar2014-1347','27Mar2014-0207','27Mar2014-1127','28Mar2014-0103','28Mar2014-1320','30Mar2014-1951'}; % real times for threshold values switches in format e.g. 20Mar2014-1645
%     thresh_values=[2583 2615 2639 2706 2685 2675 2665 2680 2720 2710 2720]; % values of threshold corresponding to switch times
%     hit_conting='below'; % hit renditions "below" or "above" threshold?

% running average
run_wind=[10 20 50];

analysis_SyntaxDepPitchShift_PLOTS




%% 11/6 - MULTIPLE DAYS, using pitch contour, taken from SyntaxDep...

% GENERAL INPUTS
clear all; close all
phrase = 'SeqDepPitchShift';
first_day= '26Oct2014';
last_day= '06Nov2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
% FcnAll={'check_HTF','calcdaypitch'};
FcnAll={'calcdaypitch'};

% INPUTS specifically for motif switches:
% i.e. each entry is for a separate motif (if want to get both ab(b) and
% ab(c), then syl_targ_list would be {'b','c'}). function will run
% separately for each motif.
% IMPORTANT:  labels will temporarily be changed to syl_replace. has to be unused (e.g. all caps).motif_pre_list={'ab','cb','a','c'};

% OLD VERSION, HAS MORE VARIANTS
% motif_pre_list={'abb','ab','cb','a','c'};
% syl_targ_list={'b','b','b','b','b'};
% motif_post_list={'','','','',''};
% syl_replace_list={'Z','M','X','A','D'};

motif_pre_list={'a','c','b',''};
syl_targ_list={'b','b','b','b'};
motif_post_list={'','','',''};
syl_replace_list={'A','C','R','b'};


% INPUTS FOR analysis (lt_all_days_various)
% enter as normally would, for each syl target (each cell entry is for separate motif switch)
% i.e. first cell is for first replaced syl

% lt_calc_pitch...:
freq_rangeDP_list={{[2800 4100]},{[2700 4000]},{[2800 4000]},{[2800 4000]}};
pc_time_windowDP_list={{[85 170]},{[60 160]},{[55 170]},{[60 170]}};
plot_resultDP=0;
pc_windowDP=2000;

% lt_check_HTF...:
freq_rangeHTF={{[3050 3750]},{[3050 3750]},{[3050 3750]},{[3050 3750]},{[3050 3750]},{[3050 4200]},{[2800 4200]}};
evtaf_verHTF='v4';
get_WN_hitsHTF=0;
get_offline_matchHTF=0;
get_FFHTF=0;
if get_offline_matchHTF==1; % template params if also doing offline check
    template_name='pu11wh87ab_SyntaxDepPitchShift_v1_6';
    cntrng_values{1}={[5 14 1] 'or' 'n' 'y'};
    cntrng_values{2}={[5 14 0.1] 'or' 'n' 'y'};
    cntrng_values{3}={[5 14 1.1] 'and' 'n' 'y'};
    cntrng_values{4}={[1 4 1.5] 'or' 'n' 'n'};
    cntrng_values{5}={[1 4 1.5] 'or' 'n' 'n'};
    cntrng_values{6}={[1 4 1.5] 'or' 'n' 'n'};
    col_logic='(a+b+c)*(d+e+f)';
end


% INPUT: WITHIN FUNCTION VARIABLES SETTING (DIFFERENT FOR ALL MOTIFS)
% DO not change the values within each function, but add and subtract Vs if you need.
num_motifs=size(syl_targ_list,2);
for i=1:num_motifs;
    % lt_check_HTF...:
    if get_offline_matchHTF==1;
        V1_mot{i}={'sylHTF',{syl_replace_list{i}},'syl_preHTF',{''},'syl_postHTF',{''},'freq_rangeHTF',freq_rangeHTF{i},'evtaf_verHTF',evtaf_verHTF,'get_WN_hitsHTF',get_WN_hitsHTF,'get_offline_matchHTF',...
            get_offline_matchHTF,'get_FFHTF',get_FFHTF,'template_name',template_name,'cntrng_values',cntrng_values,'col_logic',col_logic};
    else
        V1_mot{i}={'sylHTF',{syl_replace_list{i}},'syl_preHTF',{''},'syl_postHTF',{''},'freq_rangeHTF',freq_rangeHTF{i},'evtaf_verHTF',evtaf_verHTF,'get_WN_hitsHTF',get_WN_hitsHTF,'get_offline_matchHTF',...
            get_offline_matchHTF,'get_FFHTF',get_FFHTF};
    end
    
    % lt_calc_pitch...:
    V2_mot{i}={'syl_targetDP',syl_replace_list{i}, 'syl_preDP',{''},'phraseDP',phrase,'freq_rangeDP',freq_rangeDP_list{i},'pc_time_windowDP',...
        pc_time_windowDP_list{i},'plot_resultDP',plot_resultDP,'pc_windowDP',pc_windowDP,'batchDP','batch.labeled.all'};
    
    % combine
    Vall_mot{i}=[V1_mot{i},V2_mot{i}];
end



lt_all_days_various_calculations_COMBINE_Motif_and_Normal


% TO PLOT, set params here and run script below:
% INPUTS
% Save?
close all
save_plots=1;
% What to get? (1 = get , 0 = skip)
get_thr=0;
plot_baseline=1;
baseline_days=1:3;
plot_WN=0;
    WN_dates={'08Jul2014-1232','21Jul2014-1624','31Jul2014-1618','07Aug2014-1048'};
plot_lesions=0;
%     lesion_dates={''};
%     lesionEvents=lt_convert_EventTimes_to_RelTimes(first_day_str,lesion_dates);
%     lesion_days=lesionEvents.FinalValue;
plot_pitch_thresholds=0;    
%     threshold_switch_RealTimes={'20Mar2014-0029','20Mar2014-1739','21Mar2014-1234','24Mar2014-1651','25Mar2014-1808',...
%         '26Mar2014-1347','27Mar2014-0207','27Mar2014-1127','28Mar2014-0103','28Mar2014-1320','30Mar2014-1951'}; % real times for threshold values switches in format e.g. 20Mar2014-1645
%     thresh_values=[2583 2615 2639 2706 2685 2675 2665 2680 2720 2710 2720]; % values of threshold corresponding to switch times
%     hit_conting='below'; % hit renditions "below" or "above" threshold?

% running average
run_wind=[10 20 50];

analysis_SyntaxDepPitchShift_PLOTS


%% 11/4/14 - using pitch contour

% AB
clear all; close all
test=lt_calc_day_pitch_v2_FUNCTION('b',{'a'},'SeqDepPitchShift',{[2800 4000]},{0},1,4000,'batch.labeled.catch');
clear all; close all
test=lt_calc_day_pitch_v2_FUNCTION('b',{'a'},'SeqDepPitchShift_DIR',{[2800 4000]},{0},1,4000);

% 2:13 window

% CB
clear all; close all
test=lt_calc_day_pitch_v2_FUNCTION('b',{'c'},'SeqDepPitchShift',{[2800 4000]},{0},1,4000);
test=lt_calc_day_pitch_v2_FUNCTION('b',{'c'},'SeqDepPitchShift_DIR',{[2800 4000]},{0},1,4000);

%% 10/29/14 Single day check - pitch

% FOR ab;
clear all; close all;
batchf='batch.labeled.all';
syl='b';
syl_pre='a';
syl_post='';
syl_refract=0.2;
freq_range=[2800 4000];
evtaf_ver='v4';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;

template_name='pu11wh87ab_SyntaxDepPitchShift_v1_6';
cntrng_values{1}={[5 14 1.2] 'or' 'n' 'y'};
cntrng_values{2}={[5 14 1] 'or' 'n' 'y'};
cntrng_values{3}={[5 14 1.3] 'and' 'n' 'y'};
cntrng_values{4}={[1 4 1.6] 'or' 'n' 'n'};
cntrng_values{5}={[1 4 1.6] 'or' 'n' 'n'};
cntrng_values{6}={[1 4 1.6] 'or' 'n' 'n'};
col_logic='(a+b+c)*(d+e+f)';

check_stuff=lt_check_hit_templ_freq_FUNCTION(batchf, syl, syl_pre, syl_post, syl_refract, freq_range, ...
    evtaf_ver,get_WN_hits,get_offline_match,get_FF,template_name,cntrng_values,col_logic);


%% FOR cb
clear all; close all;
batchf='batch.labeled.all';
syl='b';
syl_pre='c';
syl_post='';
syl_refract=0.2;
freq_range=[2800 4000];
evtaf_ver='v4';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;

template_name='pu11wh87cb_SyntaxDepPitchShift_v1_3';
cntrng_values{1}={[1 4 1.7] 'or' 'n' 'n'};
cntrng_values{2}={[1 4 1.7] 'and' 'n' 'n'};
cntrng_values{3}={[4 14 2.2] 'or' 'n' 'y'};
col_logic='(a+b)*(c)';

check_stuff=lt_check_hit_templ_freq_FUNCTION(batchf, syl, syl_pre, syl_post, syl_refract, freq_range, ...
    evtaf_ver,get_WN_hits,get_offline_match,get_FF,template_name,cntrng_values,col_logic);
