% %% CHECKING TEMPLATE MATCHING (c[b]);
% 
% === GETTING cb
clear all; close all;
batchf='batch.labeled.all';
config='/bluejay5/lucas/birds/or64/config.evconfig2';
config='/bluejay5/lucas/birds/or64/config2.evconfig2';
config='/bluejay5/lucas/birds/or64/config3.evconfig2';
config='/bluejay5/lucas/birds/or64/config020817.evconfig2';

syl='g';
syl_pre='f';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);



%%  NO LABEL REQUIRED - USED FOR ANALYSIS OF LEARNING SCREENING
% close all;
% 
% Params.batch='batch.keep';
% Params.config='/bluejay5/lucas/birds/or60/config.evconfig2';
% Params.NoteNum_to_plot=0; % for the note you want to analyze
% [AllSongsData_toplot, AllData] = lt_check_hit_templ_freq_NoLabelRequired(Params);


%% =====  AUTOLABEL ALL DAYS

% 1) make batch
lt_make_batch(1);

% 2) run
batch = 'batch.keep';
config= '/bluejay5/lucas/birds/or64/config020817.evconfig2';

syl.targ='g';
syl.pre='jabcddef';
syl.post=''; 
NoteNum=0; 

ampThresh=15000;
min_dur=30;
min_int=4;

overwrite_notmat=1; % will always make backup folder

[fnames, sylnum, vlsorfn, vlsorind]=lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat);


    lt_v2_db_transfer_calls(2);
    
    batch = 'batch.labeled.all';
syl.targ='g';
syl.pre='jabcddef';
syl.post=''; 
    
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


%% ************************************************************** ANALYSIS
%% ANAYLYIS

%% =========== EXTRACT PC DATA ALL DAYS

clear all; close all;
Params.syl_list={'g', 'a', 'b', 'c', 'e', 'f'}; % single syls
Params.freq_range_list={[1700 2500], [1300 2500], [1500 2150], [1200 1700], [1800 2700], [1400 2400]};
Params.pc_dur_list=[0.08 0.12 0.14 0.11 0.13 0.15];
Params.pc_harms_list=[1 1 1 1 1 1];

Params.batch='batch.labeled.all';
Params.experiment = 'RandomWN';

date_range={'11Feb2017','11Feb2017'}; % e.g. {'20Apr2015','20May2015'}. leave blank ('') for all days

% ---- 2) Collect note group information? 
CollectNoteGroup = 0; % set to 1 if want to use online NoteGroups. Otherwise will do context stuff using the 
% [context_name] condition in the folder name - i.e. for bulk context, not
% rapid switching experiments. 

lt_extract_AllDaysPC(Params, date_range, CollectNoteGroup)

%% CONVERT PC TO FF

clear all; close all;
Params_global.CompilePC.PC_window_list={'g', [25 65], 'a', [140 240], 'b', [145 220], 'c', [160 215], ...
    'e', [240 300], 'f', [120 285]}; % syl, value pairs [single syls]
Params_global.CompilePC.FirstDay='';
Params_global.CompilePC.LastDay='';
plotON=1; % pitch contours, all days, all syls
saveON=0;

% Regular expressions - first calculates FF etc, then performs regular
% expressions
Params_global.CompilePC.regexp_list={}; % e.g. {'dcc(b)', 'ab+(g)'} : dcc(b) means match dccb, and give me ind of b in parantheses.  ab+(g) means match ab... (anly length repeat), then g. give me ind of g
Params_global.CompilePC.regexp_fieldnames={}; % whatever
% want to call structure field (if this cell array not defined, then will
% attempt to use the regexp names.
    
[ALLDATSTRUCT, Params_global]= lt_extract_CompilePC(plotON, Params_global, saveON);

%% ======= PLOT FF OVER DAYS

ind = 3;
syl = 'g';

FFvals = [ALLDATSTRUCT(ind).data.(syl).FFvals];
Tvals = [ALLDATSTRUCT(ind).data.(syl).Tvals_days];

lt_figure; hold on;
plot(Tvals, FFvals, 'ok');





