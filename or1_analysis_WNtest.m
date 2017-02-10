%% CHECKING TEMPLATE MATCHING (c[b]);

% === GETTING cb
clear all; close all;
batchf='batch.labeled.all';
config='/bluejay5/lucas/birds/or1/011017_WNtest_durWN/config.evconfig2';

syl='b';
syl_pre='c';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);



%%  NO LABEL REQUIRED - USED FOR ANALYSIS OF LEARNING SCREENING

Params.batch='batch.keep';
Params.config='/bluejay5/lucas/birds/or1/config_offline.evconfig2'; % like above, but better at getting targ syl
Params.NoteNum_to_plot=0; % for the note you want to analyze
[AllSongsData_toplot, AllData] = lt_check_hit_templ_freq_NoLabelRequired(Params);
