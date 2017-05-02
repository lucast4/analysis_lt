%% CHECKING TEMPLATE MATCHING;

clear all; close all;
batchf='batch.labeled.all';
config='/bluejay5/lucas/birds/br37br29/config040817.evconfig2';

% === WN (cc[b])
syl='n';
syl_pre='bn';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


