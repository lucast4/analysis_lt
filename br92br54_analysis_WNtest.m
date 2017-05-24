%%  NO LABEL REQUIRED - USED FOR ANALYSIS OF LEARNING SCREENING
close all;

Params.batch='batch.keep';
Params.config='/bluejay5/lucas/birds/br92br54/config_042917.evconfig2';
Params.NoteNum_to_plot=0; % for the note you want to analyze
[AllSongsData_toplot, AllData] = lt_check_hit_templ_freq_NoLabelRequired(Params);


%% CHECKING TEMPLATE MATCHING;

clear all; close all;
batchf='batch.labeled.all';
config='/bluejay5/lucas/birds/br92br54/config.evconfig2';
config='/bluejay5/lucas/birds/br92br54/config042017.evconfig2';
config='/bluejay5/lucas/birds/br92br54/config042017_2.evconfig2';
config='/bluejay5/lucas/birds/br92br54/config042717.evconfig2';
config='/bluejay5/lucas/birds/br92br54/config_042917.evconfig2';
config='/bluejay5/lucas/birds/br92br54/config050117.evconfig2'; % 5/1/17

% === WN (nk[h])
syl='h';
syl_pre='nk';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% === WN (ddd[h])

clear all; close all;
batchf='batch.labeled.all';
% batchf='batch.keep.UNLABELED.LABELED';
config='/bluejay5/lucas/birds/br92br54/config041617.evconfig2'; % fine

syl='h';
syl_pre='d';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


% ===== (ag(c)c);
clear all; close all;
batchf='batch.labeled.all';
config='/bluejay5/lucas/birds/br92br54/config042317_2.evconfig2';

% === WN (nk[h])
syl='c';
syl_pre='ag';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


% ============= all h
clear all; close all;
batchf='batch.labeled.all';
config='/bluejay5/lucas/birds/br92br54/config_052417.evconfig2'; % 5/1/17

% === WN (nk[h])
syl='h';
syl_pre='';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

