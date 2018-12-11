%% CHECKING TEMPLATE MATCHING [IGNORE NOTE GROUPS]

clear all; close all;
batchf='batch.labeled.all';
config='/bluejay2/lucas/birds/or86bk85/config112918.evconfig2';
config='/bluejay2/lucas/birds/or86bk85/config120218.evconfig2';

% ################################## NOTEGROUP0

% === Note 0 (LASER on d)
syl='c';
syl_pre='-';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=0;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

% === Note 1 (WN on b)
syl='b';
syl_pre='c';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

%% PLOT STIM AND SONG

close all;
batchf = 'batch.labeled.all'; % either .cbin file or batch
% songf = batchf; % either .cbin file or batch
lasernote = 1;
annotate_note_group = 0;

lt_batchsong_plotallchans(batchf, lasernote, annotate_note_group);






%% ============ MAKE WAVE FILES TO LOOK FOR FALSE POSITIVES
batch = 'batch.labeled.all';
syl = 'b';
presyl = 'c';
[fnames, sylnum]=lt_jc_chcklbl(batch, syl, 0.025,0.025, presyl,'','');
[vlsorfn vlsorind]=jc_vlsorfn(batch, syl, presyl,'');

