%% 1) Gather raw data for this day
clear all; close all;

Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.all';
% Params.DayRawDat.syllables={'a','b','c'};
% Params.DayRawDat.frequency_range={[1300 2200], [2800 3950],[2150 3150]};
% Params.DayRawDat.pc_dur=[0.12,0.11,0.10];
% % Params.DayRawDat.pc_time_window={[375 525],[60 220],[55 320]};
% Params.DayRawDat.pc_time_window={[375 525],[30 50],[55 320]}; % WN over b
Params.DayRawDat.syllables={'a','b','c', 'd'};
Params.DayRawDat.frequency_range={[1300 2200], [2800 3950],[2150 3150], [1100 2700]};
Params.DayRawDat.pc_dur=[0.12,0.11,0.11, 0.1];
Params.DayRawDat.pc_time_window={[375 525],[60 220],[55 320],[10 180]};

Params.DayRawDat.pc_sigma=1;

% --- trying to get all syllables - look at code to check
% Params.DayRawDat.syllables={'a','ab','cb','bb','cc','bc','dc'};
% Params.DayRawDat.frequency_range={[1300 2200], [2800 3950],[2800 3950],[2800 3950],[2150 3150],[2150 3150],[2150 3150]};
% Params.DayRawDat.pc_dur=[0.12,0.09,0.09,0.09,0.11,0.11,0.11];
% Params.DayRawDat.pc_time_window={[375 525],[60 220],[60 220],[60 220],[55 320],[55 320],[55 320]};

% plot and save?
plotON=1;
saveON=1;

% Related to LMAN inactivation
plotLMANinact=1;
Params.DayRawDat.Musc_On_Time='1153'; % time given muscimol - will plot data with temporal lag after this.
Params.DayRawDat.Musc_Off_Time='1700';

[Params, RawDatStruct]=lt_seq_dep_pitch_DayRawDat(Params,1,1,'',plotLMANinact);



%% Script to change name of all song files in a day to stick "PBS" or "MUSC" right after bird name

StringToAdd='PBS';

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



%% ANALYSIS ACROSS DAYS ============================================================
%% 1) GATHER RAW DATA ACROSS DAYS

clear all; close all
phrase = 'SeqDepPitchLMAN';
first_day= '12May2015';
last_day= '19Jun2015';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.all';
Params.DayRawDat.syllables={'a','b','c','d'};
Params.DayRawDat.frequency_range={[1300 2200], [2850 3807],[2250 2980], [1470 2680]};
Params.DayRawDat.pc_dur=[0.12,0.11,0.11, 0.1];
Params.DayRawDat.pc_time_window={[375 525],[60 220],[190 275],[20 120]};
Params.DayRawDat.pc_sigma=1;

% OLD
% Params.DayRawDat.frequency_range={[1300 2200], [2800 3950],[2150 3150], [1100 2700]};
% Params.DayRawDat.pc_dur=[0.12,0.11,0.11, 0.1];
% Params.DayRawDat.pc_time_window={[375 525],[60 220],[55 320],[10 180]};


plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);



%% 2) Seq filter, remove outliers, and compile raw data, and enter experiment info into params
cd seq_dep_pitch_SeqDepPitchLMAN/
clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=17000;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

Params.SeqFilter.SeqPreList={'a','ab','bcc','bccb','dcc','dccb','b','bc','d','dc'};
Params.SeqFilter.SylTargList={'b','b','b','b','b','b','c','c','c','c'};
Params.SeqFilter.SeqPostList={'','','','','','','','','',''};


% 2) experiment info
Params.SeqFilter.WNTimeON='12May2015-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '18Jun2015-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:5;

Params.SeqFilter.SylLists.FieldsToPlot{1}={'aB','abB','bccB','bccbB','dccB','dccbB'};
Params.SeqFilter.SylLists.FieldsToPlot{2}={'d','bC','bcC','dC','dcC'};
Params.SeqFilter.SylLists.FieldsInOrder{1}={'a','aB','abB','bC','bcC','bccB','bccbB'};
Params.SeqFilter.SylLists.FieldsInOrder{2}={'d','dC','dcC','dccB','dccbB'};
Params.SeqFilter.SylLists.TargetSyls={'bccB'};
Params.SeqFilter.SylLists.SylsSame={'aB','abB','bccbB','dccB','dccbB'};
Params.SeqFilter.SylLists.SylsDifferent={'a','d','bC','bcC','dC','dcC'};

Params.SeqFilter.DaysForSnapshot{1}={'06Jun2015','08Jun2015'};
Params.SeqFilter.DaysToMark= {'08Jun2015-2400', '16Jun2015-2400', '18Jun2015-2400'}; % will mark all plots with lines here;

% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);



%% Recalculate FF using new time windows
close all
Params.RecalculateFF.pc_time_window_list=Params.SeqFilter.pc_time_window_list{1}; % list is the same as specified for seq filter, except one change:
% Params.RecalculateFF.pc_time_window_list(:,7)=[45 55]; % bccb should have different time window.
% Params.RecalculateFF.pc_time_window_list(:,9)=[49 56]; % dccb should have different time window.
Params.RecalculateFF.pc_time_window_list(:,7)=[48 61]; % bccb should have different time window.
Params.RecalculateFF.pc_time_window_list(:,9)=[50 60]; % dccb should have different time window.
plotON=0;

[Params, AllDays_RawDatStruct] = lt_seq_dep_pitch_RecalculateFF(Params, AllDays_RawDatStruct, plotON);


%% 3) Perform various analyses on that data structure
close all; 

% below, times of muscimol in and out (2 times per day)
% Params.PlotLearning.MuscimolSchedule={...
%     {'03May2015', '1337', '1745'}, ...
%     {'04May2015', '1259', '1700'}, ...
%     {'05May2015', '1401', '2036'}, ...
%     {'07May2015', '1125', '1719'}, ...
%     {'08May2015', '1155', '1636'}, ...
%     {'09May2015', '1404', '1915'}, ...
%     {'10May2015', '1238', '1831'}, ...
%     {'11May2015', '1215', '1555'}, ...
%     {'18May2015', '1150', '1643'}, ...
%     {'20May2015', '1153', '1700'}, ...
%     {'22May2015', '1200', '1656'}, ...
%     {'24May2015', '1217', '1706'}};

Params.PlotLearning.MuscimolSchedule={...
    {'07May2015', '1125', '1719'}, ...
    {'08May2015', '1155', '1636'}, ...
    {'09May2015', '1404', '1915'}, ...
    {'10May2015', '1238', '1831'}, ...
    {'11May2015', '1215', '1555'}, ...
    {'18May2015', '1150', '1643'}, ...
    {'20May2015', '1153', '1700'}, ...
    {'22May2015', '1200', '1656'}, ...
    {'24May2015', '1217', '1706'}, ...
    {'26May2015', '1211', '1709'}, ...
    {'28May2015', '1208', '1745'}, ...
    {'30May2015', '1218', '1730'}, ...
    {'01Jun2015', '1336', '1700'}, ... % actually, 1202, but effects really slow.
    {'03Jun2015', '1156', '1654'}, ... 
    {'04Jun2015', '1210', '1723'}, ...
    {'06Jun2015', '1236', '1701'}, ...
    {'07Jun2015', '1151', '1523'}, ...
    {'09Jun2015', '1217', '1655'}, ...
    {'11Jun2015', '1218', '1721'}, ...
    {'13Jun2015', '1232', '1725'}, ...
    {'15Jun2015', '1230', '1727'}, ...
    {'17Jun2015', '1234', '1740'}, ...
    {'19Jun2015', '1240', '1735'}};
    

Params.PlotLearning.MuscimolDaysToThrowout={'08May2015', '09May2015', '10May2015', '03Jun2015'};

Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;


[Params, AllDays_PlotLearning, AllDays_RawDatStruct]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);


%% 4) PLOT - looking at effects of LMAN inactivation
close all;
Params.PlotLearning.Lag_time=2;
Params.PlotLearning.PBS_window=[-3 1];

Params.PlotLearning.timeline.consolid_start='26May2015';
Params.PlotLearning.timeline.consolid_end='08Jun2015';
Params.PlotLearning.timeline.bidir_start='09Jun2015';
Params.PlotLearning.timeline.bidir_end='16Jun2015';

[Params, AllDays_PlotLearning]= lt_seq_dep_pitch_PlotLearning_Musc(Params, AllDays_PlotLearning);



%% ========================== Use regular expressions to sort data from Raw data

Params.RegExpr.expressions={'abbccbb', 'dccbb'};
DoLMAN=1;
saveON=1;
[Params, AllDays_RegExpr] = lt_seq_dep_pitch_RegExpr(Params, AllDays_RawDatStruct, saveON, DoLMAN, AllDays_PlotLearning);


% ========================== PLOT REG EXPR DATA
Params.PlotRegExpr.plotWNdays=1;
saveON=1;
LMANon=1;
[Params, AllDays_RegExpr]=lt_seq_dep_pitch_PlotRegExpr(Params, AllDays_RegExpr ,saveON, LMANon);


%% =======  STRUCTURE STATS

[Params, AllDays_StructStatsStruct]=lt_seq_dep_pitch_StructureStats(Params, AllDays_RawDatStruct, DoLMAN, AllDays_PlotLearning);



%% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% TEMPORARY - PLOTTING BASELINE PITCH ALL DAYS, after seq compile =============

NumDays=length(AllDays_RawDatStruct);

syllist=Params.SeqFilter.SylLists.FieldsToPlot{1};

% str_to_plot='PBS';

firstday='06May2015';

for j=1:length(syllist);
    syl=syllist{j};
    lt_figure; hold on;
    title(syl);
    
    for i=1:NumDays;

        if isempty(AllDays_RawDatStruct{i});
continue
end

        NumRends=size(AllDays_RawDatStruct{i}.data.(syl),1);
        
        Ytot_PBS=[];
        Ytot_MUSC=[];
        for ii=1:NumRends
            
                tval=lt_convert_EventTimes_to_RelTimes(firstday,AllDays_RawDatStruct{i}.data.(syl){ii,6});
                tval=tval.FinalValue;
                yval=AllDays_RawDatStruct{i}.data.(syl){ii,1};

               
                if any(strfind(AllDays_RawDatStruct{i}.data.(syl){ii,5},'PBS'));
                
                
                plot(tval,yval,'ob');
                 
                Ytot_PBS=[Ytot_PBS yval];
                
                elseif any(strfind(AllDays_RawDatStruct{i}.data.(syl){ii,5},'MUSC'))
                    
                plot(tval,yval,'or');
                Ytot_MUSC=[Ytot_MUSC yval];
                grid on
            end
            
            
        end
             plot(tval,mean(Ytot_PBS),'sb','MarkerFaceColor','b');
             plot(tval,mean(Ytot_MUSC),'sr','MarkerFaceColor','r');
       
        
    end
end



%% CHECKING TEMPLATE MATCHING (getting bcc[b], use note 1);
clear all; close all;

batchf='batch.labeled.catch';
% config='/bluejay3/lucas/birds/pu11wh87/121214_SeqDepPitchShift2_UpAndDn_durWN_day20/config_121114_Start.evconfig2';
% config='/bluejay3/lucas/birds/pu11wh87/051115_SeqDepPitchLMAN_PbsMusc/test.evconfig2';
% config='/bluejay3/lucas/birds/pu11wh87/051215_SeqDepPitchLMAN_durWN_day1/config.evconfig2'; % start of WN (5/12)
% config='/bluejay3/lucas/birds/pu11wh87/051315_SeqDepPitchLMAN_durWN_day2/config051315.evconfig2'; % post 5/13 (changed 1 template param)
% config='/bluejay3/lucas/birds/pu11wh87/051715_SeqDepPitchLMAN_durWN_day6/config.evconfig2'; % start 5/17 (changed template)
config='/bluejay5/lucas/birds/pu11wh87/060915_SeqDepPitchLMAN_TwoTargs_durWN/c.evconfig2'; % start 6/9 (no change from before)

syl='b';
syl_pre='bcc';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% === GETTING dccb
batchf='batch.labeled.all';
% config='/bluejay3/lucas/birds/pu11wh87/121214_SeqDepPitchShift2_UpAndDn_durWN_day20/config_121114_Start.evconfig2';
% config='/bluejay3/lucas/birds/pu11wh87/051115_SeqDepPitchLMAN_PbsMusc/test.evconfig2';
% config='/bluejay3/lucas/birds/pu11wh87/051215_SeqDepPitchLMAN_durWN_day1/config.evconfig2'; % start of WN (5/12)
% config='/bluejay3/lucas/birds/pu11wh87/051315_SeqDepPitchLMAN_durWN_day2/config051315.evconfig2'; % post 5/13 (changed 1 template param)
% config='/bluejay3/lucas/birds/pu11wh87/051715_SeqDepPitchLMAN_durWN_day6/config.evconfig2'; % start 5/17 (changed template)
config='/bluejay5/lucas/birds/pu11wh87/060915_SeqDepPitchLMAN_TwoTargs_durWN/c.evconfig2'; % start 5/17 (changed template)


syl='b';
syl_pre='dcc';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


%% AUTOLABEL - 

batch = 'batch.keep';
config = '/bluejay3/lucas/birds/pu11wh87/051815_SeqDepPitchLMAN_durWN_MUSC_day7/config.evconfig2';
syl.targ='b';
syl.pre='bcc';
syl.post='';

NoteNum=1;
ampThresh=17000;
min_dur=30;
min_int=5;
overwrite_notmat=1;


lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat)


%% ###################################################################
%% ################################################# AUTOLABEL

% STRATEGY for complete labeling:
% first label all c(b) as dccb, then overwrite those that are bccb

%% =============== TEST CONFIGS
clear all; close all;


% ===== MOTIF 1 - bccB
% NOTE: good, hits almost all, but some FP.
batchf = 'BatchAll.LABELED.rand';
% config='/bluejay4/lucas/birds/pu11wh87/config_111715.evconfig2'; 
config='/bluejay5/lucas/birds/pu11wh87/config_AL_bccB.evconfig2'; 

syl='b';
syl_pre='bcc';
syl_post='';
get_WN_hits=0;
get_offline_match=1;
get_FF=0;

NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


% ===== MOTIF 1 - bccB
% MATCHED ALL
batchf = 'BatchAll.LABELED.rand';
% config='/bluejay4/lucas/birds/pu11wh87/config_111715.evconfig2'; 
config='/bluejay5/lucas/birds/pu11wh87/config_AL_dccB_2.evconfig2'; 
config='/bluejay5/lucas/birds/pu11wh87/config_AL_dccB_3.evconfig2'; % modified template

syl='b';
syl_pre='dcc';
syl_post='';
get_WN_hits=0;
get_offline_match=1;
get_FF=0;

NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


%% ================ AUTOLABLE
% AND ITERATION OVER DAY
clear all; close all;

% ========================= 0) ECTRACT DIRECTORIRES
basedir = '/bluejay5/lucas/birds/pu11wh87';
% date_range_base={'10Feb2015','12Feb2015'};
% date_range_WN={'14Feb2015','16Feb2015'};
% experiment = 'SeqDepPitchShift3';

    
% -------- COLLECT METADAT
% cd(basedir);
% MetadataStruct=lt_metadata_collect;
% 
% condition='';
% notes='';
% only_labeled_dirs=0;
% 
% % ----- BASELINE
% ListOfDirs1=lt_metadata_find_dirs(MetadataStruct, experiment, condition, ...
%     notes, date_range_base, only_labeled_dirs, 2);
% 
% % ------ WN
% ListOfDirs2=lt_metadata_find_dirs(MetadataStruct, experiment, condition, ...
%     notes, date_range_WN, only_labeled_dirs, 2);
% 
% % ------- COMBINE
% ListOfDirs = [ListOfDirs1 ListOfDirs2];
% 
ListOfDirs = {...
    '/bluejay5/lucas/birds/pu11wh87/050215_SeqDepPitch_LMANprobe_PBS_day5', ...
    '/bluejay5/lucas/birds/pu11wh87/050615_SeqDepPitchLMAN_PbsMusc', ...
    '/bluejay5/lucas/birds/pu11wh87/051215_SeqDepPitchLMAN_durWN_day1', ...
    '/bluejay5/lucas/birds/pu11wh87/051315_SeqDepPitchLMAN_durWN_day2', ...
    '/bluejay5/lucas/birds/pu11wh87/051415_SeqDepPitchLMAN_durWN_day3', ...
    '/bluejay5/lucas/birds/pu11wh87/051515_SeqDepPitchLMAN_durWN_day4', ...
    '/bluejay5/lucas/birds/pu11wh87/051615_SeqDepPitchLMAN_durWN_day5'};

% ============================== RUN, ITERATE OVER DAYS
for j=1:length(ListOfDirs)

    % ==================== 0) go to day folder
    cd(ListOfDirs{j});
    
    
    % ==================== 1) extract all s
    !ls *PBS*.cbin > BatchPBS
    lt_cleandirAuto('BatchPBS', 1000, 5, 5);
    batch = 'BatchPBS.keep';
%     batch = 'BatchPBS.rand';
    
    % ==================== 2) move old .notmat
    if ~exist('OLDNOTMAT_SeqDepPitch', 'dir')
        mkdir OLDNOTMAT_SeqDepPitch
        !cp *.not.mat* OLDNOTMAT_SeqDepPitch
    else
        disp('not making OLDNOTMAT_SeqDepPitch, since already made!!');
    end
    
    
    % ==================== 3) run autolabel
    % ---- GENERAL PARAMS
    ampThresh=17000;
    min_dur=30;
    min_int=5;
    
    % ---- MOTIF 1 - first do dccB. this will label all dccB as well as
    % match B on abbccb(b) (i.e. FP). Next will overwrite so is ok.
    config='/bluejay5/lucas/birds/pu11wh87/config_AL_dccB_3.evconfig2'; % modified template
    syl.targ='b';
    syl.pre='dcc';
    syl.post='b';
    NoteNum=0;
    overwrite_notmat=1; % will always make backup folder
    
    [fnames, sylnum, vlsorfn, vlsorind]=lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat);
    
    
    % ------ MOTIF 2 - abbcc(b)b. since this b is target, will replace
    % following syls with dash. this is also important because dcc(b) above
    % replaces abbccb(b) with dcc(b)b, so there will be one b jutting
    % out...
    config='/bluejay5/lucas/birds/pu11wh87/config_AL_bccB.evconfig2'; 
    syl.targ='b';
    syl.pre='abbcc';
    syl.post='--';
    NoteNum=0;
    overwrite_notmat=0; % will always make backup folder
    
    [fnames, sylnum, vlsorfn, vlsorind]=lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat);
    
    

end

%% === check

% syl = 'c';
% presyl = '';
% [fnames, sylnum]=lt_jc_chcklbl(batch, syl, 0.025,0.025, presyl,'','');
% [vlsorfn vlsorind]=jc_vlsorfn(batch, syl, presyl,'');

syl = 'd';
presyl = '';
[fnames, sylnum]=lt_jc_chcklbl(batch, syl, 0.025,0.025, presyl,'','');
[vlsorfn vlsorind]=jc_vlsorfn(batch, syl, presyl,'');

syl = 'a';
presyl = '';
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




%% ###########################################################
%% ########################################## CALC FF
%% calc FF for all syls, save next to song file
clear all; close all;

ListOfDirs_UNDIR = {...
    '/bluejay5/lucas/birds/pu11wh87/050215_SeqDepPitch_LMANprobe_PBS_day5', ...
    '/bluejay5/lucas/birds/pu11wh87/050615_SeqDepPitchLMAN_PbsMusc', ...
    '/bluejay5/lucas/birds/pu11wh87/051215_SeqDepPitchLMAN_durWN_day1', ...
    '/bluejay5/lucas/birds/pu11wh87/051315_SeqDepPitchLMAN_durWN_day2', ...
    '/bluejay5/lucas/birds/pu11wh87/051415_SeqDepPitchLMAN_durWN_day3', ...
    '/bluejay5/lucas/birds/pu11wh87/051515_SeqDepPitchLMAN_durWN_day4', ...
    '/bluejay5/lucas/birds/pu11wh87/051615_SeqDepPitchLMAN_durWN_day5'};


ListOfDirs_DIR = {};

ListOfDirs_ALL = [ListOfDirs_UNDIR ListOfDirs_DIR];

ListOfBatch = {...
    'BatchPBS.LABELED', ...
    'BatchPBS.LABELED', ...
    'BatchPBS.LABELED', ...
    'BatchPBS.LABELED', ...
    'BatchPBS.LABELED', ...
    'BatchPBS.LABELED', ...
    'BatchPBS.LABELED', ...
    };

FFparams.cell_of_freqwinds={'c', [2000 3200], 'b', [2800 3800], ...
    'a', [1300 2200], 'd', [1200 2700]};
FFparams.cell_of_FFtimebins={'c', [0.036 0.065], 'b', [0.031 0.038], ...
    'a', [0.07 0.085], 'd', [0.0255 0.045]};
plotAllPC = 0;
plotEachSyl = 0;
overwrite = 1;

% ==================== CALCULATE AND SAVE FF
lt_batchsong_calcFF(ListOfDirs_ALL, ListOfBatch, FFparams, plotAllPC, plotEachSyl, ...
    overwrite);

%% ==== EXTRACT FF
MotifsToExtract = {'(d)ccbb', 'd(c)cbb', 'dc(c)bb', 'dcc(b)b', 'dccb(b)' ...
    '(a)bbccb', 'a(b)bccb', 'ab(b)ccb', 'abb(c)cb', 'abbc(c)b', 'abbcc(b)'};
DATSTRUCT = lt_batchsong_extractFF(ListOfDirs_UNDIR, ListOfDirs_DIR, ListOfBatch, MotifsToExtract);


%% ============== PLOT
close all;
TrainON = '12May2015-0000';
SwitchTimes = {};
subtractMean = 1;
dozscore = 0;

lt_batchsong_plotFF(DATSTRUCT, MotifsToExtract, TrainON, SwitchTimes, ...
    subtractMean, dozscore);




