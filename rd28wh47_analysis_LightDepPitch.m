%% CHECKING TEMPLATE MATCHING;
%% targeting d(h)

clear all; close all;
% batchf='batch.rand.keep.LABELED';
batchf='batch.labeled.all';
% config='/bluejay5/lucas/birds/rd28wh47/config_100217_2.evconfig2'; % first config
config='/bluejay5/lucas/birds/rd28wh47/config_100617.evconfig2'; % starte 10/6
config='/bluejay5/lucas/birds/rd28wh47/config_100917.evconfig2'; %
config='/bluejay5/lucas/birds/rd28wh47/config_101317.evconfig2'; %
config='/bluejay5/lucas/birds/rd28wh47/config_102317.evconfig2'; %

% === WN (d[h])
syl='h';
syl_pre='d';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=1;

% % --- temp (testing template)
config='/bluejay5/lucas/birds/rd28wh47/config_template.evconfig2'; %
config='/bluejay5/lucas/birds/rd28wh47/config_template2.evconfig2'; %
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


%% ============= targeting all h

clear all; close all;
batchf='batch.labeled.all';
config='/bluejay5/lucas/birds/rd28wh47/config_103117_mod.evconfig2'; %

% === WN (d[h])
syl='h';
syl_pre='';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

% % --- temp (testing template)
% config='/bluejay5/lucas/birds/rd28wh47/config_template.evconfig2'; %
% config='/bluejay5/lucas/birds/rd28wh47/config_template2.evconfig2'; %
% NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


%% ====== updating config file

% ---- 1) replace with new template
config_old = '/bluejay5/lucas/birds/rd28wh47/config_102317.evconfig2';
template = '/bluejay5/lucas/birds/rd28wh47/rd28wh47_dh_v1_12.dat';

% AddTemplatesToEvConfig(config_old, template, template, template, template);
config_fname = AddTemplatesToEvConfig(config_old, template);

% ---- 2) update params for first column by hand 
batchf = 'batch.labeled.all';
uievtafsim(batchf, config_fname);

% ---- 3) copy params from first note to other notes
copyfrom = 2;
copyto = [1 3 4];
config_fname = '/bluejay5/lucas/birds/rd28wh47/config_103117.evconfig2';
lv_EvConfigCopyTemplstufftoAllNG(config_fname,copyfrom,copyto)







