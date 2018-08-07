% ++++++++++++++++++++++++++++++++++++++++++
% ============ JUST A...hbB
clear all; close all;
batchf='batch.labeled.all';
batchf='batch.labeled.all.PBS';
% config='/bluejay4/lucas/birds/wh25pk77/config_011816_2.evconfig2';
% config='/bluejay4/lucas/birds/wh25pk77/011916_SeqDepPitchLMAN_durWN_day1/config.evconfig2';
% config='/bluejay4/lucas/birds/wh25pk77/config_012116.evconfig2'; % 1/21, config change
% config='/bluejay4/lucas/birds/wh25pk77/configasdfasdf.evconfig2'; % 1/21, config change
% config='/bluejay4/lucas/birds/wh25pk77/012116_SeqDepPitchLMAN_durWN_day3/config_012116.evconfig2'; % 1/21, config change
% config='/bluejay4/lucas/birds/wh25pk77/012116_SeqDepPitchLMAN_durWN_day3/config_012116_2.evconfig2'; % 1/21, config change
% config='/bluejay4/lucas/birds/wh25pk77/012616_SeqDepPitchLMAN_durWN_TwoTarg_day1/config.evconfig2'; % two dir
% config='/bluejay4/lucas/birds/wh25pk77/config_012716.evconfig2';
% config='/bluejay4/lucas/birds/wh25pk77/config_013016.evconfig2';
% config='/bluejay4/lucas/birds/wh25pk77/config_020116.evconfig2';
% config='/bluejay4/lucas/birds/wh25pk77/config_020416.evconfig2';
% config='/bluejay4/lucas/birds/wh25pk77/020516_SeqDepPitchLMAN_durWN_TwoSameDir_day1/config.evconfig2';
% config='/bluejay4/lucas/birds/wh25pk77/config_020516.evconfig2';
% config='/bluejay4/lucas/birds/wh25pk77/config_020916.evconfig2';
% config='/bluejay4/lucas/birds/wh25pk77/config_021116.evconfig2';
% config='/bluejay4/lucas/birds/wh25pk77/config_021716.evconfig2';
% config='/bluejay4/lucas/birds/wh25pk77/config_022016_note0.evconfig2';
% config='/bluejay4/lucas/birds/wh25pk77/config_022316.evconfig2';
config='/bluejay4/lucas/birds/wh25pk77/config_022316_2.evconfig2';

% config='/bluejay4/lucas/birds/wh25pk77/config_012016.evconfig2'; %NOTE: if want to get less FP, but less
% % hit overall for hbB, then use this template (ignore the name, it is
% % wrong)
% 

syl='b';
syl_pre='hb';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


% ============ JUST jkbB
clear all; close all;
batchf='batch.labeled.all';
batchf='batch.labeled.all.PBS';
% config='/bluejay4/lucas/birds/wh25pk77/config_012516.evconfig2'; % 1/21, config change
% config='/bluejay4/lucas/birds/wh25pk77/config_012516_2.evconfig2'; % 1/21, config change
% config='/bluejay4/lucas/birds/wh25pk77/012616_SeqDepPitchLMAN_durWN_TwoTarg_day1/config.evconfig2';
% config='/bluejay4/lucas/birds/wh25pk77/config_012716.evconfig2';
% config='/bluejay4/lucas/birds/wh25pk77/config_013016.evconfig2';
% config='/bluejay4/lucas/birds/wh25pk77/config_020116.evconfig2';
% config='/bluejay4/lucas/birds/wh25pk77/config_020316.evconfig2';
% config='/bluejay4/lucas/birds/wh25pk77/020516_SeqDepPitchLMAN_durWN_TwoSameDir_day1/config.evconfig2';
config='/bluejay4/lucas/birds/wh25pk77/config_020516.evconfig2';
config='/bluejay4/lucas/birds/wh25pk77/config_021216.evconfig2';
config='/bluejay4/lucas/birds/wh25pk77/config_021816.evconfig2';
config='/bluejay4/lucas/birds/wh25pk77/config_022016.evconfig2';

syl='b';
syl_pre='kb';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);




% ================= A
clear all; close all;
batchf='batch.labeled.catch.PBS';
batchf='batch.labeled.all.late';
batchf='batch.labeled.all';
% config='/bluejay4/lucas/birds/wh25pk77/config_021416.evconfig2';
% config='/bluejay4/lucas/birds/wh25pk77/config_021516.evconfig2';
config='/bluejay4/lucas/birds/wh25pk77/config_021616.evconfig2';

syl='a';
syl_pre='';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=2;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


%% TO DO OVER ALL DAYS
clear all; close all
phrase = 'SeqDepPitchLMAN';
first_day= '19Jan2016';
last_day= '13Feb2016';
Params.DayRawDat.batch='batch.labeled.catch';
% first_day= '19Nov2014';
% last_day= '22Nov2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.syllables={'a','b', 'k', 'h', 'j', 'n'};
% Params.DayRawDat.frequency_range={[1450 2150], [2800 4000], [1400 2800], [1000 2250]};
% Params.DayRawDat.pc_time_window={[230 350],[82 123], [130 150], [155
% 205]}; % OLD
Params.DayRawDat.frequency_range={[1620 1900], [3000 3950], [1700 2690], [1175 2220], [3500 4000], [3400 4300]};
Params.DayRawDat.pc_time_window={[245 340],[87 100], [84 125], [155 205], [50 150], [15 90]}; %

Params.DayRawDat.pc_dur=[0.115, 0.105, 0.095, 0.09, 0.1, 0.08];


Params.DayRawDat.pc_sigma=1;

Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.

plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);

%% seq filter
cd seq_dep_pitch_SeqDepPitchLMAN/
clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=2000;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

Params.SeqFilter.SeqPreList={'j','k', 'kb', 'n','h','hb', '', 'a'}; % To skip seq filter, keep blank. (i.e. {})
Params.SeqFilter.SylTargList={'k','b', 'b', 'h', 'b','b', 'j', 'j'};
Params.SeqFilter.SeqPostList={'','','','','', '', 'k', ''};



% 2) experiment info
Params.SeqFilter.WNTimeON='19Jan2016-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '27Feb2016-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:4;

Params.SeqFilter.SylLists.FieldsInOrder{1}={'Jk', 'jK','kB','kbB'};
Params.SeqFilter.SylLists.FieldsInOrder{2}={'a', 'aJ', 'n', 'nH', 'hB', 'hbB'};

Params.SeqFilter.SylLists.TargetSyls={'hbB'};
Params.SeqFilter.SylLists.SylsSame={'hB','kB','kbB'};
Params.SeqFilter.SylLists.SylsDifferent={'a','jK','nH', 'Jk', 'n', 'aJ'};


% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);


%% 3) Perform various analyses on that data structure
close all;
% Extra params, for muscimol only.  do not specific this field if don't care about muscimol.  
% % below, times of muscimol in and out (2 times per day)
%     

Params.PlotLearning.MuscimolSchedule={...
    {'15Jan2016', '1256', '1759'}, ...
    {'16Jan2016', '1353', '1825'}, ...
    {'18Jan2016', '1301', '1726'}, ... 
    {'22Jan2016', '1300', '1724'}, ...
    {'23Jan2016', '1311', '1718'}, ...
    {'25Jan2016', '1305', '1818'}, ...
    {'29Jan2016', '1302', '1746'}, ...
    {'31Jan2016', '1258', '1742'}, ...
    {'02Feb2016', '1308', '1736'}, ...
    {'04Feb2016', '1304', '1742'}, ...
    {'09Feb2016', '1301', '1738'}, ...
     {'11Feb2016', '1302', '1743'}, ...
      {'13Feb2016', '1255', '1740'}, ...
      {'25Feb2016', '1258', '1735'}, ...
      {'27Feb2016', '1258', '1709'}};
 


% params
Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;


[Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);
% 


%% 4) PLOT - looking at effects of LMAN inactivation
close all
Params.PlotLearning.Lag_time=1.65; % time from switch to musc
%       Params.PlotLearning.MUSC_end_time=2.5; % hours from PBS to musc switch [OPTIONAL]
    Params.PlotLearning.PBS_window=[-2.8 2]; % time before switch for PBS
    Params.PlotLearning.PBS_window=[-3.6 2]; % time before switch for PBS
%     Params.PlotLearning.PBS_window=[-6 2]; % time before switch for PBS
%       Params.PlotLearning.Dur_of_PBS_dat_that_counts_as_MUSC=0.5; half
%       hour from musc to pbs, still call musc data.
    saveON=1;

% MUSCIMOL TIMELINES
Params.PlotLearning.timeline.consolid_start='22Jan2016';
Params.PlotLearning.timeline.consolid_end='25Jan2016';
Params.PlotLearning.timeline.bidir_start='26Jan2016';
% Params.PlotLearning.timeline.bidir_end='25Jul2015';


[Params, AllDays_PlotLearning]= lt_seq_dep_pitch_PlotLearning_Musc(Params, AllDays_PlotLearning);




%% ###################################################################
%% ################################################# AUTOLABEL

% STRATEGY for complete labeling:
% first label all c(b) as dccb, then overwrite those that are bccb

%% =============== TEST CONFIGS
clear all; close all;


% ===== MOTIF 1 % ============ JUST A...hbB
clear all; close all;
batchf='batch.labeled.all';
batchf='batch.labeled.all';
% batchf='batch.labeled.notcatch';
% config='/bluejay4/lucas/birds/wh25pk77/config_022316_2.evconfig2';
config='/bluejay4/lucas/birds/wh25pk77/config_AL_ajnhb.evconfig2'; % v1, uses 2 bins to match
config='/bluejay4/lucas/birds/wh25pk77/config_AL_ajnhb_2.evconfig2'; % v2 - uses 1 bin, seems better

syl='b';
syl_pre='hb';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% --- good: tends to be FP if bad


% ===== MOTIF 1 - ============ JUST jkbB
clear all; close all;
batchf='batch.labeled.all';
batchf='batch.labeled.catch';
% config='/bluejay4/lucas/birds/wh25pk77/config_022016.evconfig2';
config='/bluejay4/lucas/birds/wh25pk77/config_AL_kb.evconfig2';
config='/bluejay4/lucas/birds/wh25pk77/config_AL_kb_2.evconfig2';
config='/bluejay4/lucas/birds/wh25pk77/config_AL_kb_3.evconfig2';

syl='b';
syl_pre='kb';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% --- good tends to be FN

%% ================ AUTOLABLE
% AND ITERATION OVER DAY
clear all; close all;

% ========================= 0) ECTRACT DIRECTORIRES
basedir = '/bluejay4/lucas/birds/wh25pk77';
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
    '011916_SeqDepPitchLMAN_durWN_day1', ...
    '011716_SeqDepPitchLMAN_pre', ...
    '012016_SeqDepPitchLMAN_durWN_day2', ...
    '011416_SeqDepPitchLMAN_pre', ...
    '012116_SeqDepPitchLMAN_durWN_day3', ...
    '011316_SeqDepPitchLMAN_pre'};


% ============================== RUN, ITERATE OVER DAYS
for j=1:length(ListOfDirs)

    % ==================== 0) go to day folder
    cd([basedir '/' ListOfDirs{j}]);
    
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
    ampThresh=2000;
    min_dur=15;
    min_int=5;
    skipWAV =1;
    
    % ---- MOTIF 1 - 
    config='/bluejay4/lucas/birds/wh25pk77/config_AL_ajnhb_2.evconfig2'; % v2 - uses 1 bin, seems better
    syl.targ='b';
    syl.pre='ajnhb';
    syl.post='';
    NoteNum=0;
    overwrite_notmat=1; % will always make backup folder
    
    lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat, skipWAV);
    
    
    % ------ MOTIF 2 - 
    config='/bluejay4/lucas/birds/wh25pk77/config_AL_kb_3.evconfig2';
    syl.targ='b';
    syl.pre='jjkb';
    syl.post='';
    NoteNum=0;
    overwrite_notmat=0; % will always make backup folder
    
    lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat, skipWAV);
    
    

end

%% === check

% syl = 'c';
% presyl = '';
% [fnames, sylnum]=lt_jc_chcklbl(batch, syl, 0.025,0.025, presyl,'','');
% [vlsorfn vlsorind]=jc_vlsorfn(batch, syl, presyl,'');

% --- check first motif - a should be in right place.
syl = 'a';
presyl = '';
[fnames, sylnum]=lt_jc_chcklbl(batch, syl, 0.025,0.025, presyl,'','');
[vlsorfn vlsorind]=jc_vlsorfn(batch, syl, presyl,'');

% -- check second motif
syl = 'k';
presyl = '';
[fnames, sylnum]=lt_jc_chcklbl(batch, syl, 0.025, 0.025, presyl,'','');
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
    '/bluejay4/lucas/birds/wh25pk77/011316_SeqDepPitchLMAN_pre', ...
    '/bluejay4/lucas/birds/wh25pk77/011416_SeqDepPitchLMAN_pre', ...
    '/bluejay4/lucas/birds/wh25pk77/011716_SeqDepPitchLMAN_pre', ...
    '/bluejay4/lucas/birds/wh25pk77/011916_SeqDepPitchLMAN_durWN_day1', ...
    '/bluejay4/lucas/birds/wh25pk77/012016_SeqDepPitchLMAN_durWN_day2', ...
    '/bluejay4/lucas/birds/wh25pk77/012116_SeqDepPitchLMAN_durWN_day3'};


ListOfDirs_DIR = {};

ListOfDirs_ALL = [ListOfDirs_UNDIR ListOfDirs_DIR];

ListOfBatch = {...
    'BatchPBS.LABELED', ...
    'BatchPBS.LABELED', ...
    'BatchPBS.LABELED', ...
    'BatchPBS.LABELED', ...
    'BatchPBS.LABELED', ...
    'BatchPBS.LABELED', ...
    };

FFparams.cell_of_freqwinds={'k', [1250 2800], 'b', [2800 4200], ...
    'a', [1500 2100], 'h', [4000 6500]};
FFparams.cell_of_FFtimebins={'k', [0.037 0.042], 'b', [0.031 0.035], ...
    'a', [0.056 0.075], 'h', [0.02 0.024]};
plotAllPC = 0;
plotEachSyl = 0;
overwrite = 1;

% ==================== CALCULATE AND SAVE FF
lt_batchsong_calcFF(ListOfDirs_ALL, ListOfBatch, FFparams, plotAllPC, plotEachSyl, ...
    overwrite);

%% ==== EXTRACT FF
MotifsToExtract = {'jj(k)b', 'jjk(b)', 'jjkb(b)', ...
    '(a)jnhb', 'ajnh(b)', 'ajnhb(b)'};
DATSTRUCT = lt_batchsong_extractFF(ListOfDirs_UNDIR, ListOfDirs_DIR, ListOfBatch, MotifsToExtract);


%% ============== PLOT
close all;
TrainON = '19Jan2016-0000';
SwitchTimes = {};
subtractMean = 1;
dozscore = 0;

lt_batchsong_plotFF(DATSTRUCT, MotifsToExtract, TrainON, SwitchTimes, ...
    subtractMean, dozscore);


