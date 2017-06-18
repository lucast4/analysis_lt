%% ++++++++++++++++++++++++++++++++++++++ autolabeling multiple syls in same batch
clear all; close all;

%% 1) AUTOLABEL EACH SYL, OVERWRITING NOTMAT
%  TRANSITION 1 (bc)
batch = 'batch.rand.keep';
config = '/bluejay5/lucas/birds/wh8pk40/config.evconfig2';

syl.targ='c';
syl.pre='b';
syl.post='';
NoteNum=0;

ampThresh=2000;
min_dur=30;
min_int=8;

overwrite_notmat=0; % will always make backup folder

[fnames, sylnum, vlsorfn, vlsorind]=lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat);


%  TRANSITION 2 (ec)
syl.targ='c';
syl.pre='e';
syl.post='';
NoteNum=1;
overwrite_notmat=0; % will always make backup folder

[fnames, sylnum, vlsorfn, vlsorind]=lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat);

% ========= put all labeled songs into one batch (batch.labeled.all)
lt_v2_db_transfer_calls(2);

%% 2) CHECK FOR FALSE POSITIVES, DO ONCE FOR EACH TEMPLATE (or: only do once
% if diff templates have a shared syl (e.g. ab vs. cb, can just check b)

% ===== 1)
batch = 'batch.labeled.all';
syl.targ='c';
syl.pre='';
syl.post='';

[fnames, sylnum]=lt_jc_chcklbl(batch, syl.targ, 0.025,0.025,'','','');
[vlsorfn vlsorind]=jc_vlsorfn(batch, syl.targ,'','');

% --- 2) Use evsonganaly manually on the .wav file created above
% (contains only the syls you chose)
% INSTRUCTIONS:
% 1) open .wav file using evsonganaly
% 2) change threshold to segment all syls indivudally
% 3) any syl labeled "-" (default) will remain unchanged (i.e. will stay autolabeled).
%     give a new label to any mislabeled syl - that will be its new actual label
evsonganaly


% ============ 3) Replace hand-checekd mislabeld syls
lt_autolabel_FixHandCheckedSyls(fnames, sylnum, vlsorfn, vlsorind)


%% 3) CHECK FALSE NEGATIVES (GO THROUGH A HANDFUL OF SONGS ON EVSONGANALY)


%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%% +++++++++++++++++++++++++++++++ PERFORMING CONTEXT SEQ ANALYSIS
%% COLLECT TRANS MATRICES
% ============ PARAMS
cd('/bluejay5/lucas/birds/wh8pk40');
exptname = 'contextseq';
firstday = ''; % format: yymmdd
lastday = '';
% -- params for running all trans
batch = 'batch.labeled.all';
bird_name = 'wh8pk40';
plotTrnDiagrams = 1;

% ================== RUNS
cd(exptname);
dirnames = dir('*');
for i=1:length(dirnames)
    if dirnames(i).isdir==0
        continue
    end
    if length(dirnames(i).name)<4
        continue
    end
    
    if ~isempty(firstday)
        if datenum(dirnames(i).name, 'yymmdd') < datenum(firstday, 'yymmdd')
            continue
        end
    end
    if ~isempty(lastday)
        if datenum(dirnames(i).name, 'yymmdd') > datenum(lastday, 'yymmdd')
            continue
        end
    end
    
    % ============= GET TRANS
    cd(dirnames(i).name);
    disp(['==== RUNNING ALL TRANS FOR ' dirnames(i).name]);
    phrase_folder = exptname;
    phrase_filename = '';
    date_expt = datestr(datenum(dirnames(i).name, 'yymmdd') , 'ddmmmyyyy');
    lt_get_all_transition_probabilities_FUNCTION(batch,bird_name,phrase_folder,phrase_filename,date_expt);
    
    if plotTrnDiagrams ==0
        close all;
    end
    
    cd ..
end


%% ======== 2) run main function (plot seq)
close all;
cd('/bluejay5/lucas/birds/wh8pk40/');
exptname = 'contextseq';
birdname = 'wh8pk40';
transitions = {};
transitions{1} = 'bc';
transitions{2} = 'ec';
transitions{3} = 'c-';

plot_seq_context_LT(exptname,birdname, transitions);


%% ========================== ANALYZING CHRISTIAN STUFF

% syl 1
clear all; close all;
config = '/bluejay5/lucas/birds/wh8pk40/config_060617.evconfig2';
config = '/bluejay5/lucas/birds/wh8pk40/config_060717.evconfig2';
% batchf= 'batch.NoteGroup_0.LABELED';
batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'c';
syl_pre = 'b';
syl_post = '';
NoteNum = 0; 

lt_check_hit_templ_freq_v2_EvTAFv4Sim_forRachel(batchf, syl, syl_pre, ...
    syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum)


% syl 2 - target ec
config = '/bluejay5/lucas/birds/wh8pk40/config_060617.evconfig2';
config = '/bluejay5/lucas/birds/wh8pk40/config_060717.evconfig2';
%batchf= 'batch.NoteGroup_2.LABELED';
batchf= 'batch.labeled.all';

get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'c';
syl_pre = 'e';
syl_post = '';
NoteNum = 1; 

lt_check_hit_templ_freq_v2_EvTAFv4Sim_forRachel(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum)



