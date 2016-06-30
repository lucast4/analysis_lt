%% cheeck template - OLD, all b1 (hB and kB)
clear all; close all;
batchf='batch.labeled.all';
% config='/bluejay4/lucas/birds/wh25pk77/CONFIG_away_2.evconfig2'; % start 5/17 (changed template)
% config='/bluejay4/lucas/birds/wh25pk77/111515_CtxtDepPitch_away_durWN/CONFIG_away.evconfig2';
config='/bluejay4/lucas/birds/wh25pk77/config_112015.evconfig2';


syl='b';
syl_pre='k';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


% ++++++++++++++++++++++++++++++++++++++++++
% ============ JUST A...hB
clear all; close all;
batchf='batch.labeled.all';
% config='/bluejay4/lucas/birds/wh25pk77/config_120115.evconfig2';
config='/bluejay4/lucas/birds/wh25pk77/config_120115good.evconfig2';

syl='b';
syl_pre='h';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% ============ JUST kB
clear all; close all;
batchf='batch.labeled.all';
% config='/bluejay4/lucas/birds/wh25pk77/config_120115_kB.evconfig2';
config='/bluejay4/lucas/birds/wh25pk77/config_120115good.evconfig2';

syl='b';
syl_pre='k';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);



%% +++++++++++++++++++++++++++++++++++++++++++ CONTEXT ANALYSIS
%% ======================= Extracting data across days
% --- day directories must be in format
% [date]_[experimentname]_[context_name].
% -- Run this in bird folder to extract all days data to subfolder

clear all; close all;

Params.syl_list={'b'}; % single syls
Params.freq_range_list={[3000 4000]};
Params.pc_dur_list=[0.11];
Params.pc_harms_list=[1];

Params.batch='batch.labeled.all.edge';
Params.experiment = 'CtxtDepPitch';

date_range={'14Dec2015','14Dec2015'}; % e.g. {'20Apr2015','20May2015'}. leave blank ('') for all days

lt_extract_AllDaysPC(Params, date_range)


%% %% Compiling data - go to "extract" folder first
clear all; close all;
Params_global.CompilePC.PC_window_list={'b', [21 56]}; % syl, value pairs [single syls]
Params_global.CompilePC.FirstDay='';
Params_global.CompilePC.LastDay='';
plotON=1; % pitch contours, all days, all syls
saveON=1;

% Regular expressions - first calculates FF etc, then performs regular
% expressions
Params_global.CompilePC.regexp_list={'[^b](b)'}; % e.g. {'dcc(b)', 'ab+(g)'} : dcc(b) means match dccb, and give me ind of b in parantheses.  ab+g means match ab... (anly length repeat), then g. give me ind of g
Params_global.CompilePC.regexp_fieldnames={'b_first'}; % whatever
% want to call structure field (if this cell array not defined, then will
% attempt to use the regexp names.
    
[ALLDATSTRUCT, Params_global]= lt_extract_CompilePC(plotON, Params_global, saveON);


%% Convert to context1 format
% --- TO BE ABLE TO RUN USING CONTEXT PLOT SAME AS FOR METHOD 1
Params_global.ConvertToContext1.NoteGroupNum_codes={'away', 1, 'home', 2, 'awayProbe', 3}; % {NoteGroup_name, NoteGroupNum} pairs - name must match what is in "condition" field. NoteGroupNum can be anything (keep it from 1, 2, ...);
Params_global.ConvertToContext1.NoteNum_codes={'b_first', 1}; % {notestring, notenum} pairs - notestring either single syl (e.g. 'a') or regexp, using underscores (e.g. 'dcc_b_')


[AllSongsDataMatrix, Params_alldays]= lt_context2_ConvertToContext1(ALLDATSTRUCT, Params_global);


%% PLOT
% USING SAME CONTEXT PLOT CODE FROM METHOD 1
close all;
Params_alldays.NoteToPlot=1;
Params_alldays.RunBin=10;

Params_alldays.BoundaryTimes={'15Nov2015-0000', '27Nov2015-0000', '29Nov2015-1248'}; % in format of e.g. 05May2014-1423, these are times of switching in experiment (e.g. turning WN off and on, changing pitch contingency, etc)
Params_alldays.Edge_Num_Rends = 15; % num rends to call "edges"
Params_alldays.Edge_Num_Rends = 15; % num rends to call "edges"

Params_alldays.throw_out_if_epoch_diff_days=0; % throws out any transitions that overlap with O/N (potentially 2 per O/N)
one_switch_a_day=1; % manual switching experiemnts.

Params_alldays.BaselinePhase=1; % 
Params_alldays.PhasesToPlotProbesFor=[2 4];  % 


lt_context_PLOT(AllSongsDataMatrix, Params_alldays, one_switch_a_day);





%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% AUTOLABELING
% After this, can run stuff same as for evtaf amp version to replace false
% positives.

batch = 'batch.keep';
% batch = 'batch.labeled.all.edge';
config='/bluejay4/lucas/birds/wh25pk77/111515_CtxtDepPitch_away_durWN/CONFIG_away.evconfig2';
config='/bluejay4/lucas/birds/wh25pk77/config_112015.evconfig2';



syl.targ='b';
syl.pre='';
syl.post=''; 
NoteNum=0; 

ampThresh=4000;
min_dur=20;
min_int=4;

overwrite_notmat=1; % will always make backup folder

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


%% ==== autolabeling across days

%% ========================== 11/18/15 - wh25 context autolabel
clear all; close all;
batch = 'batch.keep';
% config='/bluejay4/lucas/birds/wh25pk77/111515_CtxtDepPitch_away_durWN/CONFIG_away.evconfig2';
config='/bluejay4/lucas/birds/wh25pk77/config_112015.evconfig2';


syl.targ='b';
syl.pre='';
syl.post=''; 
NoteNum=0; 

ampThresh=4000;
min_dur=20;
min_int=4;

overwrite_notmat=1;

% ---- RUN
MetadataStruct=lt_metadata_collect;

experiment = 'CtxtDepPitch';
condition='';
notes='';
date_range={'01Dec2015', '05Dec2015'};
only_labeled_dirs=0;
ListOfDirs2=lt_metadata_find_dirs(MetadataStruct, experiment, condition, notes, date_range, only_labeled_dirs);

for i=1:length(ListOfDirs2);
   
    cd(ListOfDirs2{i});
   
   lt_make_batch(1);
    
[fnames, sylnum, vlsorfn, vlsorind]=lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat);

cd ..
end



