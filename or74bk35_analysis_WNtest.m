%  NO LABEL REQUIRED - USED FOR ANALYSIS OF LEARNING SCREENING
close all;

Params.batch='batch.keep';
Params.config = '/bluejay5/lucas/birds/or74bk35/config041917.evconfig2'; % hitting n(after b)
Params.NoteNum_to_plot=0; % for the note you want to analyze
[AllSongsData_toplot, AllData] = lt_check_hit_templ_freq_NoLabelRequired(Params);


%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%% CHECKING TEMPLATE MATCHING (WN TEST)
clear all; close all;
batchf='batch.keep';
config = '/bluejay5/lucas/birds/or74bk35/config041917.evconfig2'; % hitting n(after b)


% === b(n)
syl='n';
syl_pre='b';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


%% CHECKING TEMPLATE MATCHING (LMAN NEURAL)
clear all; close all;
batchf='batch.labeled.all';
% config = '/bluejay5/lucas/birds/or74bk35/config041917.evconfig2'; % hitting n(after b)
config = '/bluejay5/lucas/birds/or74bk35/config051217.evconfig2'; % hitting n(after b)
% config = '/bluejay5/lucas/birds/or74bk35/config051217_2.evconfig2'; %


% === b(n)
syl='b';
syl_pre='n';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


