%% neuron database [NONLEARNING (CODING)]
clear NeuronDatabase;
NeuronDatabase.global.basedir='/bluejay5/lucas/birds/pk17gr57/NEURAL';
ind=0;

% ======== add neurons
ind=ind+1;
NeuronDatabase.neurons(ind).date='110916'; % date
NeuronDatabase.neurons(ind).batchfile='Batch1750'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=17; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='LIKELY MOTOR (NONSONG) RELATED ...'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='yes'; % 