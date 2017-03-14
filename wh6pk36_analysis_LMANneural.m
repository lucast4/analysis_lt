%% CHECKING TEMPLATE MATCHING a(b);

% === GETTING cb
clear all; close all;
batchf='batch.labeled.all';
config='/bluejay5/lucas/birds/wh6pk36/config.evconfig2'; % To get c(b), from 3/6/17, coarse.


syl='c';
syl_pre='ajkl';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


% === GETTING ac
clear all; close all;
batchf='batch.labeled.all';
config='/bluejay5/lucas/birds/wh6pk36/config_ac.evconfig2'; % NOTE: in progress, to get ajkl(c), made from 3/6/17


syl='c';
syl_pre='ajkl';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


% === (not A)c
clear all; close all;
batchf='batch.labeled.all';
config='/bluejay5/lucas/birds/wh6pk36/config_nota.evconfig2'; % NOTE: in progress, to get all c
    % that are not in ajkl(c), made from 3/6/17. 


syl='c';
syl_pre='ajkl';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


