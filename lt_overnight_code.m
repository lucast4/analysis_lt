%% ======
clear all; close all;

ListOfDirs = {...
   '/bluejay5/lucas/birds/or60/040517_Association2_durWN_STIMon', ...
    };


%%

for i=1:length(ListOfDirs)
    
    cd(ListOfDirs{i});
    
%     lt_make_batch(4);
%     lt_sort_batch_by_labeled('batch.rec_FB');
%     batch = 'batch.rec_FB.UNLABELED';

    lt_make_batch(1);
    lt_sort_batch_by_labeled('batch.keep');
    batch = 'batch.keep.UNLABELED';
    
    config='/bluejay5/lucas/birds/or60/config022217.evconfig2';
    
    syl.targ='b';
    syl.pre='dcc';
    syl.post='';
    NoteNum=0;
    
    ampThresh=47000;
    min_dur=30;
    min_int=4;
    
    overwrite_notmat=1; % will always make backup folder
    
    [fnames, sylnum, vlsorfn, vlsorind]=lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat);
    
    
end

if (0)
    %% ======= POST STUFF
    
    lt_v2_db_transfer_calls(2);
    
    batch = 'batch.labeled.all';
    syl.targ='b';
    syl.pre='dcc';
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




