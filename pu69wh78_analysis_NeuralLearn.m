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


%% ============= getting ab(h), abh(h), jb(h), jbh(h)

% ================== check ab(h) or abh(h)
clear all; close all;
batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'h';
syl_pre = 'ab';
syl_post = '';
% config = '/bluejay5/lucas/birds/pu69wh78/config_111017_jb.evconfig2'; % better, works by being slightly conservative as well as using NOT btaf to avoid FP.
% config = '/bluejay5/lucas/birds/pu69wh78/config_111017_jb.evconfig2'; % better, works by being slightly conservative as well as using NOT btaf to avoid FP.
config = '/bluejay5/lucas/birds/pu69wh78/config_111617.evconfig2'; % better, works by being slightly conservative as well as using NOT btaf to avoid FP.
NoteNum = 0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);


% ================== check jb(h) or jbh(h)
clear all; close all;
batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'h';
syl_pre = 'jb';
syl_post = '';
% config = '/bluejay5/lucas/birds/pu69wh78/config_111017_jb.evconfig2'; % better, works by being slightly conservative as well as using NOT btaf to avoid FP.
% config = '/bluejay5/lucas/birds/pu69wh78/config_111017_jb.evconfig2'; % better, works by being slightly conservative as well as using NOT btaf to avoid FP.
config = '/bluejay5/lucas/birds/pu69wh78/config_111617.evconfig2'; % better, works by being slightly conservative as well as using NOT btaf to avoid FP.
NoteNum = 1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);



%% ============= getting a(b), ab(h), abh(h), j(b), jb(h), jbh(h)

% ================== check ab(h) or abh(h)
clear all; close all;
batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'h';
syl_pre = 'ab';
syl = 'b';
syl_pre = 'a';
syl_post = '';
% config = '/bluejay5/lucas/birds/pu69wh78/config_111017_jb.evconfig2'; % better, works by being slightly conservative as well as using NOT btaf to avoid FP.
% config = '/bluejay5/lucas/birds/pu69wh78/config_111017_jb.evconfig2'; % better, works by being slightly conservative as well as using NOT btaf to avoid FP.
config = '/bluejay5/lucas/birds/pu69wh78/config_111617v2.evconfig2'; % better, works by being slightly conservative as well as using NOT btaf to avoid FP.
config = '/bluejay5/lucas/birds/pu69wh78/config111717.evconfig2'; % better, works by being slightly conservative as well as using NOT btaf to avoid FP.
config = '/bluejay5/lucas/birds/pu69wh78/config112017.evconfig2'; % better, works by being slightly conservative as well as using NOT btaf to avoid FP.
NoteNum = 0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);


% ================== check jb(h) or jbh(h)
clear all; close all;
batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'h';
syl_pre = 'jb';
syl_post = '';
% config = '/bluejay5/lucas/birds/pu69wh78/config_111017_jb.evconfig2'; % better, works by being slightly conservative as well as using NOT btaf to avoid FP.
% config = '/bluejay5/lucas/birds/pu69wh78/config_111017_jb.evconfig2'; % better, works by being slightly conservative as well as using NOT btaf to avoid FP.
config = '/bluejay5/lucas/birds/pu69wh78/config_111617v2.evconfig2'; % better, works by being slightly conservative as well as using NOT btaf to avoid FP.
config = '/bluejay5/lucas/birds/pu69wh78/config111717.evconfig2'; % better, works by being slightly conservative as well as using NOT btaf to avoid FP.
config = '/bluejay5/lucas/birds/pu69wh78/config112017.evconfig2'; % better, works by being slightly conservative as well as using NOT btaf to avoid FP.
NoteNum = 1;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);

%% ==================== getting only ab(h)


clear all; close all;
batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'h';
syl_pre = 'ab';
syl_post = '';
config = '/bluejay5/lucas/birds/pu69wh78/config_111017.evconfig2'; % better, works by being slightly conservative as well as using NOT btaf to avoid FP.
config = '/bluejay5/lucas/birds/pu69wh78/config_111017_2.evconfig2'; % better, works by being slightly conservative as well as using NOT btaf to avoid FP.
config = '/bluejay5/lucas/birds/pu69wh78/config_111017_3.evconfig2'; % better, works by being slightly conservative as well as using NOT btaf to avoid FP.
config = '/bluejay5/lucas/birds/pu69wh78/config_111017_4.evconfig2'; % better, works by being slightly conservative as well as using NOT btaf to avoid FP.
NoteNum = 0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);


%% ====================== getting ab(h) and abh(h)

clear all; close all;
batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'h';
syl_pre = 'ab';
syl_post = '';
config = '/bluejay5/lucas/birds/pu69wh78/config_111017_5.evconfig2'; % better, works by being slightly conservative as well as using NOT btaf to avoid FP.
config = '/bluejay5/lucas/birds/pu69wh78/config_111017_test.evconfig2'; % better, works by being slightly conservative as well as using NOT btaf to avoid FP.
NoteNum = 0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);


%% ====================================== adding DIR to end of name

ListOfSongsRegexp = {'5039.31', '714.27', '04.327', '38.329', '937.88'};
suffix = '_DIR';
for i=1:length(ListOfSongsRegexp)
   
    songname = ListOfSongsRegexp{i};
    
    tmp = dir(['*' songname '*.cbin']);
    assert(length(tmp)==1, 'asdfsd');
    
    tmp = tmp(1).name(1:end-5);
    disp(['renaming ' tmp]);
    
    % -- rename cbin
    uscores = strfind(tmp, '_');
    eval(['!mv ' tmp '.cbin ' tmp(1:uscores(1)-1) suffix tmp(uscores(1):end) '.cbin']);
    
    % -- rename notmat
    try 
    eval(['!mv ' tmp '.cbin.not.mat ' tmp(1:uscores(1)-1) suffix tmp(uscores(1):end) '.cbin.not.mat']);
    catch err
        % then no .notmat
    end
    
    % -- rename .rec
    eval(['!mv ' tmp '.rec ' tmp(1:uscores(1)-1) suffix tmp(uscores(1):end) '.rec']);
end


%% ==================================== DUAL TARGET (jb(hh) and ab(hh) both down)


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
