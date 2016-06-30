%% cheeck template 
clear all; close all;
batchf='batch.labeled.all.edges.LABELEDWELL';
batchf='batch.labeled.all';
% batchf='batch.rand.keep';
% config='/bluejay4/lucas/birds/pu11wh87/111515_CtxtDepPitch_away_durWN/CONFIG_AWAY.evconfig2'; 
% config='/bluejay4/lucas/birds/pu11wh87/config_111715.evconfig2'; 
config='/bluejay4/lucas/birds/pu11wh87/config_112015.evconfig2'; 

syl='b';
syl_pre='bcc';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


%% checking template, no labeling



%% ======================= Extracting data across days
clear all; close all;
% Params.syl_list={'b','a'};
% Params.freq_range_list={[3000 4000], [1300 2200]};
% Params.pc_dur_list=[0.12, 0.14];
% Params.pc_harms_list=[1, 1];

Params.syl_list={'b'};
Params.freq_range_list={[3000 4000]}; % should lower to 2800 4000
Params.pc_dur_list=[0.11];
Params.pc_harms_list=[1];

Params.batch='batch.labeled.all.edges';
Params.experiment = 'CtxtDepPitch';

date_range={'06Dec2015','14Dec2015'}; % e.g. {'20Apr2015','20May2015'}. leave blank ('') for all days

lt_extract_AllDaysPC(Params, date_range)


%% Compiling data - go to "extract" folder
clear all; close all;
% Params_global.CompilePC.PC_window_list={'b', [45 130], 'a', [365 460]}; % syl, value pairs
Params_global.CompilePC.PC_window_list={'b', [40 70]}; % syl, value pairs
Params_global.CompilePC.FirstDay='';
Params_global.CompilePC.LastDay='';
plotON=1; % pitch contours, all days, all syls
saveON=1;

% Regular expressions - first calculates FF etc, then performs regular
% expressions
Params_global.CompilePC.regexp_list={'c(b)'}; % e.g. {'dcc(b)', 'ab+(g)'} : dcc(b) means match dccb, and give me ind of b in parantheses.  ab+g means match ab... (anly length repeat), then g. give me ind of g
    
[ALLDATSTRUCT, Params_global]= lt_extract_CompilePC(plotON, Params_global, saveON);



%% Convert to context1 format
Params_global.ConvertToContext1.NoteGroupNum_codes={'away', 1, 'home', 2, 'awayProbe', 3}; % {NoteGroup_name, NoteGroupNum} pairs - name must match what is in "condition" field. NoteGroupNum can be anything (keep it from 1, 2, ...);
% Params_global.ConvertToContext1.NoteNum_codes={'dcc_b_', 1, 'bcc_b_', 2}; % {notestring, notenum} pairs - notestring either single syl (e.g. 'a') or regexp, using underscores (e.g. 'dcc_b_')
Params_global.ConvertToContext1.NoteNum_codes={'c_b_', 1}; % {notestring, notenum} pairs - notestring either single syl (e.g. 'a') or regexp, using underscores (e.g. 'dcc_b_')
% syl='b';


[AllSongsDataMatrix, Params_alldays]= lt_context2_ConvertToContext1(ALLDATSTRUCT, Params_global);


%% PLOT
close all;
Params_alldays.NoteToPlot=1;
Params_alldays.RunBin=10;

Params_alldays.BoundaryTimes={'15Nov2015-0000', '27Nov2015-0000', '29Nov2015-1248'}; % in format of e.g. 05May2014-1423, these are times of switching in experiment (e.g. turning WN off and on, changing pitch contingency, etc)
Params_alldays.Edge_Num_Rends = 50; % num rends to call "edges"

Params_alldays.throw_out_if_epoch_diff_days=0; % throws out any transitions that overlap with O/N (potentially 2 per O/N)
one_switch_a_day=1;

Params_alldays.BaselinePhase=1; 
Params_alldays.PhasesToPlotProbesFor=[2 4];

lt_context_PLOT(AllSongsDataMatrix, Params_alldays, one_switch_a_day);



%% =================================================
%% AUTOLABEL
% After this, can run stuff same as for evtaf amp version to replace false
% positives.

batch = 'batch.keep';
% config='/bluejay4/lucas/birds/pu11wh87/config_111715.evconfig2'; 
config='/bluejay4/lucas/birds/pu11wh87/config_112015.evconfig2'; 

syl.targ='b';
syl.pre='cc';
syl.post=''; 
NoteNum=0; 

ampThresh=19000;
min_dur=20;
min_int=4;

overwrite_notmat=1;

[fnames, sylnum, vlsorfn, vlsorind]=lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat);


% ----- OPTIONAL
[fnames, sylnum]=lt_jc_chcklbl(batch, syl.targ, 0.025,0.025,'','','');
[vlsorfn vlsorind]=jc_vlsorfn(batch, syl.targ,'','');


% ============ 2) Use evsonganaly manually on the .wav file created above
% (contains only the syls you chose)
% INSTRUCTIONS: 
% 1) open .wav file using evsonganaly
% 2) change threshold to segment all syls indivudally
% 3) any syl labeled "-" (default) will remain unchanged (i.e. will stay autolabeled). 
%     give a new label to any mislabeled syl - that will be its new actual label
evsonganaly



% ============ 3) Replace hand-checekd mislabeld syls 
lt_autolabel_FixHandCheckedSyls(fnames, sylnum, vlsorfn, vlsorind)



