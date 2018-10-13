%% check template
% ========== jjbB
clear all; close all;
batchf= 'batch.labeled.all';
% batchf= 'batch.labeled.all.PBS';

get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'jjb';
syl_post = '';
% config='/bluejay4/lucas/birds/bk34bk68/config_011516.evconfig2'; % 1/15- template change
% config='/bluejay4/lucas/birds/bk34bk68/config_012416.evconfig2'; % 1/15- template change
% config='/bluejay4/lucas/birds/bk34bk68/config_012416_2.evconfig2'; % 1/15- template change
% config='/bluejay4/lucas/birds/bk34bk68/012516_SeqDepPitchLMAN3_durWN_day1/config.evconfig2'; % start
% config='/bluejay4/lucas/birds/bk34bk68/config_012716.evconfig2'; %
% config='/bluejay4/lucas/birds/bk34bk68/config_012816.evconfig2'; % 
% config='/bluejay4/lucas/birds/bk34bk68/config_013016.evconfig2'; % 
% config='/bluejay4/lucas/birds/bk34bk68/config_013116.evconfig2'; % 
% config='/bluejay4/lucas/birds/bk34bk68/config_020116.evconfig2';
config='/bluejay4/lucas/birds/bk34bk68/020216_SeqDepPitchLMAN3_durWN_TwoSameDir_day1_noonsongs/config.evconfig2';
config='/bluejay4/lucas/birds/bk34bk68/config_020216.evconfig2';
NoteNum = 0; 

lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum)


% ====== ljbB
clear all; close all;
batchf= 'batch.labeled.all.PBS';
batchf= 'batch.labeled.all';

get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'ljb';
syl_post = '';
% config= '/bluejay4/lucas/birds/bk34bk68/config_121515.evconfig2';
% config= '/bluejay4/lucas/birds/bk34bk68/121515_SeqDepPitchLMAN_durWN_day1/config.evconfig2';
% config= '/bluejay4/lucas/birds/bk34bk68/121615_SeqDepPitchLMAN_durWN_day2/config_121615.evconfig2';
% config= '/bluejay4/lucas/birds/bk34bk68/config_121715.evconfig2';
% config='/bluejay4/lucas/birds/bk34bk68/122215_SeqDepPitchLMAN_durWN_TwoTarg_day1/config.evconfig2';
% config='/bluejay4/lucas/birds/bk34bk68/122815_SeqDepPitchLMAN_durWN_TwoTarg_day7/config_122815.evconfig2';
% config='/bluejay4/lucas/birds/bk34bk68/122915_SeqDepPitchLMAN_durWN_TwoTarg_day8/config_122915.evconfig2';
% config='/bluejay4/lucas/birds/bk34bk68/config_123015.evconfig2';
% config='/bluejay4/lucas/birds/bk34bk68/config_020116.evconfig2';
config='/bluejay4/lucas/birds/bk34bk68/020216_SeqDepPitchLMAN3_durWN_TwoSameDir_day1_noonsongs/config.evconfig2';
config='/bluejay4/lucas/birds/bk34bk68/config_020216.evconfig2';
config='/bluejay4/lucas/birds/bk34bk68/config_020816.evconfig2';
config='/bluejay4/lucas/birds/bk34bk68/config_022116.evconfig2';
config='/bluejay4/lucas/birds/bk34bk68/config_022316.evconfig2';

NoteNum = 1; 

lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum)


%% 1) Gather raw data for this day
% clear all; close all;
% 
% Params.DayRawDat.fs=32000;
% Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
% Params.DayRawDat.batch='batch.labeled.all';
% 
% Params.DayRawDat.syllables={'a','b'};
% Params.DayRawDat.frequency_range={[1400 2200], [3000 4000]};
% Params.DayRawDat.pc_dur=[0.12, 0.12];
% Params.DayRawDat.pc_time_window={[260 330],[85 185]}; %
% Params.DayRawDat.pc_sigma=1;
% 
% % --- trying to get all syllables - look at code to check
% % Params.DayRawDat.syllables={'a','ab','cb','bb','cc','bc','dc'};
% % Params.DayRawDat.frequency_range={[1300 2200], [2800 3950],[2800 3950],[2800 3950],[2150 3150],[2150 3150],[2150 3150]};
% % Params.DayRawDat.pc_dur=[0.12,0.09,0.09,0.09,0.11,0.11,0.11];
% % Params.DayRawDat.pc_time_window={[375 525],[60 220],[60 220],[60 220],[55 320],[55 320],[55 320]};
% 
% % plot and save?
% plotON=1;
% saveON=1;
% 
% % Related to LMAN inactivation
% plotLMANinact=0;
% Params.DayRawDat.Musc_On_Time='1320'; % time given muscimol - will plot data with temporal lag after this.
% Params.DayRawDat.Musc_Off_Time='1908';
% 
% [Params, RawDatStruct]=lt_seq_dep_pitch_DayRawDat(Params,1,1,'',plotLMANinact);


%% TO DO OVER ALL DAYS
clear all; close all
phrase = 'SeqDepPitchLMAN3';
first_day= '17Feb2016';
last_day= '29Feb2016';
Params.DayRawDat.batch='batch.labeled.catch';
% first_day= '19Nov2014';
% last_day= '22Nov2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.syllables={'a','b','n', 'j', 'g', 'k', 'l'};
% OLD:
% Params.DayRawDat.frequency_range={[1400 2200], [3000 4000]};
% Params.DayRawDat.pc_dur=[0.12, 0.12];
% Params.DayRawDat.pc_time_window={[206 286],[113 152]}; %
Params.DayRawDat.frequency_range={[1587 2016], [3020 3760], [750 1100], [3575 4500], [3200 4200], [3550 4450], [3450 4250]};
Params.DayRawDat.pc_dur=[0.125, 0.125, 0.105, 0.12, 0.22, 0.11, 0.1];
Params.DayRawDat.pc_time_window={[206 286],[118 158], [100 200], [210 300], [20 70], [90 220], [115 185]}; %


Params.DayRawDat.pc_sigma=1;

plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);

%% 
cd seq_dep_pitch_SeqDepPitchLMAN3
clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=4500;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

Params.SeqFilter.SeqPreList={'n', 'nj','njj','jj','jjb', 'jjbb','jjbbg',...
    'l', 'lj','ljb', 'ljbb', 'ljbbg'}; % To skip seq filter, keep blank. (i.e. {})

Params.SeqFilter.SylTargList={'j', 'j', 'j', 'b','b', 'g', 'a',...
    'j', 'b','b','g','a'};

Params.SeqFilter.SeqPostList={'', '', '', '','', '','',...
    '', '','','','',''};



% 2) experiment info
Params.SeqFilter.WNTimeON='25Jan2016-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '29Feb2016-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:4;

Params.SeqFilter.SylLists.FieldsInOrder{1}={'n', 'nJ', 'njJ', 'njjJ', 'jjB','jjbB', 'jjbbG', 'jjbbgA'};
Params.SeqFilter.SylLists.FieldsInOrder{2}={'k','l','lJ','ljB','ljbB', 'ljbbG', 'ljbbgA'};

Params.SeqFilter.SylLists.TargetSyls={'jjbB'};
Params.SeqFilter.SylLists.SylsSame={'jjB','ljB', 'ljbB'};
Params.SeqFilter.SylLists.SylsDifferent={'n', 'nJ', 'njJ', 'njjJ', 'jjbbG', 'jjbbgA', 'k','l','lJ','ljbbG', 'ljbbgA'};


% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);


%% 3) Perform various analyses on that data structure
close all;
% Extra params, for muscimol only.  do not specific this field if don't care about muscimol.  
% below, times of muscimol in and out (2 times per day)

Params.PlotLearning.MuscimolSchedule={...
    {'22Jan2016', '1330', '1720'}, ... % 1305 1720
    {'24Jan2016', '1250', '1722'}, ...
    {'27Jan2016', '1303', '1737'}, ...
    {'29Jan2016', '1301', '1745'}, ...
    {'01Feb2016', '1302', '1852'}, ...
    {'03Feb2016', '1320', '1718'}, ... % 1304 1718
    {'05Feb2016', '1311', '1714'}, ...
    {'07Feb2016', '1319', '1734'}, ... 1302 1734
    {'09Feb2016', '1300', '1738'}, ...
    {'11Feb2016', '1301', '1819'}, ...
    {'12Feb2016', '1248', '1715'}, ... % 1303 1715
    {'25Feb2016', '1258', '1735'}, ...
    {'27Feb2016', '1258', '1709'}, ...
    {'29Feb2016', '1311', '1835'}};





% params
Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;


[Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);



%% 4) PLOT - looking at effects of LMAN inactivation
close all
Params.PlotLearning.Lag_time=1.55; % time from switch to musc
Params.PlotLearning.Lag_time=1.6; % time from switch to musc
%       Params.PlotLearning.MUSC_end_time=2.5; % hours from PBS to musc switch [OPTIONAL]
    Params.PlotLearning.PBS_window=[-6 4]; % time before switch for PBS
%       Params.PlotLearning.Dur_of_PBS_dat_that_counts_as_MUSC=0.5; half
%       hour from musc to pbs, still call musc data.
    saveON=1;
    
% Params.PlotLearning.timeline.consolid_start='19Dec2015';
% Params.PlotLearning.timeline.consolid_end='21Dec2015';
% Params.PlotLearning.timeline.bidir_start='22Dec2015';
% Params.PlotLearning.timeline.bidir_end='25Jul2015';


[Params, AllDays_PlotLearning]= lt_seq_dep_pitch_PlotLearning_Musc(Params, AllDays_PlotLearning);


%% ########################################################################
%% ######################################### AUTOLABEL
%% ================ TeSTING CONFIG FILE
if (0)
    close all;
    batchf= 'BatchAll.LABELED.rand';
    batchf= 'batch.labeled.notcatch';
    batchf= 'batch.labeled.catch.rand';
    get_WN_hits=0;
    get_offline_match=1;
    get_FF=0;
    
    syl = 'b';
    syl_pre = 'jjb';
    syl_post = '';
    % config= '/bluejay3/lucas/birds/pu53wh88/config.evconfig2'; % before 2/16 templ change
    config= '/bluejay4/lucas/birds/bk34bk68/config_AL_njjjb.evconfig2';
    config= '/bluejay4/lucas/birds/bk34bk68/config_AL_njjjb_2.evconfig2';
    NoteNum = 0;
    
    
    check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, ...
        syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);
end

% to chkec: preceding b. some FP?



% ================ TeSTING CONFIG FILE
if (0)
    close all;
    batchf= 'batch.labeled.catch.rand';
    get_WN_hits=0;
    get_offline_match=1;
    get_FF=0;
    
    syl = 'b';
    syl_pre = 'ljb';
    syl_post = '';
    % config= '/bluejay3/lucas/birds/pu53wh88/config.evconfig2'; % before 2/16 templ change
    config= '/bluejay4/lucas/birds/bk34bk68/config_AL_ljb.evconfig2';
    NoteNum = 0;
    
    % GOOD 

     
    check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, ...
        syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);
end

%% ##################################### AUTOLABEL 
clear all; close all;

% ========================= 0) ECTRACT DIRECTORIRES
basedir = '/bluejay4/lucas/birds/bk34bk68';
% date_range_base={'10Feb2015','12Feb2015'};
% date_range_WN={'14Feb2015','16Feb2015'};
% experiment = 'SeqDepPitchShift';
% 
% % -------- COLLECT METADAT
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

% ------- COMBINE
ListOfDirs = {...
    '012016_SeqDepPitchLMAN3_pre', ...
    '012116_SeqDepPitchLMAN3_pre', ...
    '012316_SeqDepPitchLMAN3_pre', ...
    '012516_SeqDepPitchLMAN3_durWN_day1', ...
    '012616_SeqDepPitchLMAN3_durWN_day2', ...
    '013116_SeqDepPitchLMAN3_durWN_day7'};
ListOfDirs = {...
    '012616_SeqDepPitchLMAN3_durWN_day2', ...
    '013116_SeqDepPitchLMAN3_durWN_day7'};


% ============================== RUN, ITERATE OVER DAYS
for j=1:length(ListOfDirs)

    % ==================== 0) go to day folder
    cd([basedir '/' ListOfDirs{j}]);
    
    
    % ==================== 1) extract all s
    !ls *PBS*.cbin > BatchPBS
    lt_cleandirAuto('BatchPBS', 1000, 4, 4);
    batch = 'BatchPBS.keep';
    
    % ==================== 2) move old .notmat
    if ~exist('OLDNOTMAT_SeqDepPitch', 'dir')
        mkdir OLDNOTMAT_SeqDepPitch
        !cp *.not.mat* OLDNOTMAT_SeqDepPitch
    else
        disp('not making OLDNOTMAT_SeqDepPitch, since already made!!');
    end
    
    
    % ==================== 3) run autolabel
    % ---- GENERAL PARAMS
    ampThresh=4500;
    min_dur=30;
    min_int=5;
    
    % ---- MOTIF 1
    config= '/bluejay4/lucas/birds/bk34bk68/config_AL_njjjb_2.evconfig2';
    syl.targ='b';
    syl.pre='njjjb';
    syl.post='';
    NoteNum=0;
    overwrite_notmat=1; % will always make backup folder
    
    lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat);
    
    
    % ------ MOTIF 2 
    config= '/bluejay4/lucas/birds/bk34bk68/config_AL_ljb.evconfig2';
    syl.targ='b';
    syl.pre='kljb';
    syl.post='ga';
    NoteNum=0;
    overwrite_notmat=0; % will always make backup folder
    
    lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat);
    
    
    
end

%% ============ MAKE WAVE FILES TO LOOK FOR FALSE POSITIVES
batch = 'BatchPBS.keep';

syl = 'n';
presyl = '';
[fnames, sylnum]=lt_jc_chcklbl(batch, syl, 0.025,0.025, presyl,'','');
[vlsorfn vlsorind]=jc_vlsorfn(batch, syl, presyl,'');

syl = 'k';
presyl = '';
[fnames, sylnum]=lt_jc_chcklbl(batch, syl, 0.025,0.025, presyl,'','');
[vlsorfn vlsorind]=jc_vlsorfn(batch, syl, presyl,'');

% syl = 'b';
% presyl = 'cb';
% [fnames, sylnum]=lt_jc_chcklbl(batch, syl, 0.025,0.025, presyl,'','');
% [vlsorfn vlsorind]=jc_vlsorfn(batch, syl, presyl,'');

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
    '/bluejay4/lucas/birds/bk34bk68/012116_SeqDepPitchLMAN3_pre', ...
    '/bluejay4/lucas/birds/bk34bk68/012516_SeqDepPitchLMAN3_durWN_day1', ...
    '/bluejay4/lucas/birds/bk34bk68/012616_SeqDepPitchLMAN3_durWN_day2', ...
    };
ListOfDirs_DIR = {};

ListOfDirs_ALL = [ListOfDirs_UNDIR ListOfDirs_DIR];

ListOfBatch = {...
    'BatchPBS.LABELED', ...
    'BatchPBS.LABELED', ...
    'BatchPBS.LABELED', ...
    };

FFparams.cell_of_freqwinds={'b', [2900 3900], ...
    'a', [1400 2300]};
FFparams.cell_of_FFtimebins={'b', [0.034 0.040], ...
    'a', [0.041 0.069]};
plotAllPC = 0;
plotEachSyl = 0;
overwrite = 1;

% ==================== CALCULATE AND SAVE FF
lt_batchsong_calcFF(ListOfDirs_ALL, ListOfBatch, FFparams, plotAllPC, plotEachSyl, ...
    overwrite);

%% ==== EXTRACT FF
MotifsToExtract = {'njjj(b)', 'njjjb(b)', 'klj(b)', 'kljb(b)', 'kljbbg(a)'};
DATSTRUCT = lt_batchsong_extractFF(ListOfDirs_UNDIR, ListOfDirs_DIR, ListOfBatch, MotifsToExtract);


%% ============== PLOT
close all;
TrainON = '24Jan2016-2330';
SwitchTimes = {};
subtractMean = 0;
dozscore = 0;

lt_batchsong_plotFF(DATSTRUCT, MotifsToExtract, TrainON, SwitchTimes, ...
    subtractMean, dozscore);
