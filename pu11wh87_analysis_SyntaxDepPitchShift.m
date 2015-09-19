%% 4/12/15 - ANALYSIS ALL DAYS
% -- TO DO OVER ALL DAYS
clear all; close all
phrase = 'SyntaxDepPitchShift_abUP';
first_day= '02Jul2014';
last_day= '03Jul2014'; % 23jul
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.catch.keep';
Params.DayRawDat.syllables={'a','b','c','d'};
Params.DayRawDat.frequency_range={[1300 2200], [2800 3950],[2150 3150],[1200 3000]};
Params.DayRawDat.pc_dur=[0.135,0.115,0.125,0.1];

Params.DayRawDat.pc_time_window={[365 490],[60 220],[55 320],[30 145]};
Params.DayRawDat.pc_sigma=1;


plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);


% -- 2) Seq filter, remove outliers, and compile raw data, and enter experiment info into params
% 0) keep?
clear all; close all;
Params.SeqFilter.AmplThr=3000;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

Params.SeqFilter.SeqPreList={'a','ab','bcc','bccb','dcc','dccb','b','bc','d','dc'};
Params.SeqFilter.SylTargList={'b','b','b','b','b','b','c','c','c','c'};
Params.SeqFilter.SeqPostList={'','','','','','','','','','','',''};


% 2) experiment info
Params.SeqFilter.WNTimeON='08Jul2014-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '15Jul2014-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:6;

Params.SeqFilter.SylLists.FieldsToPlot{1}={'aB','abB','bccB','bccbB','dccB','dccbB'};
Params.SeqFilter.SylLists.FieldsToPlot{2}={'d','bC','bcC','dC','dcC'};
Params.SeqFilter.SylLists.FieldsInOrder{1}={'a','aB','abB','bC','bcC','bccB','bccbB'};
Params.SeqFilter.SylLists.FieldsInOrder{2}={'d','dC','dcC','dccB','dccbB'};
Params.SeqFilter.SylLists.TargetSyls={'aB'};
Params.SeqFilter.SylLists.SylsSame={'abB','bccB','bccbB','dccB','dccbB'};
Params.SeqFilter.SylLists.SylsDifferent={'a','d','bC','bcC','dC','dcC'};

% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);


%% -- 3) Perform various analyses on that data structure
close all
Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;


[Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);
close all;


% -- 3) Extract structure statistics

% to extract data
[Params, AllDays_StructStatsStruct]=lt_seq_dep_pitch_StructureStats(Params, AllDays_RawDatStruct);

% to look at syllable similarity - being replaced by "Correlations" below
% [Params, AllDays_StructStatsStruct]=lt_seq_dep_pitch_StructureStats_SylSimilarity(Params, AllDays_StructStatsStruct);

% to plot and perform PCA on syl structure
Params.PCA.epoch='baseline'; % will look at baseline
% Params.PCA.epoch=[21 24]; % days 21 to 24

[Params, PCA_Struct]=lt_seq_dep_pitch_StructureStats_featurePCA(Params, AllDays_StructStatsStruct,1);



% --- 4) Look at correlations between syllables
% work in progress
DaysWanted=30:32; % either baseline (astring) or array
lt_seq_dep_pitch_Correlations(Params, AllDays_StructStatsStruct,DaysWanted);


%% BELOW - OLD ANALYSIS METHODS, DON'T USE FROM NOW ON (4/12/15)


%% 9/7 - LABELED pretty well, up to 8/20 - here only looking at pitch, but can easily modify for hit rate too

% GENERAL INPUTS
clear all; close all;
phrase = 'SyntaxDepPitchShift';
first_day= '04Jul2014';
last_day= '20Aug2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
% FcnAll={'check_HTF','calcdaypitch'};
FcnAll={'calcdaypitch'};


% INPUTS specifically for motif switches:
% i.e. each entry is for a separate motif (if want to get both ab(b) and
% ab(c), then syl_targ_list would be {'b','c'}). function will run
% separately for each motif.

% motif_pre_list={'dcc','dccb','ab','bcc','bccb','a',''};
% syl_targ_list={'b','b','b','b','b','b','b'};
% motif_post_list={'','','','','','',''};
% syl_replace_list={'M','N','Z','P','Q','A','b'}; % important, labels will temporarily be changed to this. has to be unused (e.g. all caps).

motif_pre_list={'c','a','ab','cb'};
syl_targ_list={'b','b','b','b'};
motif_post_list={'','','',''};
syl_replace_list={'C','A','Z','H'}; % important, labels will temporarily be changed to this. has to be unused (e.g. all caps).


% INPUTS FOR analysis (lt_all_days_various)
% enter as normally would, for each syl target (each cell entry is for separate motif switch)

% lt_calc_pitch...:
freq_rangeDP_list={{[2700 3750]},{[3050 4200]},{[3050 3750]},{[3050 3750]}};
pc_time_windowDP_list={{[55 150]},{[55 150]},{[55 150]},{[55 150]}};
plot_resultDP=1;
pc_windowDP=2000;

% lt_check_HTF...:
freq_rangeHTF={{[3050 3750]},{[3050 3750]},{[3050 3750]},{[3050 3750]},{[3050 3750]},{[3050 4200]},{[2800 4200]}};
evtaf_verHTF='v4';
get_WN_hitsHTF=0;
get_offline_matchHTF=0;
get_FFHTF=0;
if get_offline_matchHTF==1; % template params if also doing offline check
    template_name='pu11wh87ab_SyntaxDepPitchShift_v1_6';
    cntrng_values{1}={[5 14 1] 'or' 'n' 'y'};
    cntrng_values{2}={[5 14 0.1] 'or' 'n' 'y'};
    cntrng_values{3}={[5 14 1.1] 'and' 'n' 'y'};
    cntrng_values{4}={[1 4 1.5] 'or' 'n' 'n'};
    cntrng_values{5}={[1 4 1.5] 'or' 'n' 'n'};
    cntrng_values{6}={[1 4 1.5] 'or' 'n' 'n'};
    col_logic='(a+b+c)*(d+e+f)';
end



% INPUT: WITHIN FUNCTION VARIABLES SETTING (DIFFERENT FOR ALL MOTIFS)
% DO not change the values within each function, but add and subtract V's if you need.

num_motifs=size(syl_targ_list,2);
for i=1:num_motifs;
    % lt_check_HTF...:
%     if get_offline_matchHTF==1;
%         V1_mot{i}={'sylHTF',{syl_replace_list{i}},'syl_preHTF',{''},'syl_postHTF',{''},'freq_rangeHTF',freq_rangeHTF{i},'evtaf_verHTF',evtaf_verHTF,'get_WN_hitsHTF',get_WN_hitsHTF,'get_offline_matchHTF',...
%             get_offline_matchHTF,'get_FFHTF',get_FFHTF,'template_name',template_name,'cntrng_values',cntrng_values,'col_logic',col_logic};
%     else
%         V1_mot{i}={'sylHTF',{syl_replace_list{i}},'syl_preHTF',{''},'syl_postHTF',{''},'freq_rangeHTF',freq_rangeHTF{i},'evtaf_verHTF',evtaf_verHTF,'get_WN_hitsHTF',get_WN_hitsHTF,'get_offline_matchHTF',...
%             get_offline_matchHTF,'get_FFHTF',get_FFHTF};
%     end
    
    % lt_calc_pitch...:
    V2_mot{i}={'syl_targetDP',syl_replace_list{i}, 'syl_preDP',{''},'phraseDP',phrase,'freq_rangeDP',freq_rangeDP_list{i},'pc_time_windowDP',pc_time_windowDP_list{i},'plot_resultDP',plot_resultDP,'pc_windowDP',pc_windowDP};
    
    % combine
%     Vall_mot{i}=[V1_mot{i},V2_mot{i}];
     Vall_mot{i}=[V2_mot{i}];

end


lt_all_days_various_calculations_COMBINE_Motif_and_Normal




% ----------------------------------------------------
% PLOT STUFF - specifically using all_days_various_COMPILED
% INPUTS - run folling in calling script.
% Save?
save_plots=0;
% What to get? (1 = get , 0 = skip)
get_thr=0;
plot_baseline=1;
baseline_days=1:4;
plot_WN=1;
    WN_dates={'08Jul2014-1302','16Jul2014-0000','24Jul2014-1040','04Aug2014-1154'};
plot_lesions=0;
%     lesion_dates={''};
%     lesionEvents=lt_convert_EventTimes_to_RelTimes(first_day_str,lesion_dates);
%     lesion_days=lesionEvents.FinalValue;
plot_pitch_thresholds=0;    
%     threshold_switch_RealTimes={'20Mar2014-0029','20Mar2014-1739','21Mar2014-1234','24Mar2014-1651','25Mar2014-1808',...
%         '26Mar2014-1347','27Mar2014-0207','27Mar2014-1127','28Mar2014-0103','28Mar2014-1320','30Mar2014-1951'}; % real times for threshold values switches in format e.g. 20Mar2014-1645
%     thresh_values=[2583 2615 2639 2706 2685 2675 2665 2680 2720 2710 2720]; % values of threshold corresponding to switch times
%     hit_conting='below'; % hit renditions "below" or "above" threshold?

% running average
run_wind=[10 20 50];

analysis_SyntaxDepPitchShift_PLOTS_pu11wh87;


%% 7/28 - LATEST - here only looking at pitch, but can easily modify for hit rate too

% GENERAL INPUTS
clear all; close all;
phrase = 'SyntaxDepPitchShift';
first_day= '05Jul2014';
last_day= '02Aug2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
% FcnAll={'check_HTF','calcdaypitch'};
FcnAll={'calcdaypitch'};


% INPUTS specifically for motif switches:
% i.e. each entry is for a separate motif (if want to get both ab(b) and
% ab(c), then syl_targ_list would be {'b','c'}). function will run
% separately for each motif.

motif_pre_list={'dcc','dccb','ab','bcc','bccb','a',''};
syl_targ_list={'b','b','b','b','b','b','b'};
motif_post_list={'','','','','','',''};
syl_replace_list={'M','N','Z','P','Q','A','b'}; % important, labels will temporarily be changed to this. has to be unused (e.g. all caps).



% INPUTS FOR analysis (lt_all_days_various)
% enter as normally would, for each syl target (each cell entry is for separate motif switch)

% lt_calc_pitch...:
freq_rangeDP_list={{[2700 3750]},{[3000 3750]},{[3050 3750]},{[2700 3750]},{[3050 3750]},{[3050 4200]},{[2700 4200]}}; % i.e. first cell is for first replaced syl
pc_time_windowDP_list={{[60 150]},{[60 150]},{[60 150]},{[55 150]},{[60 150]},{[50 150]},{[60 150]}};
plot_resultDP=0;
pc_windowDP=2000;

% lt_check_HTF...:
freq_rangeHTF={{[3050 3750]},{[3050 3750]},{[3050 3750]},{[3050 3750]},{[3050 3750]},{[3050 4200]},{[2800 4200]}};
evtaf_verHTF='v4';
get_WN_hitsHTF=0;
get_offline_matchHTF=0;
get_FFHTF=0;
if get_offline_matchHTF==1; % template params if also doing offline check
    template_name='pu11wh87ab_SyntaxDepPitchShift_v1_6';
    cntrng_values{1}={[5 14 1] 'or' 'n' 'y'};
    cntrng_values{2}={[5 14 0.1] 'or' 'n' 'y'};
    cntrng_values{3}={[5 14 1.1] 'and' 'n' 'y'};
    cntrng_values{4}={[1 4 1.5] 'or' 'n' 'n'};
    cntrng_values{5}={[1 4 1.5] 'or' 'n' 'n'};
    cntrng_values{6}={[1 4 1.5] 'or' 'n' 'n'};
    col_logic='(a+b+c)*(d+e+f)';
end



% INPUT: WITHIN FUNCTION VARIABLES SETTING (DIFFERENT FOR ALL MOTIFS)
% DO not change the values within each function, but add and subtract V's if you need.

num_motifs=size(syl_targ_list,2);
for i=1:num_motifs;
    % lt_check_HTF...:
%     if get_offline_matchHTF==1;
%         V1_mot{i}={'sylHTF',{syl_replace_list{i}},'syl_preHTF',{''},'syl_postHTF',{''},'freq_rangeHTF',freq_rangeHTF{i},'evtaf_verHTF',evtaf_verHTF,'get_WN_hitsHTF',get_WN_hitsHTF,'get_offline_matchHTF',...
%             get_offline_matchHTF,'get_FFHTF',get_FFHTF,'template_name',template_name,'cntrng_values',cntrng_values,'col_logic',col_logic};
%     else
%         V1_mot{i}={'sylHTF',{syl_replace_list{i}},'syl_preHTF',{''},'syl_postHTF',{''},'freq_rangeHTF',freq_rangeHTF{i},'evtaf_verHTF',evtaf_verHTF,'get_WN_hitsHTF',get_WN_hitsHTF,'get_offline_matchHTF',...
%             get_offline_matchHTF,'get_FFHTF',get_FFHTF};
%     end
    
    % lt_calc_pitch...:
    V2_mot{i}={'syl_targetDP',syl_replace_list{i}, 'syl_preDP',{''},'phraseDP',phrase,'freq_rangeDP',freq_rangeDP_list{i},'pc_time_windowDP',pc_time_windowDP_list{i},'plot_resultDP',plot_resultDP,'pc_windowDP',pc_windowDP};
    
    % combine
%     Vall_mot{i}=[V1_mot{i},V2_mot{i}];
     Vall_mot{i}=[V2_mot{i}];

end


lt_all_days_various_calculations_COMBINE_Motif_and_Normal




% ----------------------------------------------------
% PLOT STUFF - specifically using all_days_various_COMPILED
% INPUTS - run folling in calling script.
% Save?
save_plots=0;
% What to get? (1 = get , 0 = skip)
get_thr=0;
plot_baseline=1;
baseline_days=1:3;
plot_WN=1;
    WN_dates={'08Jul2014-1302','16Jul2014-0000','24Jul2014-1040','27Jul2014-0000'};
plot_lesions=0;
%     lesion_dates={''};
%     lesionEvents=lt_convert_EventTimes_to_RelTimes(first_day_str,lesion_dates);
%     lesion_days=lesionEvents.FinalValue;
plot_pitch_thresholds=0;    
%     threshold_switch_RealTimes={'20Mar2014-0029','20Mar2014-1739','21Mar2014-1234','24Mar2014-1651','25Mar2014-1808',...
%         '26Mar2014-1347','27Mar2014-0207','27Mar2014-1127','28Mar2014-0103','28Mar2014-1320','30Mar2014-1951'}; % real times for threshold values switches in format e.g. 20Mar2014-1645
%     thresh_values=[2583 2615 2639 2706 2685 2675 2665 2680 2720 2710 2720]; % values of threshold corresponding to switch times
%     hit_conting='below'; % hit renditions "below" or "above" threshold?

% running average
run_wind=[10 20 50];

analysis_SyntaxDepPitchShift_PLOTS;


%% 7/24 - combining hit rate check (lt_check_...) and lt_calc_pitch - single day analysis
% GENERAL INPUTS
clear all; close all;
phrase = 'SyntaxDepPitchShift';
first_day= '27Jul2014';
last_day= '27Jul2014';
save_results=0;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'check_HTF','calcdaypitch'};



% INPUTS specifically for motif switches:
% i.e. each entry is for a separate motif (if want to get both ab(b) and
% ab(c), then syl_targ_list would be {'b','c'}). function will run
% separately for each motif.

motif_pre_list={'dcc','dccb','ab','bcc','bccb'};
syl_targ_list={'b','b','b','b','b'};
motif_post_list={'','','','',''};
syl_replace_list={'M','N','Z','P','Q'}; % important, labels will temporarily be changed to this. has to be unused (e.g. all caps).



% INPUTS FOR analysis (lt_all_days_various)
% enter as normally would, for each syl target (each cell entry is for separate motif switch)

% lt_calc_pitch...:
freq_rangeDP_list={{[3050 3750]},{[3050 3750]},{[3050 3750]},{[3050 3750]},{[3050 3750]}}; % i.e. first cell is for first replaced syl
pc_time_windowDP_list={{[60 150]},{[60 150]},{[60 150]},{[55 150]},{[60 150]}};
plot_resultDP=0;
pc_windowDP=2000;

% lt_check_HTF...:
freq_rangeHTF={{[3050 3750]},{[3050 3750]},{[3050 3750]},{[3050 3750]},{[3050 3750]}};
evtaf_verHTF='v4';
get_WN_hitsHTF=1;
get_offline_matchHTF=1;
get_FFHTF=1;
if get_offline_matchHTF==1; % template params if also doing offline check
    template_name='pu11wh87ab_SyntaxDepPitchShift_v1_6';
    cntrng_values{1}={[5 14 1] 'or' 'n' 'y'};
    cntrng_values{2}={[5 14 0.1] 'or' 'n' 'y'};
    cntrng_values{3}={[5 14 1.1] 'and' 'n' 'y'};
    cntrng_values{4}={[1 4 1.5] 'or' 'n' 'n'};
    cntrng_values{5}={[1 4 1.5] 'or' 'n' 'n'};
    cntrng_values{6}={[1 4 1.5] 'or' 'n' 'n'};
    col_logic='(a+b+c)*(d+e+f)';
end



% INPUT: WITHIN FUNCTION VARIABLES SETTING (DIFFERENT FOR ALL MOTIFS)
% DO not change the values within each function, but add and subtract V's if you need.

num_motifs=size(syl_targ_list,2);
for i=1:num_motifs;
    % lt_check_HTF...:
    if get_offline_matchHTF==1;
        V1_mot{i}={'sylHTF',{syl_replace_list{i}},'syl_preHTF',{''},'syl_postHTF',{''},'freq_rangeHTF',freq_rangeHTF{i},'evtaf_verHTF',evtaf_verHTF,'get_WN_hitsHTF',get_WN_hitsHTF,'get_offline_matchHTF',...
            get_offline_matchHTF,'get_FFHTF',get_FFHTF,'template_name',template_name,'cntrng_values',cntrng_values,'col_logic',col_logic};
    else
        V1_mot{i}={'sylHTF',{syl_replace_list{i}},'syl_preHTF',{''},'syl_postHTF',{''},'freq_rangeHTF',freq_rangeHTF{i},'evtaf_verHTF',evtaf_verHTF,'get_WN_hitsHTF',get_WN_hitsHTF,'get_offline_matchHTF',...
            get_offline_matchHTF,'get_FFHTF',get_FFHTF};
    end
    
    % lt_calc_pitch...:
    V2_mot{i}={'syl_targetDP',syl_replace_list{i}, 'syl_preDP',{''},'phraseDP',phrase,'freq_rangeDP',freq_rangeDP_list{i},'pc_time_windowDP',pc_time_windowDP_list{i},'plot_resultDP',plot_resultDP,'pc_windowDP',pc_windowDP};
    
    % combine
    Vall_mot{i}=[V1_mot{i},V2_mot{i}];
end




% INPUTS FOR REGULAR (NON_MOTIF) SYLLABLES:

% lt_check_pitch:
syl_preHTF={'a'};
sylHTF={'b'};
syl_postHTF={''};
freq_rangeHTF={[3050 4200]};

% lt_calc_pitch
syl_preDP={'a'};
syl_targetDP='b';
freq_rangeDP={[3050 4200]};
pc_time_windowDP={[50 150]};


% Within function VARIABLES SETTING:
% lt_check...:
if get_offline_matchHTF==1;
    V1={'sylHTF',sylHTF,'syl_preHTF',syl_preHTF,'syl_postHTF',syl_postHTF,'freq_rangeHTF',freq_rangeHTF,'evtaf_verHTF',evtaf_verHTF,'get_WN_hitsHTF',get_WN_hitsHTF,'get_offline_matchHTF',get_offline_matchHTF,'get_FFHTF',get_FFHTF,'template_name',template_name,...
        'cntrng_values',cntrng_values,'col_logic',col_logic};
else
    V1={'sylHTF',sylHTF,'syl_preHTF',syl_preHTF,'syl_postHTF',syl_postHTF,'freq_rangeHTF',freq_rangeHTF,'evtaf_verHTF',evtaf_verHTF,'get_WN_hitsHTF',get_WN_hitsHTF,'get_offline_matchHTF',get_offline_matchHTF,'get_FFHTF',get_FFHTF};
end
% lt_calc...:
V2={'syl_targetDP',syl_targetDP, 'syl_preDP',syl_preDP,'phraseDP',phrase,'freq_rangeDP',freq_rangeDP,'pc_time_windowDP',pc_time_windowDP,'plot_resultDP',plot_resultDP,'pc_windowDP',pc_windowDP};
Vall=[V1,V2];


lt_all_days_various_calculations_COMBINE_Motif_and_Normal




% ----------------------------------------------------
% PLOT STUFF - specifically using all_days_various_COMPILED
bird_dir=['/bluejay3/lucas/birds/' all_days_various_COMPILED.parameters_COMPILATION.birdname];

% INPUTS
% Save?
save_plots=1;
% things to do:
% if have WN and/or lesion events (change to 1 to turn on)
get_thr=0;
plot_baseline=0;
baseline_days=1:3;
plot_WN=0;
plot_lesions=0;
plot_pitch_thresholds=0;
% running average
run_wind=[10 20 50];


if (0)
    WN_dates={'01Mar2014-1541','15Mar2014-1458','20Mar2014-0029','31Mar2014-0400'};
    WNevents=lt_convert_EventTimes_to_RelTimes(first_day_str,WN_dates);
    WN_switch_days=WNevents.FinalValue;
    lesion_dates={''};
    lesionEvents=lt_convert_EventTimes_to_RelTimes(first_day_str,lesion_dates);
    lesion_days=lesionEvents.FinalValue;
    threshold_switch_RealTimes={'20Mar2014-0029','20Mar2014-1739','21Mar2014-1234','24Mar2014-1651','25Mar2014-1808',...
        '26Mar2014-1347','27Mar2014-0207','27Mar2014-1127','28Mar2014-0103','28Mar2014-1320','30Mar2014-1951'}; % real times for threshold values switches in format e.g. 20Mar2014-1645
    thresh_values=[2583 2615 2639 2706 2685 2675 2665 2680 2720 2710 2720]; % values of threshold corresponding to switch times
    hit_conting='below'; % hit renditions "below" or "above" threshold?
end

% ------------------------
% RUNS 

% Auto: extracts other parameters
motif_table=all_days_various_COMPILED.parameters_COMPILATION.motif_table;
syllables=all_days_various_COMPILED.parameters_COMPILATION.syllables_COMPILED(:,2);
syllables_COMPILED=all_days_various_COMPILED.parameters_COMPILATION.syllables_COMPILED;
first_day_str=all_days_various_COMPILED.parameters_COMPILATION.first_day;
first_day_datenum=datenum(first_day_str,'ddmmmyyyy');
num_days=size(all_days_various_COMPILED.all_days_various(1).lt_calc_day_pitch,2);
last_day_str=all_days_various_COMPILED.parameters_COMPILATION.last_day;
NumToAddToAllDays= -first_day_datenum;% this is to make day 1 = day 0 (instead of in the thousands).
num_syl=size(syllables,1);
plot_colors=lt_make_plot_colors(num_syl,0);

for i=1:size(motif_table,1);
    syl_title{i}=[motif_table{i,1} '(' motif_table{i,2} ')']; % to use for labeling titles
end

% RUN
% PLOTTING Pitch - all days combined
for j=1:size(syllables_COMPILED,1);
    all_days_various=all_days_various_COMPILED.all_days_various(syllables_COMPILED{j,1}); % extract relevant structure from compiled structures
    hfig(j)=figure; hold on;
    
    % First, individual renditions
    for i=1:num_days; % number of days
        try % in case day has no data
            [~, WithinDayValues]=lt_convert_datenum_to_hour(all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,1)); %convert datenum to hours
            times_days=WithinDayValues.days;
            freq_values=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,2);
            hscatter=scatter(times_days+(i),freq_values,'b','.');
            %             % put in running average
            %             for j=1:length(run_wind);
            %                 X=smooth(freq_values,run_wind(j));
            %                 plot(times_days+(i),X,'-r');
            %             end
            
        catch err
            continue
        end
    end
    
    % Second, day means and std
    for i=1:num_days; % number of days
        try
            day_mean=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).mean_FF;
            day_std=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).sd_FF;
            errorbar(i+0.5,day_mean,day_std,'Marker','.','MarkerSize',27,'Color','k');
            text(i+0.4,day_mean+150,datestr(first_day_datenum+i-1,'ddmmmyyyy'));
        catch err
            continue
        end
    end
    
    % Third, format plot
    ylimits=ylim;
    ylim([ylimits(1)-150 ylimits(2)+150])
    title(['Pitch for syllable: ' syl_title{j} ' (individual renditions with means + SD)']); ylabel('Pitch (hz)');
    xlabel('Day (e.g. 1.5 = day1, 12pm)');
    ax1=gca;
    ax1_pos=get(ax1,'Position');
    
    % Fourth, Annotating important events (baseline, WN, lesion, Hz
    % threshold) - (had another version greened out also in the bk24
    % analysis file - obsolete).
    
    % Baseline
    if plot_baseline==1;
        baseline_values_temp=[];
        for i=baseline_days;
            baseline_values_temp=[baseline_values_temp all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,2)'];
        end
        baseline_mean=mean(baseline_values_temp);
        baseline_std=std(baseline_values_temp);
        line(xlim, [baseline_mean baseline_mean],'Color','r','LineWidth',0.4); % mean lines
        line(xlim, [baseline_mean+baseline_std baseline_mean+baseline_std],'LineStyle','--','Color',[0.7 0.1 0.1],'LineWidth',0.3); % variance lines
        line(xlim, [baseline_mean-baseline_std baseline_mean-baseline_std],'LineStyle','--','Color', [0.7 0.1 0.1],'LineWidth',0.3);
        line([baseline_days(end)+1 baseline_days(end)+1],ylim,'Color','k','LineWidth',1.8);% line after last baseline day
    end
    
    % WN epochs
    if plot_WN==1;
        disp('adding lines for WN epochs');
        % adding grey boxes for WN days
        ylimits=ylim;
        for i=1:size(WN_switch_days,1)
            if mod(i,2)==1; %i.e. i odd means this is start of WN
                rectangle('Position',[WN_switch_days(i), ylimits(1)+20, WN_switch_days(i+1)-WN_switch_days(i),ylimits(2)-ylimits(1)-40],...
                    'EdgeColor','r')
            end
        end
    end
    
    % Lesion events
    if plot_lesions==1;
        % adding lines for lesions
        for i=1:length(lesion_days);
            line([lesion_days(i) lesion_days(i)], ylim,'Color','g','LineWidth',0.4); % mean lines
        end
    end
    
    % Pitch training thresholds
    if plot_pitch_thresholds==1;
        % adding lines for pitch training WN thresholds
        [EventTimes_thr]= lt_convert_EventTimes_to_RelTimes(first_day_str,threshold_switch_RealTimes); % convert to numerical format
        thresh_start_times=EventTimes_thr.FinalValue;
        
        for i=1:length(thresh_start_times);
            if i==length(thresh_start_times);
                dummy=xlim;
                line([thresh_start_times(i) dummy(2)], [thresh_values(i) thresh_values(i)],'Color','g')
                line([thresh_start_times(i) thresh_start_times(i)], [thresh_values(i-1) thresh_values(i)],'Color','g')
            elseif i==1;
                line([thresh_start_times(i) thresh_start_times(i+1)], [thresh_values(i) thresh_values(i)],'Color','g')
            else
                line([thresh_start_times(i) thresh_start_times(i+1)], [thresh_values(i) thresh_values(i)],'Color','g')
                line([thresh_start_times(i) thresh_start_times(i)], [thresh_values(i-1) thresh_values(i)],'Color','g')
            end
        end
        ax2 = axes('Position',[ax1_pos(1) ax1_pos(2)-0.05 ax1_pos(3) ax1_pos(4)/100],'YGrid','off','Color','none');
    end
    
    
    
    % PLOTTING pitch contours for all days;
    hfig_pc(i)=figure; hold on;
    for ii=1:num_days;
        rows=ceil(num_days/4);
        h_sp(ii)=subplot(rows,4,ii); hold on;
        try % some days no data
            plot(all_days_various.lt_calc_day_pitch{ii}.pc_all.(syllables{j}),'LineStyle','--','Color',[0.6 0.6 0.6]); % plot all pitch contours in light shade
            plot(mean(all_days_various.lt_calc_day_pitch{ii}.pc_all.(syllables{j})'),'Linewidth',2);
            xlabel('Time (10^-4 sec)')
            ylabel('Frequency (Hz)')
            title(['syllable: ' syl_title{j} ', on ' datestr(first_day_datenum+ii-1,'ddmmmyyyy')]);
        catch err
        end
        try % plotting lines used to take frequency values
            R=all_days_various.lt_calc_day_pitch{1}.parameters.time_range.(syllables{j});
            ylimits=ylim;
            line([R(1) R(1)],[ylimits(1) ylimits(2)],'Color',[0.7 0.2 0.2]);
            line([R(2) R(2)],[ylimits(1) ylimits(2)],'Color',[0.7 0.2 0.2]);
        catch err
        end
        
    end
    linkaxes(h_sp,'xy');
    % plot mean of all days over each other
    hfig_pcAD(i)=figure; hold on;
    plot_colors_days=lt_make_plot_colors(num_days, 1, [1 1 1]);
    for ii=1:num_days;
        try
            X=mean(all_days_various.lt_calc_day_pitch{ii}.pc_all.(syllables{j})');
            plot(X,'-','Color',plot_colors_days{ii},'Linewidth',1.7);
            xvals=xlim;
            text(xvals(2),X(end),datestr(first_day_datenum+ii-1,'ddmmmyyyy'));
            xlabel('Time (10^-4 sec)')
            ylabel('Frequency (Hz)')
            title(['syllable: ' syl_title{j} ]);
        catch err
        end
        try % plotting lines used to take frequency values
            R=all_days_various.lt_calc_day_pitch{1}.parameters.time_range.(syllables{j});
            ylimits=ylim;
            line([R(1) R(1)],[ylimits(1) ylimits(2)],'Color',[0.7 0.2 0.2]);
            line([R(2) R(2)],[ylimits(1) ylimits(2)],'Color',[0.7 0.2 0.2]);
        catch err
        end
    end
    
    
    % DETERMINE NEW THRESHOLD (plot percentiles);
    % Input
    if (get_thr==1);
        day=datenum(last_day_str)-datenum(first_day_str)+1;
        total_rends=size(all_days_various.lt_calc_day_pitch{day}.FF.(syllables{j}).time_and_FF,1);
        for i=1:total_rends; % will give percentiles for all possible size rendition windows going back in time
            rends_to_take=total_rends-i+1:total_rends;
            percentiles_AllWindSizes.(syllables{j})(i,:)=prctile(all_days_various.lt_calc_day_pitch{day}.FF.(syllables{j}).time_and_FF(rends_to_take,2),[5 30 70 95]);
        end
        
        figure; hold on;
        plot(flipud(percentiles_AllWindSizes.(syllables{j})(:,2)),'og');
        plot(flipud(percentiles_AllWindSizes.(syllables{j})(:,3)),'ob');
        xlabel('how far back the beginning of the sample window goes (e.g. most right is closest to the most recent data)');
        ylabel('Pitch (hz)');
        title(['30th and 70th percentiles of pitch: Each point is a recalculation, using different windows; for ' syl_title{j}]);
    end
    
end

% FIGURES with all syllables in one plot:
% PITCH over all days;
hfig_allpitch=figure; hold on;
for j=1:num_syl;
    all_days_various=all_days_various_COMPILED.all_days_various(syllables_COMPILED{j,1}); % extract relevant structure from compiled structures
    for i=1:num_days; % number of days
        try
            day_mean=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).mean_FF;
            day_std=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).sd_FF;
            errorbar(i+0.5,day_mean,day_std,'Marker','.','MarkerSize',27,'Color',plot_colors{j});
            %             text(i+0.4,day_mean+150,datestr(first_day_datenum+i-1,'ddmmmyyyy'));
        catch err
            continue
        end
    end
    text(i+1.4,day_mean,syllables{j},'Color',plot_colors{j});
end


% PLOT HIT RATE
hfig_WNhit=figure; hold on;
title('WN hit rate over days (possibly catch songs)')
c=1;
for i=1:size(all_days_various_COMPILED.all_days_various,2); % how many data structures
    all_days_various=all_days_various_COMPILED.all_days_various(i);
    syls_and_params=fieldnames(all_days_various.lt_check_hit_templ_freq);
    num_syls=size(syls_and_params,1)-1;
    for ii=1:num_syls;
        if ~strcmp(syls_and_params(ii),'parameters');
            for j=1:num_days;
            plot(j,all_days_various.lt_check_hit_templ_freq.(syls_and_params{ii}){j}.(syls_and_params{ii}(end)).hit.sum(1)/...
                all_days_various.lt_check_hit_templ_freq.(syls_and_params{ii}){j}.(syls_and_params{ii}(end)).hit.sum(2),...
                'o','Color',plot_colors{c});
            end
            text(j+1, all_days_various.lt_check_hit_templ_freq.(syls_and_params{ii}){j}.(syls_and_params{ii}(end)).hit.sum(1)/...
                all_days_various.lt_check_hit_templ_freq.(syls_and_params{ii}){j}.(syls_and_params{ii}(end)).hit.sum(2),...
                syls_and_params(ii), 'Color', plot_colors{c});
        end
        c=c+1;
    end
end


        
        
    


% SAVING
if save_plots==1;
    timestampS=lt_get_timestamp(0);
    currdir=pwd;
    higherdir=[bird_dir '/SyntaxDepPitchShift_analysis'];
    try cd(higherdir);
    catch err
        mkdir(higherdir);
        cd(higherdir);
    end
    savedirname=['MOTIF_COMPILED_' all_days_various_COMPILED.parameters_COMPILATION.time_of_analysis '_PLOTS_' timestampS];
    try
        cd(savedirname);
    catch err
        mkdir(savedirname);
        cd(savedirname);
    end
    savemultfigs;
end

%% 7/24 - combining hit rate check (lt_check_...) and lt_calc_pitch - use this for all days analysis.
% GENERAL INPUTS
clear all; close all;
phrase = 'SyntaxDepPitchShift';
first_day= '15Jul2014';
last_day= '15Jul2014';
save_results=0;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'check_HTF','calcdaypitch'};



% INPUTS specifically for motif switches:
% i.e. each entry is for a separate motif (if want to get both ab(b) and
% ab(c), then syl_targ_list would be {'b','c'}). function will run
% separately for each motif.

motif_pre_list={'dcc','dccb','ab','bcc','bccb'};
syl_targ_list={'b','b','b','b','b'};
motif_post_list={'','','','',''};
syl_replace_list={'M','N','Z','P','Q'}; % important, labels will temporarily be changed to this. has to be unused (e.g. all caps).



% INPUTS FOR analysis (lt_all_days_various)
% enter as normally would, for each syl target (each cell entry is for separate motif switch)

% lt_calc_pitch...:
freq_rangeDP_list={{[3050 3750]},{[3050 3750]},{[3050 3750]},{[3050 3750]},{[3050 3750]}}; % i.e. first cell is for first replaced syl
pc_time_windowDP_list={{[60 150]},{[60 150]},{[60 150]},{[55 150]},{[60 150]}};
plot_resultDP=0;
pc_windowDP=2000;

% lt_check_HTF...:
freq_rangeHTF={{[3050 3750]},{[3050 3750]},{[3050 3750]},{[3050 3750]},{[3050 3750]}};
evtaf_verHTF='v4';
get_WN_hitsHTF=1;
get_offline_matchHTF=1;
get_FFHTF=1;
if get_offline_matchHTF==1; % template params if also doing offline check
    template_name='pu11wh87ab_SyntaxDepPitchShift_v1_6';
    cntrng_values{1}={[5 14 1] 'or' 'n' 'y'};
    cntrng_values{2}={[5 14 0.1] 'or' 'n' 'y'};
    cntrng_values{3}={[5 14 1.1] 'and' 'n' 'y'};
    cntrng_values{4}={[1 4 1.5] 'or' 'n' 'n'};
    cntrng_values{5}={[1 4 1.5] 'or' 'n' 'n'};
    cntrng_values{6}={[1 4 1.5] 'or' 'n' 'n'};
    col_logic='(a+b+c)*(d+e+f)';
end



% INPUT: WITHIN FUNCTION VARIABLES SETTING (DIFFERENT FOR ALL MOTIFS)
% DO not change the values within each function, but add and subtract V's if you need.

num_motifs=size(syl_targ_list,2);
for i=1:num_motifs;
    % lt_check_HTF...:
    if get_offline_matchHTF==1;
        V1_mot{i}={'sylHTF',{syl_replace_list{i}},'syl_preHTF',{''},'syl_postHTF',{''},'freq_rangeHTF',freq_rangeHTF{i},'evtaf_verHTF',evtaf_verHTF,'get_WN_hitsHTF',get_WN_hitsHTF,'get_offline_matchHTF',...
            get_offline_matchHTF,'get_FFHTF',get_FFHTF,'template_name',template_name,'cntrng_values',cntrng_values,'col_logic',col_logic};
    else
        V1_mot{i}={'sylHTF',{syl_replace_list{i}},'syl_preHTF',{''},'syl_postHTF',{''},'freq_rangeHTF',freq_rangeHTF{i},'evtaf_verHTF',evtaf_verHTF,'get_WN_hitsHTF',get_WN_hitsHTF,'get_offline_matchHTF',...
            get_offline_matchHTF,'get_FFHTF',get_FFHTF};
    end
    
    % lt_calc_pitch...:
    V2_mot{i}={'syl_targetDP',syl_replace_list{i}, 'syl_preDP',{''},'phraseDP',phrase,'freq_rangeDP',freq_rangeDP_list{i},'pc_time_windowDP',pc_time_windowDP_list{i},'plot_resultDP',plot_resultDP,'pc_windowDP',pc_windowDP};
    
    % combine
    Vall_mot{i}=[V1_mot{i},V2_mot{i}];
end




% INPUTS FOR REGULAR (NON_MOTIF) SYLLABLES:

% lt_check_pitch:
syl_preHTF={'a'};
sylHTF={'b'};
syl_postHTF={''};
freq_rangeHTF={[3050 4200]};

% lt_calc_pitch
syl_preDP={'a'};
syl_targetDP='b';
freq_rangeDP={[3050 4200]};
pc_time_windowDP={[50 150]};


% Within function VARIABLES SETTING:
% lt_check...:
if get_offline_matchHTF==1;
    V1={'sylHTF',sylHTF,'syl_preHTF',syl_preHTF,'syl_postHTF',syl_postHTF,'freq_rangeHTF',freq_rangeHTF,'evtaf_verHTF',evtaf_verHTF,'get_WN_hitsHTF',get_WN_hitsHTF,'get_offline_matchHTF',get_offline_matchHTF,'get_FFHTF',get_FFHTF,'template_name',template_name,...
        'cntrng_values',cntrng_values,'col_logic',col_logic};
else
    V1={'sylHTF',sylHTF,'syl_preHTF',syl_preHTF,'syl_postHTF',syl_postHTF,'freq_rangeHTF',freq_rangeHTF,'evtaf_verHTF',evtaf_verHTF,'get_WN_hitsHTF',get_WN_hitsHTF,'get_offline_matchHTF',get_offline_matchHTF,'get_FFHTF',get_FFHTF};
end
% lt_calc...:
V2={'syl_targetDP',syl_targetDP, 'syl_preDP',syl_preDP,'phraseDP',phrase,'freq_rangeDP',freq_rangeDP,'pc_time_windowDP',pc_time_windowDP,'plot_resultDP',plot_resultDP,'pc_windowDP',pc_windowDP};
Vall=[V1,V2];


lt_all_days_various_calculations_COMBINE_Motif_and_Normal




% ----------------------------------------------------
% PLOT STUFF - specifically using all_days_various_COMPILED
bird_dir=['/bluejay3/lucas/birds/' all_days_various_COMPILED.parameters_COMPILATION.birdname];

% INPUTS
% Save?
save_plots=0;
% things to do:
% if have WN and/or lesion events (change to 1 to turn on)
get_thr=0;
plot_baseline=1;
baseline_days=1:3;
plot_WN=0;
plot_lesions=0;
plot_pitch_thresholds=0;
% running average
run_wind=[10 20 50];


if (0)
    WN_dates={'01Mar2014-1541','15Mar2014-1458','20Mar2014-0029','31Mar2014-0400'};
    WNevents=lt_convert_EventTimes_to_RelTimes(first_day_str,WN_dates);
    WN_switch_days=WNevents.FinalValue;
    lesion_dates={''};
    lesionEvents=lt_convert_EventTimes_to_RelTimes(first_day_str,lesion_dates);
    lesion_days=lesionEvents.FinalValue;
    threshold_switch_RealTimes={'20Mar2014-0029','20Mar2014-1739','21Mar2014-1234','24Mar2014-1651','25Mar2014-1808',...
        '26Mar2014-1347','27Mar2014-0207','27Mar2014-1127','28Mar2014-0103','28Mar2014-1320','30Mar2014-1951'}; % real times for threshold values switches in format e.g. 20Mar2014-1645
    thresh_values=[2583 2615 2639 2706 2685 2675 2665 2680 2720 2710 2720]; % values of threshold corresponding to switch times
    hit_conting='below'; % hit renditions "below" or "above" threshold?
end

% ------------------------
% RUNS 

% Auto: extracts other parameters
motif_table=all_days_various_COMPILED.parameters_COMPILATION.motif_table;
syllables=all_days_various_COMPILED.parameters_COMPILATION.syllables_COMPILED(:,2);
syllables_COMPILED=all_days_various_COMPILED.parameters_COMPILATION.syllables_COMPILED;
first_day_str=all_days_various_COMPILED.parameters_COMPILATION.first_day;
first_day_datenum=datenum(first_day_str,'ddmmmyyyy');
num_days=size(all_days_various_COMPILED.all_days_various(1).lt_calc_day_pitch,2);
last_day_str=all_days_various_COMPILED.parameters_COMPILATION.last_day;
NumToAddToAllDays= -first_day_datenum;% this is to make day 1 = day 0 (instead of in the thousands).
num_syl=size(syllables,1);
plot_colors=lt_make_plot_colors(num_syl,0);

for i=1:size(motif_table,1);
    syl_title{i}=[motif_table{i,1} '(' motif_table{i,2} ')']; % to use for labeling titles
end

% RUN
% PLOTTING Pitch - all days combined
for j=1:size(syllables_COMPILED,1);
    all_days_various=all_days_various_COMPILED.all_days_various(syllables_COMPILED{j,1}); % extract relevant structure from compiled structures
    hfig(j)=figure; hold on;
    
    % First, individual renditions
    for i=1:num_days; % number of days
        try % in case day has no data
            [~, WithinDayValues]=lt_convert_datenum_to_hour(all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,1)); %convert datenum to hours
            times_days=WithinDayValues.days;
            freq_values=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,2);
            hscatter=scatter(times_days+(i),freq_values,'b','.');
            %             % put in running average
            %             for j=1:length(run_wind);
            %                 X=smooth(freq_values,run_wind(j));
            %                 plot(times_days+(i),X,'-r');
            %             end
            
        catch err
            continue
        end
    end
    
    % Second, day means and std
    for i=1:num_days; % number of days
        try
            day_mean=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).mean_FF;
            day_std=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).sd_FF;
            errorbar(i+0.5,day_mean,day_std,'Marker','.','MarkerSize',27,'Color','k');
            text(i+0.4,day_mean+150,datestr(first_day_datenum+i-1,'ddmmmyyyy'));
        catch err
            continue
        end
    end
    
    % Third, format plot
    ylimits=ylim;
    ylim([ylimits(1)-150 ylimits(2)+150])
    title(['Pitch for syllable: ' syl_title{j} ' (individual renditions with means + SD)']); ylabel('Pitch (hz)');
    xlabel('Day (e.g. 1.5 = day1, 12pm)');
    ax1=gca;
    ax1_pos=get(ax1,'Position');
    
    % Fourth, Annotating important events (baseline, WN, lesion, Hz
    % threshold) - (had another version greened out also in the bk24
    % analysis file - obsolete).
    
    % Baseline
    if plot_baseline==1;
        baseline_values_temp=[];
        for i=baseline_days;
            baseline_values_temp=[baseline_values_temp all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,2)'];
        end
        baseline_mean=mean(baseline_values_temp);
        baseline_std=std(baseline_values_temp);
        line(xlim, [baseline_mean baseline_mean],'Color','r','LineWidth',0.4); % mean lines
        line(xlim, [baseline_mean+baseline_std baseline_mean+baseline_std],'LineStyle','--','Color',[0.7 0.1 0.1],'LineWidth',0.3); % variance lines
        line(xlim, [baseline_mean-baseline_std baseline_mean-baseline_std],'LineStyle','--','Color', [0.7 0.1 0.1],'LineWidth',0.3);
        line([baseline_days(end)+1 baseline_days(end)+1],ylim,'Color','k','LineWidth',1.8);% line after last baseline day
    end
    
    % WN epochs
    if plot_WN==1;
        disp('adding lines for WN epochs');
        % adding grey boxes for WN days
        ylimits=ylim;
        for i=1:size(WN_switch_days,1)
            if mod(i,2)==1; %i.e. i odd means this is start of WN
                rectangle('Position',[WN_switch_days(i), ylimits(1)+20, WN_switch_days(i+1)-WN_switch_days(i),ylimits(2)-ylimits(1)-40],...
                    'EdgeColor','r')
            end
        end
    end
    
    % Lesion events
    if plot_lesions==1;
        % adding lines for lesions
        for i=1:length(lesion_days);
            line([lesion_days(i) lesion_days(i)], ylim,'Color','g','LineWidth',0.4); % mean lines
        end
    end
    
    % Pitch training thresholds
    if plot_pitch_thresholds==1;
        % adding lines for pitch training WN thresholds
        [EventTimes_thr]= lt_convert_EventTimes_to_RelTimes(first_day_str,threshold_switch_RealTimes); % convert to numerical format
        thresh_start_times=EventTimes_thr.FinalValue;
        
        for i=1:length(thresh_start_times);
            if i==length(thresh_start_times);
                dummy=xlim;
                line([thresh_start_times(i) dummy(2)], [thresh_values(i) thresh_values(i)],'Color','g')
                line([thresh_start_times(i) thresh_start_times(i)], [thresh_values(i-1) thresh_values(i)],'Color','g')
            elseif i==1;
                line([thresh_start_times(i) thresh_start_times(i+1)], [thresh_values(i) thresh_values(i)],'Color','g')
            else
                line([thresh_start_times(i) thresh_start_times(i+1)], [thresh_values(i) thresh_values(i)],'Color','g')
                line([thresh_start_times(i) thresh_start_times(i)], [thresh_values(i-1) thresh_values(i)],'Color','g')
            end
        end
        ax2 = axes('Position',[ax1_pos(1) ax1_pos(2)-0.05 ax1_pos(3) ax1_pos(4)/100],'YGrid','off','Color','none');
    end
    
    
    
    % PLOTTING pitch contours for all days;
    hfig_pc(i)=figure; hold on;
    for ii=1:num_days;
        rows=ceil(num_days/4);
        h_sp(ii)=subplot(rows,4,ii); hold on;
        try % some days no data
            plot(all_days_various.lt_calc_day_pitch{ii}.pc_all.(syllables{j}),'LineStyle','--','Color',[0.6 0.6 0.6]); % plot all pitch contours in light shade
            plot(mean(all_days_various.lt_calc_day_pitch{ii}.pc_all.(syllables{j})'),'Linewidth',2);
            xlabel('Time (10^-4 sec)')
            ylabel('Frequency (Hz)')
            title(['syllable: ' syl_title{j} ', on ' datestr(first_day_datenum+ii-1,'ddmmmyyyy')]);
        catch err
        end
        try % plotting lines used to take frequency values
            R=all_days_various.lt_calc_day_pitch{1}.parameters.time_range.(syllables{j});
            ylimits=ylim;
            line([R(1) R(1)],[ylimits(1) ylimits(2)],'Color',[0.7 0.2 0.2]);
            line([R(2) R(2)],[ylimits(1) ylimits(2)],'Color',[0.7 0.2 0.2]);
        catch err
        end
        
    end
    linkaxes(h_sp,'xy');
    % plot mean of all days over each other
    hfig_pcAD(i)=figure; hold on;
    plot_colors_days=lt_make_plot_colors(num_days, 1, [1 1 1]);
    for ii=1:num_days;
        try
            X=mean(all_days_various.lt_calc_day_pitch{ii}.pc_all.(syllables{j})');
            plot(X,'-','Color',plot_colors_days{ii},'Linewidth',1.7);
            xvals=xlim;
            text(xvals(2),X(end),datestr(first_day_datenum+ii-1,'ddmmmyyyy'));
            xlabel('Time (10^-4 sec)')
            ylabel('Frequency (Hz)')
            title(['syllable: ' syl_title{j} ]);
        catch err
        end
        try % plotting lines used to take frequency values
            R=all_days_various.lt_calc_day_pitch{1}.parameters.time_range.(syllables{j});
            ylimits=ylim;
            line([R(1) R(1)],[ylimits(1) ylimits(2)],'Color',[0.7 0.2 0.2]);
            line([R(2) R(2)],[ylimits(1) ylimits(2)],'Color',[0.7 0.2 0.2]);
        catch err
        end
    end
    
    
    % DETERMINE NEW THRESHOLD (plot percentiles);
    % Input
    if (get_thr==1);
        day=datenum(last_day_str)-datenum(first_day_str)+1;
        total_rends=size(all_days_various.lt_calc_day_pitch{day}.FF.(syllables{j}).time_and_FF,1);
        for i=1:total_rends; % will give percentiles for all possible size rendition windows going back in time
            rends_to_take=total_rends-i+1:total_rends;
            percentiles_AllWindSizes.(syllables{j})(i,:)=prctile(all_days_various.lt_calc_day_pitch{day}.FF.(syllables{j}).time_and_FF(rends_to_take,2),[5 30 70 95]);
        end
        
        figure; hold on;
        plot(flipud(percentiles_AllWindSizes.(syllables{j})(:,2)),'og');
        plot(flipud(percentiles_AllWindSizes.(syllables{j})(:,3)),'ob');
        xlabel('how far back the beginning of the sample window goes (e.g. most right is closest to the most recent data)');
        ylabel('Pitch (hz)');
        title(['30th and 70th percentiles of pitch: Each point is a recalculation, using different windows; for ' syl_title{j}]);
    end
    
end

% FIGURES with all syllables in one plot:
% PITCH over all days;
hfig_allpitch=figure; hold on;
for j=1:num_syl;
    all_days_various=all_days_various_COMPILED.all_days_various(syllables_COMPILED{j,1}); % extract relevant structure from compiled structures
    for i=1:num_days; % number of days
        try
            day_mean=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).mean_FF;
            day_std=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).sd_FF;
            errorbar(i+0.5,day_mean,day_std,'Marker','.','MarkerSize',27,'Color',plot_colors{j});
            %             text(i+0.4,day_mean+150,datestr(first_day_datenum+i-1,'ddmmmyyyy'));
        catch err
            continue
        end
    end
    text(i+1.4,day_mean,syllables{j},'Color',plot_colors{j});
end


% PLOT HIT RATE
hfig_WNhit=figure; hold on;
title('WN hit rate over days (possibly catch songs)')
c=1;
for i=1:size(all_days_various_COMPILED.all_days_various,2); % how many data structures
    all_days_various=all_days_various_COMPILED.all_days_various(i);
    syls_and_params=fieldnames(all_days_various.lt_check_hit_templ_freq);
    num_syls=size(syls_and_params,1)-1;
    for ii=1:num_syls;
        if ~strcmp(syls_and_params(ii),'parameters');
            for j=1:num_days;
            plot(j,all_days_various.lt_check_hit_templ_freq.(syls_and_params{ii}){j}.(syls_and_params{ii}(end)).hit.sum(1)/...
                all_days_various.lt_check_hit_templ_freq.(syls_and_params{ii}){j}.(syls_and_params{ii}(end)).hit.sum(2),...
                'o','Color',plot_colors{c});
            end
            text(j+1, all_days_various.lt_check_hit_templ_freq.(syls_and_params{ii}){j}.(syls_and_params{ii}(end)).hit.sum(1)/...
                all_days_various.lt_check_hit_templ_freq.(syls_and_params{ii}){j}.(syls_and_params{ii}(end)).hit.sum(2),...
                syls_and_params(ii), 'Color', plot_colors{c});
        end
        c=c+1;
    end
end


        
        
    


% SAVING
if save_plots==1;
    timestampS=lt_get_timestamp(0);
    currdir=pwd;
    higherdir=[bird_dir 'SyntaxDepPitchShift_analysis'];
    try cd(higherdir);
    catch err
        mkdir(higherdir);
        cd(higherdir);
    end
    savedirname=['MOTIF_COMPILED_' all_days_various_COMPILED.parameters_COMPILATION.time_of_analysis '_PLOTS_' timestampS];
    try
        cd(savedirname);
    catch err
        mkdir(savedirname);
        cd(savedirname);
    end
    savemultfigs;
end




%% 7/23 - combining hit rate check (lt_check_...) and lt_calc_pitch - COMMENTED OUT, above better
% clear all; close all
% phrase = 'SyntaxDepPitchShift';
% first_day= '21Jul2014';
% last_day= '21Jul2014';
% save_results=1;
% 
% % INPUTS FOR LT_CHECK...:
% syl_preHTF={'a','b'};
% sylHTF={'b','b',};
% syl_postHTF={'',''};
% freq_rangeHTF={[2800 3800],[2800 3800]};
% evtaf_verHTF='v4';
% get_WN_hitsHTF=1;
% get_offline_matchHTF=1;
% get_FFHTF=1;
% 
% if get_offline_matchHTF==1;
% template_name='pu11wh87ab_SyntaxDepPitchShift_v1_6';
% cntrng_values{1}={[5 14 1] 'or' 'n' 'y'};
% cntrng_values{2}={[5 14 0.1] 'or' 'n' 'y'};
% cntrng_values{3}={[5 14 1.1] 'and' 'n' 'y'};
% cntrng_values{4}={[1 4 1.5] 'or' 'n' 'n'};
% cntrng_values{5}={[1 4 1.5] 'or' 'n' 'n'};
% cntrng_values{6}={[1 4 1.5] 'or' 'n' 'n'};
% col_logic='(a+b+c)*(d+e+f)';
% end
% 
% 
% % INPUTS FOR CALC_PITCH
% syl_preDP={'a','c'};
% syl_targetDP='bb';
% freq_rangeDP={[3050 4200],[3050 3750]};
% pc_time_windowDP={[50 150],[60 160]};
% plot_resultDP=1;
% pc_windowDP=2000;
% 
% 
% % FUNCTIONS TO RUN:
% FcnAll={'check_HTF','calcdaypitch'};
% 
% 
% % WITHIN FUNCTION VARIABLES SETTING:
% % lt_check...:
% if get_offline_matchHTF==1;
%     V1={'sylHTF',sylHTF,'syl_preHTF',syl_preHTF,'syl_postHTF',syl_postHTF,'freq_rangeHTF',freq_rangeHTF,'evtaf_verHTF',evtaf_verHTF,'get_WN_hitsHTF',get_WN_hitsHTF,'get_offline_matchHTF',get_offline_matchHTF,'get_FFHTF',get_FFHTF,'template_name',template_name,...
%         'cntrng_values',cntrng_values,'col_logic',col_logic};
% else
%     V1={'sylHTF',sylHTF,'syl_preHTF',syl_preHTF,'syl_postHTF',syl_postHTF,'freq_rangeHTF',freq_rangeHTF,'evtaf_verHTF',evtaf_verHTF,'get_WN_hitsHTF',get_WN_hitsHTF,'get_offline_matchHTF',get_offline_matchHTF,'get_FFHTF',get_FFHTF};
% end
% % lt_calc...:
% V2={'syl_targetDP',syl_targetDP, 'syl_preDP',syl_preDP,'phraseDP',phrase,'freq_rangeDP',freq_rangeDP,'pc_time_windowDP',pc_time_windowDP,'plot_resultDP',plot_resultDP,'pc_windowDP',pc_windowDP};
% Vall=[V1,V2];
% 
% 
% % RUN
% [filename_save, all_days_various]=lt_all_days_various_calculations_FUNCTION_temp(phrase, first_day, last_day, FcnAll, Vall, save_results);
% 
% 
% % PLOT STUFF
% % INPUTS
% ADV_name=filename_save;
% % Save?
% save_plots=0;
% % things to do:
% % if have WN and/or lesion events (change to 1 to turn on)
% get_thr=0;
% plot_baseline=1;
% baseline_days=1;
% plot_WN=0;
% plot_lesions=0;
% plot_pitch_thresholds=0;
% % running average
% run_wind=[10 20 50];
% 
% 
% if (0)
%     WN_dates={'01Mar2014-1541','15Mar2014-1458','20Mar2014-0029','31Mar2014-0400'};
%     WNevents=lt_convert_EventTimes_to_RelTimes(first_day_str,WN_dates);
%     WN_switch_days=WNevents.FinalValue;
%     lesion_dates={''};
%     lesionEvents=lt_convert_EventTimes_to_RelTimes(first_day_str,lesion_dates);
%     lesion_days=lesionEvents.FinalValue;
%     threshold_switch_RealTimes={'20Mar2014-0029','20Mar2014-1739','21Mar2014-1234','24Mar2014-1651','25Mar2014-1808',...
%         '26Mar2014-1347','27Mar2014-0207','27Mar2014-1127','28Mar2014-0103','28Mar2014-1320','30Mar2014-1951'}; % real times for threshold values switches in format e.g. 20Mar2014-1645
%     thresh_values=[2583 2615 2639 2706 2685 2675 2665 2680 2720 2710 2720]; % values of threshold corresponding to switch times
%     hit_conting='below'; % hit renditions "below" or "above" threshold?
% end
% 
% % RUNS
% ADV_dir=['/bluejay3/lucas/birds/' all_days_various.parameters.nameofbird '/all_days_various_calculations/'];
% load([ADV_dir ADV_name]);
% 
% % Auto: extracts other parameters
% syllables=all_days_various.lt_calc_day_pitch{1}.parameters.syllables;
% first_day_str=all_days_various.parameters.days{1};
% first_day_datenum=all_days_various.parameters.days{3};
% num_days=size(all_days_various.lt_calc_day_pitch,2);
% NumToAddToAllDays= -first_day_datenum;% this is to make day 1 = day 0 (instead of in the thousands).
% 
% % PLOTTING Pitch - all days combined
% for j=1:length(syllables);
%     hfig(j)=figure; hold on;
%     
%     % First, individual renditions
%     for i=1:num_days; % number of days
%         try % in case day has no data
%             [~, WithinDayValues]=lt_convert_datenum_to_hour(all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,1)); %convert datenum to hours
%             times_days=WithinDayValues.days;
%             freq_values=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,2);
%             hscatter=scatter(times_days+(i),freq_values,'b','.');
%             %             % put in running average
%             %             for j=1:length(run_wind);
%             %                 X=smooth(freq_values,run_wind(j));
%             %                 plot(times_days+(i),X,'-r');
%             %             end
%             
%         catch err
%             continue
%         end
%     end
%     
%     % Second, day means and std
%     for i=1:num_days; % number of days
%         try
%             day_mean=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).mean_FF;
%             day_std=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).sd_FF;
%             errorbar(i+0.5,day_mean,day_std,'Marker','.','MarkerSize',27,'Color','k');
%             text(i+0.4,day_mean+150,datestr(first_day_datenum+i-1,'ddmmmyyyy'));
%         catch err
%             continue
%         end
%     end
%     
%     % Third, format plot
%     ylimits=ylim;
%     ylim([ylimits(1)-150 ylimits(2)+150])
%     title(['Pitch for syllable: ' syllables{j} ' (individual renditions with means + SD)']); ylabel('Pitch (hz)');
%     xlabel('Day (e.g. 1.5 = day1, 12pm)');
%     ax1=gca;
%     ax1_pos=get(ax1,'Position');
%     
%     % Fourth, Annotating important events (baseline, WN, lesion, Hz
%     % threshold) - (had another version greened out also in the bk24
%     % analysis file - obsolete).
%     
%     % Baseline
%     if plot_baseline==1;
%         baseline_values_temp=[];
%         for i=baseline_days;
%             baseline_values_temp=[baseline_values_temp all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,2)'];
%         end
%         baseline_mean=mean(baseline_values_temp);
%         baseline_std=std(baseline_values_temp);
%         line(xlim, [baseline_mean baseline_mean],'Color','r','LineWidth',0.4); % mean lines
%         line(xlim, [baseline_mean+baseline_std baseline_mean+baseline_std],'LineStyle','--','Color',[0.7 0.1 0.1],'LineWidth',0.3); % variance lines
%         line(xlim, [baseline_mean-baseline_std baseline_mean-baseline_std],'LineStyle','--','Color', [0.7 0.1 0.1],'LineWidth',0.3);
%         line([baseline_days(end)+1 baseline_days(end)+1],ylim,'Color','k','LineWidth',1.8);% line after last baseline day
%     end
%     
%     % WN epochs
%     if plot_WN==1;
%         disp('adding lines for WN epochs');
%         % adding grey boxes for WN days
%         ylimits=ylim;
%         for i=1:size(WN_switch_days,1)
%             if mod(i,2)==1; %i.e. i odd means this is start of WN
%                 rectangle('Position',[WN_switch_days(i), ylimits(1)+20, WN_switch_days(i+1)-WN_switch_days(i),ylimits(2)-ylimits(1)-40],...
%                     'EdgeColor','r')
%             end
%         end
%     end
%     
%     % Lesion events
%     if plot_lesions==1;
%         % adding lines for lesions
%         for i=1:length(lesion_days);
%             line([lesion_days(i) lesion_days(i)], ylim,'Color','g','LineWidth',0.4); % mean lines
%         end
%     end
%     
%     % Pitch training thresholds
%     if plot_pitch_thresholds==1;
%         % adding lines for pitch training WN thresholds
%         [EventTimes_thr]= lt_convert_EventTimes_to_RelTimes(first_day_str,threshold_switch_RealTimes); % convert to numerical format
%         thresh_start_times=EventTimes_thr.FinalValue;
%         
%         for i=1:length(thresh_start_times);
%             if i==length(thresh_start_times);
%                 dummy=xlim;
%                 line([thresh_start_times(i) dummy(2)], [thresh_values(i) thresh_values(i)],'Color','g')
%                 line([thresh_start_times(i) thresh_start_times(i)], [thresh_values(i-1) thresh_values(i)],'Color','g')
%             elseif i==1;
%                 line([thresh_start_times(i) thresh_start_times(i+1)], [thresh_values(i) thresh_values(i)],'Color','g')
%             else
%                 line([thresh_start_times(i) thresh_start_times(i+1)], [thresh_values(i) thresh_values(i)],'Color','g')
%                 line([thresh_start_times(i) thresh_start_times(i)], [thresh_values(i-1) thresh_values(i)],'Color','g')
%             end
%         end
%         ax2 = axes('Position',[ax1_pos(1) ax1_pos(2)-0.05 ax1_pos(3) ax1_pos(4)/100],'YGrid','off','Color','none');
%     end
% end
% 
% % PLOTTING pitch contours for all days;
% for i=1:length(syllables);
%     hfig_pc(i)=figure; hold on;
%     for ii=1:num_days;
%         rows=ceil(num_days/4);
%         subplot(rows,4,ii); hold on;
%         try % some days no data
%             plot(all_days_various.lt_calc_day_pitch{ii}.pc_all.(syllables{i}),'LineStyle','--','Color',[0.6 0.6 0.6]); % plot all pitch contours in light shade
%             plot(mean(all_days_various.lt_calc_day_pitch{ii}.pc_all.(syllables{i})'),'Linewidth',2);
%             xlabel('Time (10^-4 sec)')
%             ylabel('Frequency (Hz)')
%             title(['syllable: ' syllables{i} ', on ' datestr(first_day_datenum+ii-1,'ddmmmyyyy')]);
%         catch err
%         end
%     end
%     % plot mean of all days over each other
%     hfig_pcAD(i)=figure; hold on;
%     plot_colors=lt_make_plot_colors(num_days, 1, [1 1 1]);
%     for ii=1:num_days;
%         try
%             X=mean(all_days_various.lt_calc_day_pitch{ii}.pc_all.(syllables{i})');
%             plot(X,'-','Color',plot_colors{ii},'Linewidth',1.7);
%             xvals=xlim;
%             text(xvals(2),X(end),datestr(first_day_datenum+ii-1,'ddmmmyyyy'));
%             xlabel('Time (10^-4 sec)')
%             ylabel('Frequency (Hz)')
%             title(['syllable: ' syllables{i} ]);
%         catch err
%         end
%     end
%     
% end
% 
% % DETERMINE NEW THRESHOLD (plot percentiles);
% % Input
% if (get_thr==1);
%     day=datenum(last_day)-datenum(first_day)+1;
%     for  ii=1:length(syllables);
%         total_rends=size(all_days_various.lt_calc_day_pitch{day}.FF.(syllables{ii}).time_and_FF,1);
%         for i=1:total_rends; % will give percentiles for all possible size rendition windows going back in time
%             rends_to_take=total_rends-i+1:total_rends;
%             percentiles_AllWindSizes.(syllables{ii})(i,:)=prctile(all_days_various.lt_calc_day_pitch{day}.FF.(syllables{ii}).time_and_FF(rends_to_take,2),[5 30 70 95]);
%         end
%         
%         figure; hold on;
%         plot(flipud(percentiles_AllWindSizes.(syllables{ii})(:,2)),'og');
%         plot(flipud(percentiles_AllWindSizes.(syllables{ii})(:,3)),'ob');
%         xlabel('how far back the beginning of the sample window goes (e.g. most right is closest to the most recent data)');
%         ylabel('Pitch (hz)');
%         title(['30th and 70th percentiles of pitch: Each point is a recalculation, using different windows; for ' syllables{ii}]);
%     end
% end
% 
% % SAVING
% if save_plots==1;
%     timestampS=lt_get_timestamp(0);
%     currdir=pwd;
%     try cd SyntaxDepPitchShift_analysis;
%     catch err
%         mkdir SyntaxDepPitchShift_analysis;
%         cd SyntaxDepPitchShift_analysis;
%     end
%     savedirname=[ADV_name '_PLOTS_' timestampS];
%     try
%         cd(savedirname);
%     catch err
%         mkdir(savedirname);
%         cd(savedirname);
%     end
%     savemultfigs;
% end
% 
% 
% % PLOT WN HIT RATE
% syllables = all_days_various.lt_check_hit_templ_freq.parameters.sylHTF

%% NOTE: everything above here is after modified lt_calc_day_pitch - the window, so need to use different time windows for pitch contour.

%% 7/22 - WN check
%     parameters.cntrng_values{1}={[5 14 1] 'or' 'n' 'y'};
%     parameters.cntrng_values{2}={[5 14 0.1] 'or' 'n' 'y'};
%     parameters.cntrng_values{3}={[5 14 1.1] 'and' 'n' 'y'};
%     parameters.cntrng_values{4}={[1 4 1.5] 'or' 'n' 'n'};
%     parameters.cntrng_values{5}={[1 4 1.5] 'or' 'n' 'n'};
%     parameters.cntrng_values{6}={[1 4 1.5] 'or' 'n' 'n'};
% (for 7/21)
clear all
cntrng_values{1}={[5 14 1] 'or' 'n' 'y'};
cntrng_values{2}={[5 14 0.1] 'or' 'n' 'y'};
cntrng_values{3}={[5 14 1.1] 'and' 'n' 'y'};
cntrng_values{4}={[1 4 1.5] 'or' 'n' 'n'};
cntrng_values{5}={[1 4 1.5] 'or' 'n' 'n'};
cntrng_values{6}={[1 4 1.5] 'or' 'n' 'n'};
col_logic='(a+b+c)*(d+e+f)';

check_stuff=lt_check_hit_templ_freq_FUNCTION('batch.catch.keep','b','a','',0.2,[2800 3800],'v4',1,1,1,...
template_name,cntrng_values,col_logic);


%% 7/21 - up to now (i.e. post WN day 3)
clear all; close all

% FIRST, COLLECT DATA ACROSS DAYS

% GENERAL INPUTS
phrase = 'SyntaxDepPitchShift';
first_day= '21Jul2014';
last_day= '21Jul2014';

% ----------------------------------------------------
% INPUTS
% 2) Motifs - which motifs to look at, and parameters for each
% i.e. each entry is for a separate motif (if want to get both ab(b) and ab(c), then syl_targ_list would be {'b','c'}
motif_pre_list={'dcc','dccb','ab','bcc','bccb'};
syl_targ_list={'b','b','b','b','b'};
motif_post_list={'','','','',''};
syl_replace_list={'M','N','Z','P','Q'};
% calcdaypitch parameters - these can be cells arrays of cells.  inner
% cells are the actual parameters used for each iteration of function
% below.
freq_rangeDP_list={{[3050 3750]},{[3050 3750]},{[3050 3750]},{[3050 3750]},{[3050 3750]},};
pc_time_windowDP_list={{[140 230]},{[130 220]},{[120 210]},{[140 230]},{[140 230]}};
plot_resultDP_list={0,0,0,0,0};
pc_windowDP_list={3000,3000,3000,3000,3000};

% 3) Automatic parameters
num_motifs=size(syl_targ_list,2);


% RUN ANALYSIS
% First summarize motifs, so mistakes won't lead to permanent changes to
% batch files;
motif_counter=0;
for i=1:num_motifs;
    disp([motif_pre_list{i} syl_targ_list{i} motif_post_list{i} ' will be temporarily changed to '...
        motif_pre_list{i} syl_replace_list{i} motif_post_list{i} ' in the following analysis.']);
    if strcmp(input('type y to continue, anything else to quit: ','s'),'y')==0;
        forced2quit; % force quit
    end
end
for i=1:num_motifs;
    % Motif parameters - convert from list above to individual params
    syl_targ=syl_targ_list{i};
    motif_pre=motif_pre_list{i};
    motif_post=motif_post_list{i};
    syl_replace=syl_replace_list{i};
    % calcdaypitch parameters
    freq_rangeDP=freq_rangeDP_list{i};
    pc_time_windowDP=pc_time_windowDP_list{i};
    plot_resultDP=plot_resultDP_list{i};
    pc_windowDP=pc_windowDP_list{i};
    
    % RUN
    [filename_save, all_days_various(motif_counter+1)]=lt_all_days_various_calculations_FUNCTION_MOTIF(phrase,first_day,last_day,{'calcdaypitch'}, {'syl_targetDP',syl_replace, 'syl_preDP',{''},'phraseDP',phrase,'freq_rangeDP',freq_rangeDP,...
        'pc_time_windowDP',pc_time_windowDP,'plot_resultDP',plot_resultDP,'pc_windowDP',pc_windowDP},0,{syl_targ,motif_pre,motif_post,syl_replace});
    
    % OUTPUT
    %     filename_save_COMPILED{i}=filename_save; % names of relevant data structures
    motif_counter=motif_counter+1;
    
    motif_table{motif_counter,1}=[motif_pre syl_targ motif_post];
    motif_table{motif_counter,2}=[motif_pre syl_replace motif_post];
end



% ----------------------------------------------------
% RUN ANALYSIS FOR SYL THAT DON'T NEED MOTIF CONVERSION (e.g. simple 'a' or
% 'ab');

% INPUTS
% calcdaypitch parameters
% syl_preDP={'a','c','b','b'};
% syl_targetDP='bbcb';
% freq_rangeDP={[3050 4200],[3050 3750],[2200 2800],[3050 3750]};
% pc_time_windowDP={[140 230],[140 230],[150 300],[140 230]};
syl_preDP={'a'};
syl_targetDP='b';
freq_rangeDP={[3050 4200]};
pc_time_windowDP={[120 210]};
plot_resultDP=0;
pc_windowDP=3000;

% RUN
[filename_save, all_days_various(motif_counter+1)]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,{'calcdaypitch'}, {'syl_targetDP',syl_targetDP, 'syl_preDP',syl_preDP,'phraseDP',phrase,'freq_rangeDP',freq_rangeDP,...
    'pc_time_windowDP',pc_time_windowDP,'plot_resultDP',plot_resultDP,'pc_windowDP',pc_windowDP},0);

motif_counter=motif_counter+1;
for i=1:length(syl_targetDP);
    motif_table{motif_counter+i-1,2}=[syl_preDP{i} syl_targetDP(i)];
end

% jj=size(filename_save_COMPILED,2);
% filename_save_COMPILED{jj+1}=filename_save;


% ----------------------------------------------------
% COMBINE DATA STRUCTURES
% INPUT
bird_dir='/bluejay3/lucas/birds/pu11wh87/';
ADV_dir=[bird_dir 'all_days_various_calculations/'];

all_days_various_COMPILED.all_days_various=all_days_various;

% get list of motifs and correspondence with structure #
c=1;
for i=1:size(all_days_various_COMPILED.all_days_various,2);
    fields=fieldnames(all_days_various_COMPILED.all_days_various(i).lt_calc_day_pitch{1}.FF);
    num_fields=length(fields);
    for ii=1:num_fields;
        syllables_COMPILED{c,1}=i;
        syllables_COMPILED{c,2}=fields{ii};
        c=c+1;
    end
end


% OUTPUT
% compiled data structure
parameters.motif_table=motif_table;
timestamp=lt_get_timestamp(0);
parameters.syllables_COMPILED=syllables_COMPILED;
parameters.first_day=first_day;
parameters.last_day=last_day;
parameters.time_of_analysis=timestamp;
savename=[ADV_dir 'all_days_various_MOTIF_COMPILED_' timestamp];
things_analyzed=all_days_various_COMPILED.all_days_various(1).parameters.things_analyzed;
parameters.things_analyzed=things_analyzed;
parameters.savename=savename;
parameters.syllables_COMPILED=syllables_COMPILED;
all_days_various_COMPILED.parameters_COMPILATION=parameters;

save(savename,'all_days_various_COMPILED');

% add to log.txt (assumes that all motifs underwent saem analyses)
cd(ADV_dir);
log_note=['MOTIF_COMPILED_' timestamp '__|' things_analyzed '|__' strjoin(parameters.motif_table(:,2)')  '|__' first_day '_to_' last_day];
fid=fopen('log.txt','a');
fprintf(fid,'%s \n \n',log_note);
fclose(fid);



% ----------------------------------------------------
% PLOT STUFF - specifically using all_days_various_COMPILED
bird_dir='/bluejay3/lucas/birds/pu11wh87/';

% INPUTS
% Save?
save_plots=1;
% things to do:
% if have WN and/or lesion events (change to 1 to turn on)
get_thr=0;
plot_baseline=1;
baseline_days=1:3;
plot_WN=0;
plot_lesions=0;
plot_pitch_thresholds=0;
% running average
run_wind=[10 20 50];


if (0)
    WN_dates={'01Mar2014-1541','15Mar2014-1458','20Mar2014-0029','31Mar2014-0400'};
    WNevents=lt_convert_EventTimes_to_RelTimes(first_day_str,WN_dates);
    WN_switch_days=WNevents.FinalValue;
    lesion_dates={''};
    lesionEvents=lt_convert_EventTimes_to_RelTimes(first_day_str,lesion_dates);
    lesion_days=lesionEvents.FinalValue;
    threshold_switch_RealTimes={'20Mar2014-0029','20Mar2014-1739','21Mar2014-1234','24Mar2014-1651','25Mar2014-1808',...
        '26Mar2014-1347','27Mar2014-0207','27Mar2014-1127','28Mar2014-0103','28Mar2014-1320','30Mar2014-1951'}; % real times for threshold values switches in format e.g. 20Mar2014-1645
    thresh_values=[2583 2615 2639 2706 2685 2675 2665 2680 2720 2710 2720]; % values of threshold corresponding to switch times
    hit_conting='below'; % hit renditions "below" or "above" threshold?
end

% RUNS

% Auto: extracts other parameters
motif_table=all_days_various_COMPILED.parameters_COMPILATION.motif_table;
syllables=all_days_various_COMPILED.parameters_COMPILATION.syllables_COMPILED(:,2);
syllables_COMPILED=all_days_various_COMPILED.parameters_COMPILATION.syllables_COMPILED;
first_day_str=all_days_various_COMPILED.parameters_COMPILATION.first_day;
first_day_datenum=datenum(first_day_str,'ddmmmyyyy');
num_days=size(all_days_various_COMPILED.all_days_various(1).lt_calc_day_pitch,2);
last_day_str=all_days_various_COMPILED.parameters_COMPILATION.last_day;
NumToAddToAllDays= -first_day_datenum;% this is to make day 1 = day 0 (instead of in the thousands).
num_syl=size(syllables,1);
plot_colors=lt_make_plot_colors(num_syl,0);

for i=1:size(motif_table,1);
    syl_title{i}=[motif_table{i,1} '(' motif_table{i,2} ')']; % to use for labeling titles
end

% RUN
% PLOTTING Pitch - all days combined
for j=1:size(syllables_COMPILED,1);
    all_days_various=all_days_various_COMPILED.all_days_various(syllables_COMPILED{j,1}); % extract relevant structure from compiled structures
    hfig(j)=figure; hold on;
    
    % First, individual renditions
    for i=1:num_days; % number of days
        try % in case day has no data
            [~, WithinDayValues]=lt_convert_datenum_to_hour(all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,1)); %convert datenum to hours
            times_days=WithinDayValues.days;
            freq_values=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,2);
            hscatter=scatter(times_days+(i),freq_values,'b','.');
            %             % put in running average
            %             for j=1:length(run_wind);
            %                 X=smooth(freq_values,run_wind(j));
            %                 plot(times_days+(i),X,'-r');
            %             end
            
        catch err
            continue
        end
    end
    
    % Second, day means and std
    for i=1:num_days; % number of days
        try
            day_mean=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).mean_FF;
            day_std=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).sd_FF;
            errorbar(i+0.5,day_mean,day_std,'Marker','.','MarkerSize',27,'Color','k');
            text(i+0.4,day_mean+150,datestr(first_day_datenum+i-1,'ddmmmyyyy'));
        catch err
            continue
        end
    end
    
    % Third, format plot
    ylimits=ylim;
    ylim([ylimits(1)-150 ylimits(2)+150])
    title(['Pitch for syllable: ' syl_title{j} ' (individual renditions with means + SD)']); ylabel('Pitch (hz)');
    xlabel('Day (e.g. 1.5 = day1, 12pm)');
    ax1=gca;
    ax1_pos=get(ax1,'Position');
    
    % Fourth, Annotating important events (baseline, WN, lesion, Hz
    % threshold) - (had another version greened out also in the bk24
    % analysis file - obsolete).
    
    % Baseline
    if plot_baseline==1;
        baseline_values_temp=[];
        for i=baseline_days;
            baseline_values_temp=[baseline_values_temp all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,2)'];
        end
        baseline_mean=mean(baseline_values_temp);
        baseline_std=std(baseline_values_temp);
        line(xlim, [baseline_mean baseline_mean],'Color','r','LineWidth',0.4); % mean lines
        line(xlim, [baseline_mean+baseline_std baseline_mean+baseline_std],'LineStyle','--','Color',[0.7 0.1 0.1],'LineWidth',0.3); % variance lines
        line(xlim, [baseline_mean-baseline_std baseline_mean-baseline_std],'LineStyle','--','Color', [0.7 0.1 0.1],'LineWidth',0.3);
        line([baseline_days(end)+1 baseline_days(end)+1],ylim,'Color','k','LineWidth',1.8);% line after last baseline day
    end
    
    % WN epochs
    if plot_WN==1;
        disp('adding lines for WN epochs');
        % adding grey boxes for WN days
        ylimits=ylim;
        for i=1:size(WN_switch_days,1)
            if mod(i,2)==1; %i.e. i odd means this is start of WN
                rectangle('Position',[WN_switch_days(i), ylimits(1)+20, WN_switch_days(i+1)-WN_switch_days(i),ylimits(2)-ylimits(1)-40],...
                    'EdgeColor','r')
            end
        end
    end
    
    % Lesion events
    if plot_lesions==1;
        % adding lines for lesions
        for i=1:length(lesion_days);
            line([lesion_days(i) lesion_days(i)], ylim,'Color','g','LineWidth',0.4); % mean lines
        end
    end
    
    % Pitch training thresholds
    if plot_pitch_thresholds==1;
        % adding lines for pitch training WN thresholds
        [EventTimes_thr]= lt_convert_EventTimes_to_RelTimes(first_day_str,threshold_switch_RealTimes); % convert to numerical format
        thresh_start_times=EventTimes_thr.FinalValue;
        
        for i=1:length(thresh_start_times);
            if i==length(thresh_start_times);
                dummy=xlim;
                line([thresh_start_times(i) dummy(2)], [thresh_values(i) thresh_values(i)],'Color','g')
                line([thresh_start_times(i) thresh_start_times(i)], [thresh_values(i-1) thresh_values(i)],'Color','g')
            elseif i==1;
                line([thresh_start_times(i) thresh_start_times(i+1)], [thresh_values(i) thresh_values(i)],'Color','g')
            else
                line([thresh_start_times(i) thresh_start_times(i+1)], [thresh_values(i) thresh_values(i)],'Color','g')
                line([thresh_start_times(i) thresh_start_times(i)], [thresh_values(i-1) thresh_values(i)],'Color','g')
            end
        end
        ax2 = axes('Position',[ax1_pos(1) ax1_pos(2)-0.05 ax1_pos(3) ax1_pos(4)/100],'YGrid','off','Color','none');
    end
    
    
    
    % PLOTTING pitch contours for all days;
    hfig_pc(i)=figure; hold on;
    for ii=1:num_days;
        rows=ceil(num_days/4);
        h_sp(ii)=subplot(rows,4,ii); hold on;
        try % some days no data
            plot(all_days_various.lt_calc_day_pitch{ii}.pc_all.(syllables{j}),'LineStyle','--','Color',[0.6 0.6 0.6]); % plot all pitch contours in light shade
            plot(mean(all_days_various.lt_calc_day_pitch{ii}.pc_all.(syllables{j})'),'Linewidth',2);
            xlabel('Time (10^-4 sec)')
            ylabel('Frequency (Hz)')
            title(['syllable: ' syl_title{j} ', on ' datestr(first_day_datenum+ii-1,'ddmmmyyyy')]);
        catch err
        end
        try % plotting lines used to take frequency values
            R=all_days_various.lt_calc_day_pitch{1}.parameters.time_range.(syllables{j});
            ylimits=ylim;
            line([R(1) R(1)],[ylimits(1) ylimits(2)],'Color',[0.7 0.2 0.2]);
            line([R(2) R(2)],[ylimits(1) ylimits(2)],'Color',[0.7 0.2 0.2]);
        catch err
        end
        
    end
    linkaxes(h_sp,'xy');
    % plot mean of all days over each other
    hfig_pcAD(i)=figure; hold on;
    plot_colors=lt_make_plot_colors(num_days, 1, [1 1 1]);
    for ii=1:num_days;
        try
            X=mean(all_days_various.lt_calc_day_pitch{ii}.pc_all.(syllables{j})');
            plot(X,'-','Color',plot_colors{ii},'Linewidth',1.7);
            xvals=xlim;
            text(xvals(2),X(end),datestr(first_day_datenum+ii-1,'ddmmmyyyy'));
            xlabel('Time (10^-4 sec)')
            ylabel('Frequency (Hz)')
            title(['syllable: ' syl_title{j} ]);
        catch err
        end
        try % plotting lines used to take frequency values
            R=all_days_various.lt_calc_day_pitch{1}.parameters.time_range.(syllables{j});
            ylimits=ylim;
            line([R(1) R(1)],[ylimits(1) ylimits(2)],'Color',[0.7 0.2 0.2]);
            line([R(2) R(2)],[ylimits(1) ylimits(2)],'Color',[0.7 0.2 0.2]);
        catch err
        end
    end
    
    
    % DETERMINE NEW THRESHOLD (plot percentiles);
    % Input
    if (get_thr==1);
        day=datenum(last_day_str)-datenum(first_day_str)+1;
        total_rends=size(all_days_various.lt_calc_day_pitch{day}.FF.(syllables{j}).time_and_FF,1);
        for i=1:total_rends; % will give percentiles for all possible size rendition windows going back in time
            rends_to_take=total_rends-i+1:total_rends;
            percentiles_AllWindSizes.(syllables{j})(i,:)=prctile(all_days_various.lt_calc_day_pitch{day}.FF.(syllables{j}).time_and_FF(rends_to_take,2),[5 30 70 95]);
        end
        
        figure; hold on;
        plot(flipud(percentiles_AllWindSizes.(syllables{j})(:,2)),'og');
        plot(flipud(percentiles_AllWindSizes.(syllables{j})(:,3)),'ob');
        xlabel('how far back the beginning of the sample window goes (e.g. most right is closest to the most recent data)');
        ylabel('Pitch (hz)');
        title(['30th and 70th percentiles of pitch: Each point is a recalculation, using different windows; for ' syl_title{j}]);
    end
    
end

% FIGURES with all syllables in one plot:
% PITCH over all days;
hfig_allpitch=figure; hold on;
for j=1:num_syl;
    all_days_various=all_days_various_COMPILED.all_days_various(syllables_COMPILED{j,1}); % extract relevant structure from compiled structures
    for i=1:num_days; % number of days
        try
            day_mean=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).mean_FF;
            day_std=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).sd_FF;
            errorbar(i+0.5,day_mean,day_std,'Marker','.','MarkerSize',27,'Color',plot_colors{j});
            %             text(i+0.4,day_mean+150,datestr(first_day_datenum+i-1,'ddmmmyyyy'));
        catch err
            continue
        end
    end
    text(i+1.4,day_mean,syllables{j},'Color',plot_colors{j});
end

% SAVING
if save_plots==1;
    timestampS=lt_get_timestamp(0);
    currdir=pwd;
    higherdir=[bird_dir 'SyntaxDepPitchShift_analysis'];
    try cd(higherdir);
    catch err
        mkdir(higherdir);
        cd(higherdir);
    end
    savedirname=['MOTIF_COMPILED_' all_days_various_COMPILED.parameters_COMPILATION.time_of_analysis '_PLOTS_' timestampS];
    try
        cd(savedirname);
    catch err
        mkdir(savedirname);
        cd(savedirname);
    end
    savemultfigs;
end




%% 7/12 to 7/15 - DIFFERENT - incorporating code that looks at all types of b (higher order dependencies)
clear all; close all

% FIRST, COLLECT DATA ACROSS DAYS

% GENERAL INPUTS
phrase = 'SyntaxDepPitchShift';
first_day= '05Jul2014';
last_day= '15Jul2014';

% ----------------------------------------------------
% INPUTS
% 2) Motifs - which motifs to look at, and parameters for each
% i.e. each entry is for a separate motif (if want to get both ab(b) and ab(c), then syl_targ_list would be {'b','c'}
motif_pre_list={'dcc','dccb','ab','bcc','bccb'};
syl_targ_list={'b','b','b','b','b'};
motif_post_list={'','','','',''};
syl_replace_list={'M','N','Z','P','Q'};
% calcdaypitch parameters - these can be cells arrays of cells.  inner
% cells are the actual parameters used for each iteration of function
% below.
freq_rangeDP_list={{[3050 3750]},{[3050 3750]},{[3050 3750]},{[3050 3750]},{[3050 3750]},};
pc_time_windowDP_list={{[140 230]},{[130 220]},{[120 210]},{[140 230]},{[140 230]}};
plot_resultDP_list={0,0,0,0,0};
pc_windowDP_list={3000,3000,3000,3000,3000};

% 3) Automatic parameters
num_motifs=size(syl_targ_list,2);


% RUN ANALYSIS
% First summarize motifs, so mistakes won't lead to permanent changes to
% batch files;
motif_counter=0;
for i=1:num_motifs;
    disp([motif_pre_list{i} syl_targ_list{i} motif_post_list{i} ' will be temporarily changed to '...
        motif_pre_list{i} syl_replace_list{i} motif_post_list{i} ' in the following analysis.']);
    if strcmp(input('type y to continue, anything else to quit: ','s'),'y')==0;
        forced2quit; % force quit
    end
end
for i=1:num_motifs;
    % Motif parameters - convert from list above to individual params
    syl_targ=syl_targ_list{i};
    motif_pre=motif_pre_list{i};
    motif_post=motif_post_list{i};
    syl_replace=syl_replace_list{i};
    % calcdaypitch parameters
    freq_rangeDP=freq_rangeDP_list{i};
    pc_time_windowDP=pc_time_windowDP_list{i};
    plot_resultDP=plot_resultDP_list{i};
    pc_windowDP=pc_windowDP_list{i};
    
    % RUN
    [filename_save, all_days_various(motif_counter+1)]=lt_all_days_various_calculations_FUNCTION_MOTIF(phrase,first_day,last_day,{'calcdaypitch'}, {'syl_targetDP',syl_replace, 'syl_preDP',{''},'phraseDP',phrase,'freq_rangeDP',freq_rangeDP,...
        'pc_time_windowDP',pc_time_windowDP,'plot_resultDP',plot_resultDP,'pc_windowDP',pc_windowDP},0,{syl_targ,motif_pre,motif_post,syl_replace});
    
    % OUTPUT
    %     filename_save_COMPILED{i}=filename_save; % names of relevant data structures
    motif_counter=motif_counter+1;
    
    motif_table{motif_counter,1}=[motif_pre syl_targ motif_post];
    motif_table{motif_counter,2}=[motif_pre syl_replace motif_post];
end



% ----------------------------------------------------
% RUN ANALYSIS FOR SYL THAT DON'T NEED MOTIF CONVERSION (e.g. simple 'a' or
% 'ab');

% INPUTS
% calcdaypitch parameters
% syl_preDP={'a','c','b','b'};
% syl_targetDP='bbcb';
% freq_rangeDP={[3050 4200],[3050 3750],[2200 2800],[3050 3750]};
% pc_time_windowDP={[140 230],[140 230],[150 300],[140 230]};
syl_preDP={'a'};
syl_targetDP='b';
freq_rangeDP={[3050 4200]};
pc_time_windowDP={[120 210]};
plot_resultDP=0;
pc_windowDP=3000;

% RUN
[filename_save, all_days_various(motif_counter+1)]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,{'calcdaypitch'}, {'syl_targetDP',syl_targetDP, 'syl_preDP',syl_preDP,'phraseDP',phrase,'freq_rangeDP',freq_rangeDP,...
    'pc_time_windowDP',pc_time_windowDP,'plot_resultDP',plot_resultDP,'pc_windowDP',pc_windowDP},0);

motif_counter=motif_counter+1;
for i=1:length(syl_targetDP);
    motif_table{motif_counter+i-1,2}=[syl_preDP{i} syl_targetDP(i)];
end

% jj=size(filename_save_COMPILED,2);
% filename_save_COMPILED{jj+1}=filename_save;


% ----------------------------------------------------
% COMBINE DATA STRUCTURES
% INPUT
bird_dir='/bluejay3/lucas/birds/pu11wh87/';
ADV_dir=[bird_dir 'all_days_various_calculations/'];

all_days_various_COMPILED.all_days_various=all_days_various;

% get list of motifs and correspondence with structure #
c=1;
for i=1:size(all_days_various_COMPILED.all_days_various,2);
    fields=fieldnames(all_days_various_COMPILED.all_days_various(i).lt_calc_day_pitch{1}.FF);
    num_fields=length(fields);
    for ii=1:num_fields;
        syllables_COMPILED{c,1}=i;
        syllables_COMPILED{c,2}=fields{ii};
        c=c+1;
    end
end


% OUTPUT
% compiled data structure
parameters.motif_table=motif_table;
timestamp=lt_get_timestamp(0);
paramaters.syllables_COMPILED=syllables_COMPILED;
parameters.first_day=first_day;
parameters.last_day=last_day;
parameters.time_of_analysis=timestamp;
savename=[ADV_dir 'all_days_various_MOTIF_COMPILED_' timestamp];
things_analyzed=all_days_various_COMPILED.all_days_various(1).parameters.things_analyzed;
parameters.things_analyzed=things_analyzed;
parameters.savename=savename;
parameters.syllables_COMPILED=syllables_COMPILED;
all_days_various_COMPILED.parameters_COMPILATION=parameters;

save(savename,'all_days_various_COMPILED');

% add to log.txt (assumes that all motifs underwent saem analyses)
cd(ADV_dir);
log_note=['MOTIF_COMPILED_' timestamp '__|' things_analyzed '|__' strjoin(parameters.motif_table(:,2)')  '|__' first_day '_to_' last_day];
fid=fopen('log.txt','a');
fprintf(fid,'%s \n \n',log_note);
fclose(fid);



% ----------------------------------------------------
% PLOT STUFF - specifically using all_days_various_COMPILED
bird_dir='/bluejay3/lucas/birds/pu11wh87/';

% INPUTS
% Save?
save_plots=1;
% things to do:
% if have WN and/or lesion events (change to 1 to turn on)
get_thr=0;
plot_baseline=1;
baseline_days=1:3;
plot_WN=0;
plot_lesions=0;
plot_pitch_thresholds=0;
% running average
run_wind=[10 20 50];


if (0)
    WN_dates={'01Mar2014-1541','15Mar2014-1458','20Mar2014-0029','31Mar2014-0400'};
    WNevents=lt_convert_EventTimes_to_RelTimes(first_day_str,WN_dates);
    WN_switch_days=WNevents.FinalValue;
    lesion_dates={''};
    lesionEvents=lt_convert_EventTimes_to_RelTimes(first_day_str,lesion_dates);
    lesion_days=lesionEvents.FinalValue;
    threshold_switch_RealTimes={'20Mar2014-0029','20Mar2014-1739','21Mar2014-1234','24Mar2014-1651','25Mar2014-1808',...
        '26Mar2014-1347','27Mar2014-0207','27Mar2014-1127','28Mar2014-0103','28Mar2014-1320','30Mar2014-1951'}; % real times for threshold values switches in format e.g. 20Mar2014-1645
    thresh_values=[2583 2615 2639 2706 2685 2675 2665 2680 2720 2710 2720]; % values of threshold corresponding to switch times
    hit_conting='below'; % hit renditions "below" or "above" threshold?
end

% RUNS

% Auto: extracts other parameters
motif_table=all_days_various_COMPILED.parameters_COMPILATION.motif_table;
syllables=all_days_various_COMPILED.parameters_COMPILATION.syllables_COMPILED(:,2);
syllables_COMPILED=all_days_various_COMPILED.parameters_COMPILATION.syllables_COMPILED;
first_day_str=all_days_various_COMPILED.parameters_COMPILATION.first_day;
first_day_datenum=datenum(first_day_str,'ddmmmyyyy');
num_days=size(all_days_various_COMPILED.all_days_various(1).lt_calc_day_pitch,2);
last_day_str=all_days_various_COMPILED.parameters_COMPILATION.last_day;
NumToAddToAllDays= -first_day_datenum;% this is to make day 1 = day 0 (instead of in the thousands).

for i=1:size(motif_table,1);
    syl_title{i}=[motif_table{i,1} '(' motif_table{i,2} ')']; % to use for labeling titles
end

% RUN
% PLOTTING Pitch - all days combined
for j=1:size(syllables_COMPILED,1);
    all_days_various=all_days_various_COMPILED.all_days_various(syllables_COMPILED{j,1}); % extract relevant structure from compiled structures
    hfig(j)=figure; hold on;
    
    % First, individual renditions
    for i=1:num_days; % number of days
        try % in case day has no data
            [~, WithinDayValues]=lt_convert_datenum_to_hour(all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,1)); %convert datenum to hours
            times_days=WithinDayValues.days;
            freq_values=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,2);
            hscatter=scatter(times_days+(i),freq_values,'b','.');
            %             % put in running average
            %             for j=1:length(run_wind);
            %                 X=smooth(freq_values,run_wind(j));
            %                 plot(times_days+(i),X,'-r');
            %             end
            
        catch err
            continue
        end
    end
    
    % Second, day means and std
    for i=1:num_days; % number of days
        try
            day_mean=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).mean_FF;
            day_std=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).sd_FF;
            errorbar(i+0.5,day_mean,day_std,'Marker','.','MarkerSize',27,'Color','k');
            text(i+0.4,day_mean+150,datestr(first_day_datenum+i-1,'ddmmmyyyy'));
        catch err
            continue
        end
    end
    
    % Third, format plot
    ylimits=ylim;
    ylim([ylimits(1)-150 ylimits(2)+150])
    title(['Pitch for syllable: ' syl_title{j} ' (individual renditions with means + SD)']); ylabel('Pitch (hz)');
    xlabel('Day (e.g. 1.5 = day1, 12pm)');
    ax1=gca;
    ax1_pos=get(ax1,'Position');
    
    % Fourth, Annotating important events (baseline, WN, lesion, Hz
    % threshold) - (had another version greened out also in the bk24
    % analysis file - obsolete).
    
    % Baseline
    if plot_baseline==1;
        baseline_values_temp=[];
        for i=baseline_days;
            baseline_values_temp=[baseline_values_temp all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,2)'];
        end
        baseline_mean=mean(baseline_values_temp);
        baseline_std=std(baseline_values_temp);
        line(xlim, [baseline_mean baseline_mean],'Color','r','LineWidth',0.4); % mean lines
        line(xlim, [baseline_mean+baseline_std baseline_mean+baseline_std],'LineStyle','--','Color',[0.7 0.1 0.1],'LineWidth',0.3); % variance lines
        line(xlim, [baseline_mean-baseline_std baseline_mean-baseline_std],'LineStyle','--','Color', [0.7 0.1 0.1],'LineWidth',0.3);
        line([baseline_days(end)+1 baseline_days(end)+1],ylim,'Color','k','LineWidth',1.8);% line after last baseline day
    end
    
    % WN epochs
    if plot_WN==1;
        disp('adding lines for WN epochs');
        % adding grey boxes for WN days
        ylimits=ylim;
        for i=1:size(WN_switch_days,1)
            if mod(i,2)==1; %i.e. i odd means this is start of WN
                rectangle('Position',[WN_switch_days(i), ylimits(1)+20, WN_switch_days(i+1)-WN_switch_days(i),ylimits(2)-ylimits(1)-40],...
                    'EdgeColor','r')
            end
        end
    end
    
    % Lesion events
    if plot_lesions==1;
        % adding lines for lesions
        for i=1:length(lesion_days);
            line([lesion_days(i) lesion_days(i)], ylim,'Color','g','LineWidth',0.4); % mean lines
        end
    end
    
    % Pitch training thresholds
    if plot_pitch_thresholds==1;
        % adding lines for pitch training WN thresholds
        [EventTimes_thr]= lt_convert_EventTimes_to_RelTimes(first_day_str,threshold_switch_RealTimes); % convert to numerical format
        thresh_start_times=EventTimes_thr.FinalValue;
        
        for i=1:length(thresh_start_times);
            if i==length(thresh_start_times);
                dummy=xlim;
                line([thresh_start_times(i) dummy(2)], [thresh_values(i) thresh_values(i)],'Color','g')
                line([thresh_start_times(i) thresh_start_times(i)], [thresh_values(i-1) thresh_values(i)],'Color','g')
            elseif i==1;
                line([thresh_start_times(i) thresh_start_times(i+1)], [thresh_values(i) thresh_values(i)],'Color','g')
            else
                line([thresh_start_times(i) thresh_start_times(i+1)], [thresh_values(i) thresh_values(i)],'Color','g')
                line([thresh_start_times(i) thresh_start_times(i)], [thresh_values(i-1) thresh_values(i)],'Color','g')
            end
        end
        ax2 = axes('Position',[ax1_pos(1) ax1_pos(2)-0.05 ax1_pos(3) ax1_pos(4)/100],'YGrid','off','Color','none');
    end
    
    % PLOTTING pitch contours for all days;
    hfig_pc(i)=figure; hold on;
    for ii=1:num_days;
        rows=ceil(num_days/4);
        subplot(rows,4,ii); hold on;
        try % some days no data
            plot(all_days_various.lt_calc_day_pitch{ii}.pc_all.(syllables{j}),'LineStyle','--','Color',[0.6 0.6 0.6]); % plot all pitch contours in light shade
            plot(mean(all_days_various.lt_calc_day_pitch{ii}.pc_all.(syllables{j})'),'Linewidth',2);
            xlabel('Time (10^-4 sec)')
            ylabel('Frequency (Hz)')
            title(['syllable: ' syl_title{j} ', on ' datestr(first_day_datenum+ii-1,'ddmmmyyyy')]);
        catch err
        end
        try % plotting lines used to take frequency values
            R=all_days_various.lt_calc_day_pitch{1}.parameters.time_range.(syllables{j});
            ylimits=ylim;
            line([R(1) R(1)],[ylimits(1) ylimits(2)],'Color',[0.7 0.2 0.2]);
            line([R(2) R(2)],[ylimits(1) ylimits(2)],'Color',[0.7 0.2 0.2]);
        catch err
        end
        
    end
    % plot mean of all days over each other
    hfig_pcAD(i)=figure; hold on;
    plot_colors=lt_make_plot_colors(num_days, 1, [1 1 1]);
    for ii=1:num_days;
        try
            X=mean(all_days_various.lt_calc_day_pitch{ii}.pc_all.(syllables{j})');
            plot(X,'-','Color',plot_colors{ii},'Linewidth',1.7);
            xvals=xlim;
            text(xvals(2),X(end),datestr(first_day_datenum+ii-1,'ddmmmyyyy'));
            xlabel('Time (10^-4 sec)')
            ylabel('Frequency (Hz)')
            title(['syllable: ' syl_title{j} ]);
        catch err
        end
        try % plotting lines used to take frequency values
            R=all_days_various.lt_calc_day_pitch{1}.parameters.time_range.(syllables{j});
            ylimits=ylim;
            line([R(1) R(1)],[ylimits(1) ylimits(2)],'Color',[0.7 0.2 0.2]);
            line([R(2) R(2)],[ylimits(1) ylimits(2)],'Color',[0.7 0.2 0.2]);
        catch err
        end
    end
    
    
    % DETERMINE NEW THRESHOLD (plot percentiles);
    % Input
    if (get_thr==1);
        day=datenum(last_day_str)-datenum(first_day_str)+1;
        total_rends=size(all_days_various.lt_calc_day_pitch{day}.FF.(syllables{j}).time_and_FF,1);
        for i=1:total_rends; % will give percentiles for all possible size rendition windows going back in time
            rends_to_take=total_rends-i+1:total_rends;
            percentiles_AllWindSizes.(syllables{j})(i,:)=prctile(all_days_various.lt_calc_day_pitch{day}.FF.(syllables{j}).time_and_FF(rends_to_take,2),[5 30 70 95]);
        end
        
        figure; hold on;
        plot(flipud(percentiles_AllWindSizes.(syllables{j})(:,2)),'og');
        plot(flipud(percentiles_AllWindSizes.(syllables{j})(:,3)),'ob');
        xlabel('how far back the beginning of the sample window goes (e.g. most right is closest to the most recent data)');
        ylabel('Pitch (hz)');
        title(['30th and 70th percentiles of pitch: Each point is a recalculation, using different windows; for ' syl_title{j}]);
    end
    
end

% SAVING
if save_plots==1;
    timestampS=lt_get_timestamp(0);
    currdir=pwd;
    higherdir=[bird_dir 'SyntaxDepPitchShift_analysis'];
    try cd(higherdir);
    catch err
        mkdir(higherdir);
        cd(higherdir);
    end
    savedirname=['MOTIF_COMPILED_' all_days_various_COMPILED.parameters_COMPILATION.time_of_analysis '_PLOTS_' timestampS];
    try
        cd(savedirname);
    catch err
        mkdir(savedirname);
        cd(savedirname);
    end
    savemultfigs;
end


%% 7/12 - All days up to now:
clear all; close all;

% COLLECT DATA ACROSS DAYS
% INPUTS
phrase = 'SyntaxDepPitchShift';
first_day= '07Jul2014';
last_day= '13Jul2014';
% things to do:
% calcdaypitch parameters
syl_preDP={'a','c','b','b'};
syl_targetDP='bbcb';
freq_rangeDP={[3050 4200],[3050 3750],[2200 2800],[3050 3750]};
pc_time_windowDP={[140 230],[140 230],[150 300],[140 230]};
plot_resultDP=0;
pc_windowDP=3000;

% RUN
[filename_save, all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,{'calcdaypitch'}, {'syl_targetDP',syl_targetDP, 'syl_preDP',syl_preDP,'phraseDP',phrase,'freq_rangeDP',freq_rangeDP,...
    'pc_time_windowDP',pc_time_windowDP,'plot_resultDP',plot_resultDP,'pc_windowDP',pc_windowDP},1);

% PLOT STUFF
% INPUTS
ADV_name=filename_save;
% Save?
save_plots=1;
% things to do:
% if have WN and/or lesion events (change to 1 to turn on)
get_thr=1;
plot_baseline=1;
baseline_days=1;
plot_WN=0;
plot_lesions=0;
plot_pitch_thresholds=0;
% running average
run_wind=[10 20 50];


if (0)
    WN_dates={'01Mar2014-1541','15Mar2014-1458','20Mar2014-0029','31Mar2014-0400'};
    WNevents=lt_convert_EventTimes_to_RelTimes(first_day_str,WN_dates);
    WN_switch_days=WNevents.FinalValue;
    lesion_dates={''};
    lesionEvents=lt_convert_EventTimes_to_RelTimes(first_day_str,lesion_dates);
    lesion_days=lesionEvents.FinalValue;
    threshold_switch_RealTimes={'20Mar2014-0029','20Mar2014-1739','21Mar2014-1234','24Mar2014-1651','25Mar2014-1808',...
        '26Mar2014-1347','27Mar2014-0207','27Mar2014-1127','28Mar2014-0103','28Mar2014-1320','30Mar2014-1951'}; % real times for threshold values switches in format e.g. 20Mar2014-1645
    thresh_values=[2583 2615 2639 2706 2685 2675 2665 2680 2720 2710 2720]; % values of threshold corresponding to switch times
    hit_conting='below'; % hit renditions "below" or "above" threshold?
end

% RUNS
ADV_dir='/bluejay3/lucas/birds/pu11wh87/all_days_various_calculations/';
load([ADV_dir ADV_name]);

% Auto: extracts other parameters
syllables=all_days_various.lt_calc_day_pitch{1}.parameters.syllables;
first_day_str=all_days_various.parameters.days{1};
first_day_datenum=all_days_various.parameters.days{3};
num_days=size(all_days_various.lt_calc_day_pitch,2);
NumToAddToAllDays= -first_day_datenum;% this is to make day 1 = day 0 (instead of in the thousands).

% PLOTTING Pitch - all days combined
for j=1:length(syllables);
    hfig(j)=figure; hold on;
    
    % First, individual renditions
    for i=1:num_days; % number of days
        try % in case day has no data
            [~, WithinDayValues]=lt_convert_datenum_to_hour(all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,1)); %convert datenum to hours
            times_days=WithinDayValues.days;
            freq_values=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,2);
            hscatter=scatter(times_days+(i),freq_values,'b','.');
            %             % put in running average
            %             for j=1:length(run_wind);
            %                 X=smooth(freq_values,run_wind(j));
            %                 plot(times_days+(i),X,'-r');
            %             end
            
        catch err
            continue
        end
    end
    
    % Second, day means and std
    for i=1:num_days; % number of days
        try
            day_mean=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).mean_FF;
            day_std=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).sd_FF;
            errorbar(i+0.5,day_mean,day_std,'Marker','.','MarkerSize',27,'Color','k');
            text(i+0.4,day_mean+150,datestr(first_day_datenum+i-1,'ddmmmyyyy'));
        catch err
            continue
        end
    end
    
    % Third, format plot
    ylimits=ylim;
    ylim([ylimits(1)-150 ylimits(2)+150])
    title(['Pitch for syllable: ' syllables{j} ' (individual renditions with means + SD)']); ylabel('Pitch (hz)');
    xlabel('Day (e.g. 1.5 = day1, 12pm)');
    ax1=gca;
    ax1_pos=get(ax1,'Position');
    
    % Fourth, Annotating important events (baseline, WN, lesion, Hz
    % threshold) - (had another version greened out also in the bk24
    % analysis file - obsolete).
    
    % Baseline
    if plot_baseline==1;
        baseline_values_temp=[];
        for i=baseline_days;
            baseline_values_temp=[baseline_values_temp all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,2)'];
        end
        baseline_mean=mean(baseline_values_temp);
        baseline_std=std(baseline_values_temp);
        line(xlim, [baseline_mean baseline_mean],'Color','r','LineWidth',0.4); % mean lines
        line(xlim, [baseline_mean+baseline_std baseline_mean+baseline_std],'LineStyle','--','Color',[0.7 0.1 0.1],'LineWidth',0.3); % variance lines
        line(xlim, [baseline_mean-baseline_std baseline_mean-baseline_std],'LineStyle','--','Color', [0.7 0.1 0.1],'LineWidth',0.3);
        line([baseline_days(end)+1 baseline_days(end)+1],ylim,'Color','k','LineWidth',1.8);% line after last baseline day
    end
    
    % WN epochs
    if plot_WN==1;
        disp('adding lines for WN epochs');
        % adding grey boxes for WN days
        ylimits=ylim;
        for i=1:size(WN_switch_days,1)
            if mod(i,2)==1; %i.e. i odd means this is start of WN
                rectangle('Position',[WN_switch_days(i), ylimits(1)+20, WN_switch_days(i+1)-WN_switch_days(i),ylimits(2)-ylimits(1)-40],...
                    'EdgeColor','r')
            end
        end
    end
    
    % Lesion events
    if plot_lesions==1;
        % adding lines for lesions
        for i=1:length(lesion_days);
            line([lesion_days(i) lesion_days(i)], ylim,'Color','g','LineWidth',0.4); % mean lines
        end
    end
    
    % Pitch training thresholds
    if plot_pitch_thresholds==1;
        % adding lines for pitch training WN thresholds
        [EventTimes_thr]= lt_convert_EventTimes_to_RelTimes(first_day_str,threshold_switch_RealTimes); % convert to numerical format
        thresh_start_times=EventTimes_thr.FinalValue;
        
        for i=1:length(thresh_start_times);
            if i==length(thresh_start_times);
                dummy=xlim;
                line([thresh_start_times(i) dummy(2)], [thresh_values(i) thresh_values(i)],'Color','g')
                line([thresh_start_times(i) thresh_start_times(i)], [thresh_values(i-1) thresh_values(i)],'Color','g')
            elseif i==1;
                line([thresh_start_times(i) thresh_start_times(i+1)], [thresh_values(i) thresh_values(i)],'Color','g')
            else
                line([thresh_start_times(i) thresh_start_times(i+1)], [thresh_values(i) thresh_values(i)],'Color','g')
                line([thresh_start_times(i) thresh_start_times(i)], [thresh_values(i-1) thresh_values(i)],'Color','g')
            end
        end
        ax2 = axes('Position',[ax1_pos(1) ax1_pos(2)-0.05 ax1_pos(3) ax1_pos(4)/100],'YGrid','off','Color','none');
    end
end

% PLOTTING pitch contours for all days;
for i=1:length(syllables);
    hfig_pc(i)=figure; hold on;
    for ii=1:num_days;
        rows=ceil(num_days/4);
        subplot(rows,4,ii); hold on;
        try % some days no data
            plot(all_days_various.lt_calc_day_pitch{ii}.pc_all.(syllables{i}),'LineStyle','--','Color',[0.6 0.6 0.6]); % plot all pitch contours in light shade
            plot(mean(all_days_various.lt_calc_day_pitch{ii}.pc_all.(syllables{i})'),'Linewidth',2);
            xlabel('Time (10^-4 sec)')
            ylabel('Frequency (Hz)')
            title(['syllable: ' syllables{i} ', on ' datestr(first_day_datenum+ii-1,'ddmmmyyyy')]);
        catch err
        end
    end
    % plot mean of all days over each other
    hfig_pcAD(i)=figure; hold on;
    plot_colors=lt_make_plot_colors(num_days, 1, [1 1 1]);
    for ii=1:num_days;
        try
            X=mean(all_days_various.lt_calc_day_pitch{ii}.pc_all.(syllables{i})');
            plot(X,'-','Color',plot_colors{ii},'Linewidth',1.7);
            xvals=xlim;
            text(xvals(2),X(end),datestr(first_day_datenum+ii-1,'ddmmmyyyy'));
            xlabel('Time (10^-4 sec)')
            ylabel('Frequency (Hz)')
            title(['syllable: ' syllables{i} ]);
        catch err
        end
    end
    
end

% DETERMINE NEW THRESHOLD (plot percentiles);
% Input
if (get_thr==1);
    day=datenum(last_day)-datenum(first_day)+1;
    for  ii=1:length(syllables);
        total_rends=size(all_days_various.lt_calc_day_pitch{day}.FF.(syllables{ii}).time_and_FF,1);
        for i=1:total_rends; % will give percentiles for all possible size rendition windows going back in time
            rends_to_take=total_rends-i+1:total_rends;
            percentiles_AllWindSizes.(syllables{ii})(i,:)=prctile(all_days_various.lt_calc_day_pitch{day}.FF.(syllables{ii}).time_and_FF(rends_to_take,2),[5 30 70 95]);
        end
        
        figure; hold on;
        plot(flipud(percentiles_AllWindSizes.(syllables{ii})(:,2)),'og');
        plot(flipud(percentiles_AllWindSizes.(syllables{ii})(:,3)),'ob');
        xlabel('how far back the beginning of the sample window goes (e.g. most right is closest to the most recent data)');
        ylabel('Pitch (hz)');
        title(['30th and 70th percentiles of pitch: Each point is a recalculation, using different windows; for ' syllables{ii}]);
    end
end

% SAVING
if save_plots==1;
    timestampS=lt_get_timestamp(0);
    currdir=pwd;
    try cd SyntaxDepPitchShift_analysis;
    catch err
        mkdir SyntaxDepPitchShift_analysis;
        cd SyntaxDepPitchShift_analysis;
    end
    savedirname=[ADV_name '_PLOTS_' timestampS];
    try
        cd(savedirname);
    catch err
        mkdir(savedirname);
        cd(savedirname);
    end
    savemultfigs;
end

%% 7/11 - day4 WN

clear all; close all;
phrase = 'SyntaxDepPitchShift';
first_day= '21Jul2014';
last_day= '21Jul2014';

% % calcdaypitch parameters
syl_preDP={'a','c','b'};
syl_targetDP='bbb';
pc_windowDP = 2000;

% RUN
[filename_save, all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,{'calcdaypitch'}, {'syl_targetDP',syl_targetDP, 'syl_preDP',syl_preDP,'phraseDP',phrase,'freq_rangeDP',{[3200 4200],[3050 3750],[3050 3750]},...
    'pc_time_windowDP',{[140 230],[140 230],[140 230]},'plot_resultDP',1,'pc_windowDP',pc_windowDP},1);

%% calcdaypitch parameters
syl_preDP={''};
syl_targetDP='c';

% RUN
[filename_save, all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,{'calcdaypitch'}, {'syl_targetDP',syl_targetDP, 'syl_preDP',syl_preDP,'phraseDP',phrase,'freq_rangeDP',{[2200 2800]},...
    'pc_time_windowDP',{[150 300]},'plot_resultDP',1,'pc_windowDP',''},1);

ADV_dir='/bluejay3/lucas/birds/pu11wh87/all_days_various_calculations/';
load([ADV_dir filename_save]);
% lesion_dates={'10Feb2014-2000'};

% if have WN and/or lesion events (change to 1 to turn on)
plot_baseline=0;
baseline_days=1:3;
plot_WN=0;
plot_lesions=0;
plot_pitch_thresholds=0;

if (0)
    WN_dates={'01Mar2014-1541','15Mar2014-1458','20Mar2014-0029','31Mar2014-0400'};
    WNevents=lt_convert_EventTimes_to_RelTimes(first_day_str,WN_dates);
    WN_switch_days=WNevents.FinalValue;
    lesion_dates={''};
    lesionEvents=lt_convert_EventTimes_to_RelTimes(first_day_str,lesion_dates);
    lesion_days=lesionEvents.FinalValue;
    threshold_switch_RealTimes={'20Mar2014-0029','20Mar2014-1739','21Mar2014-1234','24Mar2014-1651','25Mar2014-1808',...
        '26Mar2014-1347','27Mar2014-0207','27Mar2014-1127','28Mar2014-0103','28Mar2014-1320','30Mar2014-1951'}; % real times for threshold values switches in format e.g. 20Mar2014-1645
    thresh_values=[2583 2615 2639 2706 2685 2675 2665 2680 2720 2710 2720]; % values of threshold corresponding to switch times
    hit_conting='below'; % hit renditions "below" or "above" threshold?
end

% Auto: calc other parameters
syllables=all_days_various.lt_calc_day_pitch{1}.parameters.syllables;
first_day_str=all_days_various.parameters.days{1};
first_day_datenum=all_days_various.parameters.days{3};
num_days=size(all_days_various.lt_calc_day_pitch,2);
NumToAddToAllDays= -first_day_datenum;% this is to make day 1 = day 0 (instead of in the thousands).


% PLOTTING
for j=1:length(syllables);
    hfig(j)=figure; hold on;
    
    % First, individual renditions
    for i=1:num_days; % number of days
        try % in case day has no data
            [~, WithinDayValues]=lt_convert_datenum_to_hour(all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,1)); %convert datenum to hours
            times_days=WithinDayValues.days;
            freq_values=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,2);
            hscatter=scatter(times_days+(i),freq_values,'b','.');
        catch err
            continue
        end
    end
    
    % Second, day means and std
    for i=1:num_days; % number of days
        try
            day_mean=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).mean_FF;
            day_std=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).sd_FF;
            errorbar(i+0.5,day_mean,day_std,'Marker','.','MarkerSize',27,'Color','k');
            text(i+0.4,day_mean+150,datestr(first_day_datenum+i-1,'ddmmmyyyy'));
        catch err
            continue
        end
    end
    
    % Third, format plot
    ylimits=ylim;
    ylim([ylimits(1)-150 ylimits(2)+150])
    title(['Pitch for syllable: ' syllables{j} ' (individual renditions with means + SD)']); ylabel('Pitch (hz)');
    xlabel('Day (e.g. 1.5 = day1, 12pm)');
    ax1=gca;
    ax1_pos=get(ax1,'Position');
    
    % Fourth, Annotating important events (baseline, WN, lesion, Hz
    % threshold) - (had another version greened out also in the bk24
    % analysis file - obsolete).
    
    % Baseline
    if plot_baseline==1;
        baseline_values_temp=[];
        for i=baseline_days;
            baseline_values_temp=[baseline_values_temp all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,2)'];
        end
        baseline_mean=mean(baseline_values_temp);
        baseline_std=std(baseline_values_temp);
        line(xlim, [baseline_mean baseline_mean],'Color','r','LineWidth',0.4); % mean lines
        line(xlim, [baseline_mean+baseline_std baseline_mean+baseline_std],'LineStyle','--','Color',[0.7 0.1 0.1],'LineWidth',0.3); % variance lines
        line(xlim, [baseline_mean-baseline_std baseline_mean-baseline_std],'LineStyle','--','Color', [0.7 0.1 0.1],'LineWidth',0.3);
        line([baseline_days(end)+1 baseline_days(end)+1],ylim,'Color','k','LineWidth',1.8);% line after last baseline day
    end
    
    % WN epochs
    if plot_WN==1;
        disp('adding lines for WN epochs');
        % adding grey boxes for WN days
        ylimits=ylim;
        for i=1:size(WN_switch_days,1)
            if mod(i,2)==1; %i.e. i odd means this is start of WN
                rectangle('Position',[WN_switch_days(i), ylimits(1)+20, WN_switch_days(i+1)-WN_switch_days(i),ylimits(2)-ylimits(1)-40],...
                    'EdgeColor','r')
            end
        end
    end
    
    % Lesion events
    if plot_lesions==1;
        % adding lines for lesions
        for i=1:length(lesion_days);
            line([lesion_days(i) lesion_days(i)], ylim,'Color','g','LineWidth',0.4); % mean lines
        end
    end
    
    % Pitch training thresholds
    if plot_pitch_thresholds==1;
        % adding lines for pitch training WN thresholds
        [EventTimes_thr]= lt_convert_EventTimes_to_RelTimes(first_day_str,threshold_switch_RealTimes); % convert to numerical format
        thresh_start_times=EventTimes_thr.FinalValue;
        
        for i=1:length(thresh_start_times);
            if i==length(thresh_start_times);
                dummy=xlim;
                line([thresh_start_times(i) dummy(2)], [thresh_values(i) thresh_values(i)],'Color','g')
                line([thresh_start_times(i) thresh_start_times(i)], [thresh_values(i-1) thresh_values(i)],'Color','g')
            elseif i==1;
                line([thresh_start_times(i) thresh_start_times(i+1)], [thresh_values(i) thresh_values(i)],'Color','g')
            else
                line([thresh_start_times(i) thresh_start_times(i+1)], [thresh_values(i) thresh_values(i)],'Color','g')
                line([thresh_start_times(i) thresh_start_times(i)], [thresh_values(i-1) thresh_values(i)],'Color','g')
            end
        end
        ax2 = axes('Position',[ax1_pos(1) ax1_pos(2)-0.05 ax1_pos(3) ax1_pos(4)/100],'YGrid','off','Color','none');
    end
end


% DETERMINE NEW THRESHOLD (plot percentiles);
% Input
day=datenum(last_day)-datenum(first_day)+1;

% Run
for  ii=1:length(syllables);
    total_rends=size(all_days_various.lt_calc_day_pitch{day}.FF.(syllables{ii}).time_and_FF,1);
    for i=1:total_rends; % will give percentiles for all possible size rendition windows going back in time
        rends_to_take=total_rends-i+1:total_rends;
        percentiles_AllWindSizes.(syllables{ii})(i,:)=prctile(all_days_various.lt_calc_day_pitch{day}.FF.(syllables{ii}).time_and_FF(rends_to_take,2),[5 30 70 95]);
    end
    
    figure; hold on;
    plot(flipud(percentiles_AllWindSizes.(syllables{ii})(:,2)),'og');
    plot(flipud(percentiles_AllWindSizes.(syllables{ii})(:,3)),'ob');
    xlabel('how far back the beginning of the sample window goes (e.g. most right is closest to the most recent data)');
    ylabel('Pitch (hz)');
    title(['30th and 70th percentiles of pitch: Each point is a recalculation, using different windows; for ' syllables{ii}]);
end



%% 7/10 - day3 WN

% COLLECT PITCH DATA FROM EACH DAY
% uses pitch contour.

% INPUTS
clear all; close all;
phrase = 'SyntaxDepPitchShift';
first_day= '10Jul2014';
last_day= '10Jul2014';

% calcdaypitch parameters
syl_preDP={'a','c','b'};
syl_targetDP='bbb';

% RUN
[filename_save, all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,{'calcdaypitch'}, {'syl_targetDP',syl_targetDP, 'syl_preDP',syl_preDP,'phraseDP',phrase,'freq_rangeDP',{[3200 4200],[3050 3750],[3050 3750]},...
    'pc_time_windowDP',{[140 230],[140 230],[140 230]},'plot_resultDP',1},1);


%% PLOT - using code modified from bk24bk63
% INPUTS:

ADV_dir='/bluejay3/lucas/birds/pu11wh87/all_days_various_calculations/';
load([ADV_dir filename_save]);
% lesion_dates={'10Feb2014-2000'};

% if have WN and/or lesion events (change to 1 to turn on)
plot_baseline=0;
baseline_days=1:3;
plot_WN=0;
plot_lesions=0;
plot_pitch_thresholds=0;

if (0)
    WN_dates={'01Mar2014-1541','15Mar2014-1458','20Mar2014-0029','31Mar2014-0400'};
    WNevents=lt_convert_EventTimes_to_RelTimes(first_day_str,WN_dates);
    WN_switch_days=WNevents.FinalValue;
    lesion_dates={''};
    lesionEvents=lt_convert_EventTimes_to_RelTimes(first_day_str,lesion_dates);
    lesion_days=lesionEvents.FinalValue;
    threshold_switch_RealTimes={'20Mar2014-0029','20Mar2014-1739','21Mar2014-1234','24Mar2014-1651','25Mar2014-1808',...
        '26Mar2014-1347','27Mar2014-0207','27Mar2014-1127','28Mar2014-0103','28Mar2014-1320','30Mar2014-1951'}; % real times for threshold values switches in format e.g. 20Mar2014-1645
    thresh_values=[2583 2615 2639 2706 2685 2675 2665 2680 2720 2710 2720]; % values of threshold corresponding to switch times
    hit_conting='below'; % hit renditions "below" or "above" threshold?
end

% Auto: calc other parameters
syllables=all_days_various.lt_calc_day_pitch{1}.parameters.syllables;
first_day_str=all_days_various.parameters.days{1};
first_day_datenum=all_days_various.parameters.days{3};
num_days=size(all_days_various.lt_calc_day_pitch,2);
NumToAddToAllDays= -first_day_datenum;% this is to make day 1 = day 0 (instead of in the thousands).


% PLOTTING
for j=1:length(syllables);
    hfig(j)=figure; hold on;
    
    % First, individual renditions
    for i=1:num_days; % number of days
        try % in case day has no data
            [~, WithinDayValues]=lt_convert_datenum_to_hour(all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,1)); %convert datenum to hours
            times_days=WithinDayValues.days;
            freq_values=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,2);
            hscatter=scatter(times_days+(i),freq_values,'b','.');
        catch err
            continue
        end
    end
    
    % Second, day means and std
    for i=1:num_days; % number of days
        try
            day_mean=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).mean_FF;
            day_std=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).sd_FF;
            errorbar(i+0.5,day_mean,day_std,'Marker','.','MarkerSize',27,'Color','k');
            text(i+0.4,day_mean+150,datestr(first_day_datenum+i-1,'ddmmmyyyy'));
        catch err
            continue
        end
    end
    
    % Third, format plot
    ylimits=ylim;
    ylim([ylimits(1)-150 ylimits(2)+150])
    title(['Pitch for syllable: ' syllables{j} ' (individual renditions with means + SD)']); ylabel('Pitch (hz)');
    xlabel('Day (e.g. 1.5 = day1, 12pm)');
    ax1=gca;
    ax1_pos=get(ax1,'Position');
    
    % Fourth, Annotating important events (baseline, WN, lesion, Hz
    % threshold) - (had another version greened out also in the bk24
    % analysis file - obsolete).
    
    % Baseline
    if plot_baseline==1;
        baseline_values_temp=[];
        for i=baseline_days;
            baseline_values_temp=[baseline_values_temp all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,2)'];
        end
        baseline_mean=mean(baseline_values_temp);
        baseline_std=std(baseline_values_temp);
        line(xlim, [baseline_mean baseline_mean],'Color','r','LineWidth',0.4); % mean lines
        line(xlim, [baseline_mean+baseline_std baseline_mean+baseline_std],'LineStyle','--','Color',[0.7 0.1 0.1],'LineWidth',0.3); % variance lines
        line(xlim, [baseline_mean-baseline_std baseline_mean-baseline_std],'LineStyle','--','Color', [0.7 0.1 0.1],'LineWidth',0.3);
        line([baseline_days(end)+1 baseline_days(end)+1],ylim,'Color','k','LineWidth',1.8);% line after last baseline day
    end
    
    % WN epochs
    if plot_WN==1;
        disp('adding lines for WN epochs');
        % adding grey boxes for WN days
        ylimits=ylim;
        for i=1:size(WN_switch_days,1)
            if mod(i,2)==1; %i.e. i odd means this is start of WN
                rectangle('Position',[WN_switch_days(i), ylimits(1)+20, WN_switch_days(i+1)-WN_switch_days(i),ylimits(2)-ylimits(1)-40],...
                    'EdgeColor','r')
            end
        end
    end
    
    % Lesion events
    if plot_lesions==1;
        % adding lines for lesions
        for i=1:length(lesion_days);
            line([lesion_days(i) lesion_days(i)], ylim,'Color','g','LineWidth',0.4); % mean lines
        end
    end
    
    % Pitch training thresholds
    if plot_pitch_thresholds==1;
        % adding lines for pitch training WN thresholds
        [EventTimes_thr]= lt_convert_EventTimes_to_RelTimes(first_day_str,threshold_switch_RealTimes); % convert to numerical format
        thresh_start_times=EventTimes_thr.FinalValue;
        
        for i=1:length(thresh_start_times);
            if i==length(thresh_start_times);
                dummy=xlim;
                line([thresh_start_times(i) dummy(2)], [thresh_values(i) thresh_values(i)],'Color','g')
                line([thresh_start_times(i) thresh_start_times(i)], [thresh_values(i-1) thresh_values(i)],'Color','g')
            elseif i==1;
                line([thresh_start_times(i) thresh_start_times(i+1)], [thresh_values(i) thresh_values(i)],'Color','g')
            else
                line([thresh_start_times(i) thresh_start_times(i+1)], [thresh_values(i) thresh_values(i)],'Color','g')
                line([thresh_start_times(i) thresh_start_times(i)], [thresh_values(i-1) thresh_values(i)],'Color','g')
            end
        end
        ax2 = axes('Position',[ax1_pos(1) ax1_pos(2)-0.05 ax1_pos(3) ax1_pos(4)/100],'YGrid','off','Color','none');
    end
end


% DETERMINE NEW THRESHOLD (plot percentiles);
% Input
day=datenum(last_day)-datenum(first_day)+1;

% Run
for  ii=1:length(syllables);
    total_rends=size(all_days_various.lt_calc_day_pitch{day}.FF.(syllables{ii}).time_and_FF,1);
    for i=1:total_rends; % will give percentiles for all possible size rendition windows going back in time
        rends_to_take=total_rends-i+1:total_rends;
        percentiles_AllWindSizes.(syllables{ii})(i,:)=prctile(all_days_various.lt_calc_day_pitch{day}.FF.(syllables{ii}).time_and_FF(rends_to_take,2),[5 30 70 95]);
    end
    
    figure; hold on;
    plot(flipud(percentiles_AllWindSizes.(syllables{ii})(:,2)),'og');
    plot(flipud(percentiles_AllWindSizes.(syllables{ii})(:,3)),'ob');
    xlabel('how far back the beginning of the sample window goes (e.g. most right is closest to the most recent data)');
    ylabel('Pitch (hz)');
    title(['30th and 70th percentiles of pitch: Each point is a recalculation, using different windows; for ' syllables{ii}]);
end



%% 7/8 - To do:
% 1) correlations of pitch over trials (for the different classes).  (related - temporal distance)
% 2) transition probability
% 3) hit rate

%% 7/9 - day2 WN

% COLLECT PITCH DATA FROM EACH DAY
% uses pitch contour.

% INPUTS
clear all; close all;
phrase = 'SyntaxDepPitchShift';
first_day= '05Jul2014';
last_day= '09Jul2014';

% calcdaypitch parameters
syl_preDP={'a','c','b'};
syl_targetDP='bbb';

% RUN
[filename_save, all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,{'calcdaypitch'}, {'syl_targetDP',syl_targetDP, 'syl_preDP',syl_preDP,'phraseDP',phrase,'freq_rangeDP',{[3050 3750],[3050 3750],[3050 3750]},...
    'pc_time_windowDP',{[140 230],[140 230],[140 230]},'plot_resultDP',1},1);


% PLOT - using code modified from bk24bk63
% INPUTS:

ADV_dir='/bluejay3/lucas/birds/pu11wh87/all_days_various_calculations/';
load([ADV_dir filename_save]);
% lesion_dates={'10Feb2014-2000'};

% if have WN and/or lesion events (change to 1 to turn on)
plot_baseline=1;
baseline_days=1:3;
plot_WN=0;
plot_lesions=0;
plot_pitch_thresholds=0;

if (0)
    WN_dates={'01Mar2014-1541','15Mar2014-1458','20Mar2014-0029','31Mar2014-0400'};
    WNevents=lt_convert_EventTimes_to_RelTimes(first_day_str,WN_dates);
    WN_switch_days=WNevents.FinalValue;
    lesion_dates={''};
    lesionEvents=lt_convert_EventTimes_to_RelTimes(first_day_str,lesion_dates);
    lesion_days=lesionEvents.FinalValue;
    threshold_switch_RealTimes={'20Mar2014-0029','20Mar2014-1739','21Mar2014-1234','24Mar2014-1651','25Mar2014-1808',...
        '26Mar2014-1347','27Mar2014-0207','27Mar2014-1127','28Mar2014-0103','28Mar2014-1320','30Mar2014-1951'}; % real times for threshold values switches in format e.g. 20Mar2014-1645
    thresh_values=[2583 2615 2639 2706 2685 2675 2665 2680 2720 2710 2720]; % values of threshold corresponding to switch times
    hit_conting='below'; % hit renditions "below" or "above" threshold?
end

% Auto: calc other parameters
syllables=all_days_various.lt_calc_day_pitch{1}.parameters.syllables;
first_day_str=all_days_various.parameters.days{1};
first_day_datenum=all_days_various.parameters.days{3};
num_days=size(all_days_various.lt_calc_day_pitch,2);
NumToAddToAllDays= -first_day_datenum;% this is to make day 1 = day 0 (instead of in the thousands).


% PLOTTING
for j=1:length(syllables);
    hfig(j)=figure; hold on;
    
    % First, individual renditions
    for i=1:num_days; % number of days
        try % in case day has no data
            [~, WithinDayValues]=lt_convert_datenum_to_hour(all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,1)); %convert datenum to hours
            times_days=WithinDayValues.days;
            freq_values=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,2);
            hscatter=scatter(times_days+(i),freq_values,'b','.');
        catch err
            continue
        end
    end
    
    % Second, day means and std
    for i=1:num_days; % number of days
        try
            day_mean=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).mean_FF;
            day_std=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).sd_FF;
            errorbar(i+0.5,day_mean,day_std,'Marker','.','MarkerSize',27,'Color','k');
            text(i+0.4,day_mean+150,datestr(first_day_datenum+i-1,'ddmmmyyyy'));
        catch err
            continue
        end
    end
    
    % Third, format plot
    ylimits=ylim;
    ylim([ylimits(1)-150 ylimits(2)+150])
    title(['Pitch for syllable: ' syllables{j} ' (individual renditions with means + SD)']); ylabel('Pitch (hz)');
    xlabel('Day (e.g. 1.5 = day1, 12pm)');
    ax1=gca;
    ax1_pos=get(ax1,'Position');
    
    % Fourth, Annotating important events (baseline, WN, lesion, Hz
    % threshold) - (had another version greened out also in the bk24
    % analysis file - obsolete).
    
    % Baseline
    if plot_baseline==1;
        baseline_values_temp=[];
        for i=baseline_days;
            baseline_values_temp=[baseline_values_temp all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,2)'];
        end
        baseline_mean=mean(baseline_values_temp);
        baseline_std=std(baseline_values_temp);
        line(xlim, [baseline_mean baseline_mean],'Color','r','LineWidth',0.4); % mean lines
        line(xlim, [baseline_mean+baseline_std baseline_mean+baseline_std],'LineStyle','--','Color',[0.7 0.1 0.1],'LineWidth',0.3); % variance lines
        line(xlim, [baseline_mean-baseline_std baseline_mean-baseline_std],'LineStyle','--','Color', [0.7 0.1 0.1],'LineWidth',0.3);
        line([baseline_days(end)+1 baseline_days(end)+1],ylim,'Color','k','LineWidth',1.8);% line after last baseline day
    end
    
    % WN epochs
    if plot_WN==1;
        disp('adding lines for WN epochs');
        % adding grey boxes for WN days
        ylimits=ylim;
        for i=1:size(WN_switch_days,1)
            if mod(i,2)==1; %i.e. i odd means this is start of WN
                rectangle('Position',[WN_switch_days(i), ylimits(1)+20, WN_switch_days(i+1)-WN_switch_days(i),ylimits(2)-ylimits(1)-40],...
                    'EdgeColor','r')
            end
        end
    end
    
    % Lesion events
    if plot_lesions==1;
        % adding lines for lesions
        for i=1:length(lesion_days);
            line([lesion_days(i) lesion_days(i)], ylim,'Color','g','LineWidth',0.4); % mean lines
        end
    end
    
    % Pitch training thresholds
    if plot_pitch_thresholds==1;
        % adding lines for pitch training WN thresholds
        [EventTimes_thr]= lt_convert_EventTimes_to_RelTimes(first_day_str,threshold_switch_RealTimes); % convert to numerical format
        thresh_start_times=EventTimes_thr.FinalValue;
        
        for i=1:length(thresh_start_times);
            if i==length(thresh_start_times);
                dummy=xlim;
                line([thresh_start_times(i) dummy(2)], [thresh_values(i) thresh_values(i)],'Color','g')
                line([thresh_start_times(i) thresh_start_times(i)], [thresh_values(i-1) thresh_values(i)],'Color','g')
            elseif i==1;
                line([thresh_start_times(i) thresh_start_times(i+1)], [thresh_values(i) thresh_values(i)],'Color','g')
            else
                line([thresh_start_times(i) thresh_start_times(i+1)], [thresh_values(i) thresh_values(i)],'Color','g')
                line([thresh_start_times(i) thresh_start_times(i)], [thresh_values(i-1) thresh_values(i)],'Color','g')
            end
        end
        ax2 = axes('Position',[ax1_pos(1) ax1_pos(2)-0.05 ax1_pos(3) ax1_pos(4)/100],'YGrid','off','Color','none');
    end
end


% DETERMINE NEW THRESHOLD (plot percentiles);
% Input
day=datenum(last_day)-datenum(first_day)+1;

% Run
for  ii=1:length(syllables);
    total_rends=size(all_days_various.lt_calc_day_pitch{day}.FF.(syllables{ii}).time_and_FF,1);
    for i=1:total_rends; % will give percentiles for all possible size rendition windows going back in time
        rends_to_take=total_rends-i+1:total_rends;
        percentiles_AllWindSizes.(syllables{ii})(i,:)=prctile(all_days_various.lt_calc_day_pitch{day}.FF.(syllables{ii}).time_and_FF(rends_to_take,2),[5 30 70 95]);
    end
    
    figure; hold on;
    plot(flipud(percentiles_AllWindSizes.(syllables{ii})(:,2)),'og');
    plot(flipud(percentiles_AllWindSizes.(syllables{ii})(:,3)),'ob');
    xlabel('how far back the beginning of the sample window goes (e.g. most right is closest to the most recent data)');
    ylabel('Pitch (hz)');
    title(['30th and 70th percentiles of pitch: Each point is a recalculation, using different windows; for ' syllables{ii}]);
end

%% 7/7/14 - Putting together code that will be used to analyze data during learnign. here practice on non-leraning days;

% COLLECT PITCH DATA FROM EACH DAY
% uses pitch contour.

% INPUTS
clear all; close all;
phrase = 'SyntaxDepPitchShift';
first_day= '05Jul2014';
last_day= '07Jul2014';

% calcdaypitch parameters
syl_preDP={'a','c',};
syl_targetDP='bb';

% RUN
[filename_save, all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,{'calcdaypitch'}, {'syl_targetDP',syl_targetDP, 'syl_preDP',syl_preDP,'phraseDP',phrase,'freq_rangeDP',{[3050 3750],[3050 3750],[3050 3750]},...
    'pc_time_windowDP',{[140 230],[140 230],[140 230]},'plot_resultDP',1},1);

%% Aside: trying this function out (getting specific motif
% clear all; close all;
% phrase = 'SyntaxDepPitchShift';
% first_day= '05Jul2014';
% last_day= '06Jul2014';
%
% % calcdaypitch parameters
% % syl_preDP={'a','c','b'};
% % syl_targetDP='bbb';
% syl_preDP={'','b'};
% syl_targetDP='Zb';

% lt_all_days_various_calculations_FUNCTION_MOTIF(phrase,first_day,last_day,{'calcdaypitch'}, {'syl_targetDP',syl_targetDP, 'syl_preDP',syl_preDP,'phraseDP',phrase,'freq_rangeDP',{[3050 3750],[3050 3750],[3050 3750]},...
%     'pc_time_windowDP',{[140 230],[140 230],[140 230]},'plot_resultDP',1},1,{'b','ab','','Z'});


%%

% PLOT - using code modified from bk24bk63
% INPUTS:
ADV_dir='/bluejay3/lucas/birds/pu11wh87/all_days_various_calculations/';
load([ADV_dir 'all_days_various_07Jul2014_1951.mat']);
% lesion_dates={'10Feb2014-2000'};

% if have WN and/or lesion events (change to 1 to turn on)
plot_baseline=0;
plot_WN=0;
plot_lesions=0;
plot_pitch_thresholds=0;

if (0)
    baseline_days=1;
    WN_dates={'01Mar2014-1541','15Mar2014-1458','20Mar2014-0029','31Mar2014-0400'};
    WNevents=lt_convert_EventTimes_to_RelTimes(first_day_str,WN_dates);
    WN_switch_days=WNevents.FinalValue;
    lesion_dates={''};
    lesionEvents=lt_convert_EventTimes_to_RelTimes(first_day_str,lesion_dates);
    lesion_days=lesionEvents.FinalValue;
end

% Auto: calc other parameters
syllables=all_days_various.lt_calc_day_pitch{1}.parameters.syllables;
first_day_str=all_days_various.parameters.days{1};
first_day_datenum=all_days_various.parameters.days{3};
num_days=size(all_days_various.lt_calc_day_pitch,2);
NumToAddToAllDays= -first_day_datenum;% this is to make day 1 = day 0 (instead of in the thousands).


% PLOTTING
for j=1:length(syllables);
    figure(j); hold on;
    
    % First, individual renditions
    for i=1:num_days; % number of days
        try % in case day has no data
            [~, WithinDayValues]=lt_convert_datenum_to_hour(all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,1)); %convert datenum to hours
            times_days=WithinDayValues.days;
            freq_values=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,2);
            hscatter=scatter(times_days+(i),freq_values,'b','.');
        catch err
            continue
        end
    end
    
    % Second, day means and std
    for i=1:num_days; % number of days
        try
            day_mean=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).mean_FF;
            day_std=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).sd_FF;
            errorbar(i+0.5,day_mean,day_std,'Marker','.','MarkerSize',27,'Color','k');
            text(i+0.4,day_mean+150,datestr(first_day_datenum+i-1,'ddmmmyyyy'));
        catch err
            continue
        end
    end
    
    % Third, format plot
    ylimits=ylim;
    ylim([ylimits(1)-150 ylimits(2)+150])
    title(['Pitch for syllable: ' syllables{j} ' (individual renditions with means + SD)']); ylabel('Pitch (hz)');
    xlabel('Day (e.g. 1.5 = day1, 12pm)');
    ax1=gca;
    ax1_pos=get(ax1,'Position');
    
    % Fourth, Annotating important events (baseline, WN, lesion, Hz
    % threshold) - (had another version greened out also in the bk24
    % analysis file - obsolete).
    
    % Baseline
    if plot_baseline==1;
        baseline_values_temp=[];
        for i=1:baseline_days;
            baseline_values_temp=[baseline_values_temp all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF(:,2)'];
        end
        baseline_mean=mean(baseline_values_temp);
        baseline_std=std(baseline_values_temp);
        line(xlim, [baseline_mean baseline_mean],'Color','r','LineWidth',0.4); % mean lines
        line(xlim, [baseline_mean+baseline_std baseline_mean+baseline_std],'LineStyle','--','Color',[0.7 0.1 0.1],'LineWidth',0.3); % variance lines
        line(xlim, [baseline_mean-baseline_std baseline_mean-baseline_std],'LineStyle','--','Color', [0.7 0.1 0.1],'LineWidth',0.3);
        line([baseline_days+1 baseline_days+1],ylim,'Color','k','LineWidth',1.8);% line after last baseline day
    end
    
    % WN epochs
    if plot_WN==1;
        disp('adding lines for WN epochs');
        % adding grey boxes for WN days
        ylimits=ylim;
        for i=1:size(WN_switch_days,1)
            if mod(i,2)==1; %i.e. i odd means this is start of WN
                rectangle('Position',[WN_switch_days(i), ylimits(1)+20, WN_switch_days(i+1)-WN_switch_days(i),ylimits(2)-ylimits(1)-40],...
                    'EdgeColor','r')
            end
        end
    end
    
    % Lesion events
    if plot_lesions==1;
        % adding lines for lesions
        for i=1:length(lesion_days);
            line([lesion_days(i) lesion_days(i)], ylim,'Color','g','LineWidth',0.4); % mean lines
        end
    end
    
    % Pitch training thresholds
    if plot_pitch_thresholds==1;
        % adding lines for pitch training WN thresholds
        threshold_switch_RealTimes={'20Mar2014-0029','20Mar2014-1739','21Mar2014-1234','24Mar2014-1651','25Mar2014-1808',...
            '26Mar2014-1347','27Mar2014-0207','27Mar2014-1127','28Mar2014-0103','28Mar2014-1320','30Mar2014-1951'}; % real times for threshold values switches in format e.g. 20Mar2014-1645
        [EventTimes]= lt_convert_EventTimes_to_RelTimes(first_day_str,threshold_switch_RealTimes); % convert to numerical format
        thresh_start_times=EventTimes.FinalValue;
        thresh_values=[2583 2615 2639 2706 2685 2675 2665 2680 2720 2710 2720]; % values of threshold corresponding to switch times
        hit_conting='below'; % hit renditions "below" or "above" threshold?
        
        for i=1:length(thresh_start_times);
            if i==length(thresh_start_times);
                dummy=xlim;
                line([thresh_start_times(i) dummy(2)], [thresh_values(i) thresh_values(i)],'Color','g')
                line([thresh_start_times(i) thresh_start_times(i)], [thresh_values(i-1) thresh_values(i)],'Color','g')
            elseif i==1;
                line([thresh_start_times(i) thresh_start_times(i+1)], [thresh_values(i) thresh_values(i)],'Color','g')
            else
                line([thresh_start_times(i) thresh_start_times(i+1)], [thresh_values(i) thresh_values(i)],'Color','g')
                line([thresh_start_times(i) thresh_start_times(i)], [thresh_values(i-1) thresh_values(i)],'Color','g')
            end
        end
        ax2 = axes('Position',[ax1_pos(1) ax1_pos(2)-0.05 ax1_pos(3) ax1_pos(4)/100],'YGrid','off','Color','none');
    end
end


%% 7/7/14 - Start analysis for Synt Dep Pitch shift.  Below is everything done for CP seq up to now.  there is also another analysis file with stuff below.

%%
% %% 5/15/14, Adult, after end WN and post
% con_div = 'divergence';
% all_days_all_analysis=lt_all_days_PLOT_AllTrans([1 2 3], '15May2014_1809', con_div);
%
% con_div = 'convergence';
% all_days_all_analysis=lt_all_days_PLOT_AllTrans([1 2 3], '15May2014_1809', con_div);
%
% lt_all_days_PLOT_AllTrans_specific_trans('divergence',1,'','15May2014_1809')
% lt_all_days_PLOT_AllTrans_specific_trans('convergence',1,'','15May2014_1809')
%
%
% % HIT RATES
% % GETTING WN HIT RATES
% Ind_A='15May2014_1839';
% lt_load_all_days_all_analysis(Ind_A);
% syllables=all_days_all_analysis.parameters.WN_trig.trig_syl;
% for i=1:length(syllables);
%     figure; hold on; title([syllables(i) ' green= WN hits/Labels; black= FalsePos/TotalWN'])
%     for j=1:length(all_days_all_analysis.data); % num of days
%         try
%             scatter(j,all_days_all_analysis.data{j}.WN_hit_rate.all_songs.(syllables(i)).hits_divide_labels,'g','MarkerFaceColor','g');
%             scatter(j,all_days_all_analysis.data{j}.WN_hit_rate.all_songs.(syllables(i)).FalsePos_divide_TotalWN,'k','MarkerFaceColor','k')
%             %         scatter(j,all_days_all_analysis.data{j}.WN_hit_rate.all_songs.a.FalsePos/all_days_all_analysis.data{j}.WN_hit_rate.all_songs.a.hits_labels_allhits(1),'b','MarkerFaceColor','b')
%         catch err
%         end
%     end
% end
%
%
% %% 4/28 ADULT, analysis preWN
% con_div = 'divergence';
% all_days_all_analysis=lt_all_days_PLOT_AllTrans([1 2 3], '28Apr2014_1419', con_div);
%
% con_div = 'convergence';
% all_days_all_analysis=lt_all_days_PLOT_AllTrans([1 2 3], '28Apr2014_1419', con_div);
%
%
% %---------------------------------------------------------------------------------
% %PLOT single divergent or convergent transition over days (load all_days... first)
% % DIVERGENCE
% clear all; close all;
% load /bluejay3/lucas/birds/pu11wh87/all_days_all_analysis/all_days_all_analysis_28Apr2014_1419_adult_AllTrans.mat
%
% syl1='a';
% con_div = 'divergence';
%
% % syl2='b';
% syl2_list=all_days_all_analysis.data{1}.all_songs.all_trans.syllable_list;
% num_syl=length(syl2_list);
% % make syl colors
% syl_color=lt_make_plot_colors(length(syl2_list));
%
% figure;  hold on; title([con_div ' transition probability from ' syl1 ' to (see legend): ']);
% for k=1:length(syl2_list);
%     syl2=syl2_list{k};
%     dummy=[];
%     for i=1:size(all_days_all_analysis.data,2);
%         try
%             dummy=[dummy; [i all_days_all_analysis.data{i}.all_songs.all_trans.(syl1).transition_to_.(syl2).relative_fraction_of_trans]];
%         catch err
%             continue
%         end
%     end
% %     plot(dummy,'Marker','o','Color',syl_color{k},'MarkerEdgeColor','black','MarkerFaceColor',syl_color{k},'MarkerSize',8);
%     hplot(k)=plot(dummy(:,1), dummy(:,2),'Marker','o','Color',syl_color{k},'MarkerEdgeColor','black','MarkerFaceColor',syl_color{k},'MarkerSize',8);
% end
% legend(hplot,[syl2_list]);
% ylim([0 1]); xlabel('days'); ylabel('probability of transition')
%
%
% % Convergence
% %PLOT single divergent or convergent transition over days (run the above
% %function first)
% con_div = 'convergence';
%
% syl2='b';
% syl1_list=all_days_all_analysis.data{1}.all_songs.all_trans.syllable_list;
% num_syl=length(syl1_list);
%
% % make syl colors
% syl_color=lt_make_plot_colors(length(syl1_list));
%
% figure;  hold on; title(['Convergence transition probability to ' syl2 ' from to (see legend): ']);
% for k=1:length(syl1_list);
%     syl1=syl1_list{k};
%     dummy = [];
%     for i=1:size(all_days_all_analysis.data,2);
%         try
%             dummy = [dummy; [i all_days_all_analysis.data{i}.all_songs.all_trans.convergent_to.(syl2).from.(syl1).fraction_of_trans]];
%         catch err
%             continue
%         end
%     end
%     hplot2(k)= plot(dummy(:,1), dummy(:,2),'Marker','o','Color',syl_color{k},'MarkerEdgeColor','black','MarkerFaceColor',syl_color{k},'MarkerSize',8);
% end
% legend(hplot2,[syl1_list]);
% ylim([0 1]); xlabel('days'); ylabel('probability of transition')
%
%
%
% %% getting 1) hit rates and 2) transitions from 2/26 to 3/20
% clear all; close all;
% load /bluejay3/lucas/birds/pu11wh87/all_days_all_analysis/all_days_all_analysis_24Mar2014_2328_CPseq_AllTrans_WNtrigLabel.mat
%
% % ---------------------------------------------------
% % GETTING WN HIT RATES
% syllables=all_days_all_analysis.parameters.WN_trig.trig_syl;
% for i=1:length(syllables);
%     figure; hold on; title([syllables(i) ' green= WN hits/Labels; black= FalsePos/TotalWN'])
%     for j=1:length(all_days_all_analysis.data); % num of days
%         try
%             scatter(j,all_days_all_analysis.data{j}.WN_hit_rate.all_songs.(syllables(i)).hits_divide_labels,'g','MarkerFaceColor','g');
%             scatter(j,all_days_all_analysis.data{j}.WN_hit_rate.all_songs.(syllables(i)).FalsePos_divide_TotalWN,'k','MarkerFaceColor','k')
%             %         scatter(j,all_days_all_analysis.data{j}.WN_hit_rate.all_songs.a.FalsePos/all_days_all_analysis.data{j}.WN_hit_rate.all_songs.a.hits_labels_allhits(1),'b','MarkerFaceColor','b')
%         catch err
%         end
%     end
% end
%
% % ------------------------------------------------------
% % PLOT transition matrices and difference matrices for all days
% con_div = 'divergence';
% all_days_all_analysis=lt_all_days_PLOT_AllTrans([1 2 3], '24Mar2014_2328', con_div);
%
% con_div = 'convergence';
% all_days_all_analysis=lt_all_days_PLOT_AllTrans([1 2 3], '24Mar2014_2328', con_div);
%
%
% %---------------------------------------------------------------------------------
% %PLOT single divergent or convergent transition over days (load all_days... first)
% % DIVERGENCE
% syl1='a';
% con_div = 'divergence';
%
% % syl2='b';
% syl2_list=all_days_all_analysis.data{1}.all_songs.all_trans.syllable_list;
% num_syl=length(syl2_list);
% % make syl colors
% syl_color=lt_make_plot_colors(length(syl2_list));
%
% figure;  hold on; title([con_div ' transition probability from ' syl1 ' to (see legend): ']);
% for k=1:length(syl2_list);
%     syl2=syl2_list{k};
%     dummy=[];
%     for i=1:size(all_days_all_analysis.data,2);
%         try
%             dummy=[dummy; [i all_days_all_analysis.data{i}.all_songs.all_trans.(syl1).transition_to_.(syl2).relative_fraction_of_trans]];
%         catch err
%             continue
%         end
%     end
% %     plot(dummy,'Marker','o','Color',syl_color{k},'MarkerEdgeColor','black','MarkerFaceColor',syl_color{k},'MarkerSize',8);
%     hplot(k)=plot(dummy(:,1), dummy(:,2),'Marker','o','Color',syl_color{k},'MarkerEdgeColor','black','MarkerFaceColor',syl_color{k},'MarkerSize',8);
% end
% legend(hplot,[syl2_list]);
% ylim([0 1]); xlabel('days'); ylabel('probability of transition')
%
%
% % Convergence
% %PLOT single divergent or convergent transition over days (run the above
% %function first)
% con_div = 'convergence';
%
% syl2='b';
% syl1_list=all_days_all_analysis.data{1}.all_songs.all_trans.syllable_list;
% syl1_list{end+1}='k'; % k was not present at all in baseline, so is not in the list for day 1
% num_syl=length(syl1_list);
%
% % make syl colors
% syl_color=lt_make_plot_colors(length(syl1_list));
%
% figure;  hold on; title(['Convergence transition probability to ' syl2 ' from to (see legend): ']);
% for k=1:length(syl1_list);
%     syl1=syl1_list{k};
%     dummy = [];
%     for i=1:size(all_days_all_analysis.data,2);
%         try
%             dummy = [dummy; [i all_days_all_analysis.data{i}.all_songs.all_trans.convergent_to.(syl2).from.(syl1).fraction_of_trans]];
%         catch err
%             continue
%         end
%     end
%     hplot2(k)= plot(dummy(:,1), dummy(:,2),'Marker','o','Color',syl_color{k},'MarkerEdgeColor','black','MarkerFaceColor',syl_color{k},'MarkerSize',8);
% end
% legend(hplot2,[syl1_list]);
% ylim([0 1]); xlabel('days'); ylabel('probability of transition')
%
%
% % BELOW: had expanded code here, but condensed all into the functions
% % listed above.  Ignroe the commented stuff below.
%
%
%     % -------------------------------------------------------------
%     % GETTING TRANSITION PROBABILITIES
%
%
%     % % ---------------------------------------------------
%     % % GETTING WN HIT RATES
%     % syllables=all_days_all_analysis.parameters.WN_trig.trig_syl;
%     % for i=1:length(syllables);
%     %     figure; hold on; title([syllables(i) ' green= WNhits/Labels; black= FalsePos/TotalWN'])
%     %     for j=1:length(all_days_all_analysis.data); % num of days
%     %         try
%     %             scatter(j,all_days_all_analysis.data{j}.WN_hit_rate.all_songs.(syllables(i)).hits_divide_labels,'g','MarkerFaceColor','g');
%     %             scatter(j,all_days_all_analysis.data{j}.WN_hit_rate.all_songs.(syllables(i)).FalsePos_divide_TotalWN,'k','MarkerFaceColor','k')
%     %             %         scatter(j,all_days_all_analysis.data{j}.WN_hit_rate.all_songs.a.FalsePos/all_days_all_analysis.data{j}.WN_hit_rate.all_songs.a.hits_labels_allhits(1),'b','MarkerFaceColor','b')
%     %         catch err
%     %         end
%     %     end
%     % end
%     %
%
%     % %% -------------------------------------------------------------
%     % % GETTING TRANSITION PROBABILITIES
%     % close all
%     % clear all
%     % load all_days_all_analysis_24Mar2014_2328_CPseq_AllTrans_WNtrigLabel.mat
%     %
%     % % FIRST, plotting heat map of change (rel to baseline) for every sun
%     % % transition, across days.
%     %
%     % % Input parameters
%     % baseline_days=[1 2 3]; %in 1,2,3,... indices, not days with gaps.
%     %
%     % % first, figure out the syllables that were sang every day.
%     % days_with_analysis=[];
%     % for i=1:size(all_days_all_analysis.data,2);
%     %     try
%     %         if ~isempty(all_days_all_analysis.data{i}.all_songs.all_trans);
%     %             days_with_analysis=[days_with_analysis i];
%     %         end
%     %     catch err
%     %         continue
%     %     end
%     % end
%     %
%     % num_of_days=length(days_with_analysis);
%     %
%     % for j=1:num_of_days;
%     %     syl_labels_concatenated{j}=all_days_all_analysis.data{days_with_analysis(j)}.all_songs.all_trans.summary.syl_labels_in_order;
%     % end
%     %
%     % [common_syls syl_indices]=mintersect_array(syl_labels_concatenated); % find common syls and their indices in each day
%     %
%     % % get baseline
%     % clear dummy
%     % for j=1:length(baseline_days);
%     %     dummy(:,:,j)=all_days_all_analysis.data{baseline_days(j)}.all_songs.all_trans.summary.divergence.matrix_of_fractions(syl_indices{j},syl_indices{j});
%     % end
%     % all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.baseline=mean(dummy,3);
%     %
%     %
%     % for i=1:num_of_days;
%     %     all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.all_days_incl_pre(:,:,days_with_analysis(i))=...
%     %         all_days_all_analysis.data{days_with_analysis(i)}.all_songs.all_trans.summary.divergence.matrix_of_fractions(syl_indices{i},syl_indices{i})...
%     %         -all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.baseline;
%     % end
%     %
%     % % convert from fraction to percent
%     % all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.all_days_incl_pre=...
%     %     100*all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.all_days_incl_pre
%     % all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.baseline=...
%     %     100*all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.baseline;
%     %
%     % % plot
%     % num_figures=ceil((num_of_days+1)/9); % +1 becuase have a baseline mean figure as well.
%     % for i=1:num_figures;
%     %     if i==num_figures;
%     %         row_plots(i)=ceil((num_of_days+1-(i-1)*9)/3);
%     %         col_plots(i)=ceil((num_of_days+1-(i-1)*9)/row_plots(i));
%     %     else
%     %         row_plots(i)=3;
%     %         col_plots(i)=3;
%     %     end
%     % end
%     %
%     % %
%     % % if num_of_days<6;
%     % %     row_plots(1)=min(ceil(num_of_days+1)/2,4);
%     % %     num_figures=1;
%     % %     col_plots=ceil((num_of_days+1)/row_plots);
%     % % elseif num_of_days>5 && num_of_days<9;
%     % %     row_plots(1)=4;
%     % %     num_figures=1;
%     % %     col_plots=ceil((num_of_days+1)/row_plots);
%     % % elseif num_of_days>8 && num_of_days<18;
%     % %     num_figures=2;
%     % %     row_plots(1)=4;
%     % %     row_plots(2)=ceil((num_of_days-8)/3);
%     % %     col_plots(1)=ceil((num_of_days+1)/row_plots(1));
%     % %     col_plots(2)=ceil((num_of_days+1)/row_plots(2));
%     % % end
%     %
%     % counter = 1; % count goes up 1 after each day plotted
%     % while counter<num_of_days+1;
%     %     figure_num=ceil(counter/9);
%     %     figure(figure_num); hold on;
%     %
%     %     syl_num=size(common_syls,2);
%     %     syl_labels=common_syls;
%     %
%     %     if counter==1; %only plot baseline for 1st figure
%     %         %PLOT THE BASELINE FRACTION MATRIX
%     %         subplot(col_plots(figure_num),row_plots(figure_num),1);
%     %         syl_mat = all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.baseline;
%     %         imagesc(syl_mat);
%     %         colormap(flipud(gray))
%     %         textStrings = num2str(syl_mat(:),'%0.1f');
%     %         textStrings = strtrim(cellstr(textStrings));
%     %         [x,y]=meshgrid(1:syl_num);
%     %         hStrings = text(x(:),y(:),textStrings(:), 'HorizontalAlignment','center');
%     %         midValue = mean(get(gca,'CLim'));
%     %         textColors = repmat(syl_mat(:) > midValue,1,3);
%     %         set(hStrings,{'Color'},num2cell(textColors,2));
%     %         set(gca,'XTick',1:syl_num,'XTickLabel',syl_labels, 'YTick',1:syl_num,...
%     %             'YTickLabel',syl_labels, 'TickLength',[0 0]);
%     %         ylabel('transition from:')
%     %         xlabel('transition to:')
%     %         title('\bf Baseline fractions (mean)');
%     %         freezeColors
%     %         counter=2;
%     %     end
%     %
%     %     % determine a common color scale across all days - normalize by max element
%     %     % out of entire matrix
%     %     max_value=max(max(max(all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.all_days_incl_pre)));
%     %     min_value=min(min(min(all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.all_days_incl_pre)));
%     %     absolute_max=max(min_value,max_value);
%     %
%     %     % grayscale=[hot(100); flipud(cool(100))];
%     %     % grayscale=cool(200)
%     %
%     %     colorscale = [flipud([0.01:0.01:1; zeros(1,100); zeros(1,100)]'); [zeros(1,100); zeros(1,100); 0.01:0.01:1]'];
%     %
%     %     %PLOT THE DIFFERENCE MATRICES
%     %     i=counter-(figure_num-1)*9; % index for specific figure
%     %     j=counter-1; %index out of all days with data
%     %         subplot(col_plots(figure_num),row_plots(figure_num),i);
%     %         syl_mat = all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.all_days_incl_pre(:,:,days_with_analysis(j));
%     %         max_value_local=max(max(all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.all_days_incl_pre(:,:,days_with_analysis(j))));
%     %         min_value_local=min(min(all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.all_days_incl_pre(:,:,days_with_analysis(j))));
%     %         imagesc(syl_mat,[-absolute_max absolute_max]);
%     %         %     colormap(grayscale(50+floor(min_value/2):50+ceil(max_value/2),:,:)); colorbar;
%     %         colormap(colorscale);
%     %         %     if i==num_of_days;
%     %         %         h_bar=colorbar;
%     %         %     end
%     %         textStrings = num2str(syl_mat(:),'%0.0f');
%     %         textStrings = strtrim(cellstr(textStrings));
%     %         [x,y]=meshgrid(1:syl_num);
%     %         hStrings = text(x(:),y(:),textStrings(:), 'HorizontalAlignment','center');
%     %         %     midValue = mean(get(gca,'CLim'));
%     %         textColors = repmat(syl_mat(:) >= 10,1,3)+repmat(syl_mat(:) <= -10,1,3); %only put in text of those that are past + or - 10.
%     %         textColors_weak=0.35.*repmat(syl_mat(:) <10 & syl_mat(:) > -10,1,3);
%     %         textColors=textColors+textColors_weak;
%     %
%     %         set(hStrings,{'Color'},num2cell(textColors,2));
%     %         %     set(hStrings,{'Color'},{'w'})
%     %         set(gca,'XTick',1:syl_num,'XTickLabel',syl_labels, 'YTick',1:syl_num,...
%     %             'YTickLabel',syl_labels, 'TickLength',[0 0]);
%     %         ylabel('transition from:')
%     %         xlabel('transition to:')
%     %         title(['day # ' num2str(days_with_analysis(j)) ', ' all_days_all_analysis.data{days_with_analysis(j)}.date]);
%     %         freezeColors
%     %
%     %
%     %     if counter == num_of_days+1;
%     %     % make one colorbar
%     %     ax=gca;
%     %     pos=get(gca,'pos'); % to arrange colorbar relative to the last plot
%     %     % set(gca,'pos',[pos(1) pos(2) pos(3)*0.95 pos(4)]);
%     %     % pos=get(gca,'pos');
%     %     % hc=colorbar('position',[pos(1) pos(2) pos(3) 0.5*pos4]);
%     %     hc=colorbar('position',[pos(1)+1.2*pos(3) pos(2)+(0.2*pos(4)) 0.05*pos(3) 0.7*pos(4)]);
%     %     % hc=colorbar('location','eastoutside')
%     %     % set(hc,'xaxisloc','top');
%     %
%     %
%     %     % give a general title
%     %     ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
%     %     text(0.5, 1,['\bf Divergent transitions: difference from baseline (first ' num2str(max(baseline_days)) ' days)'],'HorizontalAlignment'...
%     %         ,'center','VerticalAlignment', 'top')
%     %     end
%     %     counter = counter+1;
%     % end
%     %
%     % %% ----------------------------------------------------------------
%     % % FIRST - part B - CONVERGENCE
%     % % get baseline
%     % close all
%     % clear all
%     % load all_days_all_analysis_24Mar2014_2328_CPseq_AllTrans_WNtrigLabel
%     %
%     % % Input parameters
%     % baseline_days=[1 2 3]; %in 1,2,3,... indices, not days with gaps.
%     %
%     % % FIRST, plotting heat map of change (rel to baseline) for every sun
%     % % transition, across days.
%     %
%     % % Figure out the syllables that were sang every day.
%     % days_with_analysis=[];
%     % for i=1:size(all_days_all_analysis.data,2);
%     %     try
%     %         if ~isempty(all_days_all_analysis.data{i}.all_songs.all_trans);
%     %             days_with_analysis=[days_with_analysis i];
%     %         end
%     %     catch err
%     %         continue
%     %     end
%     % end
%     %
%     % num_of_days=length(days_with_analysis);
%     %
%     % for j=1:num_of_days;
%     %     syl_labels_concatenated{j}=all_days_all_analysis.data{days_with_analysis(j)}.all_songs.all_trans.summary.syl_labels_in_order;
%     % end
%     %
%     % [common_syls syl_indices]=mintersect_array(syl_labels_concatenated); % find common syls and their indices in each day
%     %
%     %
%     % for j=1:length(baseline_days);
%     %     dummy(:,:,j)=all_days_all_analysis.data{baseline_days(j)}.all_songs.all_trans.summary.convergence.matrix_of_fractions(syl_indices{j},syl_indices{j});
%     % end
%     % all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.baseline=mean(dummy,3);
%     %
%     %
%     % for i=1:num_of_days;
%     %     all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.all_days_incl_pre(:,:,days_with_analysis(i))=...
%     %         all_days_all_analysis.data{days_with_analysis(i)}.all_songs.all_trans.summary.convergence.matrix_of_fractions(syl_indices{i},syl_indices{i})...
%     %         -all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.baseline;
%     % end
%     %
%     % % convert from fraction to percent
%     % all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.all_days_incl_pre=...
%     %     100*all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.all_days_incl_pre
%     % all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.baseline=...
%     %     100*all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.baseline;
%     %
%     % % plot
%     % num_figures=ceil((num_of_days+1)/9); % +1 becuase have a baseline mean figure as well.
%     % for i=1:num_figures;
%     %     if i==num_figures;
%     %         row_plots(i)=ceil((num_of_days+1-(i-1)*9)/3);
%     %         col_plots(i)=ceil((num_of_days+1-(i-1)*9)/row_plots(i));
%     %     else
%     %         row_plots(i)=3;
%     %         col_plots(i)=3;
%     %     end
%     % end
%     %
%     % %
%     % % if num_of_days<6;
%     % %     row_plots(1)=min(ceil(num_of_days+1)/2,4);
%     % %     num_figures=1;
%     % %     col_plots=ceil((num_of_days+1)/row_plots);
%     % % elseif num_of_days>5 && num_of_days<9;
%     % %     row_plots(1)=4;
%     % %     num_figures=1;
%     % %     col_plots=ceil((num_of_days+1)/row_plots);
%     % % elseif num_of_days>8 && num_of_days<18;
%     % %     num_figures=2;
%     % %     row_plots(1)=4;
%     % %     row_plots(2)=ceil((num_of_days-8)/3);
%     % %     col_plots(1)=ceil((num_of_days+1)/row_plots(1));
%     % %     col_plots(2)=ceil((num_of_days+1)/row_plots(2));
%     % % end
%     %
%     % counter = 1; % count goes up 1 after each day plotted
%     % while counter<=num_of_days+1;
%     %     figure_num=ceil(counter/9);
%     %     figure(figure_num); hold on;
%     %
%     %     syl_num=size(common_syls,2);
%     %     syl_labels=common_syls;
%     %
%     %     if counter==1; %only plot baseline for 1st figure
%     %         %PLOT THE BASELINE FRACTION MATRIX
%     %         subplot(col_plots(figure_num),row_plots(figure_num),1);
%     %         syl_mat = all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.baseline;
%     %         imagesc(syl_mat);
%     %         colormap(flipud(gray))
%     %         textStrings = num2str(syl_mat(:),'%0.0f');
%     %         textStrings = strtrim(cellstr(textStrings));
%     %         [x,y]=meshgrid(1:syl_num);
%     %         hStrings = text(x(:),y(:),textStrings(:), 'HorizontalAlignment','center');
%     %         midValue = mean(get(gca,'CLim'));
%     %         textColors = repmat(syl_mat(:) > midValue,1,3);
%     %         set(hStrings,{'Color'},num2cell(textColors,2));
%     %         set(gca,'XTick',1:syl_num,'XTickLabel',syl_labels, 'YTick',1:syl_num,...
%     %             'YTickLabel',syl_labels, 'TickLength',[0 0]);
%     %         ylabel('transition from:')
%     %         xlabel('transition to:')
%     %         title('\bf Baseline fractions (mean)');
%     %         freezeColors
%     %         counter=2;
%     %     end
%     %
%     %     % determine a common color scale across all days - normalize by max element
%     %     % out of entire matrix
%     %     max_value=max(max(max(all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.all_days_incl_pre)));
%     %     min_value=min(min(min(all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.all_days_incl_pre)));
%     %     absolute_max=max(min_value,max_value);
%     %
%     %     % grayscale=[hot(100); flipud(cool(100))];
%     %     % grayscale=cool(200)
%     %
%     %     colorscale = [flipud([0.01:0.01:1; zeros(1,100); zeros(1,100)]'); [zeros(1,100); zeros(1,100); 0.01:0.01:1]'];
%     %
%     %     %PLOT THE DIFFERENCE MATRICES
%     %     i=counter-(figure_num-1)*9; % index for specific figure
%     %     j=counter-1; %index out of all days with data
%     %         subplot(col_plots(figure_num),row_plots(figure_num),i);
%     %         syl_mat = all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.all_days_incl_pre(:,:,days_with_analysis(j));
%     %         max_value_local=max(max(all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.all_days_incl_pre(:,:,days_with_analysis(j))));
%     %         min_value_local=min(min(all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.all_days_incl_pre(:,:,days_with_analysis(j))));
%     %         imagesc(syl_mat,[-absolute_max absolute_max]);
%     %         %     colormap(grayscale(50+floor(min_value/2):50+ceil(max_value/2),:,:)); colorbar;
%     %         colormap(colorscale);
%     %         %     if i==num_of_days;
%     %         %         h_bar=colorbar;
%     %         %     end
%     %         textStrings = num2str(syl_mat(:),'%0.0f');
%     %         textStrings = strtrim(cellstr(textStrings));
%     %         [x,y]=meshgrid(1:syl_num);
%     %         hStrings = text(x(:),y(:),textStrings(:), 'HorizontalAlignment','center');
%     %         %     midValue = mean(get(gca,'CLim'));
%     %         textColors = repmat(syl_mat(:) >= 10,1,3)+repmat(syl_mat(:) <= -10,1,3); %only put in text of those that are past + or - 10.
%     %         textColors_weak=0.35.*repmat(syl_mat(:) <10 & syl_mat(:) > -10,1,3);
%     %         textColors=textColors+textColors_weak;
%     %
%     %         set(hStrings,{'Color'},num2cell(textColors,2));
%     % %         set(hStrings,{'Color'},num2cell(textColors_weak,2));
%     %
%     %         %     set(hStrings,{'Color'},{'w'})
%     %         set(gca,'XTick',1:syl_num,'XTickLabel',syl_labels, 'YTick',1:syl_num,...
%     %             'YTickLabel',syl_labels, 'TickLength',[0 0]);
%     %         ylabel('transition from:')
%     %         xlabel('transition to:')
%     %         title(['day # ' num2str(days_with_analysis(j)) ', ' all_days_all_analysis.data{days_with_analysis(j)}.date]);
%     %         freezeColors
%     %
%     %
%     %     if counter == num_of_days+1;
%     %     % make one colorbar
%     %     ax=gca;
%     %     pos=get(gca,'pos'); % to arrange colorbar relative to the last plot
%     %     % set(gca,'pos',[pos(1) pos(2) pos(3)*0.95 pos(4)]);
%     %     % pos=get(gca,'pos');
%     %     % hc=colorbar('position',[pos(1) pos(2) pos(3) 0.5*pos4]);
%     %     hc=colorbar('position',[pos(1)+1.2*pos(3) pos(2)+(0.2*pos(4)) 0.05*pos(3) 0.7*pos(4)]);
%     %     % hc=colorbar('location','eastoutside')
%     %     % set(hc,'xaxisloc','top');
%     %
%     %
%     %     % give a general title
%     %     ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
%     %     text(0.5, 1,['\bf Divergent transitions: difference from baseline (first ' num2str(max(baseline_days)) ' days)'],'HorizontalAlignment'...
%     %         ,'center','VerticalAlignment', 'top')
%     %     end
%     %     counter = counter+1;
%     % end
%     %
%     %
%     % %% SECOND, plot transition matrices for all days.
%     % %% SECOND, plot transition matrices for all days. (instead of difference matrices)\
%     % % DIVERGENCE
%     %
%     % close all
%     % clear all
%     % load all_days_all_analysis_24Mar2014_2328_CPseq_AllTrans_WNtrigLabel
%     %
%     % % Input parameters
%     % baseline_days=[1 2 3]; %in 1,2,3,... indices, not days with gaps.
%     %
%     % % Figure out the syllables that were sang every day.
%     % days_with_analysis=[];
%     % for i=1:size(all_days_all_analysis.data,2);
%     %     try
%     %         if ~isempty(all_days_all_analysis.data{i}.all_songs.all_trans);
%     %             days_with_analysis=[days_with_analysis i];
%     %         end
%     %     catch err
%     %         continue
%     %     end
%     % end
%     %
%     % num_of_days=length(days_with_analysis);
%     %
%     % % concatenate syl labels and data matrices
%     % for j=1:num_of_days;
%     %     syl_labels_concatenated{j}=all_days_all_analysis.data{days_with_analysis(j)}.all_songs.all_trans.summary.syl_labels_in_order;
%     % end
%     %
%     % for i=1:num_of_days;
%     %     syl_labels{i}=all_days_all_analysis.data{days_with_analysis(i)}.all_songs.all_trans.summary.syl_labels_in_order;
%     %     all_days_all_analysis.PLOT.all_trans.divergence.fractions{days_with_analysis(i)}=...
%     %         all_days_all_analysis.data{days_with_analysis(i)}.all_songs.all_trans.summary.divergence.matrix_of_fractions;
%     %     all_days_all_analysis.PLOT.all_trans.divergence.fractions{days_with_analysis(i)}=100.*...
%     %         all_days_all_analysis.PLOT.all_trans.divergence.fractions{days_with_analysis(i)}; %convert from fraction to percent
%     % end
%     %
%     % % PLOT THE TRANSITION MATRICES
%     %
%     % num_figures=ceil((num_of_days)/9);
%     % for i=1:num_figures;
%     %     if i==num_figures;
%     %         row_plots(i)=ceil((num_of_days-(i-1)*9)/3);
%     %         col_plots(i)=ceil((num_of_days-(i-1)*9)/row_plots(i));
%     %     else
%     %         row_plots(i)=3;
%     %         col_plots(i)=3;
%     %     end
%     % end
%     %
%     % counter = 1; % count goes up 1 after each day plotted
%     % while counter<=num_of_days;
%     %     figure_num=ceil(counter/9);
%     %     figure(figure_num); hold on;
%     %
%     %
%     %
%     %
%     %     i=counter-(figure_num-1)*9; % index for specific figure
%     %     j=counter; %index out of all days with data (same as i, but i resets with each figure)
%     %     syl_num=size(syl_labels{j},2);
%     %
%     %         subplot(col_plots(figure_num),row_plots(figure_num),i);
%     %         syl_mat = all_days_all_analysis.PLOT.all_trans.divergence.fractions{days_with_analysis(j)};
%     % %         max_value_local=max(max(all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.all_days_incl_pre(:,:,days_with_analysis(j))));
%     % %         min_value_local=min(min(all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.all_days_incl_pre(:,:,days_with_analysis(j))));
%     %         imagesc(syl_mat,[0 100]);
%     %         colormap(flipud(gray))
%     %         textStrings = num2str(syl_mat(:),'%0.0f');
%     %         textStrings = strtrim(cellstr(textStrings));
%     %         [x,y]=meshgrid(1:syl_num);
%     %         hStrings = text(x(:),y(:),textStrings(:), 'HorizontalAlignment','center');
%     %         midValue = mean(get(gca,'CLim'));
%     %         textColors = repmat(syl_mat(:) > midValue,1,3);
%     %         set(hStrings,{'Color'},num2cell(textColors,2));
%     %         set(gca,'XTick',1:syl_num,'XTickLabel',syl_labels{j}, 'YTick',1:syl_num,...
%     %             'YTickLabel',syl_labels{j}, 'TickLength',[0 0]);
%     %         ylabel('transition from:')
%     %         xlabel('transition to:')
%     %         title('\bf Baseline fractions (mean)');
%     %         freezeColors
%     %
%     %         set(gca,'XTick',1:syl_num,'XTickLabel',syl_labels{j}, 'YTick',1:syl_num,...
%     %             'YTickLabel',syl_labels{j}, 'TickLength',[0 0]);
%     %         ylabel('transition from:')
%     %         xlabel('transition to:')
%     %         title(['day # ' num2str(days_with_analysis(j)) ', ' all_days_all_analysis.data{days_with_analysis(j)}.date]);
%     %         freezeColors
%     %
%     %
%     %         if counter == num_of_days;
%     %             % make one colorbar
%     %             ax=gca;
%     %             pos=get(gca,'pos'); % to arrange colorbar relative to the last plot
%     %             hc=colorbar('position',[pos(1)+1.2*pos(3) pos(2)+(0.2*pos(4)) 0.05*pos(3) 0.7*pos(4)]);
%     %             % hc=colorbar('location','eastoutside')
%     %             % set(hc,'xaxisloc','top');
%     %
%     %
%     %             % give a general title
%     %             ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
%     %             text(0.5, 1,['\bf Divergent transition matrices for each day'],'HorizontalAlignment'...
%     %                 ,'center','VerticalAlignment', 'top')
%     %         end
%     %         counter = counter+1;
%     % end
%     %
%     % % all_days_all_analysis.PLOT.all_trans.difference_matrices.common_syls=common_syls;
%     % % all_days_all_analysis.PLOT.all_trans.difference_matrices.syl_indices=syl_indices;
%     %
%     % % save
%     % % cd PLOT/
%     % % save('all_days_all_analysis',all_days_all_analysis
%     %
%     %
%     %
%     % %% -----------------------------------------------------------------
%     % % TRANSITION MATRICES, but for convergence
%     % close all
%     % clear all
%     % load all_days_all_analysis_24Mar2014_2328_CPseq_AllTrans_WNtrigLabel
%     %
%     % % Input parameters
%     % baseline_days=[1 2 3]; %in 1,2,3,... indices, not days with gaps.
%     %
%     % % Figure out the syllables that were sang every day.
%     % days_with_analysis=[];
%     % for i=1:size(all_days_all_analysis.data,2);
%     %     try
%     %         if ~isempty(all_days_all_analysis.data{i}.all_songs.all_trans);
%     %             days_with_analysis=[days_with_analysis i];
%     %         end
%     %     catch err
%     %         continue
%     %     end
%     % end
%     %
%     % num_of_days=length(days_with_analysis);
%     %
%     % % concatenate syl labels and data matrices
%     % for j=1:num_of_days;
%     %     syl_labels_concatenated{j}=all_days_all_analysis.data{days_with_analysis(j)}.all_songs.all_trans.summary.syl_labels_in_order;
%     % end
%     %
%     % for i=1:num_of_days;
%     %     syl_labels{i}=all_days_all_analysis.data{days_with_analysis(i)}.all_songs.all_trans.summary.syl_labels_in_order;
%     %     all_days_all_analysis.PLOT.all_trans.convergence.fractions{days_with_analysis(i)}=...
%     %         all_days_all_analysis.data{days_with_analysis(i)}.all_songs.all_trans.summary.convergence.matrix_of_fractions;
%     %     all_days_all_analysis.PLOT.all_trans.convergence.fractions{days_with_analysis(i)}=100.*...
%     %         all_days_all_analysis.PLOT.all_trans.convergence.fractions{days_with_analysis(i)}; %convert from fraction to percent
%     % end
%     %
%     % % PLOT THE TRANSITION MATRICES
%     %
%     % num_figures=ceil((num_of_days)/9);
%     % for i=1:num_figures;
%     %     if i==num_figures;
%     %         row_plots(i)=ceil((num_of_days-(i-1)*9)/3);
%     %         col_plots(i)=ceil((num_of_days-(i-1)*9)/row_plots(i));
%     %     else
%     %         row_plots(i)=3;
%     %         col_plots(i)=3;
%     %     end
%     % end
%     %
%     % counter = 1; % count goes up 1 after each day plotted
%     % while counter<=num_of_days;
%     %     figure_num=ceil(counter/9);
%     %     figure(figure_num); hold on;
%     %
%     %
%     %
%     %
%     %     i=counter-(figure_num-1)*9; % index for specific figure
%     %     j=counter; %index out of all days with data (same as i, but i resets with each figure)
%     %     syl_num=size(syl_labels{j},2);
%     %
%     %         subplot(col_plots(figure_num),row_plots(figure_num),i);
%     %         syl_mat = all_days_all_analysis.PLOT.all_trans.convergence.fractions{days_with_analysis(j)};
%     % %         max_value_local=max(max(all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.all_days_incl_pre(:,:,days_with_analysis(j))));
%     % %         min_value_local=min(min(all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.all_days_incl_pre(:,:,days_with_analysis(j))));
%     %         imagesc(syl_mat,[0 100]);
%     %         colormap(flipud(gray))
%     %         textStrings = num2str(syl_mat(:),'%0.0f');
%     %         textStrings = strtrim(cellstr(textStrings));
%     %         [x,y]=meshgrid(1:syl_num);
%     %         hStrings = text(x(:),y(:),textStrings(:), 'HorizontalAlignment','center');
%     %         midValue = mean(get(gca,'CLim'));
%     %         textColors = repmat(syl_mat(:) > midValue,1,3);
%     %         set(hStrings,{'Color'},num2cell(textColors,2));
%     %
%     %         set(gca,'XTick',1:syl_num,'XTickLabel',syl_labels{j}, 'YTick',1:syl_num,...
%     %             'YTickLabel',syl_labels{j}, 'TickLength',[0 0]);
%     %         ylabel('transition from:')
%     %         xlabel('transition to:')
%     %         title(['day # ' num2str(days_with_analysis(j)) ', ' all_days_all_analysis.data{days_with_analysis(j)}.date]);
%     %         freezeColors
%     %
%     %
%     %         if counter == num_of_days;
%     %             % make one colorbar
%     %             ax=gca;
%     %             pos=get(gca,'pos'); % to arrange colorbar relative to the last plot
%     %             hc=colorbar('position',[pos(1)+1.2*pos(3) pos(2)+(0.2*pos(4)) 0.05*pos(3) 0.7*pos(4)]);
%     %             % hc=colorbar('location','eastoutside')
%     %             % set(hc,'xaxisloc','top');
%     %
%     %
%     %             % give a general title
%     %             ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
%     %             text(0.5, 1,['\bf Convergent transition matrices for each day'],'HorizontalAlignment'...
%     %                 ,'center','VerticalAlignment', 'top')
%     %         end
%     %         counter = counter+1;
%     % end
%     %
%     % %% THIRD