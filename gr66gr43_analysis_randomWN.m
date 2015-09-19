
%% BELOW - RANDOM WN STUFF

%% to calculate hit rate 

[vals, trigs]=triglabel('batch.catch.keep','b',1,0,0,0)

%% to change missed labels, make template, then change back to old labels:

db_change_miss_label('batch.catch.keep','b','B')

db_make_template

db_change_syllable_in_batchfile('batch.catch.keep','B','b')

%% absv as a common motif post-WN.  did this occur often before?

% using 27Jan2014_1617 various structure:

for i=1:length(all_days_various.lt_db_get_labels.labels{end-1});
    absv_index3{i}=findstr(all_days_various.lt_db_get_labels.labels{end-1}{i},'absv')
end


%% looking at 1) a[], 2) sv

all_trans.summary.syl_labels_in_order
all_trans.summary.divergence.matrix_of_fractions

mean(cell2mat(all_trans.convergent_to.v.total_number_of_transitions_persong))

1/8 - preWN
    ab: 99
    ax: 1
    v: 0.4/song

1/9 - preWN
    ab: 98
    as: 2
    v: 0.08/song
    
2/6 - postWN
    ab: 67
    aj: 15
    as: 19
    v: 5.1/song
    
    