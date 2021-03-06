%% TO DO OVER ALL DAYS [all syls]
clear all; close all
phrase = 'SeqDepPitchShift2';
first_day= '17Nov2014';
last_day= '22Nov2014';
Params.DayRawDat.batch='batch.labeled.all';

save_results=0;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.syllables={'a','q','b','c', 'd','h','g'};

Params.DayRawDat.frequency_range={[1485 1900], [1550 2160], [2450 3900],[2000 2850], [1600 2750], [2160 2490], [2470 2850]};
Params.DayRawDat.pc_dur=[0.12,0.12,0.11,0.12, 0.12, 0.125 , 0.25];
Params.DayRawDat.pc_time_window={[355 430],[240 305], [60 195],[60 375], [35 215], [135 290], [130 200]};
Params.DayRawDat.pc_sigma=1;

% OLD
% Params.DayRawDat.frequency_range={[1300 2100], [1400 2200], [2450 3900],[2000 2850], [1450 2900], [2000 2600], [2350 3150]};
% Params.DayRawDat.pc_dur=[0.12,0.12,0.11,0.12, 0.12, 0.125 , 0.25];
% Params.DayRawDat.pc_time_window={[360 470],[240 305], [55 210],[60 375], [35 215], [135 290], [100 210]};


plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);

%% TO DO OVER ALL DAYS
% clear all; close all
% phrase = 'SeqDepPitchShift2';
% first_day= '19Nov2014';
% last_day= '22Nov2014';
% Params.DayRawDat.batch='batch.labeled.all';
% 
% save_results=0;
% 
% % functions to run (SAME FOR ALL MOTIFS)
% FcnAll={'seq_dep_pitch_2'};
% 
% % Parameters for functions within
% Params.DayRawDat.fs=32000;
% Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
% Params.DayRawDat.syllables={'a','q','b','c'};
% Params.DayRawDat.frequency_range={[1300 2100], [1400 2200], [2450 3900],[2000 2850]};
% Params.DayRawDat.pc_dur=[0.12,0.12,0.11,0.12];
% 
% Params.DayRawDat.pc_time_window={[360 470],[230 295], [55 210],[60 375]};
% Params.DayRawDat.pc_sigma=1;
% 
% 
% plotON=0;
% saveON=1;
% 
% WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};
% 
% [filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);

%% SEQ FILTER/ COMPILE
clear all; close all;
% 0) keep?
Params.SeqFilter.AmplThr=8000;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

Params.SeqFilter.SeqPreList={'','','a','a','ab','abb','qcc','qccb','bcc','bccb','q','qc','b','bc','bbb','bccbb','qccbb','',''};
Params.SeqFilter.SylTargList={'a','a','b','b','b','b','b','b','b','b','c','c','c','c','g','g','g','q','q'};
Params.SeqFilter.SeqPostList={'bb','bc','c','b','','','','','','','','','','','','','','c','d'};


% 2) experiment info
Params.SeqFilter.WNTimeON='23Nov2014-0000'; % Time WN turned on
Params.SeqFilter.WNTimeOFF= '27Nov2014-2400'; % Time WN turned off ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:5;

Params.SeqFilter.SylLists.FieldsInOrder{1}={'Abb','aBb','abB','abbB','bbbG'};
Params.SeqFilter.SylLists.FieldsInOrder{2}={'Qc','qC','qcC','qccB','qccbB','qccbbG'};
Params.SeqFilter.SylLists.FieldsInOrder{3}={'Abc','aBc','bC','bcC','bccB','bccbB','bccbbG'};
Params.SeqFilter.SylLists.FieldsInOrder{4}={'Qd','d','h'};

% Params.SeqFilter.SylLists.FieldsToPlot{1}={'aBc','qccB','qccbB','bccB','bccbB','aBb','abB','abbB'};
% Params.SeqFilter.SylLists.FieldsToPlot{2}={'Abc','Abb','q','qC','qcC','bC','bcC'};

Params.SeqFilter.SylLists.TargetSyls={'abB'};
Params.SeqFilter.SylLists.SylsSame={'aBc','aBb','qccB','qccbB','bccbB','bccB','abbB'};
Params.SeqFilter.SylLists.SylsDifferent={'Abc','Abb','qC','qcC','bC','bcC','bbbG','qccbbG','bccbbG','Qc','Qd','d','h'};


% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);


%% PLOT
close all;
Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;


[Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);




%% 5/1/15 - reanalyzing, but throwing out motif qccbb (i.e. because both qccbb and abccbb are getting hit, I don't double count data)
% clear all; close all;
% % 0) keep?
% Params.SeqFilter.AmplThr=8000;
% 
% % 1) Seq filter and remove outliers and compile into one struct
% Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
% Params.SeqFilter.FirstDay='';
% Params.SeqFilter.LastDay='';
% 
% Params.SeqFilter.SeqPreList={'','','a','a','ab','abb','bcc','bccb','b','bc'};
% Params.SeqFilter.SylTargList={'a','a','b','b','b','b','b','b','c','c'};
% Params.SeqFilter.SeqPostList={'bb','bc','c','b','','','','','',''};
% 
% 
% % 2) experiment info
% Params.SeqFilter.WNTimeON='30Oct2014-0000'; % Time WN turned on
% Params.SeqFilter.WNTimeOFF= '06Nov2014-2400'; % Time WN turned off ( use 0000 and 2400 if only plotting days)
% Params.SeqFilter.BaselineDays=1:4;
% 
% Params.SeqFilter.SylLists.FieldsToPlot{1}={'aBc','bccB','bccbB','aBb','abB','abbB'};
% Params.SeqFilter.SylLists.FieldsToPlot{2}={'Abc','Abb','bC','bcC'};
% Params.SeqFilter.SylLists.FieldsInOrder{1}={'Abb','aBb','abB','abbB'};
% Params.SeqFilter.SylLists.FieldsInOrder{2}={'Abc','aBc','bC','bcC','bccB','bccbB'};
% 
% 
% Params.SeqFilter.SylLists.TargetSyls={'bccB'};
% Params.SeqFilter.SylLists.SylsSame={'aBc','aBb','bccbB','abB','abbB'};
% Params.SeqFilter.SylLists.SylsDifferent={'Abc','Abb','bC','bcC'};
% 
% 
% % 3) RUN
% plotON=0;
% [Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);
% 
% 
% 
% %% 2/6/15 - using new method to extract and analyze data
% 
% %% 1) Gather raw data for this day
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
% 
% 
% 
% %% TO DO OVER ALL DAYS
% clear all; close all
% phrase = 'SeqDepPitchShift';
% first_day= '26Oct2014';
% last_day= '29Oct2014';
% % first_day= '19Nov2014';
% % last_day= '22Nov2014';
% save_results=0;
% 
% % functions to run (SAME FOR ALL MOTIFS)
% FcnAll={'seq_dep_pitch_2'};
% 
% % Parameters for functions within
% Params.DayRawDat.fs=32000;
% Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
% Params.DayRawDat.batch='batch.labeled.all';
% Params.DayRawDat.syllables={'a','q','b','c'};
% Params.DayRawDat.frequency_range={[1300 2100], [1400 2200], [2450 3900],[2000 2850]};
% Params.DayRawDat.pc_dur=[0.12,0.12,0.11,0.12];
% 
% Params.DayRawDat.pc_time_window={[435 518],[212 278],[50 220],[55 375]};
% Params.DayRawDat.pc_sigma=1;
% 
% 
% plotON=0;
% saveON=1;
% 
% WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};
% 
% [filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);
% 
% 
% 
% %% 2) Seq filter, remove outliers, and compile raw data, and enter experiment info into params
% 
% 
% 
% clear all; close all;
% 
% % 0) keep?
% Params.SeqFilter.AmplThr=8000;
% 
% % 1) Seq filter and remove outliers and compile into one struct
% Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
% Params.SeqFilter.FirstDay='';
% Params.SeqFilter.LastDay='';
% 
% Params.SeqFilter.SeqPreList={'','','a','a','ab','abb','qcc','qccb','bcc','bccb','q','qc','b','bc'};
% Params.SeqFilter.SylTargList={'a','a','b','b','b','b','b','b','b','b','c','c','c','c'};
% Params.SeqFilter.SeqPostList={'bb','bc','c','b','','','','','','','','','',''};
% 
% 
% % 2) experiment info
% Params.SeqFilter.WNTimeON='30Oct2014-0000'; % Time WN turned on
% Params.SeqFilter.WNTimeOFF= '06Nov2014-2400'; % Time WN turned off ( use 0000 and 2400 if only plotting days)
% Params.SeqFilter.BaselineDays=1:4;
% 
% Params.SeqFilter.SylLists.FieldsToPlot{1}={'aBc','qccB','qccbB','bccB','bccbB','aBb','abB','abbB'};
% Params.SeqFilter.SylLists.FieldsToPlot{2}={'Abc','Abb','q','qC','qcC','bC','bcC'};
% Params.SeqFilter.SylLists.FieldsInOrder{1}={'Abb','aBb','abB','abbB'};
% Params.SeqFilter.SylLists.FieldsInOrder{2}={'q','qC','qcC','qccB','qccbB'};
% Params.SeqFilter.SylLists.FieldsInOrder{3}={'Abc','aBc','bC','bcC','bccB','bccbB'};
% 
% 
% Params.SeqFilter.SylLists.TargetSyls={'qccB','bccB'};
% Params.SeqFilter.SylLists.SylsSame={'aBc','aBb','qccbB','bccbB','abB','abbB'};
% Params.SeqFilter.SylLists.SylsDifferent={'Abc','Abb','q','qC','qcC','bC','bcC'};
% 
% 
% % 3) RUN
% plotON=0;
% [Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);
% 
% 
% %% 3) Perform various analyses on that data structure
% 
% Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
% Params.PlotLearning.DayBinSize=3; % 3 day running avg.
% saveON=1;
% 
% 
% [Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);
% 
% 
% 
% %% 3) Extract structure statistics
% 
% 
% % to extract data
% [Params, AllDays_StructStatsStruct]=lt_seq_dep_pitch_StructureStats(Params, AllDays_RawDatStruct);
% 
% % to process data
% [Params, AllDays_StructStatsStruct]=lt_seq_dep_pitch_StructureStats_SylSimilarity(Params, AllDays_StructStatsStruct);
% 
% 
% %% 4) to plot and perform PCA on syl structure
% Params.PCA.epoch='baseline'; % will look at baseline
% % Params.PCA.epoch=[21 24]; % days 21 to 24
% 
% [Params, PCA_Struct]=lt_seq_dep_pitch_StructureStats_featurePCA(Params, AllDays_StructStatsStruct,1);
% 
% 
% 

