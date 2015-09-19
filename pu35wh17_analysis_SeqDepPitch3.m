%% CHECK TEMPLATE MATCHING
% === USING CONFIG FILE
% ========================== b3
clear all; close all;
batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'abb';
syl_post = '';
% config='/bluejay4/lucas/birds/pu35wh17/config_070815.evconfig2';
% config='/bluejay4/lucas/birds/pu35wh17/config_070815_2.evconfig2';
% config='/bluejay4/lucas/birds/pu35wh17/config_070815_3.evconfig2';
% config='/bluejay4/lucas/birds/pu35wh17/config_070815_4.evconfig2';
% config='/bluejay4/lucas/birds/pu35wh17/070915_SeqDepPitch3_durWN_day1/config.evconfig2';
config='/bluejay4/lucas/birds/pu35wh17/config_071015.evconfig2';
NoteNum = 0; 

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);


% ==== CHECKING, TEMPLATE TARGETING ALL b3 (after both j and a)
clear all; close all;
batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'abb';
syl_post = '';
config='/bluejay4/lucas/birds/pu35wh17/config_071415_allb3_2.evconfig2';

NoteNum = 0; 

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);


%% CHECKING HIT RATE AND FF OFFLINE - QUICK NO LABEL
clear all; close all
Params.batch='batch.rand.keep';
Params.config='/bluejay4/lucas/birds/pu35wh17/config_071415_allb3_2.evconfig2'; 
Params.NoteNum_to_plot=0;

[AllSongsData_toplot, AllData]=lt_check_hit_templ_freq_NoLabelRequired(Params);


%% ==================== ANALYSIS ALL DAYS

%% TO DO OVER ALL DAYS
% ---- BASELINE
clear all; close all
phrase = 'SeqDepPitch3';
first_day= '06Jul2015';
last_day= '08Jul2015';
% first_day= '01Jun2015';
% last_day= '01Jun2015';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.all';
Params.DayRawDat.syllables={'a','b'};
Params.DayRawDat.frequency_range={[1400 2400], [2700 3800]};
Params.DayRawDat.pc_dur=[0.12,0.11];

Params.DayRawDat.pc_time_window={[350 470],[65 200]};
Params.DayRawDat.pc_sigma=1;

plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);

% ---- DUR WN
clear all; close all
phrase = 'SeqDepPitch3';
first_day= '09Jul2015';
last_day= '19Jul2015';
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
cd seq_dep_pitch_SeqDepPitch3
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
Params.SeqFilter.WNTimeON='09Jul2015-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '19Jul2015-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:3;

Params.SeqFilter.SylLists.FieldsInOrder{1}={'Ab','aB','abB','abbB'};
Params.SeqFilter.SylLists.FieldsInOrder{2}={'jB','jbB','jbbB'};
% Params.SeqFilter.SylLists.FieldsInOrder{1}={'Aj','ajB', 'ajbB', 'ajbbB'};
% Params.SeqFilter.SylLists.FieldsInOrder{4}={'jjB', 'jjbB', 'jjbbB'};

Params.SeqFilter.SylLists.TargetSyls={'abbB'};
Params.SeqFilter.SylLists.SylsSame={'aB','abB', 'jB','jbB','jbbB'};
Params.SeqFilter.SylLists.SylsDifferent={ 'Ab'};

Params.SeqFilter.SylLists.FieldsToPlot{1}=[Params.SeqFilter.SylLists.TargetSyls Params.SeqFilter.SylLists.SylsSame];
Params.SeqFilter.SylLists.FieldsToPlot{2}=Params.SeqFilter.SylLists.SylsDifferent;

Params.SeqFilter.DaysForSnapshot{1}={'12Jul2015','14Jul2015'};
Params.SeqFilter.DaysToMark= {'14Jul2015-2400'}; % will mark all plots with lines here;

% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);


%% 4) PLOT LEARNING

% params
Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;


[Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);

