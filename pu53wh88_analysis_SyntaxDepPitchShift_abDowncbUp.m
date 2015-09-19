%% 4/12/15 - ANALYSIS ALL DAYS

% ------- COLLECT RAW DAT
clear all; close all

% baseline
phrase = 'SyntaxDepPitchShift_abDowncbUp';
first_day= '04Jul2014';
last_day= '30Jul2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'seq_dep_pitch_2'};

% Parameters for functions within
Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.catch.keep';
Params.DayRawDat.syllables={'a','b','c'};
Params.DayRawDat.frequency_range={[1050 2200], [2750 4150],[2250 2800]};
Params.DayRawDat.pc_dur=[0.115,0.105,0.120];

Params.DayRawDat.pc_time_window={[305 425],[60 200],[60 400]};
Params.DayRawDat.pc_sigma=1.5;


plotON=0;
saveON=1;

WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};

[filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);


% --------- SEQ FILTER 
clear all; close all;

% 0) keep?
Params.SeqFilter.AmplThr=3200;

% 1) Seq filter and remove outliers and compile into one struct
Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
Params.SeqFilter.FirstDay='';
Params.SeqFilter.LastDay='';

Params.SeqFilter.SeqPreList={'','','a','ab','abb','c','cb','a','ac'};
Params.SeqFilter.SylTargList={'a','a','b','b','b','b','b','c','c'};
Params.SeqFilter.SeqPostList={'b','c','','','','','','',''};


% 2) experiment info
Params.SeqFilter.WNTimeON='08Jul2014-0000'; % Time WN turned on (1st WN day)
Params.SeqFilter.WNTimeOFF= '21Jul2014-1624'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
Params.SeqFilter.BaselineDays=1:4;

Params.SeqFilter.SylLists.FieldsToPlot{1}={'cB','cbB','aB','abB','abbB'};
Params.SeqFilter.SylLists.FieldsToPlot{2}={'Ab','Ac','aC','acC'};
Params.SeqFilter.SylLists.FieldsInOrder{1}={'Ab','aB','abB','abbB'};
Params.SeqFilter.SylLists.FieldsInOrder{2}={'Ac','aC','acC','cB','cbB'};
Params.SeqFilter.SylLists.TargetSyls={'aB'};
Params.SeqFilter.SylLists.SylsSame={'cB','cbB','abB','abbB'};
Params.SeqFilter.SylLists.SylsDifferent={'Ab','Ac','aC','acC'};

% Params.SeqFilter.DaysForSnapshot{1}={'09Dec2014','11Dec2014'};
% Params.SeqFilter.DaysToMark= {'11Dec2014-2400'}; % will mark all plots with lines here;

% 3) RUN
plotON=0;
[Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);


% ---- PLOT LEARNING
Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
Params.PlotLearning.DayBinSize=3; % 3 day running avg.
saveON=1;

[Params, AllDays_PlotLearning]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);
close all;

% ----- STRUCTURE STATS

% to extract data
[Params, AllDays_StructStatsStruct]=lt_seq_dep_pitch_StructureStats(Params, AllDays_RawDatStruct);

% to plot and perform PCA on syl structure
Params.PCA.epoch='baseline'; % will look at baseline
% Params.PCA.epoch=[21 24]; % days 21 to 24

[Params, PCA_Struct]=lt_seq_dep_pitch_StructureStats_featurePCA(Params, AllDays_StructStatsStruct,1);

lt_seq_dep_pitch_Correlations(Params, AllDays_StructStatsStruct)

%% BELOW - USING OLD ANALYSIS METHODS -----


%% 7/24 - MULTIPLE DAYS Reformulating code.  Also looking at hit rate.  Better organized.
% GENERAL INPUTS
clear all; close all
phrase = 'SyntaxDepPitchShift';
first_day= '04Jul2014';
last_day= '13Aug2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
% FcnAll={'check_HTF','calcdaypitch'};
FcnAll={'calcdaypitch'};

% INPUTS specifically for motif switches:
% i.e. each entry is for a separate motif (if want to get both ab(b) and
% ab(c), then syl_targ_list would be {'b','c'}). function will run
% separately for each motif.
% IMPORTANT:  labels will temporarily be changed to syl_replace. has to be unused (e.g. all caps).motif_pre_list={'ab','cb','a','c'};
motif_pre_list={'abb','ab','cb','a','c'};
syl_targ_list={'b','b','b','b','b'};
motif_post_list={'','','','',''};
syl_replace_list={'Z','M','X','A','D'};


% INPUTS FOR analysis (lt_all_days_various)
% enter as normally would, for each syl target (each cell entry is for separate motif switch)
% i.e. first cell is for first replaced syl

% lt_calc_pitch...:
freq_rangeDP_list={{[3100 3900]},{[3100 3900]},{[3100 3900]},{[2850 3800]},{[3100 4150]},{[2850 4150]}};
pc_time_windowDP_list={{[50 130]},{[50 130]},{[60 130]},{[50 140]},{[50 140]},{[50 140]}};
plot_resultDP=1;
pc_windowDP=2000;

% lt_check_HTF...:
freq_rangeHTF={{[3100 3900]},{[3100 3900]},{[2850 3800]},{[3100 4150]},{[2850 4150]}};
evtaf_verHTF='v4';
get_WN_hitsHTF=0;
get_offline_matchHTF=0;
get_FFHTF=0;
if get_offline_matchHTF==1; % template params if also doing offline check
%     template_name='pu11wh87ab_SyntaxDepPitchShift_v1_6';
%     cntrng_values{1}={[5 14 1] 'or' 'n' 'y'};
%     cntrng_values{2}={[5 14 0.1] 'or' 'n' 'y'};
%     cntrng_values{3}={[5 14 1.1] 'and' 'n' 'y'};
%     cntrng_values{4}={[1 4 1.5] 'or' 'n' 'n'};
%     cntrng_values{5}={[1 4 1.5] 'or' 'n' 'n'};
%     cntrng_values{6}={[1 4 1.5] 'or' 'n' 'n'};
%     col_logic='(a+b+c)*(d+e+f)';
end


% INPUT: WITHIN FUNCTION VARIABLES SETTING (DIFFERENT FOR ALL MOTIFS)
% DO not change the values within each function, but add and subtract Vs if you need.
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



lt_all_days_various_calculations_COMBINE_Motif_and_Normal


% TO PLOT, set params here and run script below:
% INPUTS
% Save?
save_plots=1;
% What to get? (1 = get , 0 = skip)
get_thr=0;
plot_baseline=1;
baseline_days=1:4;
plot_WN=1;
    WN_dates={'08Jul2014-1232','21Jul2014-1624','31Jul2014-1618','07Aug2014-1048'};
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

analysis_SyntaxDepPitchShift_PLOTS




%% 7/30 - Just to get template matched pitch for a single day

clear all; close all
phrase = 'SyntaxDepPitchShift';
first_day= '03Aug2014';
last_day= '03Aug2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
FcnAll={'check_HTF'};

% INPUTS specifically for motif switches:
% i.e. each entry is for a separate motif (if want to get both ab(b) and
% ab(c), then syl_targ_list would be {'b','c'}). function will run
% separately for each motif.
% IMPORTANT:  labels will temporarily be changed to syl_replace. has to be unused (e.g. all caps).motif_pre_list={'ab','cb','a','c'};
motif_pre_list={'c'};
syl_targ_list={'b'};
motif_post_list={''};
syl_replace_list={'D'};


% INPUTS FOR analysis (lt_all_days_various)
% enter as normally would, for each syl target (each cell entry is for separate motif switch)
% i.e. first cell is for first replaced syl

% lt_calc_pitch...:
freq_rangeDP_list={{[3100 4150]}};
pc_time_windowDP_list={{[50 140]}};
plot_resultDP=0;
pc_windowDP=2000;

% lt_check_HTF...:
freq_rangeHTF={{[3100 4150]}};
evtaf_verHTF='v4';
get_WN_hitsHTF=1;
get_offline_matchHTF=1;
get_FFHTF=1;
if get_offline_matchHTF==1; % template params if also doing offline check
    template_name='pu53wh88cb_SyntaxDepPitchShift_v2_4';
    cntrng_values{1}={[1 4 1.8] 'or' 'n' 'n'};
    cntrng_values{2}={[1 4 1.8] 'or' 'n' 'n'};
    cntrng_values{3}={[1 4 1.8] 'or' 'n' 'n'};
    cntrng_values{4}={[5 13 1.3] 'and' 'n' 'y'};
    col_logic='(a+b+c)*(d)';
end


% INPUT: WITHIN FUNCTION VARIABLES SETTING (DIFFERENT FOR ALL MOTIFS)
% DO not change the values within each function, but add and subtract Vs if you need.
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
    Vall_mot{i}=[V1_mot{i}];
end



lt_all_days_various_calculations_COMBINE_Motif_and_Normal


%% 7/24 - MULTIPLE DAYS Reformulating code.  Also looking at hit rate.  Better organized.
% GENERAL INPUTS
clear all; close all
phrase = 'SyntaxDepPitchShift';
first_day= '31Jul2014';
last_day= '31Aug2014';
save_results=1;

% functions to run (SAME FOR ALL MOTIFS)
% FcnAll={'check_HTF','calcdaypitch'};
FcnAll={'calcdaypitch'};

% INPUTS specifically for motif switches:
% i.e. each entry is for a separate motif (if want to get both ab(b) and
% ab(c), then syl_targ_list would be {'b','c'}). function will run
% separately for each motif.
% IMPORTANT:  labels will temporarily be changed to syl_replace. has to be unused (e.g. all caps).motif_pre_list={'ab','cb','a','c'};
motif_pre_list={'ab','cb','a','c','a','c',''};
syl_targ_list={'b','b','c','c','b','b','b'};
motif_post_list={'','','','','','',''};
syl_replace_list={'M','X','C','Y','A','D','b'};


% INPUTS FOR analysis (lt_all_days_various)
% enter as normally would, for each syl target (each cell entry is for separate motif switch)
% i.e. first cell is for first replaced syl

% lt_calc_pitch...:
freq_rangeDP_list={{[3100 3900]},{[3100 3900]},{[2000 2900]},{[2000 3000]},{[2850 3800]},{[3100 4150]},{[2850 4150]}};
pc_time_windowDP_list={{[50 130]},{[60 130]},{[75 150]},{[75 150]},{[50 140]},{[50 140]},{[50 140]}};
plot_resultDP=0;
pc_windowDP=2000;

% lt_check_HTF...:
freq_rangeHTF={{[3100 3900]},{[3100 3900]},{[2000 2900]},{[2000 3000]},{[2850 3800]},{[3100 4150]},{[2850 4150]}};
evtaf_verHTF='v4';
get_WN_hitsHTF=0;
get_offline_matchHTF=0;
get_FFHTF=0;
if get_offline_matchHTF==1; % template params if also doing offline check
%     template_name='pu11wh87ab_SyntaxDepPitchShift_v1_6';
%     cntrng_values{1}={[5 14 1] 'or' 'n' 'y'};
%     cntrng_values{2}={[5 14 0.1] 'or' 'n' 'y'};
%     cntrng_values{3}={[5 14 1.1] 'and' 'n' 'y'};
%     cntrng_values{4}={[1 4 1.5] 'or' 'n' 'n'};
%     cntrng_values{5}={[1 4 1.5] 'or' 'n' 'n'};
%     cntrng_values{6}={[1 4 1.5] 'or' 'n' 'n'};
%     col_logic='(a+b+c)*(d+e+f)';
end


% INPUT: WITHIN FUNCTION VARIABLES SETTING (DIFFERENT FOR ALL MOTIFS)
% DO not change the values within each function, but add and subtract Vs if you need.
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



lt_all_days_various_calculations_COMBINE_Motif_and_Normal


% TO PLOT, set params here and run script below:
% INPUTS
% Save?
save_plots=1;
% What to get? (1 = get , 0 = skip)
get_thr=0;
plot_baseline=1;
baseline_days=1:3;
plot_WN=1;
    WN_dates={'08Jul2014-1232','16Jul2014-0000','21Jul2014-1624','31Jul2014-1618','04Aug2014-0000','07Aug2014-1048'};
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

analysis_SyntaxDepPitchShift_PLOTS


%% 7/18
clear all; close all

% FIRST, COLLECT DATA ACROSS DAYS

% GENERAL INPUTS
phrase = 'SyntaxDepPitchShift';
first_day= '05Jul2014';
last_day= '05Jul2014';

% ----------------------------------------------------
% INPUTS
% 2) Motifs - which motifs to look at, and parameters for each
% i.e. each entry is for a separate motif (if want to get both ab(b) and ab(c), then syl_targ_list would be {'b','c'}
motif_pre_list={'ab','cb','a','c'};
syl_targ_list={'b','b','c','c'};
motif_post_list={'','','',''};
syl_replace_list={'M','X','C','Y'};
% calcdaypitch parameters - these can be cells arrays of cells.  inner
% cells are the actual parameters used for each iteration of function
% below.
freq_rangeDP_list={{[3100 3900]},{[3100 3900]},{[2000 2900]},{[2000 3000]}};
pc_time_windowDP_list={{[50 130]},{[60 130]},{[75 150]},{[75 150]}};
plot_resultDP_list={1,1,1,1};
pc_windowDP_list={2000,2000,2000,2000};

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
% syl_preDP={'a','c',a};
% syl_targetDP='bbc';
% freq_rangeDP={[3100 3900],[3050 3800],[2000 2900]};
% pc_time_windowDP={[130 220],[130 220],[110 250]};
syl_preDP={'a','c'};
syl_targetDP='bb';
freq_rangeDP={[2900 3800],[3100 4000]};
pc_time_windowDP={[50 140],[50 140]};
plot_resultDP=1;
pc_windowDP=2000;

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
bird_dir='/bluejay3/lucas/birds/pu53wh88/';
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
bird_dir='/bluejay3/lucas/birds/pu53wh88/';

% INPUTS
% Save?
save_plots=0;
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
last_day= '14Jul2014';

% ----------------------------------------------------
% INPUTS
% 2) Motifs - which motifs to look at, and parameters for each
% i.e. each entry is for a separate motif (if want to get both ab(b) and ab(c), then syl_targ_list would be {'b','c'}
motif_pre_list={'ab','cb','a'};
syl_targ_list={'b','b','c'};
motif_post_list={'','',''};
syl_replace_list={'M','X','C'};
% calcdaypitch parameters - these can be cells arrays of cells.  inner
% cells are the actual parameters used for each iteration of function
% below.
freq_rangeDP_list={{[3100 3900]},{[3100 3900]},{[2000 2900]}};
pc_time_windowDP_list={{[125 215]},{[130 220]},{[110 250]}};
plot_resultDP_list={0,0,0};
pc_windowDP_list={3000,3000,3000};

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
% syl_preDP={'a','c',a};
% syl_targetDP='bbc';
% freq_rangeDP={[3100 3900],[3050 3800],[2000 2900]};
% pc_time_windowDP={[130 220],[130 220],[110 250]};
syl_preDP={'a','c'};
syl_targetDP='bb';
freq_rangeDP={[3100 3900],[3050 3800]};
pc_time_windowDP={[130 220],[130 220]};
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
bird_dir='/bluejay3/lucas/birds/pu53wh88/';
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
bird_dir='/bluejay3/lucas/birds/pu53wh88/';

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



%% 7/12, 7/13- All days up to now:
clear all; close all;

        % COLLECT DATA ACROSS DAYS
% INPUTS
phrase = 'SyntaxDepPitchShift';
first_day= '07Jul2014';
last_day= '14Jul2014';
% things to do:
% calcdaypitch parameters
syl_preDP={'a','c','b'};
syl_targetDP='bbb';
freq_rangeDP={[3100 3900],[3050 3800],[3000 3700]};
pc_time_windowDP={[140 210],[140 210],[140 210]};
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
ADV_dir='/bluejay3/lucas/birds/pu53wh88/all_days_various_calculations/';
load([ADV_dir ADV_name]);

% Auto: extracts other parameters
syllables=all_days_various.lt_calc_day_pitch{1}.parameters.syllables;
first_day_str=all_days_various.parameters.days{1};
first_day_datenum=all_days_various.parameters.days{3};
num_days=size(all_days_various.lt_calc_day_pitch,2);
NumToAddToAllDays= -first_day_datenum;% this is to make day 1 = day 0 (instead of in the thousands).
timestampS=lt_get_timestamp(0);


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
    hfig_pc(i)=figure; hold on; % for all days
    for ii=1:num_days;
        rows=ceil((num_days/4));
        subplot(rows,4,ii); hold on;
        try % because some days no data
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


%% 7/11 - single day

clear all; close all;
phrase = 'SyntaxDepPitchShift';
first_day= '12Jul2014';
last_day= '12Jul2014';

syl_preDP={'a','c','b'};
syl_targetDP='bbb';

% RUN
[filename_save, all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,{'calcdaypitch'}, {'syl_targetDP',syl_targetDP, 'syl_preDP',syl_preDP,'phraseDP',phrase,'freq_rangeDP',{[3200 3900],[3050 3750],[3000 3700]},...
    'pc_time_windowDP',{[140 210],[140 210],[140 210]},'plot_resultDP',1},1);


%
ADV_dir='/bluejay3/lucas/birds/pu53wh88/all_days_various_calculations/';
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





%% 7/11 - day4 WN

clear all; close all;
phrase = 'SyntaxDepPitchShift';
first_day= '11Jul2014';
last_day= '11Jul2014';

syl_preDP={'a','c','b'};
syl_targetDP='bbb';

% RUN
[filename_save, all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,{'calcdaypitch'}, {'syl_targetDP',syl_targetDP, 'syl_preDP',syl_preDP,'phraseDP',phrase,'freq_rangeDP',{[3200 3900],[3050 3750],[3000 3700]},...
    'pc_time_windowDP',{[140 210],[140 210],[140 210]},'plot_resultDP',1},1);
%%
ADV_dir='/bluejay3/lucas/birds/pu53wh88/all_days_various_calculations/';
load([ADV_dir 'all_days_various_11Jul2014_1604.mat']);
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




%% 7/9 just looking at today
clear all; close all;
phrase = 'SyntaxDepPitchShift';
first_day= '07Jul2014';
last_day= '09Jul2014';

% calcdaypitch parameters
syl_preDP={'a','c','b'};
syl_targetDP='bbb';

% RUN
[filename_save, all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,{'calcdaypitch'}, {'syl_targetDP',syl_targetDP, 'syl_preDP',syl_preDP,'phraseDP',phrase,'freq_rangeDP',{[3200 3900],[3050 3750],[3000 3700]},...
    'pc_time_windowDP',{[140 210],[140 210],[140 210]},'plot_resultDP',1},1);


% PLOT - using code modified from bk24bk63
% INPUTS:
ADV_dir='/bluejay3/lucas/birds/pu53wh88/all_days_various_calculations/';
load([ADV_dir 'all_days_various_07Jul2014_2245.mat']);
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
    hfig(j)=figure(j); hold on;
    
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


%% 7/8/14 - Putting together code that will be used to analyze data during learnign. here practice on non-leraning days;

% COLLECT PITCH DATA FROM EACH DAY
% uses pitch contour.

% INPUTS
clear all; close all;
phrase = 'SyntaxDepPitchShift';
first_day= '05Jul2014';
last_day= '07Jul2014';

% calcdaypitch parameters
syl_preDP={'a','c','b'};
syl_targetDP='bbb';

% RUN
[filename_save, all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,{'calcdaypitch'}, {'syl_targetDP',syl_targetDP, 'syl_preDP',syl_preDP,'phraseDP',phrase,'freq_rangeDP',{[3200 3900],[3050 3750],[3000 3700]},...
    'pc_time_windowDP',{[140 210],[140 210],[140 210]},'plot_resultDP',1},1);


% PLOT - using code modified from bk24bk63
% INPUTS:
ADV_dir='/bluejay3/lucas/birds/pu53wh88/all_days_various_calculations/';
load([ADV_dir 'all_days_various_07Jul2014_2245.mat']);
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
    hfig(j)=figure(j); hold on;
    
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

%% 7/7/14 - Started syntax dep pitch shuift experiment.  below is copied CP seq analysis for convenience.  it's also in another analysis file.


% %% 5/15/14 - Summary of adult WN - 17May2014_2020 (ADAA)
% 
% % HIT RATE (RENDITION also) per song and syl
% 
% clear all;
% ADAAind='17May2014_2020';
% all_days_all_analysis=lt_load_all_days_all_analysis(ADAAind);
% 
% for i=1:size(all_days_all_analysis.data,2);
%     num_songs=size(all_days_all_analysis.data{i}.WN_hit_rate.per_song.b.hits_labels_allhits,1);
%     if num_songs>0;
%         hit_rate_Mean_PerSong(i)=all_days_all_analysis.data{i}.WN_hit_rate.all_songs.b.hits_labels_allhits(1)/num_songs;
%         rend_rate_Mean_PerSong(i)=all_days_all_analysis.data{i}.WN_hit_rate.all_songs.b.hits_labels_allhits(2)/num_songs;
%         song_length_Mean(i)=length(all_days_all_analysis.data{i}.all_songs.all_trans.syl_order_compiled_across_songs)/num_songs;
%         
%         hit_rate_Mean_PerSyl(i)=hit_rate_Mean_PerSong(i)/song_length_Mean(i);
%         rend_rate_Mean_PerSyl(i)=rend_rate_Mean_PerSong(i)/song_length_Mean(i);
%         
%     elseif num_songs==0;
%         hit_rate_Mean_PerSong(i)=nan;
%         rend_rate_Mean_PerSong(i)=nan;
%         song_length_Mean(i)=nan;
%         
%         hit_rate_Mean_PerSyl(i)=nan;
%         rend_rate_Mean_PerSyl(i)=nan;
%     end
% end
% 
% figure; hold on;
% plot(hit_rate_Mean_PerSong,'sr'); 
% plot(rend_rate_Mean_PerSong,'ob');
% title('Mean per song: RED: hits/song; BLUE: renditions of target/song; (all catch)');
% 
% figure; hold on;
% plot(hit_rate_Mean_PerSyl,'sr'); 
% plot(rend_rate_Mean_PerSyl,'ob');
% title('Mean per all syllables sang: RED: hits/syl; BLUE: renditions of target/syl; (all catch)');
% 
% figure; hold on;
% plot(song_length_Mean,'or');
% title('mean song length across days'); 
% ylim([0 max(song_length_Mean)+5])
% 
% 
% % HIT RATE (per rendition of that syllable, how good template)
% ADAAind='17May2014_2020';
% lt_load_all_days_all_analysis(ADAAind);
% 
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
% 
% % TRANSITIONS
% ADAAind='17May2014_2020';
% 
% con_div = 'divergence';
% all_days_all_analysis=lt_all_days_PLOT_AllTrans([1 2 3 4], ADAAind, con_div);
% lt_all_days_PLOT_AllTrans_specific_trans(con_div,1,'',ADAAind) % run this in bird folder.  
% 
% con_div = 'convergence';
% all_days_all_analysis=lt_all_days_PLOT_AllTrans([1 2 3 4], ADAAind, con_div);
% lt_all_days_PLOT_AllTrans_specific_trans(con_div,1,'',ADAAind) % run this in bird folder.  
% 
% 
% 
% 
% 
% %% 4/28/14 - ADULT (pre days)
% clear all; close all;
% 
% lt_all_days_various_calculations
% lt_all_days_all_analysis
% 
% % ___________________________________________
% % PLOT transition matrices
% 
% load /bluejay3/lucas/birds/pu53wh88/all_days_all_analysis/all_days_all_analysis_28Apr2014_1650_adult_AllTrans.mat
% 
% con_div='divergence';
% lt_all_days_PLOT_AllTrans([1],'28Apr2014_1650',con_div)
% 
% con_div='convergence';
% lt_all_days_PLOT_AllTrans([1],'28Apr2014_1650',con_div)
% 
% % _____________________________________________________
% %PLOT single divergent or convergent transition over days (load all_days... first)
% clear all; close all;
% load /bluejay3/lucas/birds/pu53wh88/all_days_all_analysis/all_days_all_analysis_28Apr2014_1650_adult_AllTrans.mat
% 
% % DIVERGENCE
% con_div = 'divergence';
% syl1_list={'a','b','c','d','g','j'};
% for kk=1:length(syl1_list);
%     syl1=syl1_list{kk};
%     % syl2='b';
%     syl2_list=all_days_all_analysis.data{2}.all_songs.all_trans.syllable_list;
%     num_syl=length(syl2_list);
%     % make syl colors
%     syl_color=lt_make_plot_colors(length(syl2_list));
%     
%     figure;  hold on; title([con_div ' transition probability from ' syl1 ' to (see legend): ']);
%     for k=1:length(syl2_list);
%         syl2=syl2_list{k};
%         dummy=[];
%         for i=1:size(all_days_all_analysis.data,2);
%             try
%                 dummy=[dummy; [i all_days_all_analysis.data{i}.all_songs.all_trans.(syl1).transition_to_.(syl2).relative_fraction_of_trans]];
%             catch err
%                 continue
%             end
%         end
%         %     plot(dummy,'Marker','o','Color',syl_color{k},'MarkerEdgeColor','black','MarkerFaceColor',syl_color{k},'MarkerSize',8);
%         hplot(k)=plot(dummy(:,1), dummy(:,2),'Marker','o','Color',syl_color{k},'MarkerEdgeColor','black','MarkerFaceColor',syl_color{k},'MarkerSize',8);
%     end
%     legend(hplot,[syl2_list]);
%     ylim([0 1]); xlabel('days'); ylabel('probability of transition')
% end
% 
% % Convergence
% %PLOT single divergent or convergent transition over days (run the above
% %function first)
% con_div = 'convergence';
% syl2_list={'a','b','c','d','g','j'}; % all the 2nd-syls that you are interested in (one plot each)
% for kk=1:length(syl2_list)
%     syl2=syl2_list{kk};
%     syl1_list=all_days_all_analysis.data{2}.all_songs.all_trans.syllable_list;
%     num_syl=length(syl1_list);
%     
%     % make syl colors
%     syl_color=lt_make_plot_colors(length(syl1_list));
%     
%     figure;  hold on; title(['Convergence transition probability to ' syl2 ' from (see legend): ']);
%     for k=1:length(syl1_list);
%         syl1=syl1_list{k};
%         dummy = [];
%         for i=1:size(all_days_all_analysis.data,2);
%             try
%                 dummy = [dummy; [i all_days_all_analysis.data{i}.all_songs.all_trans.convergent_to.(syl2).from.(syl1).fraction_of_trans]];
%             catch err
%                 continue
%             end
%         end
%         hplot2(k)= plot(dummy(:,1), dummy(:,2),'Marker','o','Color',syl_color{k},'MarkerEdgeColor','black','MarkerFaceColor',syl_color{k},'MarkerSize',8);
%     end
%     legend(hplot2,[syl1_list]);
%     ylim([0 1]); xlabel('days'); ylabel('probability of transition')
% end
% %% 2/28/14 - looking at all of young data - making summary figure of transitions
% 
% clear all; close all;
% load /bluejay3/lucas/birds/pu53wh88/all_days_all_analysis/all_days_all_analysis_28Mar2014_1925_CPseq_AllTrans
% 
% % ____________________________________________________________________
% % for a[] divergence
% 
% %PLOT single divergent or convergent transition over days (load all_days... first)
% con_div = 'divergence';
% syl1_list={'a','b','c','d','g','j'};
% for kk=1:length(syl1_list);
%     syl1=syl1_list{kk};
%     % syl2='b';
%     syl2_list=all_days_all_analysis.data{1}.all_songs.all_trans.syllable_list;
%     num_syl=length(syl2_list);
%     % make syl colors
%     syl_color=lt_make_plot_colors(length(syl2_list));
%     
%     figure;  hold on; title([con_div ' transition probability from ' syl1 ' to (see legend): ']);
%     for k=1:length(syl2_list);
%         syl2=syl2_list{k};
%         dummy=[];
%         for i=1:size(all_days_all_analysis.data,2);
%             try
%                 dummy=[dummy; [i all_days_all_analysis.data{i}.all_songs.all_trans.(syl1).transition_to_.(syl2).relative_fraction_of_trans]];
%             catch err
%                 continue
%             end
%         end
%         %     plot(dummy,'Marker','o','Color',syl_color{k},'MarkerEdgeColor','black','MarkerFaceColor',syl_color{k},'MarkerSize',8);
%         hplot(k)=plot(dummy(:,1), dummy(:,2),'Marker','o','Color',syl_color{k},'MarkerEdgeColor','black','MarkerFaceColor',syl_color{k},'MarkerSize',8);
%     end
%     legend(hplot,[syl2_list]);
%     ylim([0 1]); xlabel('days'); ylabel('probability of transition')
% end
% 
% % Convergence
% %PLOT single divergent or convergent transition over days (run the above
% %function first)
% con_div = 'convergence';
% syl2_list={'a','b','c','d','g','j'}; % all the 2nd-syls that you are interested in (one plot each)
% for kk=1:length(syl2_list)
%     syl2=syl2_list{kk};
%     syl1_list=all_days_all_analysis.data{1}.all_songs.all_trans.syllable_list;
%     num_syl=length(syl1_list);
%     
%     % make syl colors
%     syl_color=lt_make_plot_colors(length(syl1_list));
%     
%     figure;  hold on; title(['Convergence transition probability to ' syl2 ' from (see legend): ']);
%     for k=1:length(syl1_list);
%         syl1=syl1_list{k};
%         dummy = [];
%         for i=1:size(all_days_all_analysis.data,2);
%             try
%                 dummy = [dummy; [i all_days_all_analysis.data{i}.all_songs.all_trans.convergent_to.(syl2).from.(syl1).fraction_of_trans]];
%             catch err
%                 continue
%             end
%         end
%         hplot2(k)= plot(dummy(:,1), dummy(:,2),'Marker','o','Color',syl_color{k},'MarkerEdgeColor','black','MarkerFaceColor',syl_color{k},'MarkerSize',8);
%     end
%     legend(hplot2,[syl1_list]);
%     ylim([0 1]); xlabel('days'); ylabel('probability of transition')
% end
% 
