%% ====== or64
clear all; close all;

MetadataStruct = lt_metadata_collect;

experiment = 'RandomWN';
condition='';
notes='';
date_range={'25Jan2017','12Feb2017'};
date_range={'05Feb2017','12Feb2017'};
only_labeled_dirs=0;

ListOfDirs=lt_metadata_find_dirs(MetadataStruct, experiment, condition, notes, ...
    date_range, only_labeled_dirs, 2);



%%

for i=1:length(ListOfDirs)
    
    cd(ListOfDirs(i).dirname);
    
% 1) make batch
lt_make_batch(1);

% 2) run
batch = 'batch.keep';
config= '/bluejay5/lucas/birds/or64/config020817.evconfig2';

syl.targ='g';
syl.pre='jabcddef';
syl.post=''; 
NoteNum=0; 

ampThresh=15000;
min_dur=30;
min_int=4;

overwrite_notmat=1; % will always make backup folder

[fnames, sylnum, vlsorfn, vlsorind]=lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat);
    
cd ..
    
end

if (0)
    %% ======= POST STUFF
    
    lt_v2_db_transfer_calls(2);
    
    batch = 'batch.labeled.all';
syl.targ='g';
syl.pre='jabcddef';
syl.post=''; 
    
    [fnames, sylnum]=lt_jc_chcklbl(batch, syl.targ, 0.025,0.025,'','','');
    [vlsorfn vlsorind]=jc_vlsorfn(batch, syl.targ,'','');
    
    %%
    evsonganaly
    
    
    %% ============ 3) Replace hand-checekd mislabeld syls
    lt_autolabel_FixHandCheckedSyls(fnames, sylnum, vlsorfn, vlsorind)
    
    
end



%% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
%% CONTEXT PLOTS

%% === across all birds/neurons

closeEarlyFigs = 0;
NCycles = 500; % cycles to perform shuffles


% 1) ---------------------- all
BirdsToKeep = {};
BrainArea = {'LMAN'};
NeuronDatabase = lt_neural_v2_ConvertSummary2Database(BirdsToKeep, BrainArea);

% ====== REVISED VERSION OF ABOVE - CAN COMPARE ANY BRANCHES, NOT JUST ONE BACK
close all;
lt_neural_MultNeur_AnovaTcourse(NeuronDatabase, NCycles, closeEarlyFigs);



% 1) ---------------------- bk7
BirdsToKeep = {'bk7'};
BrainArea = {'LMAN'};
NeuronDatabase = lt_neural_v2_ConvertSummary2Database(BirdsToKeep, BrainArea);

% ====== REVISED VERSION OF ABOVE - CAN COMPARE ANY BRANCHES, NOT JUST ONE BACK
close all;
lt_neural_MultNeur_AnovaTcourse(NeuronDatabase, NCycles, closeEarlyFigs);


% 1) ----------------------
BirdsToKeep = {'bu77wh13'};
BrainArea = {'LMAN'};
NeuronDatabase = lt_neural_v2_ConvertSummary2Database(BirdsToKeep, BrainArea);

% ====== REVISED VERSION OF ABOVE - CAN COMPARE ANY BRANCHES, NOT JUST ONE BACK
close all;
lt_neural_MultNeur_AnovaTcourse(NeuronDatabase, NCycles, closeEarlyFigs);



% 1) ----------------------
BirdsToKeep = {'wh6pk36'};
BrainArea = {'LMAN'};
NeuronDatabase = lt_neural_v2_ConvertSummary2Database(BirdsToKeep, BrainArea);

% ====== REVISED VERSION OF ABOVE - CAN COMPARE ANY BRANCHES, NOT JUST ONE BACK
close all;
lt_neural_MultNeur_AnovaTcourse(NeuronDatabase, NCycles, closeEarlyFigs);




