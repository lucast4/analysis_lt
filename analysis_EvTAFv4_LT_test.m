%% 3/17/15 - testing evtafv4-LT, which I am modifying in labview. 

cd '/bluejay4/lucas/birds/TEST/Labview/031615_withFFclust';

edit note_group_log.ltrec2;

%% analyzing each note group separately



%% NG1 - note 1 only
clear all; close all;
batchf='batch.labeled.all';
config='/bluejay4/lucas/birds/ab01ab01/032015_NotRec_test/config.evconfig2';

syl='b';
syl_pre='cb';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);



syl='b';
syl_pre='jb';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);



syl='b';
syl_pre='jb';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=2;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);
