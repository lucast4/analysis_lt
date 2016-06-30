%% CONSOLIDATION 2: started 8/28/15 - variant from LMANChR2


%% MATCHING TEMPLATE
% % ======= c1 (laser)
% batchf= 'batch.labeled.all';
% get_WN_hits=0;
% get_offline_match=1; % do offline matching using template? (ADDX=1)
% get_FF=1; % Analyze FF using offline matching?
% syl = 'c';
% syl_pre = '';
% syl_post = 'c';
% config= '/bluejay4/lucas/birds/pk32/config.evconfig2';
% NoteNum = 0; 
% 
% lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum)
% 
% % =========== b (WN)
% batchf= 'batch.labeled.all';
% get_WN_hits=1;
% get_offline_match=1; % do offline matching using template? (ADDX=1)
% get_FF=1; % Analyze FF using offline matching?
% syl = 'b';
% syl_pre = 'c';
% syl_post = '';
% config= '/bluejay4/lucas/birds/pk32/config_070615_b.evconfig2';
% NoteNum = 0; 
% 
% lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum)


% ======= c1 (laser)
clear all; close all;
batchf= 'batch.labeled.all';
% batchf= 'batch.rand.keep.subset';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'c';
syl_pre = 'd';
syl_post = '';
% config= '/bluejay4/lucas/birds/pk32/config_070615_good.evconfig2';
% config= '/bluejay4/lucas/birds/pk32/070715_Reversion1_durWN_STIMoff_day2/config_070715.evconfig2';
config= '/bluejay4/lucas/birds/pk32/config_081515.evconfig2'; 
NoteNum = 0; 

lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum)


% =========== b (WN)
clear all; close all;
batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'c';
syl_post = '';
% config= '/bluejay4/lucas/birds/pk32/config_070615_good.evconfig2';
% config= '/bluejay4/lucas/birds/pk32/070715_Reversion1_durWN_STIMoff_day2/config_070715.evconfig2';
config= '/bluejay4/lucas/birds/pk32/config_081515.evconfig2';
NoteNum = 1; 

lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum)



% ===== CHECK WITH NO LABELING (b, WN)
clear all; close all;
Params.batch='batch.rand.keep';
Params.config= '/bluejay4/lucas/birds/pk32/070715_Reversion1_durWN_STIMoff_day2/config_070715.evconfig2'; 
Params.NoteNum_to_plot=1; % for the note you want to analyze
lt_check_hit_templ_freq_NoLabelRequired(Params)


%% Script to change name of all song files in a day to stick stuff in file name (e.g. STIMon, STIMoff

StringToAdd='STIMoff';

FilesInFolder=dir('*'); % get all cbins, cbinnotmat, and rec

% copy all stuff to backup folder
mkdir OldSongFiles
!cp * OldSongFiles;

% continue
for i=1:length(FilesInFolder);
    fn=FilesInFolder(i).name;
    
    if any(strfind(fn,'.cbin')) || any(strfind(fn,'.rec')) || any(strfind(fn,'.not.mat'));
    
        fn_new=[fn(1:9) StringToAdd '_' fn(10:end)];
        
        eval(['!mv ' fn ' ' fn_new]);
        
    end
end

%% Script to replace filename ID with another(or vice versa) in file names of all songs in day

StringToRemove='StimOFF'; 
StringToAdd='STIMoff';

FilesInFolder=dir('*'); % get all cbins, cbinnotmat, and rec

% copy all stuff to backup folder
mkdir OldSongFiles
!cp * OldSongFiles;

% continue
for i=1:length(FilesInFolder);
    fn=FilesInFolder(i).name;
    
    if any(strfind(fn,'.cbin')) || any(strfind(fn,'.rec')) || any(strfind(fn,'.not.mat'));
    
        length_remove=length(StringToRemove);
        
        fn_new=[fn(1:9) StringToAdd fn(10+length_remove:end)];

        eval(['!mv ' fn ' ' fn_new]);
    end
end


%% ============================================================
%% =============================   OPTO ANALYSIS

clear Params
clear StatsStruct


    Params.batch='batch.rec_FB';
    Params.ExptID='All'; % an identifier for the data in this batch file. leave as '' to use 'All' as default. ('Stim' is for stim epochs).
    Params.DataInfo='UnDir'; % To note information about data, 'Dir' and 'UnDir' means this is directed or undirected song.
    
    Params.Fs=32000;
%         WHERE TO ALIGN SONGS
    Params.SylTarg='c'; % aligns to onset of this
    Params.PreNote='';
    
    Params.PreDur=0.10; % sec, how much data to take before targ
    Params.PostSylOnsetDur=0.4; % sec, data post to take
    Params.TargNoteNum=1; % template note directed to target (WN)
    Params.TargTrigCatchRate=0; % catch trial fraction at target

%         STIM
    Params.notenum_stim=0; % of Stim - CONFIRMED THIS WORKS
    Params.StimDelay=55; % in ms, delay from trigger to stim on
    Params.StimDur=100; % duration of Stim, in ms
    Params.StimType='const'; % either 'constant' or 'pulse'
    
%     	for pitch contour
    Params.PC_freqrange=[2400 3850]; % for both pitch contour and find note
    Params.pc_harms=1;

%     	To sort into stim vs. notstim trials
    Params.StimLatencyWindow=[0, 100]; % [a b] a and b are times (in negative ms) preceding syl onset. If stim is within this window, then will call a "stim trial."


% RUN DATA EXTRACT --------------------------------------------

[DatStructCompiled, Params]=lt_Opto_Stim_analy_EXTRACTDATA_v2(Params);


%% PROCESS AND PLOT -
% For only a single type of trial then only enter one field
% For 2 or more, will plot comaprisons, so enter all fields names
% Params.FieldsToCheck{1}='COMBO_StimCatch_TargAllCatch';
% Params.FieldsToCheck{2}='COMBO_StimNotCatch_TargAllCatch';
% Params.FieldsToCheck{1}='StimCatch';
% Params.FieldsToCheck{2}='StimNotCatch';
% Params.FieldsToCheck{1}='NotStim';
% Params.FieldsToCheck{2}='Stim';



% Params.FieldsToCheck{1}='COMBO_StimCatch_TargAllCatch';
% Params.FieldsToCheck{2}='COMBO_StimNotCatch_TargAllCatch';

% Params.FieldsToCheck{1}='SIMULATE_Catch';
% Params.FieldsToCheck{2}='SIMULATE_NotCatch';

Params.FieldsToCheck{1}='All';
% Params.FieldsToCheck{1}='COMBO_TargAllCatch';

% Params.FieldsToCheck{1}='COMBO_TargAllCatch';
 

% RUN
[StatsStruct, Params]=lt_Opto_Stim_analy_PLOT_Compare2_v2(DatStructCompiled,Params);

%% ==============================================
% PLOT BY TIME WINDOW
close all

% WITHOUT WN
Params.TimeWindowList{1}=[115 155];
Params.TimeWindowList{2}=[197 240];
Params.TimeWindowList{3}=[264 280];

% DURING WN (on window 3)
Params.TimeWindowList{1}=[115 155];
Params.TimeWindowList{2}=[197 240];
Params.TimeWindowList{3}=[264 272];

% DURING WN (on window 3) - MODIFICATION ON 8/28 - to account for 
Params.TimeWindowList{1}=[115 151];
Params.TimeWindowList{2}=[197 236];
Params.TimeWindowList{3}=[264 270];


    for i=1:length(Params.TimeWindowList);
        TimeWind = Params.TimeWindowList{i};
        if ceil(Params.TimeWindowList{i})~=Params.TimeWindowList{i}; % means that there is fraction
            Params.TimeField{i}=['Wind' num2str(floor(TimeWind(1))) 'fr_' num2str(floor(TimeWind(2))) 'frms']; % put "fr" at end to signify fraction
        else
        Params.TimeField{i}=['Wind' num2str(TimeWind(1)) '_' num2str(TimeWind(2)) 'ms'];
        end
    end

    % RUN
    RunStats=1;
    KeepOutliers=0; % for running stats and plotting.
[StatsStruct, Params]=lt_Opto_Stim_analy_PLOT_TimeWindow_v2(StatsStruct,Params,RunStats,KeepOutliers);

%% DISPLAY SUMMARY STATS
lt_Opto_Stim_analy_PLOT_TimeWindow_Summary(StatsStruct,Params);


%% =========================== PLOT OVER TIME - to look at learning
% Takes output from lt_Opto_Stim_analy_PLOT_TimeWindow and plots that over
% time - scatter and running average;
close all;
Params.SmthBin=20; % smooth # rends
KeepOutliers=0;

[StatsStruct,Params]=lt_Opto_Stim_analy_PLOT_TimeWindow_OverTime_v2(StatsStruct,Params,1,KeepOutliers);


%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% ======== OPTO ANALYSIS OVER DAYS

% +++++++++++++++++++++++++++++++++++++++++++++= EXCTRACTING DATA ACROSS DAYS
% RUN THIS IN BIRD FOLDER.
clear all; close all;

% =======, to find directories
Params_metadata.experiment='Consolidation2'; % 1st underscore ...
Params_metadata.condition='';
Params_metadata.notes='';
Params_metadata.date_range={'17Sep2015', '20Sep2015'};
Params_metadata.only_labeled_dirs=1;


% ===== For opto analysis
Params_glob.DataInfo='UnDir'; % To note information about data, 'Dir' and 'UnDir' means this is directed or undirected song.
Params_glob.Fs=32000;

%         WHERE TO ALIGN SONGS
Params_glob.SylTarg='c'; % aligns to onset of this
Params_glob.PreNote='';

Params_glob.PreDur=0.10; % sec, how much data to take before targ
Params_glob.PostSylOnsetDur=0.4; % sec, data post to take
Params_glob.TargNoteNum=1; % template note directed to target
Params_glob.TargTrigCatchRate=0; % catch trial fraction at target

%         STIM
Params_glob.notenum_stim=0; % of Stim - CONFIRMED THIS WORKS
Params_glob.StimDelay=55; % in ms, delay from trigger to stim on
Params_glob.StimDur=100; % duration of Stim, in ms
Params_glob.StimType='const'; % either 'constant' or 'pulse'

%     	for pitch contour
Params_glob.PC_freqrange=[2400 3850]; % for both pitch contour and find note
Params_glob.pc_harms=1;

%     	To sort into stim vs. notstim trials
Params_glob.StimLatencyWindow=[0, 100]; % [a b] a and b are times (in negative ms) preceding syl onset. If stim is within this window, then will call a "stim trial."

% Time Window List
% % DURING WN (on window 3)
% Params_glob.TimeWindowList{1}=[115 155];
% Params_glob.TimeWindowList{2}=[197 240];
% Params_glob.TimeWindowList{3}=[264 272];

% DURING WN (on window 3) - MODIFICATION ON 8/28 - to account for 
Params_glob.TimeWindowList{1}=[115 151];
Params_glob.TimeWindowList{2}=[197 236];
Params_glob.TimeWindowList{3}=[264 270];


% Plotting over time
Params_glob.SmthBin=20; % smooth # rends

% Do you want to delete old opto analysis folder if it exists?
Params_glob.Delete_old_analysis_folder=1;

% =============================== RUN
lt_Opto_Stim_analy_SUMMARY_MultDayAnaly_v3(Params_metadata, Params_glob);



%% +++++++++++++++++++++++++++++++++++++++++++++++ PLOT ACROSS DAYS [CONSOLIDATION2]
clear all; close all;
cd /bluejay4/lucas/birds/pk32

% ==== Params for analysis
BirdDir='/bluejay4/lucas/birds/pk32/';
TimeFieldsOfInterest = 1:3; % i.e. time windows in pitch contour
statfield='ffvals';
BaselineDays=1:6;
plotStimEpochs=0; % if 1, then separates all data to stim epochs (even if multiple in one day)
ListOfDirs1={};
ListOfDirs2={};

% ==== METHOD 2) METADATA automatically
MetadataStruct=lt_metadata_collect;

experiment = 'Consolidation2';
condition='';
notes='';
date_range={'05Sep2015','20Sep2015'};
only_labeled_dirs=1;

ListOfDirs2=lt_metadata_find_dirs(MetadataStruct, experiment, condition, notes, date_range, only_labeled_dirs);

% get the correct subdir that contains opto stats
c=1;
for i=1:length(ListOfDirs2);
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
    ListOfDirs2_modified{c}=[ListOfDirs2{i} '/lt_Opto_Stim_analy_v2/' tmp];
    c=c+1;
end


% ===== COMBINE DIRS
ListOfDirs_all=[ListOfDirs1 ListOfDirs2_modified];


lt_Opto_Stim_analy_SUMMARY_PlotOverTime(BirdDir, ListOfDirs_all,TimeFieldsOfInterest,statfield,BaselineDays,plotStimEpochs)








%% +++++++++++++++++++++++++++++++++++++++++++++++ PLOT ACROSS DAYS [REVERSION1]
clear all; close all;
cd /bluejay4/lucas/birds/pk32

% ==== Params for analysis
BirdDir='/bluejay4/lucas/birds/pk32/';
TimeFieldsOfInterest = 1:3; % i.e. time windows in pitch contour
statfield='ffvals';
BaselineDays=1:5;
plotStimEpochs=0; % if 1, then separates all data to stim epochs (even if multiple in one day)
ListOfDirs1={};
ListOfDirs2={};

% ==== METHOD 2) METADATA automatically
MetadataStruct=lt_metadata_collect;

experiment = 'Reversion1';
condition='';
notes='';
date_range={'01Jul2015','09Sep2015'};
only_labeled_dirs=1;

ListOfDirs2=lt_metadata_find_dirs(MetadataStruct, experiment, condition, notes, date_range, only_labeled_dirs);

% get the correct subdir that contains opto stats
c=1;
for i=1:length(ListOfDirs2);
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
    ListOfDirs2_modified{c}=[ListOfDirs2{i} '/lt_Opto_Stim_analy_v2/' tmp];
    c=c+1;
end


% ===== COMBINE DIRS
ListOfDirs_all=[ListOfDirs1 ListOfDirs2_modified];


lt_Opto_Stim_analy_SUMMARY_PlotOverTime(BirdDir, ListOfDirs_all,TimeFieldsOfInterest,statfield,BaselineDays,plotStimEpochs)







%% ================================ AUTOLABEL METHODS
% =================

%% evtaf v4 version - WORKS
clear all; close all
batch = 'batch.rec_FB';
% batch = 'batch.rand.keep';
% config= '/bluejay4/lucas/birds/pk32/config.evconfig2';
% config= '/bluejay4/lucas/birds/pk32/070715_Reversion1_durWN_day2/config_070715.evconfig2';
config= '/bluejay4/lucas/birds/pk32/config_081515.evconfig2'; 

syl.targ='c';
syl.pre='d';
syl.post=''; 
NoteNum=0; 

ampThresh=53000;
min_dur=20;
min_int=4;

overwrite_notmat=1;

lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat)


%% ======================= 2) TO CHECK ACCURACY - isolates all syls labeled and saves to .wav - open and check by eye.
[fnames, sylnum]=lt_jc_chcklbl(batch,syl.targ, 0.025,0.025,'','','');
[vlsorfn vlsorind]=jc_vlsorfn(batch,syl.targ,'','');

% Troubleshooting, enter syl name you want to find song of.
% [fnames, sylnum]=lt_jc_chcklbl(batch,'x', 0.025,0.025,'','','');
% [vlsorfn vlsorind]=jc_vlsorfn(batch,'x','','');

disp('DONE!');



% BELOW - run by hand.  use evsonganaly to check labeling, and replace those that are wrong. then run script right below.
    %% Check output using evsonganaly
    
    evsonganaly;
    
    
    %% After using evsonganaly, run below to replace with corrected things
    
    %     X1=load('syllwv1.wav.not.mat');
    %     X2=load('syllwv2.wav.not.mat');
    %     XcatLabels=strcat(X1.labels, X2.labels);
    %     [Inds, NewSyl]=regexp(XcatLabels,'\w','start','match');
    % %     newsyl=strjoin(NewSyl,'\0');
    %
    %     lt_jc_fndlbl(vlsorind, vlsorfn, Inds, NewSyl,1)
    
    
    % collect all labels
    labels_all=[];
    for i=1:length(fnames);
        load([fnames{i} '.not.mat']);
        labels_all=[labels_all labels];
    end
    
    % Any thing not '-' will be replaced by the entered label.
    Inds=find(labels_all~='-');
    sylnum_handlabeled=length(labels_all);
    
    if sylnum~=sylnum_handlabeled;
        disp('WARNING - hand labeled # of syl does not match actual number, can cause autolabeling frameshift error - check evsonganaly thresholding');
    else
        disp('GOOD - hand labeled num of syl is correct');
    end
    
    lt_jc_fndlbl(vlsorind,vlsorfn,Inds,labels_all,1)

