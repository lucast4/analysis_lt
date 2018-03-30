%% MATCHING TEMPLATE - getting all b (targeting b1 and b2)

clear all; close all;
batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
config = '/bluejay5/lucas/birds/wh44wh39/config_032118.evconfig2'; % to get all b
config = '/bluejay5/lucas/birds/wh44wh39/config_032118_2.evconfig2'; % to get all b
config = '/bluejay5/lucas/birds/wh44wh39/config_032118_3.evconfig2'; % to get all b
config = '/bluejay5/lucas/birds/wh44wh39/config_032118_4.evconfig2'; % to get all b

% ================ H1
NoteNum = 0;
syl = 'h';
syl_pre = 'n';
syl_post = '';
check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);

% ======== h2
NoteNum = 0;
syl = 'h';
syl_pre = 'nh';
syl_post = '';
check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);


%% MATCHING TEMPLATE - targeting only b2)

clear all; close all;
batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
config = '/bluejay5/lucas/birds/wh44wh39/config_032118_5.evconfig2'; %
config = '/bluejay5/lucas/birds/wh44wh39/config_032218.evconfig2'; %
config = '/bluejay5/lucas/birds/wh44wh39/config_032318.evconfig2'; %
config = '/bluejay5/lucas/birds/wh44wh39/config_032418.evconfig2'; %

% ======== h2
NoteNum = 0;
syl = 'h';
syl_pre = 'nh';
syl_post = '';
check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);


%% updating config file
clear all ; close all;

config_source = '/bluejay5/lucas/birds/wh44wh39/config_031418.evconfig2';
notenum_source = 1; % 1, 2, ...

config_targ = '/bluejay5/lucas/birds/wh44wh39/config_031418.evconfig2';
notenum_targ = [2]; % array (1, 2. ...)

[config_fname] = lt_evconfig_replaceNotes(config_targ, notenum_targ, config_source, ...
    notenum_source);


