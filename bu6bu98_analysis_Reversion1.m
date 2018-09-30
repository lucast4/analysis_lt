%%  NO LABEL REQUIRED - USED FOR ANALYSIS OF LEARNING SCREENING
% close all;
% 
% Params.batch='batch';
% Params.config='/bluejay5/lucas/birds/or60/config.evconfig2';
% Params.NoteNum_to_plot=0; % for the note you want to analyze
% [AllSongsData_toplot, AllData] = lt_check_hit_templ_freq_NoLabelRequired(Params);


%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% Reversion1

%% CHECKING TEMPLATE MATCHING;

clear all; close all;
batchf='batch.labeled.all';
% config='/bluejay5/lucas/birds/bu6bu98/config092718.evconfig2';
% config='/bluejay5/lucas/birds/bu6bu98/config092718_v2.evconfig2';
% config='/bluejay5/lucas/birds/bu6bu98/config092718_3.evconfig2';
config='/bluejay5/lucas/birds/bu6bu98/config092718_good.evconfig2';
config='/bluejay5/lucas/birds/bu6bu98/config092918.evconfig2';

% === Note 0 (LASER on d)
syl='d';
syl_pre='dd';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=0;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% === Note 1 (WN on d(b))
syl='b';
syl_pre='d';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


% === Note 2 (WN on db(h))
syl='h';
syl_pre='db';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=2;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


% === Note 3 (LASER on (c)c);
syl='c';
syl_pre='g';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=0;
NoteNum=3;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


% ==========OTHERS NOT BEING USED
% === Note (WN on c(b) [note 1 is cb, note 2 is cb(h))
config='/bluejay5/lucas/birds/bu6bu98/config092718_v2.evconfig2';
syl='c';
syl_pre='d';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=0;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


%
%% ====== ALIGNING STIM TO SONG
%% ====== ALIGNING STIM TO SONG
close all;
batchf = 'batch.rec_FB'; % either .cbin file or batch
% songf = batchf; % either .cbin file or batch
lasernote = 1;

annotate_note_group = 1;

lt_batchsong_plotallchans(batchf, lasernote, annotate_note_group);


%% ====================== ANALYSIS
% clear Params
% clear StatsStruct
% 
%     Params.batch='batch.labeled.all';
%     Params.ExptID='Stim'; % an identifier for the data in this batch file. leave as '' to use 'All' as default. ('Stim' is for stim epochs).
%     Params.DataInfo='UnDir'; % To note information about data, 'Dir' and 'UnDir' means this is directed or undirected song.
%     Params.Fs=32000;
% %         WHERE TO ALIGN SONGS
%     Params.SylTarg='b'; % aligns to onset of this
%     Params.PreNote='c';
%     
%     Params.PreDur=0.25; % sec, how much data to take before targ
%     Params.PostSylOnsetDur=0.15; % sec, data post to take
%     Params.TargNoteNum=0; % template note directed to target
%     Params.TargTrigCatchRate=0; % catch trial fraction at target
% 
% %         STIM
%     Params.notenum_stim=1; % of Stim - CONFIRMED THIS WORKS
%     Params.StimDelay=20; % in ms, delay from trigger to stim on
%     Params.StimDur=150; % duration of Stim, in ms
%     Params.StimType='pulse'; % either 'constant' or 'pulse'
%     
% %     	for pitch contour
%     Params.PC_freqrange=[3800 5200]; % for both pitch contour and find note
%     Params.pc_harms=1;
% 
% %     	To sort into stim vs. notstim trials
%     Params.StimLatencyWindow=[-250, 0]; % [a b] a and b are times (in negative ms) preceding syl onset. If stim is within this window, then will call a "stim trial."
% 
% 
% % RUN DATA EXTRACT --------------------------------------------
% 
% [DatStructCompiled, Params]=lt_Opto_Stim_analy_EXTRACTDATA_v2(Params);
% 
% 
% 
% %% PROCESS AND PLOT -
% close all;
% % For only a single type of trial then only enter one field
% % For 2 or more, will plot comaprisons, so enter all fields names
% % Params.FieldsToCheck{1}='COMBO_StimCatch_TargAllCatch';
% % Params.FieldsToCheck{2}='COMBO_StimNotCatch_TargAllCatch';
% % Params.FieldsToCheck{1}='StimCatch';
% % Params.FieldsToCheck{2}='StimNotCatch';
% % Params.FieldsToCheck{1}='NotStim';
% % Params.FieldsToCheck{2}='Stim';
% % Params.FieldsToCheck{1}='COMBO_StimCatch_TargAllCatch';
% % Params.FieldsToCheck{2}='COMBO_StimNotCatch_TargAllCatch';
% % Params.FieldsToCheck{1}='SIMULATE_Catch';
% % Params.FieldsToCheck{2}='SIMULATE_NotCatch';
% Params.FieldsToCheck{1}='All';
% % Params.FieldsToCheck{1}='COMBO_TargAllCatch';
% % Params.FieldsToCheck{1}='COMBO_TargAllCatch';
%  
% 
% % RUN
% [StatsStruct, Params]=lt_Opto_Stim_analy_PLOT_Compare2_v2(DatStructCompiled,Params);
% 
% 
% %% LOOK AT CERTAIN TIME WINDOW - EXTRACT AND PLOT AVERAGES
% % Must first run lt_Opto_Stim_analy_PLOT_Compare2 to extract PC data. enter
% % outputs from that into function here.
% close all
% 
% Params.TimeWindowList = {};
% 
% % NEW - targetting b2 with WN(2bins) (changed to this0
% Params.TimeWindowList{1}=[254 268]; % entire syl
% 
% Params.TimeWindowList{1}= [254 262]; % during WN
% 
%     for i=1:length(Params.TimeWindowList);
%         TimeWind = Params.TimeWindowList{i};
%         if ceil(Params.TimeWindowList{i})~=Params.TimeWindowList{i}; % means that there is fraction
%             Params.TimeField{i}=['Wind' num2str(floor(TimeWind(1))) 'fr_' num2str(floor(TimeWind(2))) 'frms']; % put "fr" at end to signify fraction
%         else
%         Params.TimeField{i}=['Wind' num2str(TimeWind(1)) '_' num2str(TimeWind(2)) 'ms'];
%         end
%     end
% 
%     % RUN
%     RunStats=1;
%     KeepOutliers=1; % for running stats and plotting.
% [StatsStruct, Params]=lt_Opto_Stim_analy_PLOT_TimeWindow_v2(StatsStruct, Params, RunStats, KeepOutliers);
% 
% % % DISPLAY SUMMARY STATS
% % lt_Opto_Stim_analy_PL
% 
% 
% 
% %% PLOT OVER TIME - to look at learning
% % Takes output from lt_Opto_Stim_analy_PLOT_TimeWindow and plots that over
% % time - scatter and running average;
% close all;
% Params.SmthBin=10; % smooth # rends
% KeepOutliers=1;
% 
% [StatsStruct,Params]=lt_Opto_Stim_analy_PLOT_TimeWindow_OverTime_v2(StatsStruct,Params,1,KeepOutliers);
% 
% 
% %% PERFORM STATISTICS on time window data 
% 
% KeepOutliers=1;
% [StatsStruct,Params]=lt_Opto_Stim_analy_PLOT_TimeWindow_Statistics_v2(StatsStruct,Params,KeepOutliers);
% 
% 
% 
% %% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% %% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% %% OPTO ANALY ACROSS DAYS
% %% EXCTRACTING DATA ACROSS DAYS
% % IMPORTANT: dirs must be structured as (for e.g.)
% % /bluejay4/lucas/birds/pk32/070115_Reversion1_preWN_STIMoff
% % (date_experiment_somethingelse_STIMoff[or STIMon]).
% 
% % ALSO: Stim epochs must be catch trials (because will use StimCatch and
% % StimNotCatch fields to filter data)
% 
% % WILL TAKE ALL LABELED SONGS
% 
% % RUN THIS IN BIRD FOLDER
% clear Params_metadata; clear Params_glob;
% close all;
% 
% % =======, to find directories
% Params_metadata.experiment='Reversion2'; % 1st underscore ...
% Params_metadata.condition='';
% Params_metadata.notes='';
% Params_metadata.date_range={'17Mar2017', '18Mar2017'};
% Params_metadata.only_labeled_dirs=1;
% 
% % ===== For opto analysis
% Params_glob.DataInfo='UnDir'; % To note information about data, 'Dir' and 'UnDir' means this is directed or undirected song.
% Params_glob.Fs=32000;
% 
% %         WHERE TO ALIGN SONGS
% Params_glob.SylTarg='b'; % aligns to onset of this
% Params_glob.PreNote='c';
% 
% Params_glob.PreDur=0.25; % sec, how much data to take before targ
% Params_glob.PostSylOnsetDur=0.5; % sec, data post to take
% Params_glob.TargNoteNum=0; % template note directed to target
% Params_glob.TargTrigCatchRate=0; % catch trial fraction at target
% 
% %         STIM
% Params_glob.notenum_stim=1; % of Stim - CONFIRMED THIS WORKS
% Params_glob.StimDelay=20; % in ms, delay from trigger to stim on
% Params_glob.StimDur=150; % duration of Stim, in ms
% Params_glob.StimType='const'; % either 'constant' or 'pulse'
% 
% %     	for pitch contour
% Params_glob.PC_freqrange=[4150 5100]; % for both pitch contour and find note
% Params_glob.pc_harms=1;
% 
% %     	To sort into stim vs. notstim trials
% Params_glob.StimLatencyWindow=[-250, 0]; % [a b] a and b are times (in negative ms) preceding syl onset. If stim is within this window, then will call a "stim trial."
% 
% % Time Window List
% % DURING WN (on window 3)
% Params_glob.TimeWindowList{1}=[254 262];
% 
% % Plotting over time
% Params_glob.SmthBin=15; % smooth # rends
% 
% % Do you want to delete old opto analysis folder if it exists?
% Params_glob.Delete_old_analysis_folder=1;
% 
% 
% % =============================== RUN
% KeepOutliers=1; % for running stats and plotting.
% lt_Opto_Stim_analy_SUMMARY_MultDayAnaly_v3(Params_metadata, Params_glob, KeepOutliers);
% 
% cd ../../
% 
% 
% %% ==================== PLOT ACROSS DAYS
% close all;
% clear all;
% 
% % ==== Params for analysis
% BirdDir='/bluejay5/lucas/birds/or60/';
% TimeFieldsOfInterest = 1; % i.e. time windows in pitch contour
% statfield='ffvals';
% BaselineDays=1;
% plotStimEpochs=0; % if 1, then separates all data to stim epochs (even if multiple in one day)
% ListOfDirs1={};
% ListOfDirs2={};
% 
% % ==== METHOD 2) METADATA automatically
% MetadataStruct=lt_metadata_collect;
% 
% experiment = 'Reversion2';
% condition='';
% notes='';
% date_range={'13Mar2017', '18Mar2017'};
% only_labeled_dirs=1;
% 
% ListOfDirs2=lt_metadata_find_dirs(MetadataStruct, experiment, condition, notes, date_range, only_labeled_dirs);
% 
% % get the correct subdir that contains opto stats
% c=1;
% for i=1:length(ListOfDirs2);
%     cd(ListOfDirs2{i});
%     
%     
%     tmp=[];
%     try
%         cd lt_Opto_Stim_analy_v2
%         try cd 'All';
%             tmp='All';
%         catch err
%             try cd 'Stim';
%                 tmp='Stim';
%             end
%         end
%     catch err
%         disp(['error - no lt_Opto_Stim_analy_v2 data on: ' ListOfDirs2{i} ' - throwing day out']);
%     cd(BirdDir);        
%         continue
%     end
%     
%     % go back up to main dir
%     cd(BirdDir);
%     
%     % modify name to add opto analysis name
%     ListOfDirs2_modified{c}=[ListOfDirs2{i} '/lt_Opto_Stim_analy_v2/' tmp];
%     c=c+1;
% end
% 
% 
% % ===== COMBINE DIRS
% ListOfDirs_all=[ListOfDirs1 ListOfDirs2_modified];
% 
% MetaParams.WNonDates = {'13Mar2017-2312-up', '15Mar2017-2300-dn', '18Mar2017-1432-up'}; % times when WN epochs began
% 
% 
% lt_Opto_Stim_analy_SUMMARY_PlotOverTime(BirdDir, ListOfDirs_all,TimeFieldsOfInterest, ...
%     statfield,BaselineDays,plotStimEpochs, MetaParams)
% 
% 
% 
% 
% 
% 
% 
% 
% %% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% %% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% %% AUTOLABEL
% 
% % batch = 'batch.keep.UNLABELED';
% batch = 'batch.rec_FB';
% config='/bluejay5/lucas/birds/or60/config022217.evconfig2';
% 
% syl.targ='b';
% syl.pre='dcc';
% syl.post=''; 
% NoteNum=0; 
% 
% ampThresh=47000;
% min_dur=30;
% min_int=4;
% 
% overwrite_notmat=1; % will always make backup folder
% 
% [fnames, sylnum, vlsorfn, vlsorind]=lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat);
% 
% 
% %% ============ 2) Use evsonganaly manually on the .wav file created above
% % (contains only the syls you chose)
% % INSTRUCTIONS: 
% % 1) open .wav file using evsonganaly
% % 2) change threshold to segment all syls indivudally
% % 3) any syl labeled "-" (default) will remain unchanged (i.e. will stay autolabeled). 
% %     give a new label to any mislabeled syl - that will be its new actual label
% evsonganaly
% 
% %% ============ 3) Replace hand-checekd mislabeld syls 
% lt_autolabel_FixHandCheckedSyls(fnames, sylnum, vlsorfn, vlsorind)
% 


%% ##################### METHOD 2 - MORE FLEXIBLE.

%% calc FF for all syls, save next to song file
clear all; close all;

ListOfDirs_ALL = {...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110117_RALMANlearn1'};

ListOfBatch = {...
    'BatchAll'};

FFparams.cell_of_freqwinds={'a', [1000 2600], 'g', [2000 3400], ...
    'h', [2900 3800], 'b', [2900 3800]}; % 'j', [950 1450], 'l', [1200 1600], 't', [3590 4960]
FFparams.cell_of_FFtimebins={'a', [0.068 0.078], 'g', [0.04 0.06], ...
    'h', [0.033 0.042], 'b', [0.033 0.04]}; % 'j', [0.04 0.045], 'l', [0.035 0.039], 't', [0.026 0.033], ...

plotAllPC = 0;
plotEachSyl = 0;
overwrite = 1;

% ==================== CALCULATE AND SAVE FF
lt_batchsong_calcFF(ListOfDirs_ALL, ListOfBatch, FFparams, plotAllPC, plotEachSyl, ...
    overwrite);

%% ==== EXTRACT FF
MotifsToExtract = {'(a)b', 'a(b)', 'j(b)', 'ab(h)', 'jb(h)',  'abh(h)', 'jbh(h)', '(g)'};
DATSTRUCT = lt_batchsong_extractFF(ListOfDirs_ALL, {}, ListOfBatch, MotifsToExtract);

%% ======= PLOT 
close all;
TrainON = '01Nov2017-1402';
SwitchTimes = {'01Nov2017-2045'};
subtractMean = 1;
dozscore = 1;

lt_batchsong_plotFF(DATSTRUCT, MotifsToExtract, TrainON, SwitchTimes, ...
    subtractMean, dozscore);
