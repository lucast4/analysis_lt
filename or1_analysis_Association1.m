%%  NO LABEL REQUIRED - USED FOR ANALYSIS OF LEARNING SCREENING
% close all;
% 
% Params.batch='batch';
% Params.config='/bluejay5/lucas/birds/or60/config.evconfig2';
% Params.NoteNum_to_plot=0; % for the note you want to analyze
% [AllSongsData_toplot, AllData] = lt_check_hit_templ_freq_NoLabelRequired(Params);
% 
% 
%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% Reversion1

%% CHECKING TEMPLATE MATCHING;



% ----------------------------- v2: (laser , wn c1)
% === WN (cc[b]) NOTE 0
clear all; close all;
batchf='batch.labeled.all';
config = '/bluejay5/lucas/birds/or1/config041317.evconfig2';
config = '/bluejay5/lucas/birds/or1/config041917.evconfig2';

syl='c';
syl_pre='f';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


% === LASER
syl='d';
syl_pre='h';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=0;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


%% ====== ALIGNING STIM TO SONG
close all; 
songf = 'or1_STIMon_040517_165907.4141.cbin'; % either .cbin file or batch
songf = 'batch.labeled.all'; % either .cbin file or batch
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







% %% ====================== ANALYSIS
% clear Params
% clear StatsStruct
% 
%     Params.batch='batch.labeled.all';
%     Params.ExptID='Stim'; % an identifier for the data in this batch file. leave as '' to use 'All' as default. ('Stim' is for stim epochs).
%     Params.DataInfo='UnDir'; % To note information about data, 'Dir' and 'UnDir' means this is directed or undirected song.
%     Params.Fs=32000;
% %         WHERE TO ALIGN SONGS
%     Params.SylTarg='c'; % aligns to onset of this
%     Params.PreNote='f';
%     
%     Params.PreDur=0.5; % sec, how much data to take before targ
%     Params.PostSylOnsetDur=0.2; % sec, data post to take
%     Params.TargNoteNum=0; % template note directed to target
%     Params.TargTrigCatchRate=0; % catch trial fraction at target
% 
% %         STIM
%     Params.notenum_stim=1; % of Stim - CONFIRMED THIS WORKS
%     Params.StimDelay=150; % in ms, delay from trigger to stim on
%     Params.StimDur=350; % duration of Stim, in ms
%     Params.StimType='pulse'; % either 'constant' or 'pulse'
%     
% %     	for pitch contour
%     Params.PC_freqrange=[1800 3000]; % for both pitch contour and find note
%     Params.pc_harms=1;
% 
% %     	To sort into stim vs. notstim trials
%     Params.StimLatencyWindow=[-450, -250]; % [a b] a and b are times (in negative ms) preceding syl onset. If stim is within this window, then will call a "stim trial."
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
% Params.FieldsToCheck{1}='StimCatch';
% Params.FieldsToCheck{2}='StimNotCatch';
% % Params.FieldsToCheck{1}='NotStim';
% % Params.FieldsToCheck{2}='Stim';
% % Params.FieldsToCheck{1}='COMBO_StimCatch_TargAllCatch';
% % Params.FieldsToCheck{2}='COMBO_StimNotCatch_TargAllCatch';
% % Params.FieldsToCheck{1}='SIMULATE_Catch';
% % Params.FieldsToCheck{2}='SIMULATE_NotCatch';
% % Params.FieldsToCheck{1}='All';
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
% Params.TimeWindowList{1}= [532 542]; % during WN
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
% % DISPLAY SUMMARY STATS
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
% Params_metadata.date_range={'15Apr2017', '17Apr2017'};
% Params_metadata.only_labeled_dirs=1;
% 
% % ===== For opto analysis
% Params_glob.DataInfo='UnDir'; % To note information about data, 'Dir' and 'UnDir' means this is directed or undirected song.
% Params_glob.Fs=32000;
% 
% %         WHERE TO ALIGN SONGS
% Params_glob.SylTarg='c'; % aligns to onset of this
% Params_glob.PreNote='f';
% 
% Params_glob.PreDur=0.5; % sec, how much data to take before targ
% Params_glob.PostSylOnsetDur=0.2; % sec, data post to take
% Params_glob.TargNoteNum=0; % template note directed to target
% Params_glob.TargTrigCatchRate=0; % catch trial fraction at target
% 
% %         STIM
% Params_glob.notenum_stim=1; % of Stim - CONFIRMED THIS WORKS
% Params_glob.StimDelay=150; % in ms, delay from trigger to stim on
% Params_glob.StimDur=350; % duration of Stim, in ms
% Params_glob.StimType='pulse'; % either 'constant' or 'pulse'
% 
% %     	for pitch contour
% Params_glob.PC_freqrange=[1800 3000]; % for both pitch contour and find note
% Params_glob.pc_harms=1;
% 
% %     	To sort into stim vs. notstim trials
% Params_glob.StimLatencyWindow=[-450, -250]; % [a b] a and b are times (in negative ms) preceding syl onset. If stim is within this window, then will call a "stim trial."
% 
% % Time Window List
% % DURING WN (on window 3)
% Params_glob.TimeWindowList{1}=[532 542];
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
% cd ../../../
% 
% 
% %% ==================== PLOT ACROSS DAYS
% close all;
% 
% % ==== Params for analysis
% BirdDir='/bluejay5/lucas/birds/or1/';
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
% date_range={'06Apr2017', '17Apr2017'};
% only_labeled_dirs=1;
% 
% ListOfDirs2=lt_metadata_find_dirs(MetadataStruct, experiment, condition, notes, date_range, only_labeled_dirs);
% 
% % get the correct subdir that contains opto stats
% c=1;
% for i=1:length(ListOfDirs2);
%     cd(ListOfDirs2{i});
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
% 
% MetaParams.WNonDates = {'07Apr2017-1109-up', '14Apr2017-1330-dn'}; % times when WN epochs began
% 
% 
% lt_Opto_Stim_analy_SUMMARY_PlotOverTime(BirdDir, ListOfDirs_all,TimeFieldsOfInterest, ...
%     statfield,BaselineDays,plotStimEpochs, MetaParams)
% 
% 
% 
% %% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% %% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% %% AUTOLABEL
% 
% % batch = 'batch.keep.UNLABELED';
% batch = 'batch.keep';
% config = '/bluejay5/lucas/birds/or1/config_autolabel.evconfig2';
% 
% syl.targ='c';
% syl.pre='kkmhdef';
% syl.post=''; 
% NoteNum=0; 
% 
% ampThresh=9000;
% min_dur=20;
% min_int=5;
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


%% === context analysis for association
%% ======================= Extracting data across days
% --- day directories must be in format
% [date]_[experimentname]_[context_name].
% -- Run this in bird folder to extract all days data to subfolder

clear all; close all;

Params.syl_list={'c'}; % single syls
Params.freq_range_list={[1700 2800]};
Params.pc_dur_list=[0.13];
Params.pc_harms_list=[1];

Params.batch='batch.labeled.all';
Params.experiment = 'Association1';

date_range={'24Mar2017', '25Mar2017'}; % e.g. {'20Apr2015','20May2015'}. leave blank ('') for all days

% ---- 2) Collect note group information? 
CollectNoteGroup = 1; % set to 1 if want to use online NoteGroups. Otherwise will do context stuff using the 
% [context_name] condition in the folder name - i.e. for bulk context, not
% rapid switching experiments. 

lt_extract_AllDaysPC(Params, date_range, CollectNoteGroup)


%% Compiling data - go to "extract" folder first
clear all; close all;
Params_global.CompilePC.PC_window_list={'c', [230 287]}; % syl, value pairs [single syls]
Params_global.CompilePC.FirstDay='';
Params_global.CompilePC.LastDay='';
plotON=1; % pitch contours, all days, all syls
saveON=1;

% Regular expressions - first calculates FF etc, then performs regular
% expressions
Params_global.CompilePC.regexp_list={'f(c)'}; % e.g. {'dcc(b)', 'ab+(g)'} : dcc(b) means match dccb, and give me ind of b in parantheses.  ab+(g) means match ab... (anly length repeat), then g. give me ind of g
Params_global.CompilePC.regexp_fieldnames={'fC'}; % whatever
% want to call structure field (if this cell array not defined, then will
% attempt to use the regexp names.
    
[ALLDATSTRUCT, Params_global]= lt_extract_CompilePC(plotON, Params_global, saveON);


%% Convert to context1 format
% --- TO BE ABLE TO RUN USING CONTEXT PLOT SAME AS FOR METHOD 1
% Params_global.ConvertToContext1.NoteNum_codes={'dcc_b_', 1, 'bcc_b_', 2}; % {notestring, notenum} pairs - notestring either single syl (e.g. 'a') or regexp, using underscores (e.g. 'dcc_b_')
Params_global.ConvertToContext1.NoteNum_codes={'fC', 1}; % {notestring, notenum} pairs - notestring either single syl (e.g. 'a') or regexp, using underscores (e.g. 'dcc_b_')

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

Params_alldays.BoundaryTimes={'07Apr2017-1109', '19Apr2017-0946', '25Apr2017-2032', '03May2017-1002', ...
    '07May2017-2151', '12May2017-1423'}; % laserDN, laserUP, laserPOWERINCREASE
Params_alldays.Edge_Num_Rends = 5; % num rends to call "edges"

Params_alldays.throw_out_if_epoch_diff_days=0; % throws out any transitions that overlap with O/N (potentially 2 per O/N)
one_switch_a_day=0; % manual switching experiemnts.

plotIndTrials = 1;

lt_context_PLOT(AllSongsDataMatrix, Params_alldays, one_switch_a_day, plotIndTrials);
