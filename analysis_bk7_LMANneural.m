%%  =========== EMPTY TEMPLATE

ind=3;
NeuronDatabase.neurons(ind).date=''; % date
NeuronDatabase.neurons(ind).batchfile=''; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=''; % channel
NeuronDatabase.neurons(ind).clustnum=''; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit=''; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed=''; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten=''; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random=''; % random note


%% neuron database
NeuronDatabase.global.basedir='/bluejay4/lucas/birds/bk7/';

% ======== add neurons
ind=1;
NeuronDatabase.neurons(ind).date='080916'; % date
NeuronDatabase.neurons(ind).batchfile='BatchChan14good_v4'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan='14'; % channel
NeuronDatabase.neurons(ind).clustnum='1'; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='yes'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random=''; % random note

ind=2;
NeuronDatabase.neurons(ind).date='080916'; % date
NeuronDatabase.neurons(ind).batchfile='BatchChan14good_v4'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan='9'; % channel
NeuronDatabase.neurons(ind).clustnum='1'; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='incr or decrease threshold'; % random note

ind=3;
NeuronDatabase.neurons(ind).date=''; % date
NeuronDatabase.neurons(ind).batchfile=''; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=''; % channel
NeuronDatabase.neurons(ind).clustnum=''; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit=''; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed=''; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten=''; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random=''; % random note

% ======== CONVERT TO TABLE
NeuronDatabase_table=struct2table(NeuronDatabase.neurons);


%% +++++++++++++++++++++ PLOTS

NumNeurons=length(NeuronDatabase.neurons);

%% === 1) Bout onset and offset modulation for each neuron
currdir=pwd;
close all;

for i=1:NumNeurons
    cd(NeuronDatabase.global.basedir);
    
    % - find day folder
   dirdate=NeuronDatabase.neurons(i).date;
   tmp=dir([dirdate '*']);
   assert(length(tmp)==1, 'PROBLEM - issue finding day folder');
   cd(tmp(1).name);
   
   % - load data for this neuron
   batchf=NeuronDatabase.neurons(i).batchfile;
   channel_board=NeuronDatabase.neurons(i).chan;
    [SongDat, NeurDat, Params] = lt_neural_ExtractDat(batchf, channel_board);

    % --- Find all full bouts
    regexpr_str='WHOLEBOUTS';
    predur=3; % sec
    postdur=3; % sec
    alignByOnset=1; 
    [SegmentsExtract, Params]=lt_neural_RegExp(SongDat, NeurDat, Params, regexpr_str, predur, postdur, alignByOnset);
    
    % --- Plot individually for this neuron
useRescaled=0; % 1, then need to run LinTimeWarp first (plots scaled spikes, not song dat)
plotAllSegs=0; % then plots each trial own plot.
[Params]=lt_neural_motifRaster(SegmentsExtract, Params, useRescaled, plotAllSegs);
    
    
end


