%% Pull out all the songs into a single batch

% first pull out all songs with FB.
% second, out of left over songs, some had trigger, but "catch", so no FB.
% Pull those out by using cleandirAuto on the non-WN songs.
% third, combine those two to get all songs.

% MAKE a batch file with all songs
batchname = 'batch';
db_write_batch(batchname)

% PULL out all songs with WN FB given.
lt_rec_files_find_FB 

% CLEAN the leftovers to find remaining non-WN songs.
% batch='batch.rec_noFB'; % name of batch without WN FB.
% cleandirAuto('batch.rec_noFB',1000,4,4) % these parameters tailored for bk51bk59.

cleandir5('batch',12000,1000,6,6)

%% MAKE a new total batch file by combining the two above.
% this shoudl contain all songs.

batch.rec_FB
batch.rec_noFB.keep

batch_one=textread(batch.rec_FB
batch_two=

%sort:





%% ALTERNATIVE METHODS TO PULL SONGS

batchname = 'batch';% make batch
db_write_batch(batchname)

cleandirAuto('batch',1000,4,4); % clean

cleandirAuto('batch.dcrd',1000,4,4); % clean the dscrd pile with more lenient params to make sure got all songs.


%% CHECK how good template was at detecting

% First make templates of a and x to see if dramatic change in syllable
% and to get count of number of f. neg.

db_make_template

% the script will do the following:
% first, change all "A" to a. copy all .not.mat with A to a temporary
% folder,then change all A to a, run the check_template script, then
% restore the old .not.mat with A.

mkdir('temp_folder') 
!cp *.not.mat* temp_folder
db_change_syllable_in_batchfile('batch.catch.keep','u','f')

lt_db_check_template_timing_and_hit_rate

!cp temp_folder/*.not.mat* .
!rm -r temp_folder


%% want to ask whether WN is making bird drop the syllable.


