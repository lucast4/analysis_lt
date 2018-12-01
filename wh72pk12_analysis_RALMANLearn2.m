%% CHECKING TEMPLATE MATCHING;

clear all; close all;
batchf='batch.labeled.all';
config='/bluejay2/lucas/birds/wh72pk12/config112818.evconfig2';
config='/bluejay2/lucas/birds/wh72pk12/config112818_2.evconfig2';
config='/bluejay2/lucas/birds/wh72pk12/config112818_3.evconfig2';

% === Note 0 
syl='b';
syl_pre='ajkl';
syl_post='';
get_WN_hits=0;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% === Note 1
syl='h';
syl_pre='ajklb';
syl_post='';
get_WN_hits=0;
get_offline_match=1;
get_FF=1;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

