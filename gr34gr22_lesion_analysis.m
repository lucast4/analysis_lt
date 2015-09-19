
%% to make batch file and subsample randomly to then analyze with evsonganaly

batchname = 'batch';
% batchname = input('What is the name of the batch file?  ', 's');

%makes a batch file
db_write_batch(batchname)

lt_batch_all_clean

randsamp('batch.keep',0.2)

%%
% looking at the abc repeat - # repeats and variabily change?
% go to each day folder and do the following. does analysis for all
% possible repeats (each with diff final letter).
% MAKE SURE TO CHANGE DATE ARGUMENT

clear all; close all
syllables={'a' 'b' 'c' 'd' 'e'};

for i=1:length(syllables);
    syl=syllables(i);
    lt_db_seq_func_day_save_rd3gr35('batch.catch.keep','', 'gr34gr22', '22Oct2013', 1, syl, 'HVCml')
end


%% pitch contours
% go to bird folder and run this:
% looking at syllables a,b,i,j,k,q

% Frequency range for q for gr34gr22?
% (format [start stop])  [800 2000]
% Refractory period for q for gr34gr22?  0.2
% Frequency range for a for gr34gr22?
% (format [start stop])  [2500 4000]
% Refractory period for a for gr34gr22?  0.2
% Frequency range for b for gr34gr22?
% (format [start stop])  [2500 4000]
% Refractory period for b for gr34gr22?  0.2
% Frequency range for i for gr34gr22?
% (format [start stop])  [2500 4000]
% Refractory period for i for gr34gr22?  0.2
% Frequency range for j for gr34gr22?
% (format [start stop])  [800 2000]
% Refractory period for j for gr34gr22?  0.2
% Frequency range for k for gr34gr22?
% (format [start stop])  [800 2000]
% Refractory period for k for gr34gr22? 0.5


db_contour_and_FF_analysis_over_time_v3
