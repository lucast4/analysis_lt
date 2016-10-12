%%  =========== EMPTY TEMPLATE

ind=ind+1;
NeuronDatabase.neurons(ind).date=''; % date
NeuronDatabase.neurons(ind).batchfile=''; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=[]; % channel
NeuronDatabase.neurons(ind).clustnum=[]; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit=''; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed=''; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten=''; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random=''; % random note


%% neuron database [ALL]
clear NeuronDatabase;
NeuronDatabase.global.basedir='/bluejay4/lucas/birds/bk7/NEURAL';
ind=0;

% ======== add neurons
ind=ind+1;
NeuronDatabase.neurons(ind).date='080916'; % date
NeuronDatabase.neurons(ind).batchfile='BatchChan14good_v4'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=14; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='yes'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='excluded some noises songs'; % random note

ind=ind+1;
NeuronDatabase.neurons(ind).date='080916'; % date
NeuronDatabase.neurons(ind).batchfile='BatchChan14good_v4'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=9; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='incr or decrease threshold'; % random note

ind=ind+1;
NeuronDatabase.neurons(ind).date='080916'; % date
NeuronDatabase.neurons(ind).batchfile='BatchChan14Late'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=14; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='yes'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='last song miss some spikes - excluded some noisy songs'; % random note


ind=ind+1;
NeuronDatabase.neurons(ind).date='081616'; % date
NeuronDatabase.neurons(ind).batchfile='BatchMidDayChan18SU'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=23; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='could get more song; missing some spikes'; % random note


ind=ind+1;
NeuronDatabase.neurons(ind).date='080916'; % date
NeuronDatabase.neurons(ind).batchfile='BatchChan9Midday'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=9; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='IMPORTANT: is likely similar, but not identical, MU to BatchChan14good_v4 [Could combine or only use one, but should not consider them as independent]'; % random note

ind=ind+1;
NeuronDatabase.neurons(ind).date='081616'; % date
NeuronDatabase.neurons(ind).batchfile='BatchMidDayChan18SU'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=18; % channel
NeuronDatabase.neurons(ind).clustnum=2; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='yes'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='IDENTICAL TO PREVIOUS NEURON 4 (already removed)'; % random note

ind=ind+1;
NeuronDatabase.neurons(ind).date='081616'; % date
NeuronDatabase.neurons(ind).batchfile='BatchChan14MidDay'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=14; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='some noise (Intan LVDS problem), usually outside song [song mod is clear, so noise not likely issue]; long duration - confirm that similar modulation througout [yes is similar]'; % random note


ind=ind+1;
NeuronDatabase.neurons(ind).date='081616'; % date
NeuronDatabase.neurons(ind).batchfile='BatchMidDayChan18SU'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=18; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='could get more song'; % random note

% ======================= IGNORE THIS ONE, LIKELY NOT LMAN
% ind=9;
% NeuronDatabase.neurons(ind).date='081616'; % date
% NeuronDatabase.neurons(ind).batchfile='BatchChan10Early'; % batchfile (songs)
% NeuronDatabase.neurons(ind).chan=10; % channel
% NeuronDatabase.neurons(ind).clustnum=1; % cluster
% NeuronDatabase.neurons(ind).NOTE_is_single_unit='yes'; % is_single_unit
% NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
% NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
% NeuronDatabase.neurons(ind).NOTE_random='IMPORTANT: good chance is not in LMAN, not bursty and lack syl modulation'; % random note
%

ind=ind+1;
NeuronDatabase.neurons(ind).date='081916'; % date
NeuronDatabase.neurons(ind).batchfile='BatchChan18Early'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=18; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='yes'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='looks good'; % random note

% ------------------- CHECK SONG MOD BELOW:
ind=ind+1;
NeuronDatabase.neurons(ind).date='082216'; % date
NeuronDatabase.neurons(ind).batchfile='BatchChan23EarlyNeg'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=23; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='ok'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='CHECK: no overlap with other from this batch'; % random note

ind=ind+1;
NeuronDatabase.neurons(ind).date='082216'; % date
NeuronDatabase.neurons(ind).batchfile='BatchChan23EarlyPos'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=23; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='ok'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='Potentially SU, but maybe 2 units, also not perfectly clean'; % random note


% ================ NOISY MU, FOR CHECKING STABILITY OF MU OVER DAYS AND
% WITHIN DAY
ind=ind+1;
NeuronDatabase.neurons(ind).date='081916'; % date
NeuronDatabase.neurons(ind).batchfile='batchall_MU_sub'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=18; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='IMPORTANT: to check MU stability - compare to chan 18 other days; also compare to chan 18 this day'; % random note



% ======== CONVERT TO TABLE
NeuronDatabase_table=struct2table(NeuronDatabase.neurons);
summary(NeuronDatabase_table);
disp(NeuronDatabase_table)
NumNeurons=length(NeuronDatabase.neurons);

f = figure('Position',[200 200 1000 500]);
dat=table2cell(NeuronDatabase_table);
cnames=fieldnames(NeuronDatabase_table);
t = uitable('Parent', f, 'Data',dat,'ColumnName',cnames, 'Position',[0 0 900 450]);

% === if there are any empty neurons, then move another neuron

%% neuron database [CHAN 18 ONLY]
clear NeuronDatabase;
NeuronDatabase.global.basedir='/bluejay4/lucas/birds/bk7/NEURAL';
ind=0;

% ======== add neurons
% ind=ind+1;
% NeuronDatabase.neurons(ind).date='080916'; % date
% NeuronDatabase.neurons(ind).batchfile='BatchChan14good_v4'; % batchfile (songs)
% NeuronDatabase.neurons(ind).chan=14; % channel
% NeuronDatabase.neurons(ind).clustnum=1; % cluster
% NeuronDatabase.neurons(ind).NOTE_is_single_unit='yes'; % is_single_unit
% NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
% NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
% NeuronDatabase.neurons(ind).NOTE_random='excluded some noises songs'; % random note

ind=ind+1;
NeuronDatabase.neurons(ind).date='080916'; % date
NeuronDatabase.neurons(ind).batchfile='BatchChan14good_v4'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=9; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='incr or decrease threshold'; % random note

% ind=ind+1;
% NeuronDatabase.neurons(ind).date='080916'; % date
% NeuronDatabase.neurons(ind).batchfile='BatchChan14Late'; % batchfile (songs)
% NeuronDatabase.neurons(ind).chan=14; % channel
% NeuronDatabase.neurons(ind).clustnum=1; % cluster
% NeuronDatabase.neurons(ind).NOTE_is_single_unit='yes'; % is_single_unit
% NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
% NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
% NeuronDatabase.neurons(ind).NOTE_random='last song miss some spikes - excluded some noisy songs'; % random note


% ind=ind+1;
% NeuronDatabase.neurons(ind).date='081616'; % date
% NeuronDatabase.neurons(ind).batchfile='BatchMidDayChan18SU'; % batchfile (songs)
% NeuronDatabase.neurons(ind).chan=23; % channel
% NeuronDatabase.neurons(ind).clustnum=1; % cluster
% NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
% NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
% NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
% NeuronDatabase.neurons(ind).NOTE_random='could get more song; missing some spikes'; % random note


ind=ind+1;
NeuronDatabase.neurons(ind).date='080916'; % date
NeuronDatabase.neurons(ind).batchfile='BatchChan9Midday'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=9; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='IMPORTANT: is likely similar, but not identical, MU to BatchChan14good_v4 [Could combine or only use one, but should not consider them as independent]'; % random note

ind=ind+1;
NeuronDatabase.neurons(ind).date='081616'; % date
NeuronDatabase.neurons(ind).batchfile='BatchMidDayChan18SU'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=18; % channel
NeuronDatabase.neurons(ind).clustnum=2; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='yes'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='IDENTICAL TO PREVIOUS NEURON 4 (already removed)'; % random note

% ind=ind+1;
% NeuronDatabase.neurons(ind).date='081616'; % date
% NeuronDatabase.neurons(ind).batchfile='BatchChan14MidDay'; % batchfile (songs)
% NeuronDatabase.neurons(ind).chan=14; % channel
% NeuronDatabase.neurons(ind).clustnum=1; % cluster
% NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
% NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
% NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
% NeuronDatabase.neurons(ind).NOTE_random='some noise (Intan LVDS problem), usually outside song [song mod is clear, so noise not likely issue]; long duration - confirm that similar modulation througout [yes is similar]'; % random note


ind=ind+1;
NeuronDatabase.neurons(ind).date='081616'; % date
NeuronDatabase.neurons(ind).batchfile='BatchMidDayChan18SU'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=18; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='could get more song'; % random note

% ======================= IGNORE THIS ONE, LIKELY NOT LMAN
% ind=9;
% NeuronDatabase.neurons(ind).date='081616'; % date
% NeuronDatabase.neurons(ind).batchfile='BatchChan10Early'; % batchfile (songs)
% NeuronDatabase.neurons(ind).chan=10; % channel
% NeuronDatabase.neurons(ind).clustnum=1; % cluster
% NeuronDatabase.neurons(ind).NOTE_is_single_unit='yes'; % is_single_unit
% NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
% NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
% NeuronDatabase.neurons(ind).NOTE_random='IMPORTANT: good chance is not in LMAN, not bursty and lack syl modulation'; % random note
%

ind=ind+1;
NeuronDatabase.neurons(ind).date='081916'; % date
NeuronDatabase.neurons(ind).batchfile='BatchChan18Early'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=18; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='yes'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='looks good'; % random note

% ------------------- CHECK SONG MOD BELOW:
% ind=ind+1;
% NeuronDatabase.neurons(ind).date='082216'; % date
% NeuronDatabase.neurons(ind).batchfile='BatchChan23EarlyNeg'; % batchfile (songs)
% NeuronDatabase.neurons(ind).chan=23; % channel
% NeuronDatabase.neurons(ind).clustnum=1; % cluster
% NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
% NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='ok'; % cluster_quality_confirmed
% NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
% NeuronDatabase.neurons(ind).NOTE_random='CHECK: no overlap with other from this batch'; % random note

% ind=ind+1;
% NeuronDatabase.neurons(ind).date='082216'; % date
% NeuronDatabase.neurons(ind).batchfile='BatchChan23EarlyPos'; % batchfile (songs)
% NeuronDatabase.neurons(ind).chan=23; % channel
% NeuronDatabase.neurons(ind).clustnum=1; % cluster
% NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
% NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='ok'; % cluster_quality_confirmed
% NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
% NeuronDatabase.neurons(ind).NOTE_random='Potentially SU, but maybe 2 units, also not perfectly clean'; % random note

% ================ NOISY MU, FOR CHECKING STABILITY OF MU OVER DAYS AND
% WITHIN DAY
ind=ind+1;
NeuronDatabase.neurons(ind).date='081916'; % date
NeuronDatabase.neurons(ind).batchfile='batchall_MU_sub'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=18; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='IMPORTANT: to check MU stability - compare to chan 18 other days; also compare to chan 18 this day'; % random note



% ======== CONVERT TO TABLE
NeuronDatabase_table=struct2table(NeuronDatabase.neurons);
summary(NeuronDatabase_table);
disp(NeuronDatabase_table)
NumNeurons=length(NeuronDatabase.neurons);

f = figure('Position',[200 200 1000 500]);
dat=table2cell(NeuronDatabase_table);
cnames=fieldnames(NeuronDatabase_table);
t = uitable('Parent', f, 'Data',dat,'ColumnName',cnames, 'Position',[0 0 900 450]);

% === if there are any empty neurons, then move another neuron


%% neuron database [LEARNING - TEMP]
clear NeuronDatabase;
NeuronDatabase.global.basedir='/bluejay4/lucas/birds/bk7/NEURAL';
ind=0;

% === obsolete, is a subset of Batch1860_DurLearn
% ind=ind+1;
% NeuronDatabase.neurons(ind).date='100516'; % date
% NeuronDatabase.neurons(ind).batchfile='BatchNotAllSongs'; % batchfile (songs)
% NeuronDatabase.neurons(ind).chan=10; % channel
% NeuronDatabase.neurons(ind).clustnum=1; % cluster
% NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
% NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
% NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
% NeuronDatabase.neurons(ind).NOTE_random='IMPORTANT: just to develop code - DATA NOT COMPLETE'; % random note

ind=ind+1;
NeuronDatabase.neurons(ind).date='100516'; % date
NeuronDatabase.neurons(ind).batchfile='Batch1860_DurLearn'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=10; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='HAVE NOT LOOKED THRU CLUSTER RESULTS REL SONG'; % random note

ind=ind+1;
NeuronDatabase.neurons(ind).date='100516'; % date
NeuronDatabase.neurons(ind).batchfile='Batch1860DurLearnChan23'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=23; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='HAVE NOT LOOKED THRU CLUSTER RESULTS REL SONG'; % random note





% ======== CONVERT TO TABLE
NeuronDatabase_table=struct2table(NeuronDatabase.neurons);
summary(NeuronDatabase_table);
disp(NeuronDatabase_table)
NumNeurons=length(NeuronDatabase.neurons);

f = figure('Position',[200 200 1000 500]);
dat=table2cell(NeuronDatabase_table);
cnames=fieldnames(NeuronDatabase_table);
t = uitable('Parent', f, 'Data',dat,'ColumnName',cnames, 'Position',[0 0 900 450]);

% === if there are any empty neurons, then move another neuron



%% +++++++++++++++++++++ PLOTS
%% ===== PLOT A RANDOM SONG FILE (INCLUDING RAW NEURAL AND SPIKES)


%% ==== plot  spike waveforms for all neurons
close all;
numrandspikes=100;

figcount=1;
subplotrows=NumNeurons;
subplotcols=1;
fignums_alreadyused=[];
hfigs=[];

plotcols=lt_make_plot_colors(NumNeurons, 0, 0);

for i=1:NumNeurons
    
    cd(NeuronDatabase.global.basedir);
    dirdate=NeuronDatabase.neurons(i).date;
    tmp=dir([dirdate '*']);
    assert(length(tmp)==1, 'PROBLEM - issue finding day folder');
    cd(tmp(1).name);
    
    % - load data for this neuron
    batchf=NeuronDatabase.neurons(i).batchfile;
    channel_board=NeuronDatabase.neurons(i).chan;
    [SongDat, NeurDat, Params] = lt_neural_ExtractDat(batchf, channel_board);
    
    
    inds=find(NeurDat.spikes_cat.cluster_class(:,1)==NeuronDatabase.neurons(i).clustnum); % get desired clust
    % get random subsamp
    inds=inds(randperm(length(inds), numrandspikes)); % get subset of spikes
    spkwaves=NeurDat.spikes_cat.spikes(inds, :);
    fs=NeurDat.metaDat(1).fs;
    
    % -- plot individual spikes
    [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
    title(['neuron ' num2str(i)]);
    tt=1:size(spkwaves,2);
    tt=1000*tt/fs;
    plot(tt, spkwaves', 'Color', plotcols{i});
    
    % -- overlay mean + std
    spkwaves_mean=mean(spkwaves,1);
    spkwaves_std=std(spkwaves,0, 1);
    plot(tt, spkwaves_mean, 'Color', plotcols{i}, 'LineWidth', 3);
    
    if strcmp(NeuronDatabase.neurons(i).NOTE_is_single_unit, 'no')
        % then is mu
        lt_plot_text(tt(1), 200, 'MU');
        
    end
    
end


%% FOR ALL NEURONS PLOT RASTERS, ETC, FOR A GIVEN MOTIF
% NOTE: need to throw this out (redundant with below) or put into a
% function
% ================ MOTIF STATISTICS (E.G. FIRING RATE, BURSTS, ...)
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
    
    % --- EXTRACT DAT
    regexpr_str='WHOLEBOUTS';
    predur=6; % sec
    postdur=6; % sec
    alignByOnset=1;
    WHOLEBOUTS_edgedur=6; % OPTIONAL (only works if regexpr_str='WHOLEBOUTS', only keeps
    % those motifs that have long enough pre and post - LEAVE EMPTY TO GET ALL BOUTS
    [SegmentsExtract, Params]=lt_neural_RegExp(SongDat, NeurDat, Params, ...
        regexpr_str, predur, postdur, alignByOnset, WHOLEBOUTS_edgedur);
    
    
    % ==================== Plot individually for this neuron
    useRescaled=0; % 1, then need to run LinTimeWarp first (plots scaled spikes, not song dat)
    plotAllSegs=0; % then plots each trial own plot.
    [Params]=lt_neural_motifRaster(SegmentsExtract, Params, useRescaled, plotAllSegs);
    
end


%% ==== SONG MODULATION [SUMMARY OF FR AND ISI]
% ---- MORE ACCURATETLY, OUTPUTS FR AND ISI FOR USER DEFINED WINDOWS, FOR A
% GIVEN MOTIF
close all;
Window_relOnset={};
Window_relOffset={};

% === set params
regexpr_str='WHOLEBOUTS';
predur=6; % sec
postdur=6; % sec
alignByOnset=1;
WHOLEBOUTS_edgedur=6; % OPTIONAL (only works if regexpr_str='WHOLEBOUTS', only keeps

% -- for summary analyses
motifwind=[-0.04 -0.04]; % e.g. 40ms premotif onset to 40ms pre motif offest
Window_relOnset{1}=[-6 -5.5]; % window rel 1st syl onset
Window_relOnset{2}=[-0.6 -0.1]; % window rel 1st syl onset
Window_relOffset{1}=[0.1 0.6]; % window rel last syl offset... can have as many as desired
Window_relOffset{2}=[5.5 6];

lt_neural_MultNeur_SongMod(NeuronDatabase, regexpr_str, predur, postdur, ...
    alignByOnset, WHOLEBOUTS_edgedur, Window_relOnset, motifwind, Window_relOffset)


%% ==== MOTIF MODULATION

% ========== FOR A GIVEN NEURON, COMPARE RASTERS FOR TWO MOTIFS, ALIGNING
% THOSE MOTIFS


% ============= GIVEN A MOTIF, ALIGN RASTERS FOR ALL NEURONS (that have
% data for that motif)

%% COLLECT AND PLOT STATS ACROSS NEURONS [CHOOSE ONE MOTIF]
close all;
% ===================== OBSOLETE ---> USE MULTIPLE MOTIFS CODE BELOW
% 
% % ================ MOTIF STATISTICS (E.G. FIRING RATE, BURSTS, ...)
% motif_regexpr_str='[^b](b)bb';
% motif_regexpr_str='n(h)hh';
% motif_regexpr_str='nn(h)hhh[^h]';
% motif_regexpr_str='(h)hhhh-';
% 
% motif_regexpr_str='(g)b';
% motif_regexpr_str='(g)h';
% 
% motif_regexpr_str='(h)';
% 
% motif_regexpr_str='n(h)';
% motif_predur=0.2;
% motif_postdur=0.1;
% 
% % --- to plot entire bouts
% motif_regexpr_str='WHOLEBOUTS';
% motif_predur=6; % to be able to collect about 2 sec pre and post after stretch, account for up to 3x contraction (so get 6s)
% motif_postdur=6;
% % TO DO: make this not have to do linear stretch
% 
% lt_neural_MultNeur_MotifRasters(NeuronDatabase, motif_regexpr_str, motif_predur, motif_postdur)


%% SAME AS ABOVE, BUT CHOOSE MULTIPLE MOTIFS
% linearly warps across all motifs all neurons
close all;

motif_regexpr_str={'(b)', '(h)'};
motif_predur=0.2;
motif_postdur=0;

motif_regexpr_str={'n(h)'};
motif_predur=0.2;
motif_postdur=0.1;


motif_regexpr_str={'n(h)', 'g(h)'};
motif_predur=0.2;
motif_postdur=0.1;

motif_regexpr_str={'[^vb](b)b', '[v](b)b'};
motif_predur=0.2;
motif_postdur=0.2;

motif_regexpr_str={'[gm](b)b', '[v](b)b'};
motif_predur=0.2;
motif_postdur=0.2;

motif_regexpr_str={'nn(h)hh', 'nnh(h)h'};
motif_predur=0.3;
motif_postdur=0.2;

% --- for whole motif
motif_regexpr_str='WHOLEBOUTS';
motif_predur=6; % to be able to collect about 2 sec pre and post after stretch, account for up to 3x contraction (so get 6s)
motif_postdur=6;
LinScaleGlobal=1;
% --

LinScaleGlobal=0; % 0:NONE; 1: global (across neurosn and motifs); 2: local (specific to neuron x motif)
lt_neural_MultNeur_MotifRasters_v2(NeuronDatabase, motif_regexpr_str, motif_predur, motif_postdur, LinScaleGlobal);


%% ========================== BUILD LINEAR MODEL OF FIRING RATES
lt_neural_MultNeur_CollectFeats


%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++ LEARNING
% === CURRENTLY ASSUMES THAT ALL NERUONS IN CURRENT DATABASE WERE COLLECTED
% DURING LEARNING (NOT NECESSARILY 100% OVERLAPPING TEMPORALLY)

% FOR EACH NEURON, PLOT RASTER AND SMOOTHED FIRING FOR A GIVEN MOTIF ACROSS
% TIME 
% - I.E. same as above code, except noting when learning began, gets FF,
% hit/escape, and catch song information
close all; 
motif_regexpr_str={'g(h)', 'nnn(h)hh','v(b)bb'};
motif_predur=0.2;
motif_postdur=0.1;
LinScaleGlobal=0; % 0:NONE; 1: global (across neurosn and motifs); 2: local (specific to neuron x motif)


FFparams.collectFF=1; % note, will try to collect FF for each motif inputed in the cell array. will 
FFparams.FF_PosRelToken=0; % syl to get FF of, relative to token (i.e. -1 is 1 before token;
    % +1 is 1 after token
FFparams.FF_sylName=''; % Optional: what syl do you expect this to be? if incompatible will raise error
    % not required (can set as []);
FFparams.cell_of_freqwinds={'h', [1100 2600], 'b', [2400 3500], ...
            'v', [2450 4300]};
% FFparams.cell_of_FFtimebins={'h', [0.042 0.058], 'b', [0.053 0.07], ...
%             'v', [0.052 0.07]}; % in sec, relative to onset (i.e. see vector T)
FFparams.cell_of_FFtimebins={'h', [0.034 0.038], 'b', [0.053 0.07], ...
            'v', [0.052 0.07]}; % WN on g H
% NOTE: will also determine whether was hit or miss, based on WN sound
% detection.
        
% LEARNING PARAMS
WNchangeDateStrings={'05Oct2016-1348'};

OnlyPlotNoHit=0; % then only plots trials that were not hit (WN)


        lt_neural_MultNeur_MotifRasters_Learning(NeuronDatabase, motif_regexpr_str, ...
    motif_predur, motif_postdur, LinScaleGlobal, FFparams, WNchangeDateStrings, OnlyPlotNoHit)




