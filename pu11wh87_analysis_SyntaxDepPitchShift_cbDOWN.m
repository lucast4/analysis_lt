%% 5/1 - reanalyzed starting, doing seq compile - consoldating motifs, because my target was actually hitting both.
% will only analyze abbccbb (will throw out dccbb);

% seqfilter
clear all; close all;
Params.SeqFilter.AmplThr=3000;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';


Params.SeqFilter.SeqPreList={'a','ab','bcc','bccb','b','bc'};
Params.SeqFilter.SylTargList={'b','b','b','b','c','c'};
Params.SeqFilter.SeqPostList={'','','','','',''};


% 2) experiment info
Params.SeqFilter.WNTimeON='24Jul2014-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '03Aug2014-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:4;

Params.SeqFilter.SylLists.FieldsInOrder{1}={'a','aB','abB','bC','bcC','bccB','bccbB'};
Params.SeqFilter.SylLists.FieldsInOrder{2}={'d'};

Params.SeqFilter.SylLists.TargetSyls={'bccB'};
Params.SeqFilter.SylLists.SylsSame={'aB','abB','bccbB'};
Params.SeqFilter.SylLists.SylsDifferent={'a','bC','bcC', 'd'}; % NOTE: should add "d"

Params.SeqFilter.SylLists.FieldsToPlot{1}=Params.SeqFilter.SylLists.SylsSame;
Params.SeqFilter.SylLists.FieldsToPlot{2}=Params.SeqFilter.SylLists.SylsDifferent;

% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);Params.SeqFilter.AmplThr=2200;


%% 4/27/15 - Copied relevant (latest) parts from SyntaxDepPitchShift (which was actaully abUP). 



%% 4/27/15 - ANALYSIS ALL DAYS 
% -- TO DO OVER ALL DAYS
clear all; close all
phrase = 'SyntaxDepPitchShift_cbDOWN';
first_day= '18Jul2014';
last_day= '23Jul2014'; 
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.catch.keep';
Params.DayRawDat.syllables={'a','b','c','d'};
Params.DayRawDat.frequency_range={[1300 2200], [2800 3950],[2150 3150],[1200 3000]};
Params.DayRawDat.pc_dur=[0.135,0.117,0.127,0.1];

Params.DayRawDat.pc_time_window={[365 490],[60 220],[55 320],[30 145]};
Params.DayRawDat.pc_sigma=1;


plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);

% ====================== [ REMOVED BELOW, don't do both abbccbb and dccbb -
% see above for updated code.]
% -- 2) Seq filter, remove outliers, and compile raw data, and enter experiment info into params
% 0) keep? 
% clear all; close all;
% Params.SeqFilter.AmplThr=3000;
% 
% % 1) Seq filter and remove outliers and compile into one struct
% Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
% Params.SeqFilter.FirstDay='';
% Params.SeqFilter.LastDay='';
% 
% Params.SeqFilter.SeqPreList={'a','ab','bcc','bccb','dcc','dccb','b','bc','d','dc'};
% Params.SeqFilter.SylTargList={'b','b','b','b','b','b','c','c','c','c'};
% Params.SeqFilter.SeqPostList={'','','','','','','','','','','',''};
% 
% 
% % 2) experiment info
% Params.SeqFilter.WNTimeON='24Jul2014-0000'; % Time WN turned on (1st WN day)
% Params.SeqFilter.WNTimeOFF= '03Aug2014-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
% Params.SeqFilter.BaselineDays=1:4;
% 
% Params.SeqFilter.SylLists.FieldsToPlot{1}={'aB','abB','bccB','bccbB','dccB','dccbB'};
% Params.SeqFilter.SylLists.FieldsToPlot{2}={'d','bC','bcC','dC','dcC'};
% Params.SeqFilter.SylLists.FieldsInOrder{1}={'a','aB','abB','bC','bcC','bccB','bccbB'};
% Params.SeqFilter.SylLists.FieldsInOrder{2}={'d','dC','dcC','dccB','dccbB'};
% 
% Params.SeqFilter.SylLists.TargetSyls={'bccB'};
% Params.SeqFilter.SylLists.SylsSame={'aB','abB','bccbB','dccbB'};
% Params.SeqFilter.SylLists.SylsDifferent={'a','d','bC','bcC','dC','dcC'};
% 
% % 3) RUN
% plotON=0;
% [Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);Params.SeqFilter.AmplThr=2200;


%% -- 3) Perform various analyses on that data structure
close all;
Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;


[Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);


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


