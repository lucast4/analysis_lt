%% 2/23/15 - Pitch Shift test
% target: b1 (thr based largely on ab)

batchf='batch.labeled.all';
syl='b';
syl_pre='';
syl_post='';
syl_refract=0.5;
freq_range=[2800 3800];
evtaf_ver='v4';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;


template_name='pu35wh17b1_v1_1';
cntrng_values{1}={[1 4 1.5] 'or' 'n' 'n'};
col_logic='(a)';

check_stuff=lt_check_hit_templ_freq_FUNCTION(batchf, syl, syl_pre, syl_post, syl_refract, freq_range, ...
    evtaf_ver,get_WN_hits,get_offline_match,get_FF,template_name,cntrng_values,col_logic);


%% 4/29/15 - CtxtDepPitch - targeting all b1

% Checking hit rate
batchf='batch.labeled.all';
syl='b';
syl_pre='';
% syl_post='bb';
syl_post='';
syl_refract=0.3;
freq_range=[2800 3800];
evtaf_ver='v4';
get_WN_hits=0;
get_offline_match=1;
get_FF=1;


% template_name='pu35wh17b1_v2_5';
template_name='pu35wh17b1_v2_8'; % 5/16 5pm - to get misses of b1
cntrng_values{1}={[2 4 1.8] 'or' 'n' 'n'};
cntrng_values{2}={[2 4 1.8] 'or' 'n' 'n'};
cntrng_values{3}={[2 4 1.8] 'or' 'n' 'n'};
cntrng_values{4}={[2 4 1.8] 'or' 'n' 'n'};
cntrng_values{5}={[2 4 1.5] 'or' 'n' 'n'};
cntrng_values{6}={[2 4 1.8] 'or' 'n' 'n'};
cntrng_values{7}={[2 4 1.8] 'or' 'n' 'n'};
cntrng_values{8}={[2 4 1.5] 'or' 'n' 'n'};
col_logic='(a+b+c+d+e+f+g+h)';

check_stuff=lt_check_hit_templ_freq_FUNCTION(batchf, syl, syl_pre, syl_post, syl_refract, freq_range, ...
    evtaf_ver,get_WN_hits,get_offline_match,get_FF,template_name,cntrng_values,col_logic);

%% 4/29/15 - LightDepPitch - targeting a[b]

% Checking hit rate
batchf='batch.labeled.all';
syl='b';
syl_pre='a';
% syl_post='bb';
syl_post='';
syl_refract=0.3;
freq_range=[2800 3800];
evtaf_ver='v4';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;


template_name='pu35wh17ab1_v1_11'; 
cntrng_values{1}={[2 4 1.8] 'or' 'n' 'n'};
cntrng_values{2}={[2 4 1.8] 'or' 'n' 'n'};
cntrng_values{3}={[2 4 1.8] 'or' 'n' 'n'};
cntrng_values{4}={[2 4 1.8] 'or' 'n' 'n'};
cntrng_values{5}={[2 4 1.5] 'or' 'n' 'n'};
cntrng_values{6}={[2 4 0] 'or' 'n' 'n'};
cntrng_values{7}={[2 4 0] 'or' 'n' 'n'};
cntrng_values{8}={[2 4 0] 'or' 'n' 'n'};
cntrng_values{9}={[2 10 1.4] 'or' 'n' 'y'};
cntrng_values{10}={[2 10 1.4] 'or' 'n' 'y'};
cntrng_values{11}={[2 10 1.4] 'or' 'n' 'y'};

col_logic='(a+b+c+d+e+f+g+h)*(i+j+k)';

check_stuff=lt_check_hit_templ_freq_FUNCTION(batchf, syl, syl_pre, syl_post, syl_refract, freq_range, ...
    evtaf_ver,get_WN_hits,get_offline_match,get_FF,template_name,cntrng_values,col_logic);



%% Context analysis
% Single day data extraction
% extracts data using evtafsim, also extracts notegroup information. puts
% all into one structure and saves into a common dir.
clear all; close all

% -- 1) what batch and config file to use to run evtafsim.  if needed, make a batch.
Params.batch='batch.keep';
% --- OLD TEMPLATES, SPECIFIC FOR DAYS
% Params.config= '/bluejay4/lucas/birds/pu35wh17/042915_CtxtDepPitch_day1/config.evconfig2';
% Params.config='/bluejay4/lucas/birds/pu35wh17/050315_CtxtDepPitch2_day3/config_050315_2.evconfig2'; % post 5/3?
% Params.config='/bluejay4/lucas/birds/pu35wh17/050715_LightDepPitch_durWN_day1/config.evconfig2'; % LightDepPitch (WN ON) 5/7 +
Params.config = '/bluejay4/lucas/birds/pu35wh17/051715_LightDepPitch_durWN_abDN_Probe/config.evconfig2'; % 5/16 (end) started - targetting just a[b]

% --------------------
% below: better template, used during SeqDepPitch, that targets just ab
% better
% last version
Params.config = '/bluejay4/lucas/birds/pu35wh17/061215_SeqDepPitch_durWN_day9/config_061115.evconfig2';
% --------------------

Params.dataID='All'; % e.g. id of data (e.g. 'All' for all data in data). if blank, uses batch name.

% -- Run evtafsim and save information
AllData=lt_context_ExtractDayData(Params);



%% ======= TO EXTRACT FOR EACH DAY ACROSS ALL DAYS (instead of each day individually, as above)
clear all; close all;
% metadata params
Params.metadata.experiment = 'LightDepPitch';
Params.metadata.condition='';
Params.metadata.notes='';
Params.metadata.date_range={'06May2015','06May2015'};
Params.metadata.only_labeled_dirs=0;

% analysis params
Params.analysis.batch='batch.keep';
% last version config (template used at very end of SeqDepPitch)
Params.analysis.config = '/bluejay4/lucas/birds/pu35wh17/061215_SeqDepPitch_durWN_day9/config_061115.evconfig2';
Params.analysis.dataID='All'; % e.g. id of data (e.g. 'All' for all data in data). if blank, uses batch name.
Params.analysis.Make_BatchKeep=0; % will make a new batch.keep for each day


Dirs_Missing_notegroups=lt_context_ExtractData_AcrossDays(Params);

%% -- TO PLOT, run in save folder ---------------------------------------

% ----- 1) OLD VERSION, USING ACTUAL TEMPLATE FOR EACH DAY
% ------
clear all; close all;
% Params
Params_alldays.CollectAllData=1; % if 1, then collects all data starting from first day
Params_alldays.firstday='';
Params_alldays.lastday='';

Params_alldays.NoteToPlot=0; % this is the note whose detects we will analyze (i.e. this note should get all renditions of the syl)
Params_alldays.RunBin=10;
Params_alldays.BoundaryTimes={'07May2015-0000', '14May2015-2200', '16May2015-1935', '20May2015-2400', '26May2015-0806'}; % in format of e.g. 05May2014-1423, these are times of switching in experiment (e.g. turning WN off and on, changing pitch contingency, etc)
Params_alldays.Edge_Num_Rends=20;

% Params describing note groups and phases
Params_alldays.Probe_CSplus=[1 2]; % [from to] (actual NG nums)
Params_alldays.Probe_CSminus=[1 3]; % [from to] (actual NG nums)

Params_alldays.PhaseToCompare1=4; % e.g. [light + WN up] phase
Params_alldays.PhaseToCompare2=5; %

Params_alldays.throw_out_if_epoch_diff_days=0; % throws out any transitions that overlap with O/N (potentially 2 per O/N)


lt_context_CompileAndPlot(Params_alldays);


% ------ 2)  FOR NEW VERSION, USING ONE CONFIG FILE FOR ALL DAYS
clear all; close all;
% Params
Params_alldays.CollectAllData=1; % if 1, then collects all data starting from first day
Params_alldays.firstday='';
Params_alldays.lastday='';

Params_alldays.NoteToPlot=0; % this is the note whose detects we will analyze (i.e. this note should get all renditions of the syl)
Params_alldays.RunBin=10;
Params_alldays.BoundaryTimes={'07May2015-0000', '14May2015-2200', '16May2015-1935', '20May2015-2400', '26May2015-0806'}; % in format of e.g. 05May2014-1423, these are times of switching in experiment (e.g. turning WN off and on, changing pitch contingency, etc)
Params_alldays.Edge_Num_Rends=20;

% Params describing note groups and phases
Params_alldays.Probe_CSplus=[1 2]; % [from to] (actual NG nums)
Params_alldays.Probe_CSminus=[1 3]; % [from to] (actual NG nums)

Params_alldays.PhaseToCompare1=4; % e.g. [light + WN up] phase
Params_alldays.PhaseToCompare2=5; 

Params_alldays.throw_out_if_epoch_diff_days=1; % throws out any transitions that overlap with O/N (potentially 2 per O/N)

lt_context_CompileAndPlot(Params_alldays);

