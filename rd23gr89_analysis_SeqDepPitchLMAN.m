%% 1) Gather raw data for this day
clear all; close all;

Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.all';

Params.DayRawDat.syllables={'n','a','h','k','d','b','g','c'};
Params.DayRawDat.frequency_range={[1750 1950], [1200 2250], [900 1600], [700 2800], [900 2300], [3000 4000], [1100 1700], [2250 3150]};
Params.DayRawDat.pc_dur=[0.1, 0.11, 0.12, 0.09, 0.11, 0.11, 0.16, 0.12];
Params.DayRawDat.pc_time_window={[30 345], [270 395], [40 280], [15 230], [190 318], [40 161], [130 380], [140 370]};

Params.DayRawDat.pc_sigma=1;

% plot and save?
plotON=1;
saveON=1;

% Related to LMAN inactivation
plotLMANinact=1;
Params.DayRawDat.Musc_On_Time='1052'; % time given muscimol - will plot data with temporal lag after this.
Params.DayRawDat.Musc_Off_Time='1631';

[Params, RawDatStruct]=lt_seq_dep_pitch_DayRawDat(Params,1,1,'',plotLMANinact);



%% 6/2/15 - Hitting of b2 (modified config from CtxtDepPitch)

% batchf= 'batch.labeled.all';
% get_WN_hits=1;
% get_offline_match=1; % do offline matching using template? (ADDX=1)
% get_FF=1; % Analyze FF using offline matching?
% syl = 'b';
% syl_pre = 'b';
% syl_post = '';
% 
% config='/bluejay4/lucas/birds/rd23gr89/060315_SeqDepPitch_durWN_day1/config.evconfig2'; % SeqDepPitch (good with no FP)
% config='/bluejay4/lucas/birds/rd23gr89/config_061115.evconfig2'; % SeqDepPitch (good with no FP)
% 
% % note 0 and 1 are c2, note 2 and 3 are b2
% NoteNum = 2;
% 
% check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);
% 
% 
% 
% %% === EXTRACT DATA FOR ONE DAY (WITHOUT LABELING, USING EVTAFSIM)
% 
% % -- SINGLE DAY DATA EXTRACTION
% % 1) what batch and config file to use to run evtafsim.  if needed, make a batch.
% Params.batch='batch.rand.keep';
% Params.batch='batch.rec_FB';
% Params.config='/bluejay4/lucas/birds/rd23gr89/060315_SeqDepPitch_durWN_day1/config.evconfig2'; 
% Params.config='/bluejay4/lucas/birds/rd23gr89/config_061115.evconfig2'; % SeqDepPitch (good with no FP)
% Params.NoteNum_to_plot=2;
% 
% [AllSongsData_toplot, AllData]=lt_check_hit_templ_freq_NoLabelRequired(Params);
% 



%% ==== ANALYSIS ALL DAYS
% clear all; close all
% phrase = 'SeqDepPitch';
% first_day= '09Sep2015';
% last_day= '14Jun2015';
% save_results=1;
% 
% % functions to run (SAME FOR ALL MOTIFS)
% FcnAll={'seq_dep_pitch_2'};
% 
% % Parameters for functions within
% Params.DayRawDat.fs=32000;
% Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
% Params.DayRawDat.batch='batch.labeled.all';
% Params.DayRawDat.syllables={'n','a','h','k','d','b','g','c'};
% Params.DayRawDat.frequency_range={[1750 1950], [1550 2250], [900 1600], [900 2850], [1100 2400], [3000 4000], [1100 1700], [2250 3150]};
% Params.DayRawDat.pc_dur=[0.1, 0.11, 0.12, 0.09, 0.11, 0.11, 0.16, 0.12];
% Params.DayRawDat.pc_time_window={[30 345], [165 276], [10 145], [15 230], [105 275], [26 150], [130 380], [185 560]};
% Params.DayRawDat.pc_sigma=1;
% 
% 
% plotON=0;
% saveON=1;
% 
% WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};
% 
% [filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);


%% Seq compile - NOTE, redo to compress 
% clear all; close all;
% 
% % 0) keep?
% Params.SeqFilter.AmplThr=11500;
% 
% % 1) Seq filter and remove outliers and compile into one struct
% Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
% Params.SeqFilter.FirstDay='';
% Params.SeqFilter.LastDay='';
% 
% Params.SeqFilter.SeqPreList={'','','d','db','c'}; % To skip seq filter, keep blank. (i.e. {})
% Params.SeqFilter.SylTargList={'a','a','b','b','b'};
% Params.SeqFilter.SeqPostList={'h','k','','',''};
% 
% 
% % 2) experiment info
% Params.SeqFilter.WNTimeON='03Jun2015-0000'; % Time WN turned on (1st WN day)
% Params.SeqFilter.WNTimeOFF= '14Jun2015-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
% Params.SeqFilter.BaselineDays=1:3;
% 
% Params.SeqFilter.SylLists.FieldsInOrder{1}={'Ah','h'};
% % Params.SeqFilter.SylLists.FieldsInOrder{2}={'Ak','k'};
% Params.SeqFilter.SylLists.FieldsInOrder{2}={'d','dB','dbB','g','c','cB'};
% 
% % Params.SeqFilter.SylLists.FieldsInOrder{3}={'Dbbj','dBbj','bBj'};
% % Params.SeqFilter.SylLists.FieldsInOrder{4}={'Dbbg','dBbg','bBg','g','c','cB'};
% 
% Params.SeqFilter.SylLists.TargetSyls={'dbB'};
% Params.SeqFilter.SylLists.SylsSame={'dB','cB'};
% Params.SeqFilter.SylLists.SylsDifferent={'d','Ah','h','g','c'};
% 
% Params.SeqFilter.SylLists.FieldsToPlot{1}=[Params.SeqFilter.SylLists.TargetSyls Params.SeqFilter.SylLists.SylsSame];
% Params.SeqFilter.SylLists.FieldsToPlot{2}=Params.SeqFilter.SylLists.SylsDifferent;
% 
% % 3) RUN
% plotON=0;
% [Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);
% 
% 
% %% == PLOT
% % params
% Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
% Params.PlotLearning.DayBinSize=3; % 3 day running avg.
% saveON=1;
% 
% 
% [Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);
% close all
