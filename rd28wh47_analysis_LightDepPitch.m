%% CHECKING TEMPLATE MATCHING;

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


