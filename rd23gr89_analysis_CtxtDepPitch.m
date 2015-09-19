%% 4/15/15 - testing out evtafv4_LT_v2 - i.e. using epoch (renditions) mode

% Testing hitting of c:

batchf='batch.labeled.all';
syl='c';
syl_pre='';
syl_post='';
syl_refract=0.2;
freq_range=[2400 3000];
evtaf_ver='v4';
get_WN_hits=0;
get_offline_match=1;
get_FF=1;


template_name='rd23gr89c_v1_2';
cntrng_values{1}={[4 6 2.4] 'or' 'n' 'n'};
cntrng_values{2}={[4 6 2.2] 'and' 'n' 'n'};
col_logic='(a+b)';

check_stuff=lt_check_hit_templ_freq_FUNCTION(batchf, syl, syl_pre, syl_post, syl_refract, freq_range, ...
    evtaf_ver,get_WN_hits,get_offline_match,get_FF,template_name,cntrng_values,col_logic);


%% TESTING HIT OF B2 (4/20/15)

batchf= 'batch.labeled.all';
get_WN_hits=1;
get_offline_match=1; % do offline matching using template? (ADDX=1)
get_FF=1; % Analyze FF using offline matching?
syl = 'b';
syl_pre = 'b';
syl_post = '';
% config= '/bluejay4/lucas/birds/rd23gr89/042115_CtxtDepPitch_testEvtaf_TargB2_day2/config.evconfig2';
% config= '/bluejay4/lucas/birds/rd23gr89/config_042115_fixedfreqbounds.evconfig2';
% config='/bluejay4/lucas/birds/rd23gr89/042815_CtxtDepPitch2_TargB2_day3/config.evconfig2'; % for CtxtDepPitch2 (4/28 +) (better hits)
config='/bluejay4/lucas/birds/rd23gr89/050715_LightDepPitch_durWN_day1/config.evconfig2'; % 5/7 and + up (LightDep)

% note 0 and 1 are c2, note 2 and 3 are b2
NoteNum = 2;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits, get_offline_match, get_FF, config, NoteNum);




%% EXTRACTING CONTEXT DEP LEARNING DATA - WITHOUT LABELING, BY USING EVSIM

% -- SINGLE DAY DATA EXTRACTION
% 1) what batch and config file to use to run evtafsim.  if needed, make a batch.
Params.batch='batch.temp';
% Params.config= '/bluejay4/lucas/birds/rd23gr89/config_042115_fixedfreqbounds.evconfig2'; % for CtxtDepPitch (before 4/26)
% Params.config= '/bluejay4/lucas/birds/rd23gr89/042715_CtxtDepPitch2_TargB2_day2/config.evconfig2'; % for CtxtDepPitch2 (4/26 +)
% Params.config= '/bluejay4/lucas/birds/rd23gr89/042815_CtxtDepPitch2_TargB2_day3/config.evconfig2'; % for CtxtDepPitch2 (4/28 +) (better hits)
Params.config='/bluejay4/lucas/birds/rd23gr89/050715_LightDepPitch_durWN_day1/config.evconfig2'; % for LightDepPitch

% latest (from SeqDepPitch - checked by eye looks very good)
% Params.config='/bluejay4/lucas/birds/rd23gr89/config_061115.evconfig2'; % SeqDepPitch (good with no FP)

Params.dataID='All'; % e.g. id of data (e.g. 'All' for all data in data). if blank, uses batch name.

% -- Run evtafsim and save information
AllData=lt_context_ExtractDayData(Params);


%% -- COLLECT DATA AND PLOT

% Params
Params_alldays.CollectAllData=1; % if 1, then collects all data starting from first day
Params_alldays.firstday='';
Params_alldays.lastday='';

Params_alldays.NoteToPlot=2; % this is the note whose detects we will analyze (i.e. this note should get all renditions of the syl)
Params_alldays.RunBin=15;
Params_alldays.BoundaryTimes={'07May2015-0000', '14May2015-2200', '20May2015-2400', '25May2015-1913'}; % in format of e.g. 05May2014-1423, these are times of switching in experiment (e.g. turning WN off and on, changing pitch contingency, etc)

Params_alldays.Edge_Num_Rends=20;

% Params describing note groups and phases
Params_alldays.Probe_CSplus=[1 2]; % [from to] (actual NG nums)
Params_alldays.Probe_CSminus=[1 3]; % [from to] (actual NG nums)

Params_alldays.PhaseToCompare1=3; % e.g. [light + WN up] phase
Params_alldays.PhaseToCompare2=4; %


lt_context_CompileAndPlot(Params_alldays);




%% ++++++++++++++++++++++++++=++++
%% CONTEXT REANALYSIS (9/2/15) - USING ONE GOOD TEMPLATE ACROSS ALL DAYS, 
% TEMPLATE MODIFIED SO HAS ONLY ONE NOTE, SO IS MUCH FASTER TO DO EVTAFSIM

clear all; close all;
% metadata params
Params.metadata.experiment = 'LightDepPitch';
Params.metadata.condition='';
Params.metadata.notes='';
% Params.metadata.date_range={'05May2015','24May2015'}; % all light expts
Params.metadata.date_range={'15May2015','24May2015'}; % Ones with CS- probe
Params.metadata.only_labeled_dirs=0;

% analysis params
Params.analysis.batch='batch.keep';
% last version config (template used at very end of SeqDepPitch)
Params.analysis.config = '/bluejay4/lucas/birds/rd23gr89/config_b2_OneNote_090315.evconfig2';
Params.analysis.dataID='All'; % e.g. id of data (e.g. 'All' for all data in data). if blank, uses batch name.
Params.analysis.Make_BatchKeep=0; % will make a new batch.keep for each day

Dirs_Missing_notegroups=lt_context_ExtractData_AcrossDays(Params);


% ============================= COLLECT DATA AND PLOT
% (only difference, using note 0, since modified template to have just one
% note)
clear all; close all;
% Params
Params_alldays.CollectAllData=1; % if 1, then collects all data starting from first day
Params_alldays.firstday='';
Params_alldays.lastday='';

Params_alldays.NoteToPlot=0; % this is the note whose detects we will analyze (i.e. this note should get all renditions of the syl)
Params_alldays.RunBin=15;
Params_alldays.BoundaryTimes={'20May2015-2400', '25May2015-1913'}; % in format of e.g. 05May2014-1423, these are times of switching in experiment (e.g. turning WN off and on, changing pitch contingency, etc)

Params_alldays.Edge_Num_Rends=20;

% Params describing note groups and phases
Params_alldays.Probe_CSplus=[1 2]; % [from to] (actual NG nums)
Params_alldays.Probe_CSminus=[1 3]; % [from to] (actual NG nums)

Params_alldays.PhaseToCompare1=1; % e.g. [light + WN up] phase
Params_alldays.PhaseToCompare2=2; %

Params_alldays.throw_out_if_epoch_diff_days=1; % throws out any transitions that overlap with O/N (potentially 2 per O/N)

lt_context_CompileAndPlot(Params_alldays);



