%% === GETTING ALL B

% ==== lower pitch B
clear all; close all;
batchf='batch.labeled.all.PBS';
batchf='batch.labeled.all';
% config='/bluejay4/lucas/birds/rd28pu64/config_021216.evconfig2'; % two diff dir
% config='/bluejay4/lucas/birds/rd28pu64/021316_SeqDepPitchLMAN2_durWN_AllSameDir_day2/config.evconfig2';
% config='/bluejay4/lucas/birds/rd28pu64/config_021416.evconfig2';
% config='/bluejay4/lucas/birds/rd28pu64/config_021716.evconfig2';
config='/bluejay4/lucas/birds/rd28pu64/config_022116.evconfig2';

syl='b';
syl_pre='';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% === no label
Params.batch='batch.labeled.all';
% Params.config='/bluejay4/lucas/birds/rd28pu64/config_021416.evconfig2';
% Params.config='/bluejay4/lucas/birds/rd28pu64/config_021716.evconfig2';
Params.config='/bluejay4/lucas/birds/rd28pu64/config_022116.evconfig2';
Params.NoteNum_to_plot=0; % for the note you want to analyze
[AllSongsData_toplot, AllData]=lt_check_hit_templ_freq_NoLabelRequired(Params);



% === higher pitch B
clear all; close all;
batchf='batch.labeled.all';
% config='/bluejay4/lucas/birds/rd28pu64/021316_SeqDepPitchLMAN2_durWN_AllSameDir_day2/config.evconfig2';
% config='/bluejay4/lucas/birds/rd28pu64/config_021416.evconfig2';
% config='/bluejay4/lucas/birds/rd28pu64/config_021716.evconfig2';
config='/bluejay4/lucas/birds/rd28pu64/config_022116.evconfig2';

syl='b';
syl_pre='';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% == no label
Params.batch='batch.labeled.all';
% Params.config='/bluejay4/lucas/birds/rd28pu64/config_021416.evconfig2';
% Params.config='/bluejay4/lucas/birds/rd28pu64/config_021716.evconfig2';
Params.config='/bluejay4/lucas/birds/rd28pu64/config_022116.evconfig2';
Params.NoteNum_to_plot=1; % for the note you want to analyze
[AllSongsData_toplot, AllData]=lt_check_hit_templ_freq_NoLabelRequired(Params);


%% CHECKING TEMPLATE MATCHING (ab[b]);



% === GETTING jjB (note 0)
clear all; close all;
batchf='batch.labeled.all';
batchf='batch.labeled.all.PBS';
% batchf='batch.labeled.all.late';
% config='/bluejay4/lucas/birds/rd28pu64/011816_SeqDepPitchLMAN2_durWN_day3/config_011816_2.evconfig2';
% config='/bluejay4/lucas/birds/rd28pu64/config_011816_newtempl.evconfig2';
% config='/bluejay4/lucas/birds/rd28pu64/config_012916_2.evconfig2';
% config='/bluejay4/lucas/birds/rd28pu64/config_013016.evconfig2';
config='/bluejay4/lucas/birds/rd28pu64/013016_SeqDepPitchLMAN2_durWN_TwoSameDir_day1/config_013016_2.evconfig2';
config='/bluejay4/lucas/birds/rd28pu64/config_020116.evconfig2';
config='/bluejay4/lucas/birds/rd28pu64/021216_SeqDepPitchLMAN2_durWN_TwoDiffDir_day1/config.evconfig2'; % two diff dir

syl='b';
syl_pre='jj';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


% === GETTING kjB (note 1)
clear all; close all;
batchf='batch.labeled.all';
batchf='batch.labeled.all.PBS';
% config='/bluejay4/lucas/birds/rd28pu64/122315_SeqDepPitchLMAN_durWN_TwoTarg_day2/config_122315.evconfig2';
% config='/bluejay4/lucas/birds/rd28pu64/config_012916_2.evconfig2';
% config='/bluejay4/lucas/birds/rd28pu64/config_013016.evconfig2';
config='/bluejay4/lucas/birds/rd28pu64/013016_SeqDepPitchLMAN2_durWN_TwoSameDir_day1/config_013016_2.evconfig2';
config='/bluejay4/lucas/birds/rd28pu64/021216_SeqDepPitchLMAN2_durWN_TwoDiffDir_day1/config.evconfig2'; % two diff dir


syl='b';
syl_pre='kj';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);






%% 1) Gather raw data for this day
clear all; close all;
% 
% Params.DayRawDat.fs=32000;
% Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
% Params.DayRawDat.batch='batch.labeled.catch';
% 
% Params.DayRawDat.syllables={'a','b','d', 'g','k'};
% Params.DayRawDat.frequency_range={[1200 2100], [3000 4000],[1100 2000], [1250 1750], [1200 2600]};
% Params.DayRawDat.pc_dur=[0.12, 0.12, 0.11, 0.3, 0.1];
% Params.DayRawDat.pc_time_window={[297 360],[105 170],[130 180], [490 670], [55 185]};
% 
% Params.DayRawDat.pc_sigma=1;
% 
% 
% % plot and save?
% plotON=1;
% saveON=1;
% 
% % Related to LMAN inactivation
% plotLMANinact=0;
% Params.DayRawDat.Musc_On_Time='1305'; % time given muscimol - will plot data with temporal lag after this.
% Params.DayRawDat.Musc_Off_Time='1706';
% 
% [Params, RawDatStruct]=lt_seq_dep_pitch_DayRawDat(Params,1,1,'',plotLMANinact);
% 


%% TO DO OVER ALL DAYS
clear all; close all
phrase = 'SeqDepPitchLMAN2';
first_day= '16Jan2016';
last_day= '16Jan2016';
Params.DayRawDat.batch='batch.labeled.catch';

% first_day= '19Nov2014';
% last_day= '22Nov2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.

Params.DayRawDat.syllables={'a','b','d', 'g','k', 'j'};
Params.DayRawDat.frequency_range={[1200 2100], [2800 4040],[1390 1950], [1250 1750], [1200 2600], [3500 4500]};
Params.DayRawDat.pc_dur=[0.125, 0.125, 0.115, 0.305, 0.105, 0.11];
Params.DayRawDat.pc_time_window={[305 360],[105 170],[130 180], [490 670], [55 185], [20 100]};


Params.DayRawDat.pc_sigma=1;


plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);




%% 2) Seq filter, remove outliers, and compile raw data, and enter experiment info into params
cd seq_dep_pitch_SeqDepPitchLMAN2
clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=8000;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

% Params.SeqFilter.SeqPreList={'jj', 'jjb', 'jjbb', 'jjbbb', 'jjbbbb', ...
%     'a','d', 'kj', 'kjb', 'kjbb', 'kjbbb', 'kjbbbb', 'j'}; % motif 1, motif 2, diff lines
% Params.SeqFilter.SylTargList={'b', 'b', 'b', 'b', 'b', ...
%     'b','g', 'b', 'b', 'b', 'b', 'b', 'a'};
% Params.SeqFilter.SeqPostList={'', '', '', '', '', ...
%     '','', '', '', '', '', '', ''}; IGNORE >2 repeats, since gets
%     variable pitch

Params.SeqFilter.SeqPreList={'','j', 'jj', 'jjb', ...
    '','a','d', 'k','kj', 'kjb', 'j'}; % motif 1, motif 2, diff lines
Params.SeqFilter.SylTargList={'j', 'j','b', 'b', ...
    'j','b','g', 'j','b', 'b', 'a'};
Params.SeqFilter.SeqPostList={'jb','b', '', '', ...
    'a','','', '', '', '', ''};


% 2) experiment info
Params.SeqFilter.WNTimeON='16Jan2016-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '24Feb2016-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:3;


Params.SeqFilter.SylLists.FieldsInOrder{1}={'Jjb','jJb','jjB', 'jjbB'};
Params.SeqFilter.SylLists.FieldsInOrder{2}={'Ja','jA','aB','d','dG','k','kJ','kjB', 'kjbB'};

Params.SeqFilter.SylLists.TargetSyls={'jjB'};
Params.SeqFilter.SylLists.SylsSame={'jjbB', 'aB', 'kjB', 'kjbB'};
Params.SeqFilter.SylLists.SylsDifferent={'Jjb','jJb','Ja','jA','d','dG', 'k','kJ'};

% Params.SeqFilter.DaysForSnapshot{1}={'20Nov2015','22Nov2015'};
% Params.SeqFilter.DaysToMark= {'22Nov2015-2400'}; % will mark all plots with lines here;

% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);


%% 3) Perform various analyses on that data structure
close all;
% Extra params, for muscimol only.  do not specific this field if don't care about muscimol.  
% below, times of muscimol in and out (2 times per day)

% Params.PlotLearning.MuscimolSchedule={...
%     {'08Jan2016', '1347', '1830'}, ...
%     {'10Jan2016', '1331', '1809'}, ...
%     {'11Jan2016', '1323', '1755'}, ...
%     {'13Jan2016', '1318', '1812'}, ...
%     {'14Jan2016', '1303', '1807'}, ...
%     {'24Jan2016', '1207', '1722'}};

Params.PlotLearning.MuscimolSchedule={{'10Jan2016', '1331', '1809'}, ...
    {'11Jan2016', '1323', '1755'}, ...
    {'13Jan2016', '1318', '1812'}, ...
    {'14Jan2016', '1303', '1807'}, ...
    {'21Jan2016', '1304', '1722'}, ...
    {'22Jan2016', '1302', '1728'}, ...
    {'23Jan2016', '1309', '1716'}, ...
    {'24Jan2016', '1207', '1722'}, ...
    {'26Jan2016', '1237', '1724'}, ... 
    {'27Jan2016', '1233', '1736'}, ...
    {'29Jan2016', '1259', '1747'}, ...
    {'02Feb2016', '1303', '1735'}, ...
    {'04Feb2016', '1240', '1713'}, ...
    {'06Feb2016', '1254', '1739'}, ...
    {'08Feb2016', '1300', '1704'}, ...
    {'11Feb2016', '1255', '1743'}, ...
    {'16Feb2016', '1302', '1733'}, ...
    {'18Feb2016', '1251', '1709'}, ...
        {'20Feb2016', '1258', '1822'}, ...
        {'22Feb2016', '1257', '1755'}, ...
        {'24Feb2016', '1251', '1735'}};





Params.PlotLearning.MuscimolDaysToThrowout={'22Jan2016'};

% params
Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;


[Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);



%% 4) PLOT - looking at effects of LMAN inactivation
close all
    Params.PlotLearning.Lag_time=0.6; % time from switch to musc
    Params.PlotLearning.Lag_time=0.9; % time from switch to musc
%       Params.PlotLearning.MUSC_end_time=2.5; % hours from PBS to musc switch [OPTIONAL]
    Params.PlotLearning.PBS_window=[-4 2]; % time before switch for PBS
%       Params.PlotLearning.Dur_of_PBS_dat_that_counts_as_MUSC=0.5; half
%       hour from musc to pbs, still call musc data.
    saveON=1;

Params.PlotLearning.timeline.consolid_start='21Jan2016';
% Params.PlotLearning.timeline.consolid_end='21Dec2015';
% Params.PlotLearning.timeline.bidir_start='22Dec2015';
% Params.PlotLearning.timeline.bidir_end='25Jul2015';


[Params, AllDays_PlotLearning]= lt_seq_dep_pitch_PlotLearning_Musc(Params, AllDays_PlotLearning);



%% +++++++++++++++++++++++++++++++++++++++++++++++++++++
% %%  making batch of songs using template
% % NOT CONFIRMED WORKING !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% 
% % Evtaf amp sim version
% % Using modified version of Joanne's, which uses evtaf_amp simulation
% % This autolabels, and does post-analysis, looking at all syls and
% % replacing any mistakes.
% 
% % ================== 1) Input template parameters. This runs evtafsim and autolabels.
% % Can choose whether to overwrite old .cbin.not.mat or to add onto old
% % ones.
% clear all; close all;
% Params.batch='batch';
% 
% Params.ampThresh=4000;
% Params.min_dur=30;
% Params.min_int=8;
% 
% Params.syl.pre='';
% Params.syl.post='';
% Params.syl.targ='b';
% 
% Params.overwrite_notmat=1;
% 
% 
% % TEMPLATE SETTINGS
% Params.TEMPLATE.templatefile = 'rd28pu64_autolabel_b.dat'; % should be one dir up.
% % Template params: one array entry for each column. 
% Params.TEMPLATE.cntrng(1).MIN=2;
% Params.TEMPLATE.cntrng(1).MAX=3;
% Params.TEMPLATE.cntrng(1).NOT=0;
% Params.TEMPLATE.cntrng(1).MODE=1;
% Params.TEMPLATE.cntrng(1).TH=2;
% Params.TEMPLATE.cntrng(1).AND=0;
% Params.TEMPLATE.cntrng(1).BTMIN=0;
% 
% Params.TEMPLATE.cntrng(2).MIN=2;
% Params.TEMPLATE.cntrng(2).MAX=3;
% Params.TEMPLATE.cntrng(2).NOT=0;
% Params.TEMPLATE.cntrng(2).MODE=1;
% Params.TEMPLATE.cntrng(2).TH=2;
% Params.TEMPLATE.cntrng(2).AND=0;
% Params.TEMPLATE.cntrng(2).BTMIN=0;
% 
% Params.TEMPLATE.refract=0.2;
% 
% % RUN
% [fnames, sylnum, vlsorfn, vlsorind]=lt_autolabel_function(Params);
% 
% % ============ 2) Use evsonganaly manually on the .wav file created above
% % (contains only the syls you chose)
% % INSTRUCTIONS: 
% % 1) open .wav file using evsonganaly
% % 2) change threshold to segment all syls indivudally
% % 3) any syl labeled "-" (default) will remain unchanged (i.e. will stay autolabeled). 
% %     give a new label to any mislabeled syl - that will be its new actual label
% evsonganaly
% 
% 
% % ============ 3) Replace hand-checekd mislabeld syls 
% lt_autolabel_FixHandCheckedSyls(fnames, sylnum, vlsorfn, vlsorind)
