%% CHECKING TEMPLATE MATCHING;

clear all; close all;
% batchf='batch.rand.keep.LABELED';
batchf='batch.labeled.all';
% config='/bluejay5/lucas/birds/rd28wh47/config_100217_2.evconfig2'; % first config
config='/bluejay5/lucas/birds/pu46wh04/config101817.evconfig2'; %
config='/bluejay5/lucas/birds/pu46wh04/config102217.evconfig2'; %
config='/bluejay5/lucas/birds/pu46wh04/config102617.evconfig2'; %

% === WN (d[h])
syl='b';
syl_pre='j';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=1;

% --- temp (testing template)
config='/bluejay5/lucas/birds/pu46wh04/configtest.evconfig2'; %
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


