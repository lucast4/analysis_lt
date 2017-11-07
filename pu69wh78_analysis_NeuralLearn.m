%% MATCHING TEMPLATE - getting all b

clear all; close all;
batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'j';
syl_post = '';
% config = '/bluejay5/lucas/birds/pu69wh78/config103017.evconfig2'; % to get ab
config = '/bluejay5/lucas/birds/pu69wh78/config103017_Bonly.evconfig2'; % to get all b
NoteNum = 0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);

%% ============== getting only ab (driving up - off targets are fine, since they are higher pitch)


clear all; close all;
batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'a';
syl_post = '';
% config = '/bluejay5/lucas/birds/pu69wh78/config_110117actual.evconfig2'; % to get ab (v2)
config = '/bluejay5/lucas/birds/pu69wh78/config_110117actual2.evconfig2'; % to get ab (v2)
NoteNum = 0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);



%% ============== getting only ab (driving DOWN - avoids off targets, since those are higher pitch, so that would be bad


clear all; close all;
batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'a';
syl_post = '';
% config = '/bluejay5/lucas/birds/pu69wh78/config_110117actual.evconfig2'; % to get ab (v2)
config = '/bluejay5/lucas/birds/pu69wh78/config_110517_v2.evconfig2'; % works by being conservative - gets substantial misses...
config = '/bluejay5/lucas/birds/pu69wh78/config_110517.evconfig2'; % better, works by being slightly conservative as well as using NOT btaf to avoid FP.
NoteNum = 0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);

%% === autolabel all b
%% === first all b
% After this, can run stuff same as for evtaf amp version to replace false
% positives.
clear all; close all;

batch = 'batch.keep';
config = '/bluejay5/lucas/birds/pu69wh78/config103017_Bonly.evconfig2'; % to get all b

syl.targ='b';
syl.pre='';
syl.post=''; 
NoteNum=0; 

ampThresh=4000;
min_dur=30;
min_int=5;

overwrite_notmat=1; % will always make backup folder

[fnames, sylnum, vlsorfn, vlsorind]=lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat);

%% === then just ab
clear all; close all;

batch = 'batch.keep';
config = '/bluejay5/lucas/birds/pu69wh78/config_110117actual2.evconfig2'; % to get ab (v2)

syl.targ='b';
syl.pre='a';
syl.post=''; 
NoteNum=0; 

ampThresh=4000;
min_dur=30;
min_int=5;

overwrite_notmat=0; % will always make backup folder

[fnames, sylnum, vlsorfn, vlsorind]=lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat);


%% make file of all b

[fnames, sylnum]=lt_jc_chcklbl(batch, 'b', 0.025,0.025,'','','');
[vlsorfn vlsorind]=jc_vlsorfn(batch, 'b','','');


%%
% ============ 2) Use evsonganaly manually on the .wav file created above
% (contains only the syls you chose)
% INSTRUCTIONS: 
% 1) open .wav file using evsonganaly
% 2) change threshold to segment all syls indivudally
% 3) any syl labeled "-" (default) will remain unchanged (i.e. will stay autolabeled). 
%     give a new label to any mislabeled syl - that will be its new actual label
evsonganaly


% ============ 3) Replace hand-checekd mislabeld syls 
lt_autolabel_FixHandCheckedSyls(fnames, sylnum, vlsorfn, vlsorind)



%% using feature vectors

lt_autolabel
