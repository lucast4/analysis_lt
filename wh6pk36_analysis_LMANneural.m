%% CHECKING TEMPLATE MATCHING a(b);

% === GETTING cb
clear all; close all;
batchf='batch.labeled.all';
batchf='batch.keep';
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


% ============ ch(b)
clear all; close all;
batchf='batch.labeled.all';
config='/bluejay5/lucas/birds/wh6pk36/config032917_2.evconfig2'; % NOTE: works well


syl='b';
syl_pre='ch';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);



%% ========== NEURON DATABASE

% ========================= TEMPORARY
clear NeuronDatabase;
NeuronDatabase.global.basedir='/bluejay5/lucas/birds/wh6pk36/NEURAL';
ind=0;



% ====================== 3/8
ind=ind+1;
NeuronDatabase.neurons(ind).exptID='LMANneural2'; % 
NeuronDatabase.neurons(ind).date='030817'; % date
NeuronDatabase.neurons(ind).batchfile='Batch1438to1909v2'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=14; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='Only subset songs that are not degraded'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 
NeuronDatabase.neurons(ind).electrode_depth=[]; % in um 

ind=ind+1;
NeuronDatabase.neurons(ind).exptID='LMANneural2'; % 
NeuronDatabase.neurons(ind).date='030817'; % date
NeuronDatabase.neurons(ind).batchfile='Batch1438to1909'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=11; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='Only subset songs that are not degraded'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 
NeuronDatabase.neurons(ind).electrode_depth=[]; % in um 

% ====================== 3/15
ind=ind+1;
NeuronDatabase.neurons(ind).exptID='LMANlearn1'; % 
NeuronDatabase.neurons(ind).date='031517'; % date
NeuronDatabase.neurons(ind).batchfile='Batch1039to1117'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=14; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random=''; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 
NeuronDatabase.neurons(ind).electrode_depth=[]; % in um 


% ====================== 3/15
ind=ind+1;
NeuronDatabase.neurons(ind).exptID='LMANlearn1'; % 
NeuronDatabase.neurons(ind).date='031517'; % date
NeuronDatabase.neurons(ind).batchfile='Batch1051to1106'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=8; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='yes'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='[DONT USE]Not clear song mod. low FR, no bursts, IN? dip at song onset, no clear offset suppression...'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='yes'; % 
NeuronDatabase.neurons(ind).electrode_depth=[]; % in um 


% ======== add neurons
ind=ind+1;
NeuronDatabase.neurons(ind).exptID='LMANlearn1'; % 
NeuronDatabase.neurons(ind).date='031517'; % date
NeuronDatabase.neurons(ind).batchfile='Batch1307to1424'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=14; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='TEMP: cehkceing if song mod'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 
NeuronDatabase.neurons(ind).electrode_depth=[]; % in um 


%% ======================================== [LMANlearn1]
% ========================= TEMPORARY
clear NeuronDatabase;
NeuronDatabase.global.basedir='/bluejay5/lucas/birds/wh6pk36/NEURAL';
ind=0;

% ===
ind=ind+1;
NeuronDatabase.neurons(ind).exptID='LMANlearn1'; % 
NeuronDatabase.neurons(ind).date='031517'; % date
NeuronDatabase.neurons(ind).batchfile='Batch1307to2152'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=14; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random=''; % random note
NeuronDatabase.neurons(ind).LEARN_exptID='LMANlearn1';
NeuronDatabase.neurons(ind).LEARN_WNonDatestr='15Mar2017-1425';
NeuronDatabase.neurons(ind).LEARN_WNotherImportantDates={}; % leave empty if nothing.
NeuronDatabase.neurons(ind).NOTE_all_labeled='yes'; % 


%% ============= LMANlearn2
% TEMPORARY
clear NeuronDatabase;
NeuronDatabase.global.basedir='/bluejay5/lucas/birds/wh6pk36/NEURAL';
ind=0;

% === 3/30 (neuron 1)
ind=ind+1;
NeuronDatabase.neurons(ind).exptID='LMANlearn2'; % 
NeuronDatabase.neurons(ind).date='033017'; % date
NeuronDatabase.neurons(ind).batchfile='Batch1036to2037'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=11; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random=''; % random note
NeuronDatabase.neurons(ind).LEARN_exptID='LMANlearn2';
NeuronDatabase.neurons(ind).LEARN_WNonDatestr='30Mar2017-1123';
NeuronDatabase.neurons(ind).LEARN_WNotherImportantDates={}; % leave empty if nothing.
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 

% === 3/30 (neuron 2)
ind=ind+1;
NeuronDatabase.neurons(ind).exptID='LMANlearn2'; % 
NeuronDatabase.neurons(ind).date='033017'; % date
NeuronDatabase.neurons(ind).batchfile='Batch1036to2037'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=20; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random=''; % random note
NeuronDatabase.neurons(ind).LEARN_exptID='LMANlearn2';
NeuronDatabase.neurons(ind).LEARN_WNonDatestr='30Mar2017-1123';
NeuronDatabase.neurons(ind).LEARN_WNotherImportantDates={}; % leave empty if nothing.
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 

% === 3/30 (neuron 3)
ind=ind+1;
NeuronDatabase.neurons(ind).exptID='LMANlearn2'; % 
NeuronDatabase.neurons(ind).date='033017'; % date
NeuronDatabase.neurons(ind).batchfile='Batch1036to1445'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=14; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random=''; % random note
NeuronDatabase.neurons(ind).LEARN_exptID='LMANlearn2';
NeuronDatabase.neurons(ind).LEARN_WNonDatestr='30Mar2017-1123';
NeuronDatabase.neurons(ind).LEARN_WNotherImportantDates={}; % leave empty if nothing.
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 

% === 3/30 (neuron 4)
ind=ind+1;
NeuronDatabase.neurons(ind).exptID='LMANlearn2'; % 
NeuronDatabase.neurons(ind).date='033017'; % date
NeuronDatabase.neurons(ind).batchfile='Batch1036to1445'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=8; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random=''; % random note
NeuronDatabase.neurons(ind).LEARN_exptID='LMANlearn2';
NeuronDatabase.neurons(ind).LEARN_WNonDatestr='30Mar2017-1123';
NeuronDatabase.neurons(ind).LEARN_WNotherImportantDates={}; % leave empty if nothing.
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 


% === 3/30 (neuron 5)
ind=ind+1;
NeuronDatabase.neurons(ind).exptID='LMANlearn2'; % 
NeuronDatabase.neurons(ind).date='033017'; % date
NeuronDatabase.neurons(ind).batchfile='Batch1036to1445'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=18; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random=''; % random note
NeuronDatabase.neurons(ind).LEARN_exptID='LMANlearn2';
NeuronDatabase.neurons(ind).LEARN_WNonDatestr='30Mar2017-1123';
NeuronDatabase.neurons(ind).LEARN_WNotherImportantDates={}; % leave empty if nothing.
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 

% ================================================================== 3/31 (neuron1)
ind=ind+1;
NeuronDatabase.neurons(ind).exptID='LMANlearn2'; % 
NeuronDatabase.neurons(ind).date='033117'; % date
NeuronDatabase.neurons(ind).batchfile='Batch0901to1718'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=11; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random=''; % random note
NeuronDatabase.neurons(ind).LEARN_exptID='LMANlearn2';
NeuronDatabase.neurons(ind).LEARN_WNonDatestr='31Mar2017-1224';
NeuronDatabase.neurons(ind).LEARN_WNotherImportantDates={}; % leave empty if nothing.
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 


%% =================== NEURAL V2
% ===== LMANlearn2
BirdsToKeep = {'wh6pk36'}; % {birdname , neuronstokeep} if neuronstokeep = [], then gets all;
BrainArea = {};
ExptToKeep = {'LMANlearn2'};
[NeuronDatabase, SummaryStruct] = lt_neural_v2_ConvertSummary2Database(BirdsToKeep, BrainArea, ExptToKeep);




