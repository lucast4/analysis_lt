%% EXPERIMENT - targetting both: ab[b] and abb[b].
% This is a little hard because in WN songs b(3) and b(2) are superimposed.

% TARGETTING ABB[B];
clear all; close all
batchf='batch.labeled.catch';
% config='/bluejay3/lucas/birds/pu37wh20/120314_SeqDepPitchShift2_durWN_day11/config_120314';
% config='/bluejay3/lucas/birds/pu37wh20/config_thirdb_fake.evconfig2';
config='/bluejay3/lucas/birds/pu37wh20/config_thirdb_fake_actualtempl.evconfig2'; % using pu37wh20abbb_v1_7


get_WN_hits=1;
get_offline_match=1;
get_FF=1;

syl='b';
syl_pre='abb';
syl_post='';


check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config);




% TO TARGET ANYTHING RANDOM
clear all; close all;
batchf='batch.labeled.notcatch';
syl='B';
syl_pre='';
syl_post='';
syl_refract=0.06;
freq_range=[2800 4000];
evtaf_ver='v4';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;

% template_name='testTempl_B';
%         cntrng_values{1}={[1 4 1.5] 'or' 'n' 'n'};
%         cntrng_values{2}={[1 4 1.5] 'or' 'n' 'n'};
% col_logic='(a+b)ui';


template_name= 'pu37wh20abbb_v1_7';
            cntrng_values{1}={[5 40 1.5] 'or' 'n' 'y'};
            cntrng_values{2}={[5 40 1.5] 'and' 'n' 'y'};
            cntrng_values{3}={[2 4 2.2] 'or' 'n' 'n'};
            cntrng_values{4}={[2 4 2.2] 'or' 'n' 'n'};
            cntrng_values{5}={[2 4 2.2] 'or' 'n' 'n'};
            cntrng_values{6}={[1 4 1.6] 'or' 'n' 'n'};
            cntrng_values{7}={[1 4 1.6] 'or' 'n' 'n'};
            col_logic='(a+b)*(c+d+e+f+g)';

check_stuff=lt_check_hit_templ_freq_FUNCTION(batchf, syl, syl_pre, syl_post, syl_refract, freq_range, ...
    evtaf_ver,get_WN_hits,get_offline_match,get_FF,template_name,cntrng_values,col_logic);



%% SeqDepPitchShift2 - targeting cb(up)
% Single day check template/pitch

% clear all; close all;
% batchf='batch.labeled.c';
% syl='b';
% syl_pre='c';
% syl_post='';
% syl_refract=0.2;
% freq_range=[2800 4000];
% evtaf_ver='v4';
% get_WN_hits=0;
% get_offline_match=1;
% get_FF=1;
% 
% template_name='pu37wh20cb_v1_4';
%         cntrng_values{1}={[1 14 1.7] 'or' 'n' 'y'};
%         cntrng_values{2}={[1 14 1.7] 'and' 'n' 'y'};
%         cntrng_values{3}={[1 4 1.4] 'or' 'n' 'n'};
%         cntrng_values{4}={[1 4 1.4] 'or' 'n' 'n'};
%         col_logic='(a+b)*(c+d)';
% 
% check_stuff=lt_check_hit_templ_freq_FUNCTION(batchf, syl, syl_pre, syl_post, syl_refract, freq_range, ...
%     evtaf_ver,get_WN_hits,get_offline_match,get_FF,template_name,cntrng_values,col_logic);


% TARGETTING AB[B];
clear all; close all;
batchf='batch.labeled.all';
syl='b';
syl_pre='ab';
syl_post='';
syl_refract=0.07;
freq_range=[2800 4000];
evtaf_ver='v4';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;

template_name='pu37wh20abbb_v1_5';
        cntrng_values{1}={[5 40 1.5] 'or' 'n' 'y'};
        cntrng_values{2}={[5 40 1.5] 'and' 'n' 'y'};
        cntrng_values{3}={[2 4 2.1] 'or' 'n' 'n'};
        cntrng_values{4}={[2 4 2.1] 'or' 'n' 'n'};
        cntrng_values{5}={[2 4 2.1] 'or' 'n' 'n'};
col_logic='(a+b)*(c+d+e)';

check_stuff=lt_check_hit_templ_freq_FUNCTION(batchf, syl, syl_pre, syl_post, syl_refract, freq_range, ...
    evtaf_ver,get_WN_hits,get_offline_match,get_FF,template_name,cntrng_values,col_logic);



%% COMPILING TO PLOT

%% 11/18/14 - USING NEW METHOD - UNDIR SONGS



clear all; close all
phrase = 'SeqDepPitchShift2';
first_day= '23Nov2014';
last_day= '05Dec2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch'};

% Parameters
batchSDP='batch.labeled.catch';
syllables_SDP={'a','q','b','c'};
frequency_range_SDP ={[1300 2100], [1400 2200], [2450 3900],[2000 2850]}; % for findwnote
pc_window_SDP =[0.12,0.09,0.07,0.11]; % size of syl data window (in sec); (how much data to get for each rend (relative to onset), in sec)
pc_time_window ={[435 515],[220 285],[50 220],[55 375]}; %for pitch contour (time bins to avg).


SeqPreList_SDP={'a','a','ab','abb','qcc','qccb','bcc','bccb','q','qc','b','bc'}; % format: 1st elem of all three lists should combine
SylTargList_SDP={'b','b','b','b','b','b','b','b','c','c','c','c'}; % these must already have raw data compiled above
SeqPostList_SDP={'c','b','','','','','','','','','',''};


WithinParams={'batchSDP',batchSDP,'syllables_SDP',syllables_SDP,'frequency_range_SDP',frequency_range_SDP,'pc_window_SDP',pc_window_SDP,...
    'pc_time_window',pc_time_window,'SeqPreList_SDP',SeqPreList_SDP,'SylTargList_SDP',SylTargList_SDP,'SeqPostList_SDP',SeqPostList_SDP};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);



%% (OPTIONAL) - TO FILTER OUT SEQUENCES IN (SINGLE SYL) DATA THAT HAVE ALREADY BEEN STORED INTO STRUCTURES
% Run in the folder containing the data structures (e.g. % Run in folder: 
% e.g.
% /bluejay3/lucas/birds/pu11wh87/compile_seq_dep_pitch_data_SeqDepPitchShift,
% containing structures:
% e.g. DataStruct_02Nov2014);

all_days=1;
FirstDay='';
LastDay='';
SeqPreList={'a','a','ab','abb','qcc','qccb','bcc','bccb','q','qc','b','bc'}; % format: 1st elem of all three lists should combine
SylTargList={'b','b','b','b','b','b','b','b','c','c','c','c'}; % these must already have raw data compiled above
SeqPostList={'c','b','','','','','','','','','',''};

lt_compile_seq_dep_pitch_data_SEQFILTER_MULTDAYS(all_days,FirstDay,LastDay,SeqPreList,SylTargList,SeqPostList)



%% THEN GO TO THE SAVED FOLDER AND RUN FOLLOWING
lt_compile_seq_dep_pitch_data_LOADSAVEFILES(1);



%% ONCE HAVE COMPILED DIR AND UNDIR INTO SINGLE STRUCTURES, use this to plot
clear all; close all;

plotDIR=0;
DirFilename='';
UndirFilename='/bluejay3/lucas/birds/pu37wh20/compile_seq_dep_pitch_data_SeqDepPitchShift2/SEQFILTER/AllDays_Compiled/AllDays_Compiled_19Nov2014_to_05Dec2014';

SylLists.FieldsToPlot{1}={'qccB','qccbB','bccB','bccbB','aBb','abB','abbB'};
SylLists.FieldsToPlot{2}={'qC','qcC','bC','bcC'};
% FieldsToPlot{3}={'q','a','b','aB'};

BaselineDays=1:4;

plotWNdays=1; % 1 is on, 0 is off.
WNTimeON='23Nov2014-0000'; % Time WN turned on
WNTimeOFF='05Dec2014-2400'; % Time WN turned off ( use 0000 and 2400 if only plotting days)

SylLists.TargetSyls={'abB'};

SylLists.FieldsInOrder{1}={'aBb','abB','abbB'};
SylLists.FieldsInOrder{2}={'q','qC','qcC','qccB','qccbB'};

SylLists.SylsSame={'aBc','aBb','qccB','qccbB','bccB','bccbB','aBb','abB','abbB'};
SylLists.SylsDifferent={'a','q','qC','qcC','bC','bcC'};

lt_compile_seq_dep_pitch_data_PLOTDirUndir(DirFilename,UndirFilename,plotDIR,BaselineDays,...
    plotWNdays,WNTimeON,WNTimeOFF,SylLists)




%% --------------------------------------------------------------------------
%% --------------------------------------------------------------------------
%% --------------------------------------------------------------------------
%% 1/11/15 - DOING WELL, for UNDIR ONLY
% TO FILTER OUT SEQUENCES IN (SINGLE SYL) DATA THAT HAVE ALREADY BEEN STORED INTO STRUCTURES
% Run in the folder containing the data structures (e.g. % Run in folder: 
% e.g.
% /bluejay3/lucas/birds/pu11wh87/compile_seq_dep_pitch_data_SeqDepPitchShift,
% containing structures:
% e.g. DataStruct_02Nov2014);

all_days=1;
FirstDay='';
LastDay='';
SeqPreList={'','','a','a','ab','abb','qcc','qccb','bcc','bccb','q','qc','b','bc'}; % format: 1st elem of all three lists should combine
SylTargList={'a','a','b','b','b','b','b','b','b','b','c','c','c','c'}; % these must already have raw data compiled above
SeqPostList={'bb','bc','c','b','','','','','','','','','',''};

lt_compile_seq_dep_pitch_data_SEQFILTER_MULTDAYS(all_days,FirstDay,LastDay,SeqPreList,SylTargList,SeqPostList)




% THEN GO TO THE SAVED FOLDER AND RUN FOLLOWING
lt_compile_seq_dep_pitch_data_LOADSAVEFILES(1);



% ONCE HAVE COMPILED DIR AND UNDIR INTO SINGLE STRUCTURES, use this to plot
clear all; close all;

plotDIR=0;
DirFilename='/bluejay3/lucas/birds/pu37wh20/compile_seq_dep_pitch_data_SeqDepPitchShiftDIR/SEQFILTER/AllDays_Compiled/AllDays_Compiled_26Oct2014_to_18Nov2014';
UndirFilename='//bluejay3/lucas/birds/pu37wh20/compile_seq_dep_pitch_data_SeqDepPitchShift/SEQFILTER/AllDays_Compiled/AllDays_Compiled_26Oct2014_to_22Nov2014';

SylLists.FieldsToPlot{1}={'aBc','qccB','qccbB','bccB','bccbB','aBb','abB','abbB'};
SylLists.FieldsToPlot{2}={'Abc','Abb','q','qC','qcC','bC','bcC'};
% FieldsToPlot{3}={'q','a','b','aB'};

BaselineDays=1:4;

plotWNdays=1; % 1 is on, 0 is off.
WNTimeON='30Oct2014-0000'; % Time WN turned on
WNTimeOFF= '06Nov2014-2400'; % Time WN turned off ( use 0000 and 2400 if only plotting days)

SylLists.TargetSyls={'qccB'};

SylLists.FieldsInOrder{1}={'Abb','aBb','abB','abbB'};
SylLists.FieldsInOrder{2}={'q','qC','qcC','qccB','qccbB'};
SylLists.FieldsInOrder{3}={'Abc','aBc','bC','bcC','bccB','bccbB'};


SylLists.SylsSame={'aBc','aBb','qccbB','bccbB','aBb','abB','abbB'};
SylLists.SylsDifferent={'Abc','Abb','q','qC','qcC','bC','bcC'};

lt_compile_seq_dep_pitch_data_PLOTDirUndir(DirFilename,UndirFilename,plotDIR,BaselineDays,...
    plotWNdays,WNTimeON,WNTimeOFF,SylLists)


% BELOW WAS BEFORE I MADE SURE I HAD ALL SYLS FOR ALL CONTEXTS TO CONSTRUCT
% THE THREE SEQUENCES


%% ONCE HAVE COMPILED DIR AND UNDIR INTO SINGLE STRUCTURES, use this to plot
clear all; close all;

plotDIR=1;
DirFilename='/bluejay3/lucas/birds/pu37wh20/compile_seq_dep_pitch_data_SeqDepPitchShiftDIR/SEQFILTER/AllDays_Compiled/AllDays_Compiled_26Oct2014_to_18Nov2014';
UndirFilename='/bluejay3/lucas/birds/pu37wh20/compile_seq_dep_pitch_data_SeqDepPitchShift/SEQFILTER/AllDays_Compiled/AllDays_Compiled_26Oct2014_to_18Nov2014';

SylLists.FieldsToPlot{1}={'qccB','qccbB','bccB','bccbB','aBb','abB','abbB'};
SylLists.FieldsToPlot{2}={'qC','qcC'};
% FieldsToPlot{3}={'q','a','b','aB'};

BaselineDays=1:4;

plotWNdays=1; % 1 is on, 0 is off.
WNTimeON='30Oct2014-0000'; % Time WN turned on
WNTimeOFF= '06Nov2014-2400'; % Time WN turned off ( use 0000 and 2400 if only plotting days)

SylLists.TargetSyls={'qccB'};

SylLists.FieldsInOrder{1}={'aBb','abB','abbB'};
SylLists.FieldsInOrder{2}={'q','qC','qcC','qccB','qccbB'};

SylLists.SylsSame={'aBc','aBb','qccB','qccbB','bccB','bccbB','aBb','abB','abbB'};
SylLists.SylsDifferent={'a','q','qC','qcC'};

lt_compile_seq_dep_pitch_data_PLOTDirUndir(DirFilename,UndirFilename,plotDIR,BaselineDays,...
    plotWNdays,WNTimeON,WNTimeOFF,SylLists)


%% THEN GO TO THE SAVED FOLDER AND RUN FOLLOWING
lt_compile_seq_dep_pitch_data_LOADSAVEFILES(1);

lt_compile_seq_dep_pitch_data_LOADSAVEFILES(0,'26Oct2014','18Nov2014');

%% (OPTIONAL) - TO FILTER OUT SEQUENCES IN (SINGLE SYL) DATA THAT HAVE ALREADY BEEN STORED INTO STRUCTURES
% Run in the folder containing the data structures (e.g. % Run in folder: 
% e.g.
% /bluejay3/lucas/birds/pu11wh87/compile_seq_dep_pitch_data_SeqDepPitchShift,
% containing structures:
% e.g. DataStruct_02Nov2014);

all_days=1;
FirstDay='';
LastDay='';
SeqPreList={'a','a','ab','abb','qcc','qccb','bcc','bccb','q','qc'}; % format: 1st elem of all three lists should combine
SylTargList={'b','b','b','b','b','b','b','b','c','c'}; % these must already have raw data compiled above
SeqPostList={'c','b','','','','','','','',''};

lt_compile_seq_dep_pitch_data_SEQFILTER_MULTDAYS(all_days,FirstDay,LastDay,SeqPreList,SylTargList,SeqPostList)



%% 11/18/14 - USING NEW METHOD - UNDIR SONGS
clear all; close all
phrase = 'SeqDepPitchShiftDIR';
first_day= '27Oct2014';
last_day= '18Nov2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch'};

% Parameters
batchSDP='batch.labeled.all';
syllables_SDP={'a','q','b','c'};
frequency_range_SDP ={[1300 2100], [1400 2200], [2450 3900],[2000 2850]}; % for findwnote
pc_window_SDP =[0.12,0.09,0.07,0.11]; % size of syl data window (in sec); (how much data to get for each rend (relative to onset), in sec)
pc_time_window ={[395 475],[245 295],[80 220],[100 450]}; %for pitch contour (time bins to avg).


SeqPreList_SDP={'a','a','ab','abb','qcc','qccb','bcc','bccb','q','qc'}; % format: 1st elem of all three lists should combine
SylTargList_SDP={'b','b','b','b','b','b','b','b','c','c'}; % these must already have raw data compiled above
SeqPostList_SDP={'c','b','','','','','','','',''};


WithinParams={'batchSDP',batchSDP,'syllables_SDP',syllables_SDP,'frequency_range_SDP',frequency_range_SDP,'pc_window_SDP',pc_window_SDP,...
    'pc_time_window',pc_time_window,'SeqPreList_SDP',SeqPreList_SDP,'SylTargList_SDP',SylTargList_SDP,'SeqPostList_SDP',SeqPostList_SDP};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);



%% 11/18/14 - USING NEW METHOD - UNDIR SONGS
clear all; close all
phrase = 'SeqDepPitchShift';
first_day= '26Oct2014';
last_day= '18Nov2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch'};

% Parameters
batchSDP='batch.labeled.all';
syllables_SDP={'a','q','b','c'};
frequency_range_SDP ={[1300 2100], [1400 2200], [2450 3900],[2000 2850]}; % for findwnote
pc_window_SDP =[0.12,0.09,0.07,0.11]; % size of syl data window (in sec); (how much data to get for each rend (relative to onset), in sec)
pc_time_window ={[435 515],[220 285],[50 220],[55 375]}; %for pitch contour (time bins to avg).


SeqPreList_SDP={'a','ab','abb','qcc','qccb','bcc','bccb','q','qc'}; % format: 1st elem of all three lists should combine
SylTargList_SDP={'b','b','b','b','b','b','b','c','c'}; % these must already have raw data compiled above
SeqPostList_SDP={'','','','','','','','',''};


WithinParams={'batchSDP',batchSDP,'syllables_SDP',syllables_SDP,'frequency_range_SDP',frequency_range_SDP,'pc_window_SDP',pc_window_SDP,...
    'pc_time_window',pc_time_window,'SeqPreList_SDP',SeqPreList_SDP,'SylTargList_SDP',SylTargList_SDP,'SeqPostList_SDP',SeqPostList_SDP};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);




%% ------------------------------------------------
%% OLD METHOD BELOW
%% COMBINE DIR AND UNDIR


%% PLOT DIR AND UNDIR TOGETHER

clear all; close all;
UNDIRfilename='/bluejay3/lucas/birds/pu37wh20/all_days_various_calculations/all_days_various_MOTIF_COMPILED_07Nov2014_1320';
DIRfilename='/bluejay3/lucas/birds/pu37wh20/all_days_various_calculations/all_days_various_MOTIF_COMPILED_07Nov2014_1402';

baseline_days=1:3; % for calculate DIR/UNDIR difference, 1 is first day for UNDIR.


analysis_SyntaxDepPitchShift_DIRandUNDIR


%% 11/7 - MULTIPLE DAYS, using pitch contour, taken from SyntaxDep [DIR SONG!!!!!]

% GENERAL INPUTS
clear all; close all
phrase = 'SeqDepPitchShiftDIR';
first_day= '28Oct2014';
last_day= '05Nov2014';
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
syl_replace_list={'A','D','N','Y'};


% INPUTS FOR analysis (lt_all_days_various)
% enter as normally would, for each syl target (each cell entry is for separate motif switch)
% i.e. first cell is for first replaced syl

% lt_calc_pitch...:
freq_rangeDP_list={{[2800 4000]},{[2800 4000]},{[2800 4000]},{[2800 4000]}};
pc_time_windowDP_list={{[40 145]},{[40 160]},{[50 155]},{[45 145]}};
plot_resultDP=0;
pc_windowDP=2000;

% lt_check_HTF...:
freq_rangeHTF={{[3100 3900]},{[3100 3900]},{[2850 3800]},{[3100 4150]},{[2850 4150]}};
evtaf_verHTF='v4';
get_WN_hitsHTF=0;
get_offline_matchHTF=0;
get_FFHTF=0;
if get_offline_matchHTF==1; % template params if also doing offline check
%     template_name='pu11wh87ab_SyntaxDepPitchShift_v1_6';
%     cntrng_values{1}={[5 14 1] 'or' 'n' 'y'};
%     cntrng_values{2}={[5 14 0.1] 'or' 'n' 'y'};
%     cntrng_values{3}={[5 14 1.1] 'and' 'n' 'y'};
%     cntrng_values{4}={[1 4 1.5] 'or' 'n' 'n'};
%     cntrng_values{5}={[1 4 1.5] 'or' 'n' 'n'};
%     cntrng_values{6}={[1 4 1.5] 'or' 'n' 'n'};
%     col_logic='(a+b+c)*(d+e+f)';
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


%% 11/7 - MULTIPLE DAYS, using pitch contour, taken from SyntaxDep

% GENERAL INPUTS
clear all; close all
phrase = 'SeqDepPitchShift';
first_day= '26Oct2014';
last_day= '05Nov2014';
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
syl_replace_list={'A','D','N','Y'};


% INPUTS FOR analysis (lt_all_days_various)
% enter as normally would, for each syl target (each cell entry is for separate motif switch)
% i.e. first cell is for first replaced syl

% lt_calc_pitch...:
freq_rangeDP_list={{[2800 4000]},{[2800 4000]},{[2800 4000]},{[2800 4000]}};
pc_time_windowDP_list={{[50 170]},{[50 155]},{[55 150]},{[65 150]}};
plot_resultDP=0;
pc_windowDP=2000;

% lt_check_HTF...:
freq_rangeHTF={{[3100 3900]},{[3100 3900]},{[2850 3800]},{[3100 4150]},{[2850 4150]}};
evtaf_verHTF='v4';
get_WN_hitsHTF=0;
get_offline_matchHTF=0;
get_FFHTF=0;
if get_offline_matchHTF==1; % template params if also doing offline check
%     template_name='pu11wh87ab_SyntaxDepPitchShift_v1_6';
%     cntrng_values{1}={[5 14 1] 'or' 'n' 'y'};
%     cntrng_values{2}={[5 14 0.1] 'or' 'n' 'y'};
%     cntrng_values{3}={[5 14 1.1] 'and' 'n' 'y'};
%     cntrng_values{4}={[1 4 1.5] 'or' 'n' 'n'};
%     cntrng_values{5}={[1 4 1.5] 'or' 'n' 'n'};
%     cntrng_values{6}={[1 4 1.5] 'or' 'n' 'n'};
%     col_logic='(a+b+c)*(d+e+f)';
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



%% 11/6/14 - using pitch contour

% AB
% clear all; close all
% test=lt_calc_day_pitch_v2_FUNCTION('b',{'a'},'SeqDepPitchShift',{[2800 4000]},{0},1,4000,'batch.labeled.catch');
% clear all; close all
% test=lt_calc_day_pitch_v2_FUNCTION('b',{'a'},'SeqDepPitchShift_DIR',{[2800 4000]},{0},1,4000,'batch.labeled.all');
% 

% CB
% clear all; close all
% test=lt_calc_day_pitch_v2_FUNCTION('b',{'c'},'SeqDepPitchShift',{[2800 4000]},{0},1,4000,'batch.labeled.catch');
% clear all; close all
% test=lt_calc_day_pitch_v2_FUNCTION('b',{'c'},'SeqDepPitchShift_DIR',{[2800 4000]},{0},1,4000,'batch.labeled.all');

% BB
clear all; close all
test=lt_calc_day_pitch_v2_FUNCTION('b',{''},'SeqDepPitchShift',{[2800 4000]},{0},1,4000,'batch.labeled.catch');
clear all; close all
test=lt_calc_day_pitch_v2_FUNCTION('b',{''},'SeqDepPitchShift_DIR',{[2800 4000]},{0},1,4000,'batch.labeled.all');


%% 110314 - 1113, changed template:
% Day analysis of pitch and offline template matching - for cb
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

template_name='pu37wh20cb_v1_5';
cntrng_values{1}={[1 4 1.4] 'or' 'n' 'n'};
cntrng_values{2}={[1 4 1.4] 'or' 'n' 'n'};
cntrng_values{3}={[1 4 1.4] 'or' 'n' 'n'};
cntrng_values{4}={[1 4 1.4] 'and' 'n' 'n'};
cntrng_values{5}={[1 14 1.6] 'and' 'n' 'y'};
col_logic='(a+b+c+d)*(e)';

check_stuff=lt_check_hit_templ_freq_FUNCTION(batchf, syl, syl_pre, syl_post, syl_refract, freq_range, ...
    evtaf_ver,get_WN_hits,get_offline_match,get_FF,template_name,cntrng_values,col_logic);


%% Day analysis of pitch and offline template matching - for cb
clear all; close all;
batchf='batch.labeled.catch';
syl='b';
syl_pre='c';
syl_post='';
syl_refract=0.2;
freq_range=[2800 4000];
evtaf_ver='v4';
get_WN_hits=0;
get_offline_match=1;
get_FF=1;

template_name='pu37wh20cb_v1_3';
cntrng_values{1}={[1 14 1.6] 'and' 'n' 'y'};
cntrng_values{2}={[1 4 1.2] 'or' 'n' 'n'};
cntrng_values{3}={[1 4 1.2] 'or' 'n' 'n'};
col_logic='(a)*(b+c)';

check_stuff=lt_check_hit_templ_freq_FUNCTION(batchf, syl, syl_pre, syl_post, syl_refract, freq_range, ...
    evtaf_ver,get_WN_hits,get_offline_match,get_FF,template_name,cntrng_values,col_logic);
