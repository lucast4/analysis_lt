%% 4/12/15 - ANALYSIS ALL DAYS

% ------- COLLECT RAW DAT
clear all; close all

% baseline
phrase = 'SyntaxDepPitchShift_cbUp';
first_day= '28Jul2014';
last_day= '13Aug2014';

save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.catch.keep';
Params.DayRawDat.syllables={'a','b','c'};
Params.DayRawDat.frequency_range={[1050 2200], [2750 4150],[2250 2800]};
Params.DayRawDat.pc_dur=[0.125,0.115,0.125];

Params.DayRawDat.pc_time_window={[305 425],[60 200],[60 400]};
Params.DayRawDat.pc_sigma=1.5;


plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);


% --------- SEQ FILTER 
clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=3200;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

Params.SeqFilter.SeqPreList={'','','a','ab','abb','c','cb','a','ac'};
Params.SeqFilter.SylTargList={'a','a','b','b','b','b','b','c','c'};
Params.SeqFilter.SeqPostList={'b','c','','','','','','',''};


% 2) experiment info
Params.SeqFilter.WNTimeON='01Aug2014-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '06Aug2014-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:4;

Params.SeqFilter.SylLists.FieldsToPlot{1}={'cB','cbB','aB','abB','abbB'};
Params.SeqFilter.SylLists.FieldsToPlot{2}={'Ab','Ac','aC','acC'};
Params.SeqFilter.SylLists.FieldsInOrder{1}={'Ab','aB','abB','abbB'};
Params.SeqFilter.SylLists.FieldsInOrder{2}={'Ac','aC','acC','cB','cbB'};
Params.SeqFilter.SylLists.TargetSyls={'cB'};
Params.SeqFilter.SylLists.SylsSame={'cbB','aB','abB','abbB'};
Params.SeqFilter.SylLists.SylsDifferent={'Ab','Ac','aC','acC'};

% Params.SeqFilter.DaysForSnapshot{1}={'09Dec2014','11Dec2014'};
% Params.SeqFilter.DaysToMark= {'11Dec2014-2400'}; % will mark all plots with lines here;

% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);


% ---- PLOT LEARNING
Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;

[Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);
close all;

% % ----- STRUCTURE STATS

% to extract data
[Params, AllDays_StructStatsStruct]=lt_seq_dep_pitch_StructureStats(Params, AllDays_RawDatStruct);

% to plot and perform PCA on syl structure
Params.PCA.epoch='baseline'; % will look at baseline
% Params.PCA.epoch=[21 24]; % days 21 to 24

[Params, PCA_Struct]=lt_seq_dep_pitch_StructureStats_featurePCA(Params, AllDays_StructStatsStruct,1);

lt_seq_dep_pitch_Correlations(Params, AllDays_StructStatsStruct)


%% NOTE: OLD ANALYSIS IS IN pu53wh88_analysis_SyntaxDepPitchShift_abDowncbUp (name was changed from without suffix). old analysis methods are obsolete
