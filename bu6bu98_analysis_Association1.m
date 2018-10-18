%%  NO LABEL REQUIRED - USED FOR ANALYSIS OF LEARNING SCREENING
% close all;
% 
% Params.batch='batch';
% Params.config='/bluejay5/lucas/birds/or60/config.evconfig2';
% Params.NoteNum_to_plot=0; % for the note you want to analyze
% [AllSongsData_toplot, AllData] = lt_check_hit_templ_freq_NoLabelRequired(Params);


%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 % ============ SEAPRATE BATCHES FOR EACH NOTE GROUP

lt_read_ltrec2




%% CHECKING TEMPLATE MATCHING [IGNORE NOTE GROUPS]

clear all; close all;
batchf='batch.labeled.all';
config='/bluejay5/lucas/birds/bu6bu98/config101218.evconfig2';
config='/bluejay5/lucas/birds/bu6bu98/config101518.evconfig2';
% config='/bluejay5/lucas/birds/bu6bu98/config_d_test.evconfig2';

% ################################## NOTEGROUP0

% === Note 0 (LASER on d)
syl='d';
syl_pre='d';
syl_post='d';
get_WN_hits=1;
get_offline_match=1;
get_FF=0;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% === Note 1 (WN on d(b)) [UP]
syl='b';
syl_pre='d';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


% === Note 2 (WN on d(b)) [DN]
syl='h';
syl_pre='db';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=2;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


%% CHECKING TEMPLATE MATCHING;

clear all; close all;
% batchf='batch.labeled.all';
lt_read_ltrec2;
config='/bluejay5/lucas/birds/bu6bu98/config101218.evconfig2';

% ################################## NOTEGROUP0
lt_sort_batch_by_labeled('batch.NoteGroup_0');
batchf = 'batch.NoteGroup_0.LABELED';

% === Note 0 (LASER on d)
syl='d';
syl_pre='dd';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=0;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% === Note 1 (WN on d(b)) [UP]
syl='b';
syl_pre='d';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


% === Note 2 (WN on d(b)) [DN]
syl='h';
syl_pre='db';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=2;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


% ################################## NOTEGROUP1
lt_sort_batch_by_labeled('batch.NoteGroup_1');
batchf = 'batch.NoteGroup_1.LABELED';


% === Note 3 (WN on d(b)) [UP]
syl='b';
syl_pre='d';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=3;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


% === Note 4 (WN on d(b)) [DN]
syl='h';
syl_pre='db';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=4;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);




%% ====== ALIGNING STIM TO SONG
%% ====== ALIGNING STIM TO SONG
% ========== CHECKING NOTEGROUP 1
close all;
batchf = 'batch.NoteGroup_0.rec_FB'; % either .cbin file or batch
% songf = batchf; % either .cbin file or batch
lasernote = 1;
annotate_note_group = 1;

lt_batchsong_plotallchans(batchf, lasernote, annotate_note_group);


% ============= CHECKIGN NOTEGROUP 2
close all;
batchf = 'batch.NoteGroup_1.rec_FB'; % either .cbin file or batch
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
% % close all;
% % % For only a single type of trial then only enter one field
% % % For 2 or more, will plot comaprisons, so enter all fields names
% % % Params.FieldsToCheck{1}='COMBO_StimCatch_TargAllCatch';
% % % Params.FieldsToCheck{2}='COMBO_StimNotCatch_TargAllCatch';
% % % Params.FieldsToCheck{1}='StimCatch';
% % % Params.FieldsToCheck{2}='StimNotCatch';
% % % Params.FieldsToCheck{1}='NotStim';
% % % Params.FieldsToCheck{2}='Stim';
% % % Params.FieldsToCheck{1}='COMBO_StimCatch_TargAllCatch';
% % % Params.FieldsToCheck{2}='COMBO_StimNotCatch_TargAllCatch';
% % % Params.FieldsToCheck{1}='SIMULATE_Catch';
% % % Params.FieldsToCheck{2}='SIMULATE_NotCatch';
% % Params.FieldsToCheck{1}='All';
% % % Params.FieldsToCheck{1}='COMBO_TargAllCatch';
% % % Params.FieldsToCheck{1}='COMBO_TargAllCatch';
% %  
% % 
% % % RUN
% % [StatsStruct, Params]=lt_Opto_Stim_analy_PLOT_Compare2_v2(DatStructCompiled,Params);
% % 
% % 
% % %% LOOK AT CERTAIN TIME WINDOW - EXTRACT AND PLOT AVERAGES
% % % Must first run lt_Opto_Stim_analy_PLOT_Compare2 to extract PC data. enter
% % % outputs from that into function here.
% % close all
% % 
% % Params.TimeWindowList = {};
% % 
% % % NEW - targetting b2 with WN(2bins) (changed to this0
% % Params.TimeWindowList{1}=[254 268]; % entire syl
% % 
% % Params.TimeWindowList{1}= [254 262]; % during WN
% % 
% %     for i=1:length(Params.TimeWindowList);
% %         TimeWind = Params.TimeWindowList{i};
% %         if ceil(Params.TimeWindowList{i})~=Params.TimeWindowList{i}; % means that there is fraction
% %             Params.TimeField{i}=['Wind' num2str(floor(TimeWind(1))) 'fr_' num2str(floor(TimeWind(2))) 'frms']; % put "fr" at end to signify fraction
% %         else
% %         Params.TimeField{i}=['Wind' num2str(TimeWind(1)) '_' num2str(TimeWind(2)) 'ms'];
% %         end
% %     end
% % 
% %     % RUN
% %     RunStats=1;
% %     KeepOutliers=1; % for running stats and plotting.
% % [StatsStruct, Params]=lt_Opto_Stim_analy_PLOT_TimeWindow_v2(StatsStruct, Params, RunStats, KeepOutliers);
% % 
% % % % DISPLAY SUMMARY STATS
% % % lt_Opto_Stim_analy_PL
% % 
% % 
% % 
% % %% PLOT OVER TIME - to look at learning
% % % Takes output from lt_Opto_Stim_analy_PLOT_TimeWindow and plots that over
% % % time - scatter and running average;
% % close all;
% % Params.SmthBin=10; % smooth # rends
% % KeepOutliers=1;
% % 
% % [StatsStruct,Params]=lt_Opto_Stim_analy_PLOT_TimeWindow_OverTime_v2(StatsStruct,Params,1,KeepOutliers);
% % 
% % 
% % %% PERFORM STATISTICS on time window data 
% % 
% % KeepOutliers=1;
% % [StatsStruct,Params]=lt_Opto_Stim_analy_PLOT_TimeWindow_Statistics_v2(StatsStruct,Params,KeepOutliers);
% % 
% % 
% % 
% % %% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% % %% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% % %% OPTO ANALY ACROSS DAYS
% % %% EXCTRACTING DATA ACROSS DAYS
% % % IMPORTANT: dirs must be structured as (for e.g.)
% % % /bluejay4/lucas/birds/pk32/070115_Reversion1_preWN_STIMoff
% % % (date_experiment_somethingelse_STIMoff[or STIMon]).
% % 
% % % ALSO: Stim epochs must be catch trials (because will use StimCatch and
% % % StimNotCatch fields to filter data)
% % 
% % % WILL TAKE ALL LABELED SONGS
% % 
% % % RUN THIS IN BIRD FOLDER
% % clear Params_metadata; clear Params_glob;
% % close all;
% % 
% % % =======, to find directories
% % Params_metadata.experiment='Reversion2'; % 1st underscore ...
% % Params_metadata.condition='';
% % Params_metadata.notes='';
% % Params_metadata.date_range={'17Mar2017', '18Mar2017'};
% % Params_metadata.only_labeled_dirs=1;
% % 
% % % ===== For opto analysis
% % Params_glob.DataInfo='UnDir'; % To note information about data, 'Dir' and 'UnDir' means this is directed or undirected song.
% % Params_glob.Fs=32000;
% % 
% % %         WHERE TO ALIGN SONGS
% % Params_glob.SylTarg='b'; % aligns to onset of this
% % Params_glob.PreNote='c';
% % 
% % Params_glob.PreDur=0.25; % sec, how much data to take before targ
% % Params_glob.PostSylOnsetDur=0.5; % sec, data post to take
% % Params_glob.TargNoteNum=0; % template note directed to target
% % Params_glob.TargTrigCatchRate=0; % catch trial fraction at target
% % 
% % %         STIM
% % Params_glob.notenum_stim=1; % of Stim - CONFIRMED THIS WORKS
% % Params_glob.StimDelay=20; % in ms, delay from trigger to stim on
% % Params_glob.StimDur=150; % duration of Stim, in ms
% % Params_glob.StimType='const'; % either 'constant' or 'pulse'
% % 
% % %     	for pitch contour
% % Params_glob.PC_freqrange=[4150 5100]; % for both pitch contour and find note
% % Params_glob.pc_harms=1;
% % 
% % %     	To sort into stim vs. notstim trials
% % Params_glob.StimLatencyWindow=[-250, 0]; % [a b] a and b are times (in negative ms) preceding syl onset. If stim is within this window, then will call a "stim trial."
% % 
% % % Time Window List
% % % DURING WN (on window 3)
% % Params_glob.TimeWindowList{1}=[254 262];
% % 
% % % Plotting over time
% % Params_glob.SmthBin=15; % smooth # rends
% % 
% % % Do you want to delete old opto analysis folder if it exists?
% % Params_glob.Delete_old_analysis_folder=1;
% % 
% % 
% % % =============================== RUN
% % KeepOutliers=1; % for running stats and plotting.
% % lt_Opto_Stim_analy_SUMMARY_MultDayAnaly_v3(Params_metadata, Params_glob, KeepOutliers);
% % 
% % cd ../../
% % 
% % 
% % %% ==================== PLOT ACROSS DAYS
% % close all;
% % clear all;
% % 
% % % ==== Params for analysis
% % BirdDir='/bluejay5/lucas/birds/or60/';
% % TimeFieldsOfInterest = 1; % i.e. time windows in pitch contour
% % statfield='ffvals';
% % BaselineDays=1;
% % plotStimEpochs=0; % if 1, then separates all data to stim epochs (even if multiple in one day)
% % ListOfDirs1={};
% % ListOfDirs2={};
% % 
% % % ==== METHOD 2) METADATA automatically
% % MetadataStruct=lt_metadata_collect;
% % 
% % experiment = 'Reversion2';
% % condition='';
% % notes='';
% % date_range={'13Mar2017', '18Mar2017'};
% % only_labeled_dirs=1;
% % 
% % ListOfDirs2=lt_metadata_find_dirs(MetadataStruct, experiment, condition, notes, date_range, only_labeled_dirs);
% % 
% % % get the correct subdir that contains opto stats
% % c=1;
% % for i=1:length(ListOfDirs2);
% %     cd(ListOfDirs2{i});
% %     
% %     
% %     tmp=[];
% %     try
% %         cd lt_Opto_Stim_analy_v2
% %         try cd 'All';
% %             tmp='All';
% %         catch err
% %             try cd 'Stim';
% %                 tmp='Stim';
% %             end
% %         end
% %     catch err
% %         disp(['error - no lt_Opto_Stim_analy_v2 data on: ' ListOfDirs2{i} ' - throwing day out']);
% %     cd(BirdDir);        
% %         continue
% %     end
% %     
% %     % go back up to main dir
% %     cd(BirdDir);
% %     
% %     % modify name to add opto analysis name
% %     ListOfDirs2_modified{c}=[ListOfDirs2{i} '/lt_Opto_Stim_analy_v2/' tmp];
% %     c=c+1;
% % end
% % 
% % 
% % % ===== COMBINE DIRS
% % ListOfDirs_all=[ListOfDirs1 ListOfDirs2_modified];
% % 
% % MetaParams.WNonDates = {'13Mar2017-2312-up', '15Mar2017-2300-dn', '18Mar2017-1432-up'}; % times when WN epochs began
% % 
% % 
% % lt_Opto_Stim_analy_SUMMARY_PlotOverTime(BirdDir, ListOfDirs_all,TimeFieldsOfInterest, ...
% %     statfield,BaselineDays,plotStimEpochs, MetaParams)
% % 
% % 
% % 
% % 
% % 
% % 
% % 
% % 
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








%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% OPTO ANALY ACROSS DAYS
% ================ DO SEPARATELY FOR EACH SYLLABLE OF INTEREST

clear Params_metadata; clear Params_glob;
close all;

% ================== SYL PARAMS CATALOGp
clear Params_bysyl

Params_bysyl(1).SylTarg='b'; % aligns to onset of this
Params_bysyl(1).PreNote='d';
Params_bysyl(1).PreDur=0.05; % sec, how much data to take before targ
Params_bysyl(1).PostSylOnsetDur=0.1; % sec, data post to take
Params_bysyl(1).TargNoteNum=1; % template note directed to target
Params_bysyl(1).PC_freqrange=[3000 4200]; % for both pitch contour and find note
Params_bysyl(1).StimLatencyWindow=[-150, 0]; % [a b] a and b are times (in negative ms) preceding syl onset. If stim is within this window, then will call a "stim trial."
Params_bysyl(1).TimeWindowList{1}=[53 59]; % entire syl
Params_bysyl(1).notenum_stim=0; % of Stim - CONFIRMED THIS WORKS

% Params_bysyl(2).SylTarg='b'; % aligns to onset of this
% Params_bysyl(2).PreNote='c';
% Params_bysyl(2).PreDur=0.05; % sec, how much data to take before targ
% Params_bysyl(2).PostSylOnsetDur=0.1; % sec, data post to take
% Params_bysyl(2).TargNoteNum=-1; % template note directed to target
% Params_bysyl(2).PC_freqrange=[3100 3900]; % for both pitch contour and find note
% Params_bysyl(2).StimLatencyWindow=[-300 0]; % [a b] a and b are times (in negative ms) preceding syl onset. If stim is within this window, then will call a "stim trial."
% Params_bysyl(2).TimeWindowList{1}=[53 61]; % entire syl
% Params_bysyl(2).notenum_stim=3; % of Stim - CONFIRMED THIS WORKS
% 
% Params_bysyl(3).SylTarg='h'; % aligns to onset of this
% Params_bysyl(3).PreNote='cb';
% Params_bysyl(3).PreDur=0.05; % sec, how much data to take before targ
% Params_bysyl(3).PostSylOnsetDur=0.1; % sec, data post to take
% Params_bysyl(3).TargNoteNum=-1; % template note directed to target
% Params_bysyl(3).PC_freqrange=[2800 3800]; % for both pitch contour and find note
% Params_bysyl(3).StimLatencyWindow=[-450, 0]; % [a b] a and b are times (in negative ms) preceding syl onset. If stim is within this window, then will call a "stim trial."
% Params_bysyl(3).TimeWindowList{1}=[54 62]; % entire syl
% Params_bysyl(3).notenum_stim=3;


% ####################### GENERAL PARAMS (shared across sykls)
% =======, to find directories
Params_metadata.experiment='Association1'; % 1st underscore ...
Params_metadata.condition='';
Params_metadata.notes='';
%     Params_metadata.date_range={'28Sep2018', '04Oct2018'};
Params_metadata.date_range={'12Oct2018', '14Oct2018'};
Params_metadata.only_labeled_dirs=1;

% ===== For opto analysis
Params_glob.DataInfo='UnDir'; % To note information about data, 'Dir' and 'UnDir' means this is directed or undirected song.
Params_glob.Fs=32000;

%         STIM
Params_glob.StimDelay=0; % in ms, delay from trigger to stim on
Params_glob.StimDur=250; % duration of Stim, in ms
Params_glob.StimType='pulse'; % either 'constant' or 'pulse'



% Time Window List
% Plotting over time
Params_glob.SmthBin=10; % smooth # rends

% Do you want to delete old opto analysis folder if it exists?
Params_glob.Delete_old_analysis_folder=1;



% ###################### SYL SPECIFIC PARAMS
SepBySyl = 1;
currdir = pwd;
for i=1:length(Params_bysyl)
    
    % ================== WHERE TO ALIGN SONGS
    Params_glob.SylTarg=Params_bysyl(i).SylTarg; % aligns to onset of this
    Params_glob.PreNote=Params_bysyl(i).PreNote;
    Params_glob.PreDur=Params_bysyl(i).PreDur; % sec, how much data to take before targ
    Params_glob.PostSylOnsetDur=Params_bysyl(i).PostSylOnsetDur; % sec, data post to take
    Params_glob.TargNoteNum=Params_bysyl(i).TargNoteNum; % template note directed to target
    Params_glob.PC_freqrange=Params_bysyl(i).PC_freqrange; % for both pitch contour and find note
    Params_glob.StimLatencyWindow=Params_bysyl(i).StimLatencyWindow; % [a b] a and b are times (in negative ms) preceding syl onset. If stim is within this window, then will call a "stim trial."
    Params_glob.TimeWindowList=Params_bysyl(i).TimeWindowList; % entire syl
    Params_glob.notenum_stim=Params_bysyl(i).notenum_stim;
    
    % ================================== DEFAULTS, UNLIKELY TO NEED TO CHANGE
    Params_glob.TargTrigCatchRate=0; % catch trial fraction at target
    Params_glob.pc_harms=1;
    
    
    % =============================== RUN
    KeepOutliers=1; % for running stats and plotting.
    lt_Opto_Stim_analy_SUMMARY_MultDayAnaly_v3(Params_metadata, Params_glob, ...
        KeepOutliers, SepBySyl);
    
    cd(currdir);
end

%% EXCTRACTING DATA ACROSS DAYS
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
% Params_metadata.experiment='Reversion1'; % 1st underscore ...
% Params_metadata.condition='';
% Params_metadata.notes='';
% Params_metadata.date_range={'29Sep2018', '02Oct2018'};
% Params_metadata.only_labeled_dirs=1;
% 
% % ===== For opto analysis
% Params_glob.DataInfo='UnDir'; % To note information about data, 'Dir' and 'UnDir' means this is directed or undirected song.
% Params_glob.Fs=32000;
% 
% %         WHERE TO ALIGN SONGS
% Params_glob.SylTarg='b'; % aligns to onset of this
% Params_glob.PreNote='a';
% 
% Params_glob.PreDur=0.15; % sec, how much data to take before targ
% Params_glob.PostSylOnsetDur=0.2; % sec, data post to take
% Params_glob.TargNoteNum=1; % template note directed to target
% Params_glob.TargTrigCatchRate=0; % catch trial fraction at target
% 
% %         STIM
% Params_glob.notenum_stim=0; % of Stim - CONFIRMED THIS WORKS
% Params_glob.StimDelay=0; % in ms, delay from trigger to stim on
% Params_glob.StimDur=400; % duration of Stim, in ms
% Params_glob.StimType='pulse'; % either 'constant' or 'pulse'
% 
% %     	for pitch contour
% Params_glob.PC_freqrange=[2650 3850]; % for both pitch contour and find note
% Params_glob.pc_harms=1;
% 
% %     	To sort into stim vs. notstim trials
% Params_glob.StimLatencyWindow=[-150, 0]; % [a b] a and b are times (in negative ms) preceding syl onset. If stim is within this window, then will call a "stim trial."
% 
% % Time Window List
% % DURING WN (on window 3)
% Params_glob.TimeWindowList{1}=[160 184]; % entire syl
% Params_glob.TimeWindowList{2}=[250 271]; % entire syl
% 
% % Plotting over time
% Params_glob.SmthBin=10; % smooth # rends
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


%% ==================== PLOT ACROSS DAYS
close all;
clear all;

% ==== Params for analysis
BirdDir='/bluejay5/lucas/birds/bu6bu98/';
TimeFieldsOfInterest = 1; % i.e. time windows in pitch contour
statfield='ffvals';
BaselineDays=1;
plotStimEpochs=0; % if 1, then separates all data to stim epochs (even if multiple in one day)
ListOfDirs1={};
ListOfDirs2={};
SepBySyl =1;
syllist = {'d_b'};
sylthis = 'd_b';

% ==== METHOD 2) METADATA automatically
MetadataStruct=lt_metadata_collect;

experiment = 'Association1';
condition='';
notes='';
date_range={'12Oct2018', '14Oct2018'};
only_labeled_dirs=1;

ListOfDirs2=lt_metadata_find_dirs(MetadataStruct, experiment, condition, notes, date_range, only_labeled_dirs);

% get the correct subdir that contains opto stats
c=1;
for i=1:length(ListOfDirs2)
    cd(ListOfDirs2{i});
    
    
    tmp=[];
    try
        cd lt_Opto_Stim_analy_v2
        try cd 'All';
            tmp='All';
        catch err
            try cd 'Stim';
                tmp='Stim';
            end
        end
    catch err
        disp(['error - no lt_Opto_Stim_analy_v2 data on: ' ListOfDirs2{i} ' - throwing day out']);
    cd(BirdDir);        
        continue
    end
    
    % go back up to main dir
    cd(BirdDir);
    
    % modify name to add opto analysis name
    if SepBySyl==1
        ListOfDirs2_modified{c}=[ListOfDirs2{i} '/lt_Opto_Stim_analy_v2/' tmp '/' sylthis];
    else
    ListOfDirs2_modified{c}=[ListOfDirs2{i} '/lt_Opto_Stim_analy_v2/' tmp];
    end
    c=c+1;
end


% ===== COMBINE DIRS
ListOfDirs_all=[ListOfDirs1 ListOfDirs2_modified];

MetaParams.WNonDates = {}; % times when WN epochs began


lt_Opto_Stim_analy_SUMMARY_PlotOverTime(BirdDir, ListOfDirs_all,TimeFieldsOfInterest, ...
    statfield,BaselineDays,plotStimEpochs, MetaParams)



%% #########################
% clear all; close all;
% 
% 
% % ========= TRAINING PARAMS
% % --- BU6
% dirtoplot = '/bluejay5/lucas/birds/bu6bu98/Opto_Stim_analy/Reversion1';
% twind = 1;
% 
% SwitchTimes = {...
%     '29Sep2018-2021', 'of-up', ...
%     '04Oct2018-2400', 'up-dn', ...
%     '09Oct2018-2400', 'dn-up'...
%     };
% 
% % -- PU83
% dirtoplot = '/bluejay5/lucas/birds/pu83wh58/Opto_Stim_analy/Reversion1';
% twind = 1;
% 
% SwitchTimes = {...
%     '29Sep2018-2016', 'of-dn', ...
%     '06Oct2018-2400', 'dn-up', ...
%     };
% 
% 
% OUTSTRUCT = lt_opto_ExtrBirdDat(dirtoplot, twind, SwitchTimes);
% 

%% ########################################################################
%% ######################################### AUTOLABEL
%% ================ TeSTING CONFIG FILE
if (0)
    close all;
    batchf= 'BatchAll.LABELED';
    get_WN_hits=0;
    get_offline_match=1;
    get_FF=0;
    
    syl = 'b';
    syl_pre = 'ab';
    syl_post = '';
    % config= '/bluejay3/lucas/birds/pu53wh88/config.evconfig2'; % before 2/16 templ change
    config= '/bluejay5/lucas/birds/pu53wh88/config_AL_aB.evconfig2';
    NoteNum = 0;
    
    
    check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, ...
        syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);
end

% ================ TeSTING CONFIG FILE
if (0)
    close all;
    batchf= 'BatchAll.LABELED';
    get_WN_hits=0;
    get_offline_match=1;
    get_FF=0;
    
    syl = 'b';
    syl_pre = 'c';
    syl_post = '';
    % config= '/bluejay3/lucas/birds/pu53wh88/config.evconfig2'; % before 2/16 templ change
    config= '/bluejay5/lucas/birds/pu53wh88/config_AL_cB.evconfig2';
    NoteNum = 0;
    
    
    check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, ...
        syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);
end



%% ##################################### AUTOLABEL 
clear all; close all;

% ========================= 0) ECTRACT DIRECTORIRES
basedir = '/bluejay5/lucas/birds/bu6bu98';
date_range_base={};
date_range_WN={'15Oct2018','17Oct2018'};
experiment = 'Association1';

% -------- COLLECT METADAT
cd(basedir);
MetadataStruct=lt_metadata_collect;

condition='';
notes='';
only_labeled_dirs=0;

% ----- BASELINE
ListOfDirs1=lt_metadata_find_dirs(MetadataStruct, experiment, condition, ...
    notes, date_range_base, only_labeled_dirs, 2);

% ------ WN
ListOfDirs2=lt_metadata_find_dirs(MetadataStruct, experiment, condition, ...
    notes, date_range_WN, only_labeled_dirs, 2);

% ------- COMBINE
if ~isempty(date_range_base) & ~isempty(date_range_WN)
ListOfDirs = [ListOfDirs1 ListOfDirs2];
elseif isempty(date_range_base) 
    ListOfDirs = [ListOfDirs2];
elseif isempty(date_range_WN) 
    ListOfDirs = [ListOfDirs1];
end
% ListOfDirs = [ListOfDirs2];


% ============================== RUN, ITERATE OVER DAYS
for j=1:length(ListOfDirs)

    % ==================== 0) go to day folder
    cd([basedir '/' ListOfDirs(j).dirname]);
    
    % ==================== 1) extract all s
%     try
%     lt_make_batch(1);
%     batch = 'batch.keep';
%     catch err
        lt_make_batch(3);
        lt_cleandirAuto('batch', 1000,5,5);
        batch = 'batch.keep';
%     end
    
    % ==================== 2) move old .notmat
    if ~exist('OLDNOTMAT_SeqDepPitch', 'dir')
        mkdir OLDNOTMAT_SeqDepPitch
        !cp *.not.mat* OLDNOTMAT_SeqDepPitch
    else
        disp('not making OLDNOTMAT_SeqDepPitch, since already made!!');
    end
    
    % ==================== 3) run autolabel
    % ---- GENERAL PARAMS
    ampThresh=12000;
    min_dur=30;
    min_int=5;
    sm_win = 4;
    
    % ---- MOTIF 1 [ddd]
    config= '/bluejay5/lucas/birds/bu6bu98/config_AL_d3.evconfig2';
    syl.targ='d';
    syl.pre='dd';
    syl.post='b';
    NoteNum=0;
    overwrite_notmat=1; % will always make backup folder
    
    [fnames, sylnum, vlsorfn, vlsorind]=lt_autolabel_EvTAFv4(batch, config, ...
        syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat, [], sm_win);
    
    
    % ------ MOTIF 2 [accBb]
    config= '/bluejay5/lucas/birds/bu6bu98/config_AL_c1.evconfig2';
    syl.targ='c';
    syl.pre='g';
    syl.post='cbh';
    NoteNum=0;
    overwrite_notmat=0; % will always make backup folder
    
    [fnames, sylnum, vlsorfn, vlsorind]=lt_autolabel_EvTAFv4(batch, config, ...
        syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat, [], sm_win);
end

%% ============ MAKE WAVE FILES TO LOOK FOR FALSE POSITIVES
batch = 'batch.labeled.all';
syl = 'b';
presyl = 'd';
[fnames, sylnum]=lt_jc_chcklbl(batch, syl, 0.025,0.025, presyl,'','');
[vlsorfn vlsorind]=jc_vlsorfn(batch, syl, presyl,'');

% syl = 'd';
% presyl = 'dd';
% [fnames, sylnum]=lt_jc_chcklbl(batch, syl, 0.025,0.025, presyl,'','');
% [vlsorfn vlsorind]=jc_vlsorfn(batch, syl, presyl,'');

syl = 'b';
presyl = 'c';
[fnames, sylnum]=lt_jc_chcklbl(batch, syl, 0.025,0.025, presyl,'','');
[vlsorfn vlsorind]=jc_vlsorfn(batch, syl, presyl,'');
 
%% ============ 2) Use evsonganaly manually on the .wav file created above
% (contains only the syls you chose)
% INSTRUCTIONS: 
% 1) open .wav file using evsonganaly
% 2) change threshold to segment all syls indivudally
% 3) any syl labeled "-" (default) will remain unchanged (i.e. will stay autolabeled). 
%     give a new label to any mislabeled syl - that will be its new actual label
evsonganaly


%% ============ 3) Replace hand-checekd mislabeld syls 
lt_autolabel_FixHandCheckedSyls(fnames, sylnum, vlsorfn, vlsorind)

