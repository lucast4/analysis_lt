%% MATCHING TEMPLATE - gH

clear all; close all;
batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'h';
syl_pre = 'g';
syl_post = '';
% config = '/bluejay4/lucas/birds/bk7/config_latest.evconfig2';
% config = '/bluejay4/lucas/birds/bk7/100516_LearnLMAN1/config_start.evconfig2';
config = '/bluejay4/lucas/birds/bk7/config_101716_newtempl.evconfig2';
config = '/bluejay4/lucas/birds/bk7/102516_NewEvtaf/config.evconfig2';
NoteNum = 0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);

