%% MATCHING TEMPLATE - getting all b

clear all; close all;
batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'cb';
syl_post = '';
config = '/bluejay5/lucas/birds/wh44wh39/config_021918.evconfig2'; % to get all b
config = '/bluejay5/lucas/birds/wh44wh39/config_021918_2.evconfig2'; % to get all b
config = '/bluejay5/lucas/birds/wh44wh39/config_021918_3.evconfig2'; % to get all b
NoteNum = 0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);
