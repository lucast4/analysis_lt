%% CHECKING TEMPLATE MATCHING;

clear all; close all;
batchf='batch.labeled.all';
% config='/bluejay2/lucas/birds/wh72pk12/config112818.evconfig2';
% config='/bluejay2/lucas/birds/wh72pk12/config112818_2.evconfig2';
config='/bluejay2/lucas/birds/wh72pk12/config112818_3.evconfig2';
config='/bluejay2/lucas/birds/wh72pk12/config113018.evconfig2';

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



%% targeting all b and h

clear all; close all;
batchf='batch.labeled.all';
% config='/bluejay2/lucas/birds/wh72pk12/config112818.evconfig2';
% config='/bluejay2/lucas/birds/wh72pk12/config112818_2.evconfig2';
config='/bluejay2/lucas/birds/wh72pk12/config120418.evconfig2';
config='/bluejay2/lucas/birds/wh72pk12/config120518.evconfig2';
config='/bluejay2/lucas/birds/wh72pk12/config120518_2.evconfig2';
config='/bluejay2/lucas/birds/wh72pk12/config120518_3.evconfig2'; % gets all b, by having birdtaf for each context, combined.
config='/bluejay2/lucas/birds/wh72pk12/config120618.evconfig2'; % gets all b, by having birdtaf for each context, combined.
config='/bluejay2/lucas/birds/wh72pk12/config120718.evconfig2'; % gets all b, by having birdtaf for each context, combined.
config='/bluejay2/lucas/birds/wh72pk12/config120718_2.evconfig2'; % gets all b, by having birdtaf for each context, combined.
config='/bluejay2/lucas/birds/wh72pk12/config120918_2.evconfig2'; % gets all b, by having birdtaf for each context, combined.

% === Note 0 
syl='b';
syl_pre='';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% === Note 1
syl='h';
syl_pre='';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

%% targeting only jr(b) and jrb(h)

clear all; close all;
batchf='batch.labeled.all';
config='/bluejay2/lucas/birds/wh72pk12/121018_rb.evconfig2'; % gets all b, by having birdtaf for each context, combined.
config='/bluejay2/lucas/birds/wh72pk12/config121018_v2.evconfig2'; % gets all b, by having birdtaf for each context, combined.

% === Note 0 
syl='b';
syl_pre='r';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% === Note 1
syl='h';
syl_pre='rb';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

