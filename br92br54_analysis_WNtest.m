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
config='/bluejay5/lucas/birds/br92br54/config_052417_2.evconfig2'; % 5/1/17

% === WN (nk[h])
syl='h';
syl_pre='';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


% =================== cd
clear all; close all;
batchf='batch.labeled.all';
config='/bluejay5/lucas/birds/br92br54/config_061617.evconfig2'; % 5/1/17 - NOTE !! IN PROGRESS 

% === WN 
syl='d';
syl_pre='c';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

%% ==== LMANlearn6

clear all; close all;
batchf='batch.labeled.all';
config='/bluejay5/lucas/birds/br92br54/config_061617_2.evconfig2'; % 
config='/bluejay5/lucas/birds/br92br54/config_061617_3.evconfig2'; % 6/17/16 - now letting hd get also the shorter h

% === WN 
syl='d';
syl_pre='h';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, ...
    syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% =================== (^h)d
clear all; close all;
batchf='batch.labeled.all';
config='/bluejay5/lucas/birds/br92br54/config_061617_2.evconfig2'; %
config='/bluejay5/lucas/birds/br92br54/config_061617_3.evconfig2'; % 6/17/16 - now letting hd get also the shorter h

% === WN
syl='d';
syl_pre='';
syl_post='dd';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, ...
    syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


%% 
clear NeuronDatabase;
NeuronDatabase.global.basedir='/bluejay5/lucas/birds/br92br54/NEURAL';
ind=0;

% ======== add neurons
ind=ind+1;
NeuronDatabase.neurons(ind).exptID='LMANlearn6'; % 
NeuronDatabase.neurons(ind).date='061617'; % date
NeuronDatabase.neurons(ind).batchfile='Batch1034to1134check'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=14; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='just checking if clearly song mod'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 
NeuronDatabase.neurons(ind).electrode_depth=[]; % in um 

ind=ind+1;
NeuronDatabase.neurons(ind).exptID='LMANlearn6'; % 
NeuronDatabase.neurons(ind).date='061617'; % date
NeuronDatabase.neurons(ind).batchfile='Batch1034to1134check'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=23; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='just checking if clearly song mod'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 
NeuronDatabase.neurons(ind).electrode_depth=[]; % in um 

ind=ind+1;
NeuronDatabase.neurons(ind).exptID='LMANlearn6'; % 
NeuronDatabase.neurons(ind).date='061617'; % date
NeuronDatabase.neurons(ind).batchfile='Batch1801to1831check'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=14; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='just checking if clearly song mod'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 
NeuronDatabase.neurons(ind).electrode_depth=[]; % in um 

ind=ind+1;
NeuronDatabase.neurons(ind).exptID='LMANlearn6'; % 
NeuronDatabase.neurons(ind).date='061617'; % date
NeuronDatabase.neurons(ind).batchfile='Batch1801to1831check'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=23; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='just checking if clearly song mod'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 
NeuronDatabase.neurons(ind).electrode_depth=[]; % in um 
