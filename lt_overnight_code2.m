%% 7/9/15 - pk32 autolabeling

clear all; close all
% batch = 'batch.rand.keep';
config= '/bluejay4/lucas/birds/pk32/070715_Reversion1_durWN_STIMoff_day2/config_070715.evconfig2';

syl.targ='c';
syl.pre='d';
syl.post=''; 
NoteNum=0; 

ampThresh=53000;
min_dur=20;
min_int=4;

overwrite_notmat=1;


% =============== ALL SONGS
% cd /bluejay4/lucas/birds/pk32/080815_Reversion1_noWN_STIMon_day5_CONSOLIDATION
% lt_make_batch(4);
% batch = 'batch.rec_FB';
% close all;
% lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat)

% 
% % ======== RANDOM 50%
% cd /bluejay4/lucas/birds/pk32/080315_Reversion1_postWN_STIMoff;
% lt_make_batch(2,0.5);
% batch = 'batch.rand.keep';
% close all;
% lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat)



%%  7/9/15 pk32 - opto analysis




%% 6/1 - wh73 autolabeling


clear all; close all;

DirList={'/bluejay3/lucas/birds/wh73pk61/032015_HVCChR2_XStimOFF_PitchShiftON_day12',...
    '/bluejay3/lucas/birds/wh73pk61/052015_ReversionWNup_StimOFFWnOFF'};

curdir=pwd;

for i=1:length(DirList);
    cd(curdir);
    cd(DirList{i});
% Collect all songs
% lt_make_batch(1)

% Autolabel
Params.batch='batch.rec_FB.rand';

Params.ampThresh=21000;
Params.min_dur=13;
Params.min_int=1;

Params.syl.pre='';
Params.syl.post='';
Params.syl.targ='b';

Params.overwrite_notmat=1;


% TEMPLATE SETTINGS
Params.TEMPLATE.templatefile = 'autolabel_templ_b1_v2.dat';
Params.TEMPLATE.cntrng(1).MIN=1;
Params.TEMPLATE.cntrng(1).MAX=3;
Params.TEMPLATE.cntrng(1).NOT=0;
Params.TEMPLATE.cntrng(1).MODE=1;
Params.TEMPLATE.cntrng(1).TH=1;
Params.TEMPLATE.cntrng(1).AND=0;
Params.TEMPLATE.cntrng(1).BTMIN=0;

Params.TEMPLATE.cntrng(2).MIN=1;
Params.TEMPLATE.cntrng(2).MAX=3;
Params.TEMPLATE.cntrng(2).NOT=0;
Params.TEMPLATE.cntrng(2).MODE=1;
Params.TEMPLATE.cntrng(2).TH=2.2;
Params.TEMPLATE.cntrng(2).AND=0;
Params.TEMPLATE.cntrng(2).BTMIN=0;

Params.TEMPLATE.cntrng(3).MIN=1;
Params.TEMPLATE.cntrng(3).MAX=3;
Params.TEMPLATE.cntrng(3).NOT=0;
Params.TEMPLATE.cntrng(3).MODE=1;
Params.TEMPLATE.cntrng(3).TH=2.2;
Params.TEMPLATE.cntrng(3).AND=1;
Params.TEMPLATE.cntrng(3).BTMIN=0;

Params.TEMPLATE.cntrng(4).MIN=0;
Params.TEMPLATE.cntrng(4).MAX=10;
Params.TEMPLATE.cntrng(4).NOT=0;
Params.TEMPLATE.cntrng(4).MODE=0;
Params.TEMPLATE.cntrng(4).TH=3;
Params.TEMPLATE.cntrng(4).AND=0;
Params.TEMPLATE.cntrng(4).BTMIN=0;

Params.TEMPLATE.refract=0.2;



% RUN
[fnames, sylnum, vlsorfn, vlsorind]=lt_autolabel_function(Params);

end


%% BEFORE or INCLUDING 4/27/15
%% Stuff to run opto analysis on
% 
% clear all; close all
% BaseDir='/bluejay3/lucas/birds/wh73pk61/';
% 
% ListOfDirs=...
%     {'012115_HVCChR2_StimAndLearn_durStim_WNoff_day2',...
%     '012215_HVCChR2_StimAndLearn_durStim_WNoff_day3',...
%     '012315_HVCChR2_StimAndLearn_durStim_WNoff_day4',...
%     '012415_HVCChR2_StimAndLearn_durStim_WNoff_day5',...
%     '012515_HVCChR2_StimAndLearn_durStim_WNoff_day6',...
%     '012615_HVCChR2_StimAndLearn_durStim_WNoff_day7'};
% 
% ListOfBatchNames={'batch.labeled.all',...
%     'batch.labeled.all',...
%     'batch.labeled.catch',...
%     'batch.labeled.catch',...
%     'batch.labeled.all',...
%     'batch.labeled.catch',...
%     'batch.labeled.all',...
%     'batch.labeled.all',...
%     'batch.labeled.all'};
% 
% ListOfTrialTypes=[0 1 0 0 0 0 1 1 1];



%% AUTOLABEL STUFF
if (0)
    clear all; close all;

DirList={
'/bluejay3/lucas/birds/wh73pk61/012115_HVCChR2_StimAndLearn_durStim_WNoff_day2',...
'/bluejay3/lucas/birds/wh73pk61/012215_HVCChR2_StimAndLearn_durStim_WNoff_day3',...
'/bluejay3/lucas/birds/wh73pk61/012315_HVCChR2_StimAndLearn_durStim_WNoff_day4',...
'/bluejay3/lucas/birds/wh73pk61/012415_HVCChR2_StimAndLearn_durStim_WNoff_day5',...
'/bluejay3/lucas/birds/wh73pk61/012515_HVCChR2_StimAndLearn_durStim_WNoff_day6',...
'/bluejay3/lucas/birds/wh73pk61/012615_HVCChR2_StimAndLearn_durStim_WNoff_day7'};

curdir=pwd;

for i=1:length(DirList);
    cd(curdir);
    cd(DirList{i});
% Collect all songs
% lt_make_batch(1)

% Autolabel
ampThresh=21000;
min_dur=13;
min_int=1;
batch='batch.rec_FB';

templatefile = 'autolabel_templ_b1_v2.dat';
syl.pre='';
syl.post='';
syl.targ='b';

overwrite_notmat=1;

% TEMPLATE SETTINGS
% TEMPLATE SETTINGS
cntrng(1).MIN=1;
cntrng(1).MAX=3;
cntrng(1).NOT=0;
cntrng(1).MODE=1;
cntrng(1).TH=1;
cntrng(1).AND=0;
cntrng(1).BTMIN=0;

cntrng(2).MIN=1;
cntrng(2).MAX=3;
cntrng(2).NOT=0;
cntrng(2).MODE=1;
cntrng(2).TH=2.2;
cntrng(2).AND=0;
cntrng(2).BTMIN=0;

cntrng(3).MIN=1;
cntrng(3).MAX=3;
cntrng(3).NOT=0;
cntrng(3).MODE=1;
cntrng(3).TH=2.2;
cntrng(3).AND=1;
cntrng(3).BTMIN=0;

cntrng(4).MIN=0;
cntrng(4).MAX=10;
cntrng(4).NOT=0;
cntrng(4).MODE=0;
cntrng(4).TH=3;
cntrng(4).AND=0;
cntrng(4).BTMIN=0;


refract=0.2;

% 1) RUN
lt_jc_autoLabel(batch,templatefile,cntrng,syl,refract,ampThresh,min_dur,min_int,overwrite_notmat)

end
end

%%
lt_make_batch(4);

lt_read_ltrec2('note_group_log.ltrec2');

% check note group 2 nothing missed? (since only WN at trigger) - there
% shouldn't be any songs here:
cleandirAuto('batch.NoteGroup_2.rec_noFB',1000,4,4);



% clean note group 3
cleandirAuto('batch.NoteGroup_3',1000,4,4);


%% Checking if discarded songs have any real songs

cleandirAuto('batch.dcrd',1000,4,4)

lt_disp_random_songs_syls('batch.dcrd.keep',0,1,50)