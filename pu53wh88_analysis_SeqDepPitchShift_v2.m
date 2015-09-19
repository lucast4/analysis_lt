%% 2/5/15 - STARTED v2, this is analyzed and extracting song data a different way.

%% 1) TO GATHER RAW DATA for one day - PARAMS INCORRECT
% clear all; close all;
% 
% Params.DayRawDat.fs=32000;
% Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
% Params.DayRawDat.batch='batch.labeled.all.subset';
% Params.DayRawDat.syllables={'a','b','c'};
% Params.DayRawDat.frequency_range={[1300 2200], [2800 3950],[2150 3150]};
% % Params.DayRawDat.dat_dur;
% Params.DayRawDat.pc_dur=[0.12,0.09,0.11];
% Params.DayRawDat.pc_time_window={[375 525],[60 220],[55 320]};
% Params.DayRawDat.pc_sigma=1;
% 
% % plot and save?
% plotON=1;
% saveON=0;
% 
% [Params, RawDatStruct]=lt_seq_dep_pitch_DayRawDat(Params,1,1);
% 

%% TO DO OVER ALL DAYS
clear all; close all

% baseline
phrase = 'SeqDepPitchShift';
first_day= '24Oct2014';
last_day= '25Oct2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.all';
Params.DayRawDat.syllables={'a','b','c'};
Params.DayRawDat.frequency_range={[950 2100], [2550 4000],[2150 2950]};
Params.DayRawDat.pc_dur=[0.125,0.115,0.125];

Params.DayRawDat.pc_time_window={[305 425],[45 175],[60 385]};
Params.DayRawDat.pc_sigma=1;


plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);

% WN
clear all; close all

% baseline
phrase = 'SeqDepPitchShift';
first_day= '30Oct2014';
last_day= '11Nov2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.catch';
Params.DayRawDat.syllables={'a','b','c'};
Params.DayRawDat.frequency_range={[950 2100], [2550 4000],[2150 2950]};
Params.DayRawDat.pc_dur=[0.125,0.115,0.125];

Params.DayRawDat.pc_time_window={[305 425],[45 175],[60 385]};
Params.DayRawDat.pc_sigma=1;


plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);

% post
clear all; close all

% baseline
phrase = 'SeqDepPitchShift';
first_day= '12Nov2014';
last_day= '18Nov2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.all';
Params.DayRawDat.syllables={'a','b','c'};
Params.DayRawDat.frequency_range={[950 2100], [2550 4000],[2150 2950]};
Params.DayRawDat.pc_dur=[0.125,0.115,0.125];

Params.DayRawDat.pc_time_window={[305 425],[45 175],[60 385]};
Params.DayRawDat.pc_sigma=1;


plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);

%% 2) Seq filter, remove outliers, and compile raw data, and enter experiment info into params
cd seq_dep_pitch_SeqDepPitchShift/
clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=28000;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

Params.SeqFilter.SeqPreList={'','','a','ab','abb','c','cb','a','ac'};
Params.SeqFilter.SylTargList={'a','a','b','b','b','b','b','c','c'};
Params.SeqFilter.SeqPostList={'b','c','','','','','','',''};


% 2) experiment info
Params.SeqFilter.WNTimeON='30Oct2014-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '11Nov2014-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:5;

Params.SeqFilter.SylLists.FieldsToPlot{1}={'cB','cbB','aB','abB','abbB'};
Params.SeqFilter.SylLists.FieldsToPlot{2}={'Ab','Ac','aC','acC'};
Params.SeqFilter.SylLists.FieldsInOrder{1}={'Ab','aB','abB','abbB'};
Params.SeqFilter.SylLists.FieldsInOrder{2}={'Ac','aC','acC','cB','cbB'};
Params.SeqFilter.SylLists.TargetSyls={'aB'};
Params.SeqFilter.SylLists.SylsSame={'cB','cbB','abB','abbB'};
Params.SeqFilter.SylLists.SylsDifferent={'Ab','Ac','aC','acC'};

% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);



% -- PLOT LEARNING
Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;


[Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);
close all

%% 3) Extract structure statistics


% to extract data
[Params, AllDays_StructStatsStruct]=lt_seq_dep_pitch_StructureStats(Params, AllDays_RawDatStruct);
% to plot and perform PCA on syl structure
Params.PCA.epoch='baseline'; % will look at baseline
% Params.PCA.epoch=[21 24]; % days 21 to 24

[Params, PCA_Struct]=lt_seq_dep_pitch_StructureStats_featurePCA(Params, AllDays_StructStatsStruct,1);



%% 4) Look at correlations between syllables
% work in progress
DaysWanted=25:27; % either baseline (astring) or array
lt_seq_dep_pitch_Correlations(Params, AllDays_StructStatsStruct,DaysWanted)% to plot and perform PCA on syl structure




