%% Checking hit rate, template, b1 (after a)

batchf='batch.labeled.all';
syl='b';
syl_pre='a';
% syl_post='bb';
syl_post='';
syl_refract=0.3;
freq_range=[2800 3800];
evtaf_ver='v4';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;

% % OLD
% template_name='pu35wh17ab1_v1_12'; 
% cntrng_values{1}={[2 4 1.8] 'or' 'n' 'n'};
% cntrng_values{2}={[2 4 1.8] 'or' 'n' 'n'};
% cntrng_values{3}={[2 4 1.8] 'or' 'n' 'n'};
% cntrng_values{4}={[2 4 1.8] 'or' 'n' 'n'};
% cntrng_values{5}={[2 4 1.5] 'or' 'n' 'n'};
% cntrng_values{6}={[2 4 0] 'or' 'n' 'n'};
% cntrng_values{7}={[2 4 0] 'or' 'n' 'n'};
% cntrng_values{8}={[2 4 0] 'or' 'n' 'n'};
% cntrng_values{9}={[6 10 1.4] 'or' 'n' 'y'};
% cntrng_values{10}={[6 10 1.4] 'or' 'n' 'y'};
% cntrng_values{11}={[6 10 1.4] 'or' 'n' 'y'};
% cntrng_values{12}={[5 27 1.4] 'or' 'y' 'y'};
% col_logic='(a+b+c+d+e+f+g+h)*(i+j+k)*(l)';

% NEW 6/8+
template_name='pu35wh17ab1_v2_10'; 
cntrng_values{1}={[2 4 1.8] 'or' 'n' 'n'};
cntrng_values{2}={[2 4 1.8] 'or' 'n' 'n'};
cntrng_values{3}={[2 4 1.8] 'or' 'n' 'n'};
cntrng_values{4}={[2 4 1.8] 'or' 'n' 'n'};
cntrng_values{5}={[2 4 1.5] 'or' 'n' 'n'};

cntrng_values{6}={[4 10 1.4] 'or' 'n' 'y'};
cntrng_values{7}={[4 10 1.4] 'or' 'n' 'y'};
cntrng_values{8}={[4 10 1.4] 'or' 'n' 'y'};
cntrng_values{9}={[4 10 1.4] 'or' 'n' 'y'};

cntrng_values{10}={[5 27 1.4] 'or' 'y' 'y'};

col_logic='(a+b+c+d+e)*(f+g+h+i)*(j)';



check_stuff=lt_check_hit_templ_freq_FUNCTION(batchf, syl, syl_pre, syl_post, syl_refract, freq_range, ...
    evtaf_ver,get_WN_hits,get_offline_match,get_FF,template_name,cntrng_values,col_logic);


% === USING CONFIG FILE

batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'a';
syl_post = '';
% config= '/bluejay4/lucas/birds/pu35wh17/060415_SeqDepPitch_durWN_day1/config.evconfig2';
config='/bluejay4/lucas/birds/pu35wh17/060815_SeqDepPitch_durWN_day5/config2.evconfig2'; % 6/8 +
% config='/bluejay4/lucas/birds/pu35wh17/config_061115.evconfig2'; % 6/8 +
NoteNum = 0; 

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);


%% CHECKING HIT RATE AND FF OFFLINE - QUICK NO LABEL

Params.batch='batch.rand.keep';
Params.config='/bluejay4/lucas/birds/pu35wh17/060415_SeqDepPitch_durWN_day1/config.evconfig2'; 
Params.NoteNum_to_plot=0;

[AllSongsData_toplot, AllData]=lt_check_hit_templ_freq_NoLabelRequired(Params);


%% ==================== ANALYSIS ALL DAYS

%% TO DO OVER ALL DAYS
clear all; close all
phrase = 'SeqDepPitch';
first_day= '04Jun2015';
last_day= '14Jun2015';
% first_day= '01Jun2015';
% last_day= '01Jun2015';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.catch';
Params.DayRawDat.syllables={'a','b'};
Params.DayRawDat.frequency_range={[1400 2400], [2700 3800]};
Params.DayRawDat.pc_dur=[0.12,0.11];

Params.DayRawDat.pc_time_window={[350 470],[65 200]};
Params.DayRawDat.pc_sigma=1;

plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);



%% SEQ FILTER AND COMPILE
clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=5500;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

% OLD, dividing
% Params.SeqFilter.SeqPreList={'jj','jjb','jjbb','aj','ajb','ajbb','ja','jab','jabb','bj','bjb','bjbb','',''}; % To skip seq filter, keep blank. (i.e. {})
% Params.SeqFilter.SylTargList={'b','b','b','b','b','b','b','b','b','b','b','b','a','a'};
% Params.SeqFilter.SeqPostList={'','','','','','','','','','','','','j','b'};
Params.SeqFilter.SeqPreList={'j','jb','jbb','a','ab','abb','',''}; % To skip seq filter, keep blank. (i.e. {})
Params.SeqFilter.SylTargList={'b','b','b','b','b','b','a','a'};
Params.SeqFilter.SeqPostList={'','','','','','','j','b'};


% 2) experiment info
Params.SeqFilter.WNTimeON='04Jun2015-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '14Jun2015-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:5;


Params.SeqFilter.SylLists.FieldsInOrder{1}={'Ab','aB','abB','abbB'};
Params.SeqFilter.SylLists.FieldsInOrder{2}={'jB','jbB','jbbB'};
% Params.SeqFilter.SylLists.FieldsInOrder{1}={'Aj','ajB', 'ajbB', 'ajbbB'};
% Params.SeqFilter.SylLists.FieldsInOrder{4}={'jjB', 'jjbB', 'jjbbB'};

Params.SeqFilter.SylLists.TargetSyls={'aB'};
Params.SeqFilter.SylLists.SylsSame={'abB','abbB', 'jB','jbB','jbbB'};
Params.SeqFilter.SylLists.SylsDifferent={'Ab'};

Params.SeqFilter.SylLists.FieldsToPlot{1}=[Params.SeqFilter.SylLists.TargetSyls Params.SeqFilter.SylLists.SylsSame];
Params.SeqFilter.SylLists.FieldsToPlot{2}=Params.SeqFilter.SylLists.SylsDifferent;

% Params.SeqFilter.DaysForSnapshot{1}={'09Dec2014','11Dec2014'};
% Params.SeqFilter.DaysToMark= {'11Dec2014-2400'}; % will mark all plots with lines here;

% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);


%% 4) PLOT LEARNING
% params
Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;


[Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);
close all
