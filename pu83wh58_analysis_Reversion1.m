%% CHECKING TEMPLATE MATCHING (ab[b]);

clear all; close all;
batchf='batch.labeled.all';
% config='/bluejay5/lucas/birds/pu83wh58/config092618.evconfig2';
% config='/bluejay5/lucas/birds/pu83wh58/config_a_092618.evconfig2';
% config='/bluejay5/lucas/birds/pu83wh58/config092618_3.evconfig2';
config='/bluejay5/lucas/birds/pu83wh58/config092618_3_v2.evconfig2';
config='/bluejay5/lucas/birds/pu83wh58/config092918.evconfig2';
config='/bluejay5/lucas/birds/pu83wh58/config092918_v2.evconfig2';


% === GETTING a
syl='a';
syl_pre='';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


% === GETTING a(b)h
syl='b';
syl_pre='a';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% === GETTING ab(h)
syl='h';
syl_pre='ab';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=2;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


% === GETTING (c)c
syl='c';
syl_pre='';
syl_post='c';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=3;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


%% ====== ALIGNING STIM TO SONG
close all;
batchf = 'batch.rec_FB'; % either .cbin file or batch
% songf = batchf; % either .cbin file or batch
lasernote = 1;

annotate_note_group = 1;

lt_batchsong_plotallchans(batchf, lasernote, annotate_note_group);


%% ########## AUTOLABEL


%% ######### ANALYSES - OPTO



%% ====================== ANALYSIS
clear Params
clear StatsStruct

Params.batch='batch.labeled.all';
Params.ExptID='Stim'; % an identifier for the data in this batch file. leave as '' to use 'All' as default. ('Stim' is for stim epochs).
Params.DataInfo='UnDir'; % To note information about data, 'Dir' and 'UnDir' means this is directed or undirected song.
Params.Fs=32000;
%         WHERE TO ALIGN SONGS
Params.SylTarg='c'; % aligns to onset of this
Params.PreNote='c';

Params.PreDur=0.05; % sec, how much data to take before targ
Params.PostSylOnsetDur=0.2; % sec, data post to take
Params.TargNoteNum=2; % template note directed to target
Params.TargTrigCatchRate=0; % catch trial fraction at target

%         STIM
Params.notenum_stim=3; % of Stim - CONFIRMED THIS WORKS
Params.StimDelay=0; % in ms, delay from trigger to stim on
Params.StimDur=400; % duration of Stim, in ms
Params.StimType='pulse'; % either 'constant' or 'pulse'

%     	for pitch contour
Params.PC_freqrange=[2650 3850]; % for both pitch contour and find note
Params.pc_harms=1;

%     	To sort into stim vs. notstim trials
Params.StimLatencyWindow=[-250, 0]; % [a b] a and b are times (in negative ms) preceding syl onset. If stim is within this window, then will call a "stim trial."


% RUN DATA EXTRACT --------------------------------------------

[DatStructCompiled, Params]=lt_Opto_Stim_analy_EXTRACTDATA_v2(Params);


%% PROCESS AND PLOT -
close all;
% For only a single type of trial then only enter one field
% For 2 or more, will plot comaprisons, so enter all fields names
% Params.FieldsToCheck{1}='COMBO_StimCatch_TargAllCatch';
% Params.FieldsToCheck{2}='COMBO_StimNotCatch_TargAllCatch';
% Params.FieldsToCheck{1}='StimCatch';
% Params.FieldsToCheck{2}='StimNotCatch';
Params.FieldsToCheck{1}='NotStim';
Params.FieldsToCheck{2}='Stim';
% Params.FieldsToCheck{1}='COMBO_StimCatch_TargAllCatch';
% Params.FieldsToCheck{2}='COMBO_StimNotCatch_TargAllCatch';
% Params.FieldsToCheck{1}='SIMULATE_Catch';
% Params.FieldsToCheck{2}='SIMULATE_NotCatch';
% Params.FieldsToCheck{1}='All';
% Params.FieldsToCheck{1}='COMBO_TargAllCatch';
% Params.FieldsToCheck{1}='COMBO_TargAllCatch';
 

% RUN
[StatsStruct, Params]=lt_Opto_Stim_analy_PLOT_Compare2_v2(DatStructCompiled,Params);


%% LOOK AT CERTAIN TIME WINDOW - EXTRACT AND PLOT AVERAGES
% Must first run lt_Opto_Stim_analy_PLOT_Compare2 to extract PC data. enter
% outputs from that into function here.
close all

Params.TimeWindowList = {};

% NEW - targetting b2 with WN(2bins) (changed to this0
Params.TimeWindowList{1}=[160 184]; % entire syl
Params.TimeWindowList{2}=[250 271]; % entire syl

for i=1:length(Params.TimeWindowList)
    TimeWind = Params.TimeWindowList{i};
    if ceil(Params.TimeWindowList{i})~=Params.TimeWindowList{i}; % means that there is fraction
        Params.TimeField{i}=['Wind' num2str(floor(TimeWind(1))) 'fr_' num2str(floor(TimeWind(2))) 'frms']; % put "fr" at end to signify fraction
    else
        Params.TimeField{i}=['Wind' num2str(TimeWind(1)) '_' num2str(TimeWind(2)) 'ms'];
    end
end

% RUN
RunStats=1;
KeepOutliers=1; % for running stats and plotting.
[StatsStruct, Params]=lt_Opto_Stim_analy_PLOT_TimeWindow_v2(StatsStruct, Params, RunStats, KeepOutliers);

% % DISPLAY SUMMARY STATS
% lt_Opto_Stim_analy_PL



%% PLOT OVER TIME - to look at learning
% Takes output from lt_Opto_Stim_analy_PLOT_TimeWindow and plots that over
% time - scatter and running average;
close all;
Params.SmthBin=10; % smooth # rends
KeepOutliers=1;

[StatsStruct,Params]=lt_Opto_Stim_analy_PLOT_TimeWindow_OverTime_v2(StatsStruct,Params,1,KeepOutliers);


%% PERFORM STATISTICS on time window data 
close all;

KeepOutliers=1;
[StatsStruct,Params]=lt_Opto_Stim_analy_PLOT_TimeWindow_Statistics_v2(StatsStruct,Params,KeepOutliers);



%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% OPTO ANALY ACROSS DAYS
% ================ DO SEPARATELY FOR EACH SYLLABLE OF INTEREST

clear Params_metadata; clear Params_glob;
close all;

% ================== SYL PARAMS CATALOGp
clear Params_bysyl

Params_bysyl(1).SylTarg='b'; % aligns to onset of this
Params_bysyl(1).PreNote='a';
Params_bysyl(1).PreDur=0.05; % sec, how much data to take before targ
Params_bysyl(1).PostSylOnsetDur=0.1; % sec, data post to take
Params_bysyl(1).TargNoteNum=1; % template note directed to target
Params_bysyl(1).PC_freqrange=[2650 3950]; % for both pitch contour and find note
Params_bysyl(1).StimLatencyWindow=[-150, 0]; % [a b] a and b are times (in negative ms) preceding syl onset. If stim is within this window, then will call a "stim trial."
Params_bysyl(1).TimeWindowList{1}=[62 84]; % entire syl
Params_bysyl(1).notenum_stim=0; % of Stim - CONFIRMED THIS WORKS

Params_bysyl(2).SylTarg='h'; % aligns to onset of this
Params_bysyl(2).PreNote='ab';
Params_bysyl(2).PreDur=0.05; % sec, how much data to take before targ
Params_bysyl(2).PostSylOnsetDur=0.1; % sec, data post to take
Params_bysyl(2).TargNoteNum=2; % template note directed to target
Params_bysyl(2).PC_freqrange=[2650 3850]; % for both pitch contour and find note
Params_bysyl(2).StimLatencyWindow=[-300, 0]; % [a b] a and b are times (in negative ms) preceding syl onset. If stim is within this window, then will call a "stim trial."
Params_bysyl(2).TimeWindowList{1}=[61 83]; % entire syl
Params_bysyl(2).notenum_stim=0; % of Stim - CONFIRMED THIS WORKS

Params_bysyl(3).SylTarg='c'; % aligns to onset of this
Params_bysyl(3).PreNote='c';
Params_bysyl(3).PreDur=0.05; % sec, how much data to take before targ
Params_bysyl(3).PostSylOnsetDur=0.15; % sec, data post to take
Params_bysyl(3).TargNoteNum=-1; % template note directed to target [make -1 if don't care]
Params_bysyl(3).PC_freqrange=[2000 2900]; % for both pitch contour and find note
Params_bysyl(3).StimLatencyWindow=[-200, 0]; % [a b] a and b are times (in negative ms) preceding syl onset. If stim is within this window, then will call a "stim trial."
Params_bysyl(3).TimeWindowList{1}=[75 115]; % entire syl
Params_bysyl(3).notenum_stim=3; % of Stim - CONFIRMED THIS WORKS

Params_bysyl(4).SylTarg='b'; % aligns to onset of this
Params_bysyl(4).PreNote='c';
Params_bysyl(4).PreDur=0.05; % sec, how much data to take before targ
Params_bysyl(4).PostSylOnsetDur=0.1; % sec, data post to take
Params_bysyl(4).TargNoteNum=-1; % template note directed to target
Params_bysyl(4).PC_freqrange=[3100 3900]; % for both pitch contour and find note
Params_bysyl(4).StimLatencyWindow=[-300 0]; % [a b] a and b are times (in negative ms) preceding syl onset. If stim is within this window, then will call a "stim trial."
Params_bysyl(4).TimeWindowList{1}=[60 81]; % entire syl
Params_bysyl(4).notenum_stim=3; % of Stim - CONFIRMED THIS WORKS

Params_bysyl(5).SylTarg='h'; % aligns to onset of this
Params_bysyl(5).PreNote='cb';
Params_bysyl(5).PreDur=0.05; % sec, how much data to take before targ
Params_bysyl(5).PostSylOnsetDur=0.1; % sec, data post to take
Params_bysyl(5).TargNoteNum=-1; % template note directed to target
Params_bysyl(5).PC_freqrange=[2800 3800]; % for both pitch contour and find note
Params_bysyl(5).StimLatencyWindow=[-450, 0]; % [a b] a and b are times (in negative ms) preceding syl onset. If stim is within this window, then will call a "stim trial."
Params_bysyl(5).TimeWindowList{1}=[59 81]; % entire syl
Params_bysyl(5).notenum_stim=3;

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
    
    
    % ####################### GENERAL PARAMS (shared across sykls)
    % =======, to find directories
    Params_metadata.experiment='Reversion1'; % 1st underscore ...
    Params_metadata.condition='';
    Params_metadata.notes='';
    Params_metadata.date_range={'29Sep2018', '29Sep2018'};
    Params_metadata.only_labeled_dirs=1;
    
    % ===== For opto analysis
    Params_glob.DataInfo='UnDir'; % To note information about data, 'Dir' and 'UnDir' means this is directed or undirected song.
    Params_glob.Fs=32000;
    
    %         STIM
    Params_glob.StimDelay=0; % in ms, delay from trigger to stim on
    Params_glob.StimDur=400; % duration of Stim, in ms
    Params_glob.StimType='pulse'; % either 'constant' or 'pulse'
    
    
    
    % Time Window List
    % Plotting over time
    Params_glob.SmthBin=10; % smooth # rends
    
    % Do you want to delete old opto analysis folder if it exists?
    Params_glob.Delete_old_analysis_folder=1;
    
    
    % =============================== RUN
    KeepOutliers=1; % for running stats and plotting.
    lt_Opto_Stim_analy_SUMMARY_MultDayAnaly_v3(Params_metadata, Params_glob, ...
        KeepOutliers, SepBySyl);
    
    cd(currdir);
end

%% EXCTRACTING DATA ACROSS DAYS
% IMPORTANT: dirs must be structured as (for e.g.)
% /bluejay4/lucas/birds/pk32/070115_Reversion1_preWN_STIMoff
% (date_experiment_somethingelse_STIMoff[or STIMon]).

% ALSO: Stim epochs must be catch trials (because will use StimCatch and
% StimNotCatch fields to filter data)

% WILL TAKE ALL LABELED SONGS

% RUN THIS IN BIRD FOLDER
clear Params_metadata; clear Params_glob;
close all;

% =======, to find directories
Params_metadata.experiment='Reversion1'; % 1st underscore ...
Params_metadata.condition='';
Params_metadata.notes='';
Params_metadata.date_range={'28Sep2018', '29Sep2018'};
Params_metadata.only_labeled_dirs=1;

% ===== For opto analysis
Params_glob.DataInfo='UnDir'; % To note information about data, 'Dir' and 'UnDir' means this is directed or undirected song.
Params_glob.Fs=32000;

%         WHERE TO ALIGN SONGS
Params_glob.SylTarg='b'; % aligns to onset of this
Params_glob.PreNote='a';

Params_glob.PreDur=0.15; % sec, how much data to take before targ
Params_glob.PostSylOnsetDur=0.2; % sec, data post to take
Params_glob.TargNoteNum=1; % template note directed to target
Params_glob.TargTrigCatchRate=0; % catch trial fraction at target

%         STIM
Params_glob.notenum_stim=0; % of Stim - CONFIRMED THIS WORKS
Params_glob.StimDelay=0; % in ms, delay from trigger to stim on
Params_glob.StimDur=400; % duration of Stim, in ms
Params_glob.StimType='pulse'; % either 'constant' or 'pulse'

%     	for pitch contour
Params_glob.PC_freqrange=[2650 3850]; % for both pitch contour and find note
Params_glob.pc_harms=1;

%     	To sort into stim vs. notstim trials
Params_glob.StimLatencyWindow=[-150, 0]; % [a b] a and b are times (in negative ms) preceding syl onset. If stim is within this window, then will call a "stim trial."

% Time Window List
% DURING WN (on window 3)
Params_glob.TimeWindowList{1}=[160 184]; % entire syl
Params_glob.TimeWindowList{2}=[250 271]; % entire syl

% Plotting over time
Params_glob.SmthBin=10; % smooth # rends

% Do you want to delete old opto analysis folder if it exists?
Params_glob.Delete_old_analysis_folder=1;


% =============================== RUN
KeepOutliers=1; % for running stats and plotting.
lt_Opto_Stim_analy_SUMMARY_MultDayAnaly_v3(Params_metadata, Params_glob, KeepOutliers);

cd ../../


%% ==================== PLOT ACROSS DAYS
close all;
clear all;

% ==== Params for analysis
BirdDir='/bluejay5/lucas/birds/pu83wh58/';
TimeFieldsOfInterest = 1; % i.e. time windows in pitch contour
statfield='ffvals';
BaselineDays=1;
plotStimEpochs=0; % if 1, then separates all data to stim epochs (even if multiple in one day)
ListOfDirs1={};
ListOfDirs2={};

% ==== METHOD 2) METADATA automatically
MetadataStruct=lt_metadata_collect;

experiment = 'Reversion1';
condition='';
notes='';
date_range={'28Sep2018', '29Sep2018'};
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
    ListOfDirs2_modified{c}=[ListOfDirs2{i} '/lt_Opto_Stim_analy_v2/' tmp];
    c=c+1;
end


% ===== COMBINE DIRS
ListOfDirs_all=[ListOfDirs1 ListOfDirs2_modified];

MetaParams.WNonDates = {}; % times when WN epochs began


lt_Opto_Stim_analy_SUMMARY_PlotOverTime(BirdDir, ListOfDirs_all,TimeFieldsOfInterest, ...
    statfield,BaselineDays,plotStimEpochs, MetaParams)





