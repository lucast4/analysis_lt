%%  NO LABEL REQUIRED - USED FOR ANALYSIS OF LEARNING SCREENING
close all;

Params.batch='batch';
Params.config='/bluejay5/lucas/birds/or60/config.evconfig2';
Params.NoteNum_to_plot=0; % for the note you want to analyze
[AllSongsData_toplot, AllData] = lt_check_hit_templ_freq_NoLabelRequired(Params);


%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% Reversion1

%% CHECKING TEMPLATE MATCHING;
clear all; close all;
lt_read_ltrec2

% ============================== NOTE GROUP 0
% WN(1) + LASER
batchf = 'batch.NoteGroup_0.rec_FB';
config='/bluejay5/lucas/birds/or60/config032717.evconfig2';

% - WN (cc[b])

syl='b';
syl_pre='c';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% - LASER
syl='c';
syl_pre='d';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=0;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


% ============================== NOTE GROUP 1
% WN(2)
try
lt_cleandirAuto('batch.NoteGroup_1', 1000, 4, 4);
batchf = 'batch.NoteGroup_1.keep';
catch err
   batchf = 'batch.NoteGroup_1'; 
end
batchf = 'batch.NoteGroup_1.rec_FB';

config='/bluejay5/lucas/birds/or60/config032717.evconfig2';

% - WN (cc[b])

syl='b';
syl_pre='c';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


%% ====== ALIGNING STIM TO SONG
close all;
songf = 'or1_STIMon_260317_214921.1362.cbin'; % either .cbin file or batch
songf = batchf; % either .cbin file or batch
lasernote = 1;

if any(strfind(songf, 'cbin'));
    lt_figure; hold on;
    % then assume is a single song
    % 1) song
    [dat, Fs, DOFILT, ext]=ReadDataFile(songf,'0');
    x = [1:length(dat)]./Fs;
    plot(x, dat, '-k')
    
    % 2) trigger
    [dat, Fs, DOFILT, ext]=ReadDataFile(songf,'1');
    plot(x, dat, '-r')
    
    % -- ad trig time with rec file ...
    rd = readrecf_LT_evtafv4(songf);
    
    
else
    
    figcount=1;
    subplotrows=4;
    subplotcols=2;
    fignums_alreadyused=[];
    hfigs=[];
    
    hsplots = [];
    % ---------- go thur all songs in batch
    batchf = songf;
    fid = fopen(batchf);
    songf = fgetl(fid);
    
    while ischar(songf)
        
        
        [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
        title(songf);
        hsplots = [hsplots hsplot];
        
        % 1) song
        [dat, Fs, DOFILT, ext]=ReadDataFile(songf,'0');
        x = [1:length(dat)]./Fs;
        plot(x, dat, '-k')
        
        % 2) trigger
        [dat, Fs, DOFILT, ext]=ReadDataFile(songf,'1');
        plot(x, dat, '-r')
        
        % -- ad trig time with rec file ...
        rd = readrecf_LT_evtafv4(songf);
        if ~isempty(rd.ttimes)
            for i=1:length(rd.ttimes)
                if rd.trignote(i)==lasernote
                    if rd.catch(i) ==1
                        plot(rd.ttimes(i)/1000, 0, '^g');
                    else
                        plot(rd.ttimes(i)/1000, 0, '^r');
                        lt_plot_text(rd.ttimes(i)/1000 +0.05, 0, 'hit', 'r');
                    end
                    
                end
                
            end
        end
        
        % - next
        songf = fgetl(fid);
    end
    linkaxes(hsplots, 'y');
end




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
%% PROCESS AND PLOT -
close all;
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


%% LOOK AT CERTAIN TIME WINDOW - EXTRACT AND PLOT AVERAGES
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
%% PLOT OVER TIME - to look at learning
% Takes output from lt_Opto_Stim_analy_PLOT_TimeWindow and plots that over
% time - scatter and running average;
close all;
Params.SmthBin=10; % smooth # rends
KeepOutliers=1;

[StatsStruct,Params]=lt_Opto_Stim_analy_PLOT_TimeWindow_OverTime_v2(StatsStruct,Params,1,KeepOutliers);


%% PERFORM STATISTICS on time window data 

KeepOutliers=1;
[StatsStruct,Params]=lt_Opto_Stim_analy_PLOT_TimeWindow_Statistics_v2(StatsStruct,Params,KeepOutliers);



%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% OPTO ANALY ACROSS DAYS
%% EXCTRACTING DATA ACROSS DAYS
% IMPORTANT: dirs must be structured as (for e.g.)
% /bluejay4/lucas/birds/pk32/070115_Reversion1_preWN_STIMoff
% (date_experiment_somethingelse_STIMoff[or STIMon]).

% ALSO: Stim epochs must be catch trials (because will use StimCatch and
% StimNotCatch fields to filter data)

% WILL TAKE ALL LABELED SONGS

% NOTE: will extract stim types (StimCatch StimNotCatch) and NotStim fields.
% NOTE: in the PlotOverTime code I
% convert Stim --> StimNotCatch and NotStim --> StimCatch, so is not a
% problem. (will end up with 2 filds for stim and no stim in the end)

% NOTE: does not currently support use of both Note groups and catch. In
% that case would have NotStim and StimCatch as different. Currently
% PlotOverTime overrides NotStim witm StimCatch instead of combining.


% RUN THIS IN BIRD FOLDER
clear Params_metadata; clear Params_glob;
close all;

% =======, to find directories
Params_metadata.experiment='Association2'; % 1st underscore ...
Params_metadata.condition='';
Params_metadata.notes='';
% Params_metadata.date_range={'15Apr2017', '17Apr2017'};
Params_metadata.date_range={'05Apr2017', '27Apr2017'}; % DONE!
Params_metadata.date_range={'28Apr2017', '01May2017'}; % TO DO;
Params_metadata.only_labeled_dirs=1;

% ===== For opto analysis
Params_glob.DataInfo='UnDir'; % To note information about data, 'Dir' and 'UnDir' means this is directed or undirected song.
Params_glob.Fs=32000;

%         WHERE TO ALIGN SONGS
Params_glob.SylTarg='b'; % aligns to onset of this
Params_glob.PreNote='c';

Params_glob.PreDur=0.25; % sec, how much data to take before targ
Params_glob.PostSylOnsetDur=0.5; % sec, data post to take
Params_glob.TargNoteNum=0; % template note directed to target
Params_glob.TargTrigCatchRate=0; % catch trial fraction at target

%         STIM
Params_glob.notenum_stim=1; % of Stim - CONFIRMED THIS WORKS
Params_glob.StimDelay=20; % in ms, delay from trigger to stim on
Params_glob.StimDur=150; % duration of Stim, in ms
Params_glob.StimType='const'; % either 'constant' or 'pulse'

%     	for pitch contour
Params_glob.PC_freqrange=[4150 5100]; % for both pitch contour and find note
Params_glob.pc_harms=1;

%     	To sort into stim vs. notstim trials
Params_glob.StimLatencyWindow=[-250, 0]; % [a b] a and b are times (in negative ms) preceding syl onset. If stim is within this window, then will call a "stim trial."

% Time Window List
% DURING WN (on window 3)
Params_glob.TimeWindowList{1}=[254 262];

% Plotting over time
Params_glob.SmthBin=15; % smooth # rends

% Do you want to delete old opto analysis folder if it exists?
Params_glob.Delete_old_analysis_folder=1;


% =============================== RUN
KeepOutliers=1; % for running stats and plotting.
lt_Opto_Stim_analy_SUMMARY_MultDayAnaly_v3(Params_metadata, Params_glob, KeepOutliers);

cd ../../../


%% ==================== PLOT ACROSS DAYS
close all;

% ==== Params for analysis
BirdDir='/bluejay5/lucas/birds/or60/';
TimeFieldsOfInterest = 1; % i.e. time windows in pitch contour
statfield='ffvals';
BaselineDays=1;
plotStimEpochs=0; % if 1, then separates all data to stim epochs (even if multiple in one day)
ListOfDirs1={};
ListOfDirs2={};

% ==== METHOD 2) METADATA automatically
MetadataStruct=lt_metadata_collect;

experiment = 'Association2';
condition='';
notes='';
% date_range={'27Mar2017', '04Apr2017'};
date_range={'27Mar2017', '01May2017'};
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

MetaParams.WNonDates = {}; % times when WN epochs began
% MetaParams.AssocExpt.Timeline.Stim_WNup_BiDir={'29Mar2017'};



lt_Opto_Stim_analy_SUMMARY_PlotOverTime(BirdDir, ListOfDirs_all,TimeFieldsOfInterest, ...
    statfield,BaselineDays,plotStimEpochs, MetaParams)




%% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% ++++++++++++++++++++++++++++++++++++++++++ USING CONTEXT ANALYSIS


%% ======================= Extracting data across days
% --- day directories must be in format
% [date]_[experimentname]_[context_name].
% -- Run this in bird folder to extract all days data to subfolder

clear all; close all;

Params.syl_list={'b'}; % single syls
Params.freq_range_list={[4150 5100]};
Params.pc_dur_list=[0.11];
Params.pc_harms_list=[1];

Params.batch='batch.labeled.all';
Params.experiment = 'Association2';

date_range={'30Apr2017','01May2017'}; % e.g. {'20Apr2015','20May2015'}. leave blank ('') for all days

% ---- 2) Collect note group information? 
CollectNoteGroup = 1; % set to 1 if want to use online NoteGroups. Otherwise will do context stuff using the 
% [context_name] condition in the folder name - i.e. for bulk context, not
% rapid switching experiments. 

lt_extract_AllDaysPC(Params, date_range, CollectNoteGroup)


%% %% Compiling data - go to "extract" folder first
clear all; close all;
Params_global.CompilePC.PC_window_list={'b', [22 74]}; % syl, value pairs [single syls]
Params_global.CompilePC.PC_window_list={'b', [60 80]}; % syl, value pairs [single syls]
Params_global.CompilePC.FirstDay='';
Params_global.CompilePC.LastDay='';
plotON=1; % pitch contours, all days, all syls
saveON=1;

% Regular expressions - first calculates FF etc, then performs regular
% expressions
Params_global.CompilePC.regexp_list={'c(b)'}; % e.g. {'dcc(b)', 'ab+(g)'} : dcc(b) means match dccb, and give me ind of b in parantheses.  ab+(g) means match ab... (anly length repeat), then g. give me ind of g
Params_global.CompilePC.regexp_fieldnames={'cB'}; % whatever
% want to call structure field (if this cell array not defined, then will
% attempt to use the regexp names.
    
[ALLDATSTRUCT, Params_global]= lt_extract_CompilePC(plotON, Params_global, saveON);


%% Convert to context1 format
% --- TO BE ABLE TO RUN USING CONTEXT PLOT SAME AS FOR METHOD 1
% Params_global.ConvertToContext1.NoteNum_codes={'dcc_b_', 1, 'bcc_b_', 2}; % {notestring, notenum} pairs - notestring either single syl (e.g. 'a') or regexp, using underscores (e.g. 'dcc_b_')
Params_global.ConvertToContext1.NoteNum_codes={'cB', 1}; % {notestring, notenum} pairs - notestring either single syl (e.g. 'a') or regexp, using underscores (e.g. 'dcc_b_')

% syl='b';

Params_global.ConvertToContext1.UseAutoNG = 1; % if 1, this uses .ltrec2 saved note group information (this was extracted in lt_extract_AllDaysPC)
% if 0, then uses the names of directories - assumes that each directory
% (for a given day) was a different context
% ([date]_[experimentname]_[context_name]); if 0, then need to fill this
% out. If 1, then don't need this - can leave the field as whatever, will
% delete the entry.
Params_global.ConvertToContext1.NoteGroupNum_codes={'away', 1, 'home', 2}; % {NoteGroup_name, NoteGroupNum} pairs - name must match what is in "condition" field. NoteGroupNum can be anything (keep it from 1, 2, ...);



[AllSongsDataMatrix, Params_alldays]= lt_context2_ConvertToContext1(ALLDATSTRUCT, Params_global);


%% PLOT
% USING SAME CONTEXT PLOT CODE FROM METHOD 1
close all;
Params_alldays.NoteToPlot=1;
Params_alldays.RunBin=10;

Params_alldays.BoundaryTimes={'27Mar2017-0931', '28Mar2017-1019', ...
     '31Mar2017-1139', '02Apr2017-1904', '04Apr2017-0900', ...
     '10Apr2017-1024', '13Apr2017-2027', '17Apr2017-1326', ...
     '26Apr2017-2157', '30Apr2017-1120'}; % in format of e.g. 05May2014-1423, these are times of switching in experiment (e.g. turning WN off and on, changing pitch contingency, etc)
Params_alldays.Edge_Num_Rends = 5; % num rends to call "edges"

Params_alldays.throw_out_if_epoch_diff_days=0; % throws out any transitions that overlap with O/N (potentially 2 per O/N)
one_switch_a_day=0; % manual switching experiemnts.

plotIndTrials = 1;

justDoExtraction = 0;
lt_context_PLOT(AllSongsDataMatrix, Params_alldays, one_switch_a_day, plotIndTrials, ...
    justDoExtraction);

%% ############ [OPTO LASER PLOT]
%% === 1) EXTRACT SONG DATA
justDoExtraction = 1;
[SORTED_DATA, PARAMS_GLOB] = lt_context_PLOT(AllSongsDataMatrix, Params_alldays, one_switch_a_day, plotIndTrials, ...
    justDoExtraction);


%% === 2) GET SUMMAR ACROSS PHASES, LASER EFFECT.

% ============ PARAMS

% datatype = 'phase'; % one value per phase
datatype = 'day'; % one value per day

% ====== for each phase, specify direction of learning
% disp('this is learning in notegroup 0. notegroup 0 must always be laser');
% disp('i.e. assumes that laser is in notegroup 0 and that is paired with some dir of laerning that depends on phase of expt');
disp(' THIS ASSUMES THAT THE NG ASSOCAITED WITH LASER DOES NOT CHANGE DURING THE EXPT...');
pause;



% ======================================
% === for each phase and each notegroup get one mean FF across trials
numNG = length(SORTED_DATA.ByNoteGroup);
numPhase = length(PARAMS_GLOB.Phases_DayBounds);

PARAMS_GLOB.Assoc_PhaseLearndirMapping = nan(numPhase,1);
PARAMS_GLOB.Assoc_PhaseLearndirMapping(3) = 1;
PARAMS_GLOB.Assoc_PhaseLearndirMapping(4) = -1;
PARAMS_GLOB.Assoc_PhaseLearndirMapping(6) = -1;
PARAMS_GLOB.Assoc_PhaseLearndirMapping(7) = -1;
PARAMS_GLOB.Assoc_PhaseLearndirMapping(8) = 1;
PARAMS_GLOB.Assoc_PhaseLearndirMapping(9) = 1;
PARAMS_GLOB.Assoc_PhaseLearndirMapping(11) = 1;
PARAMS_GLOB.Assoc_LaserNGnum = 0;
PARAMS_GLOB.Assoc_LaserOffNGnum = 1;


%% ============================= [PLOT ACROSS DAY SUMMARY]
lt_figure; hold on;


% =================== LASER
pcol = 'b';
ng = PARAMS_GLOB.Assoc_LaserNGnum+1;

% ----------- RUN
ffvals = cell2mat(cellfun(@transpose, SORTED_DATA.ByNoteGroup(ng).Stats_OneDataPtPerEpoch.RAW.FFvals, 'UniformOutput', 0));
tvals = cell2mat(cellfun(@transpose, SORTED_DATA.ByNoteGroup(ng).Stats_OneDataPtPerEpoch.RAW.Tvals, 'UniformOutput', 0));
phasenums = cell2mat(cellfun(@transpose, SORTED_DATA.ByNoteGroup(ng).Stats_OneDataPtPerEpoch.RAW.PhaseNumvals, 'UniformOutput', 0));

% --- day means
[ffmean, ffsem] = grpstats(ffvals, floor(tvals), {'mean', 'sem'});
x = unique(floor(tvals))+0.5;
lt_plot(x, ffmean, {'Errors', ffsem, 'Color', pcol});



% =================== NO LASER
pcol = [0.8 0.5 0.5];
ng = PARAMS_GLOB.Assoc_LaserOffNGnum+1;

% ----------- RUN
ffvals = cell2mat(cellfun(@transpose, SORTED_DATA.ByNoteGroup(ng).Stats_OneDataPtPerEpoch.RAW.FFvals, 'UniformOutput', 0));
tvals = cell2mat(cellfun(@transpose, SORTED_DATA.ByNoteGroup(ng).Stats_OneDataPtPerEpoch.RAW.Tvals, 'UniformOutput', 0));
phasenums = cell2mat(cellfun(@transpose, SORTED_DATA.ByNoteGroup(ng).Stats_OneDataPtPerEpoch.RAW.PhaseNumvals, 'UniformOutput', 0));

% --- day means
[ffmean, ffsem] = grpstats(ffvals, floor(tvals), {'mean', 'sem'});
x = unique(floor(tvals))+0.5;
lt_plot(x, ffmean, {'Errors', ffsem, 'Color', pcol});


% ============== PUT LINES FOR PHASES
nphases = length(PARAMS_GLOB.BoundaryTimes_DayUnits)+1;
for n=1:nphases
   
    % -- boundary line
    if n<=nphases-1
    btime = PARAMS_GLOB.BoundaryTimes_DayUnits(n);
    line([btime btime], ylim, 'Color', 'k');
    end
    
    % -- line spanning
    XLIM = xlim;
    YLIM = ylim;
    dirthis = PARAMS_GLOB.Assoc_PhaseLearndirMapping(n);
    if n==1
        xthis = [XLIM(1) PARAMS_GLOB.BoundaryTimes_DayUnits(n)];
    elseif n==nphases
        xthis = [PARAMS_GLOB.BoundaryTimes_DayUnits(n-1) XLIM(2)];
    else
        xthis = [PARAMS_GLOB.BoundaryTimes_DayUnits(n-1) ...
            PARAMS_GLOB.BoundaryTimes_DayUnits(n)];
    end
    if dirthis==1
        linecol = [0.4 0.8 0.4];
    elseif dirthis==-1
        linecol = [0.6 0.2 0.6];
    else
        linecol = [0.8 0.8 0.8];
    end
    line(xthis, [YLIM(2)-20 YLIM(2)-20], 'Color', linecol);
    lt_plot_text(mean(xthis), YLIM(2)-10, num2str(dirthis), linecol);
end
%%
% AllFFmeans_NGxPhase = nan(numNG, numPhase);
AllFFmeans_NGxPhase = cell(numNG, numPhase);
AllDayNums_NGxPhase = cell(numNG, numPhase);
for ng = 1:numNG
    for pp=1:numPhase
        
        % --- get "epochs" within this phase
        indsepoch = SORTED_DATA.ByNoteGroup(ng).Stats_OneDataPtPerEpoch.PhaseNum_array == pp;
        
        % --- get all trials within this pohase
        ffvals = cell2mat(cellfun(@transpose, SORTED_DATA.ByNoteGroup(ng).Stats_OneDataPtPerEpoch.RAW.FFvals(indsepoch), 'UniformOutput', 0));
        tvals = cell2mat(cellfun(@transpose, SORTED_DATA.ByNoteGroup(ng).Stats_OneDataPtPerEpoch.RAW.Tvals(indsepoch), 'UniformOutput', 0));
        %         ffvals = SORTED_DATA.ByNoteGroup(ng).Stats_OneDataPtPerEpoch.meanFF(indsepoch);
        
        %         AllFFmeans_NGxPhase(ng, pp) = mean(ffvals);
        if strcmp(datatype, 'phase')
            AllFFmeans_NGxPhase{ng, pp} = mean(ffvals);
        elseif strcmp(datatype, 'day')
            ffmeans = grpstats(ffvals, floor(tvals), {'mean'}); % get day means
            AllFFmeans_NGxPhase{ng, pp} = ffmeans;
            AllDayNums_NGxPhase{ng, pp} = unique(floor(tvals))';
        end
    end
end
    

% ============= go thru all phases, collect data
ng_las = PARAMS_GLOB.Assoc_LaserNGnum+1;
ng_nolas = PARAMS_GLOB.Assoc_LaserOffNGnum+1;

phasestoget = find(~isnan(PARAMS_GLOB.Assoc_PhaseLearndirMapping));

FFmeans_Las_NoLas = [];
Daynums_Las_NoLas = [];
LaserLearnDir = [];
Phasenum = [];
for pp=phasestoget'
   
    ffthis = AllFFmeans_NGxPhase([ng_las ng_nolas], pp);
    daythis = AllDayNums_NGxPhase([ng_las ng_nolas], pp);
    trdir = PARAMS_GLOB.Assoc_PhaseLearndirMapping(pp);
    
    % ======= save output
    FFmeans_Las_NoLas = [FFmeans_Las_NoLas; ffthis'];
    Daynums_Las_NoLas = [Daynums_Las_NoLas; daythis'];
    LaserLearnDir = [LaserLearnDir; trdir];
    Phasenum = [Phasenum; pp];

end

% =============== BREAK OUT INDIVIDUAL DAYS (IF MULTIPE IN PHASES)
FFmeans_Las_NoLas_TMP = [];
Daynums_Las_NoLas_TMP = [];
LaserLearnDir_TMP = [];
Phasenum_TMP = [];
nrows = size(FFmeans_Las_NoLas,1);
for i=1:nrows

    ffmeans = [FFmeans_Las_NoLas{i,1} FFmeans_Las_NoLas{i,2}];
    daythis = [Daynums_Las_NoLas{i,1}, Daynums_Las_NoLas{i,2}];
    ldir = LaserLearnDir(i);
    ph = Phasenum(i);
    
    % ===== stick into new output
FFmeans_Las_NoLas_TMP = [FFmeans_Las_NoLas_TMP; ffmeans];
Daynums_Las_NoLas_TMP = [Daynums_Las_NoLas_TMP; daythis];
LaserLearnDir_TMP = [LaserLearnDir_TMP; ones(size(ffmeans,1),1)*ldir];
Phasenum_TMP = [Phasenum_TMP; ones(size(ffmeans,1),1)*ph];
end
FFmeans_Las_NoLas = FFmeans_Las_NoLas_TMP;
Daynums_Las_NoLas = Daynums_Las_NoLas_TMP;
LaserLearnDir = LaserLearnDir_TMP;
Phasenum = Phasenum_TMP;


% ############### [PLOT]
figcount=1;
subplotrows=4;
subplotcols=3;
fignums_alreadyused=[];
hfigs=[];
hsplots = [];

% ====== [LASER + WN UP]
[fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
xlabel('laser -- nolaser');
ylabel('mean ff (each phase)');
title('laser + WN up');

ff = FFmeans_Las_NoLas(LaserLearnDir==1, :);
x = [1 2];
plot(x, ff', '-ok');
xlim([0 3]);

% ====== [LASER + WN DN]
[fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
xlabel('laser -- nolaser');
ylabel('mean ff (each phase)');
title('laser + WN dn');

ff = FFmeans_Las_NoLas(LaserLearnDir==-1, :);
x = [1 2];
plot(x, ff', '-ok');
xlim([0 3]);


% ======== [COMBINED - PLOT DIFFERENCE (LASER MINUS NO LASER)]
[fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
xlabel('laser+DN ------ Laser+UP');
ylabel('diff in mean ff (laser - nolaser)');
title('phase = dtpt');

ffdiff = FFmeans_Las_NoLas(:,1) - FFmeans_Las_NoLas(:,2);
x = LaserLearnDir;
plot(x, ffdiff, 'ok');

% -- means
[ymean, ysem] = grpstats(ffdiff, x, {'mean', 'sem'});
lt_plot(unique(x)+0.2, ymean, {'Errors', ysem, 'Color', 'r'});
[h, p] = ttest2(ffdiff(x==1), ffdiff(x==-1));
lt_plot_pvalue(p, 'ttest2', 1);
xlim([-2 2]);
lt_plot_zeroline;
axis tight

%% =============== CONVERT TO FORMAT TO USE IN OPTO ANALYSIS 
% i.e. see lt_opto_MasterScript

% start from these
% FFmeans_Las_NoLas = FFmeans_Las_NoLas_TMP;
% LaserLearnDir = LaserLearnDir_TMP;
% Phasenum = Phasenum_TMP;

dat = struct;
dat.All_FFmeanStimMinusNostim = FFmeans_Las_NoLas(:,1) - FFmeans_Las_NoLas(:,2);
dat.All_daynums = Daynums_Las_NoLas(:,1);
dat.All_traindir = LaserLearnDir;
dat.SORTED_DATA = SORTED_DATA;
dat.PARAMS_GLOB = PARAMS_GLOB;
dat.Params_global = Params_global;
dat.Params_alldays = Params_alldays;

bname = 'or60';
savename = ['/bluejay5/lucas/analyses/opto/ConvertFromContextToOpto/dat_' bname '_' Params_global.ind_days(1).experiment '.mat'];
save(savename, 'dat');
disp(['SAVED! at ' savename]);

%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
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

