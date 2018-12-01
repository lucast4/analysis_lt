%% CHECKING TEMPLATE MATCHING [IGNORE NOTE GROUPS]

clear all; close all;
batchf='batch.labeled.all';
config='/bluejay2/lucas/birds/or86bk85/config112918.evconfig2';

% ################################## NOTEGROUP0

% === Note 0 (LASER on d)
syl='c';
syl_pre='-';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=0;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

