%% NOTE!!!: on 5/27/15 - moved all data from bluejay3 to bluejay4. might break some of code below.  should be easy fix.

%% 9/11 - Up to 07/28 (inclusive) (i.e. including washout)


% FIRST, compile transition data:
% going into each folder and getting transition data - do this after labeling and before compiling data into structure below
% run the below for each day folder (run either C1 or C2)
% if C1, then first separate b.c.k into b.c.k.early and b.c.k.late. Then
% run functions.  For C2, just use b.c.k. and run function.
clear all;close all

% INPUTS
folder_phrase='ContextSeq'; % marking the save folder
[nameofbird, bluejaynum, date, ~]=lt_get_birdname_date_from_dir(1);
datestring=date{2};

% RUN DIFFERENT DEPENDING ON CONTEXT

% context A
edit batch.catch.keep
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep.early',nameofbird,folder_phrase,'contextA_early',datestring);
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep.late',nameofbird,folder_phrase,'contextA_late',datestring);

%  context B
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep',nameofbird,folder_phrase,'contextB',datestring);


% -------------------------------------------
% NOTE: DO EACH OF THE DIV/CONV/COMBINED SEPARATELY

% SECOND, COMPILE DATA for all contexts for a single day into one data structure.
% INSTRUCTIONS: 1) first run lt_get_all_transition_probabilities. 2) Then enter
% your parameters below and run to compile transition info over multiple
% contexts into one structure. 3) Run this in the bird folder!

% Con and Div combined
clear all; close all
% INPUTS
first_day='31May2014';
last_day='28Jul2014';
folder_phrase='ContextSeq'; %this marks the all_transitions folder (e.g. all_days_transition_matrix_ContextSeq)
motifs={'ab','aa','aj','an','bb','jb','nb'}; % BEST TO TAKE ALL TRANSITIONS AT A BRANCH POINT
context_label_set={'contextA_early','contextB','contextA_late'}; % enter the contexts that are stored in that structure (exactly as they are written in the saved structures (e.g. rd66gr93_01Jun2014_contextA_early.mat)
curr_dir=pwd;
save_phrase='ConAndDiv_ab';

lt_all_days_ContextSeq_COMPILE(first_day,last_day,folder_phrase,motifs,context_label_set,save_phrase,0)

cd(curr_dir);

% Divergence
clear all; close all
% INPUTS
first_day='31May2014';
last_day='04Jul2014';
folder_phrase='ContextSeq'; %this marks the all_transitions folder (e.g. all_days_transition_matrix_ContextSeq)
motifs={'ab','aa','aj','an'}; % BEST TO TAKE ALL TRANSITIONS AT A BRANCH POINT
context_label_set={'contextA_early','contextB','contextA_late'}; % enter the contexts that are stored in that structure (exactly as they are written in the saved structures (e.g. rd66gr93_01Jun2014_contextA_early.mat)
curr_dir=pwd;
save_phrase='div_a';

lt_all_days_ContextSeq_COMPILE(first_day,last_day,folder_phrase,motifs,context_label_set,save_phrase,0)

cd(curr_dir);

% Convergence
clear all; close all
% INPUTS
first_day='31May2014';
last_day='04Jul2014';
folder_phrase='ContextSeq'; %this marks the all_transitions folder (e.g. all_days_transition_matrix_ContextSeq)
motifs={'ab','bb','jb','nb'}; % BEST TO TAKE ALL TRANSITIONS AT A BRANCH POINT
context_label_set={'contextA_early','contextB','contextA_late'}; % enter the contexts that are stored in that structure (exactly as they are written in the saved structures (e.g. rd66gr93_01Jun2014_contextA_early.mat)
curr_dir=pwd;
save_phrase='conv_b';

lt_all_days_ContextSeq_COMPILE(first_day,last_day,folder_phrase,motifs,context_label_set,save_phrase,0)

cd(curr_dir);


% It will ask you for context switch times.  Keep track of them below:
% -------------------------------------------------------------
% LIST OF CONTEXT SWITCH TIMES
% rd66 trial1:
{'31May2014-1205','31May2014-1658'}
{'01Jun2014-1305','01Jun2014-1730','01Jun2014-2030'}
{'02Jun2014-1210','02Jun2014-1707','02Jun2014-2030'}
{'03Jun2014-1225','03Jun2014-1723','03Jun2014-2030'}
{'04Jun2014-1205','04Jun2014-1213','04Jun2014-1703','04Jun2014-1757','04Jun2014-2035'}
{'05Jun2014-1133','05Jun2014-1135','05Jun2014-1208','05Jun2014-1716'}
{'06Jun2014-1201','06Jun2014-1714','06Jun2014-2019'}

{'07Jun2014-1218','07Jun2014-1724','07Jun2014-2032'}
{'08Jun2014-1238','08Jun2014-1722','08Jun2014-2005'}
{'09Jun2014-1317','09Jun2014-1712','09Jun2014-2100'}



%___________________________________________________________________________
% THIRD: Plot
% Uses the same parameters in "SECOND" above.  

% PLOT PARAMETERS
BaselineDays=[1:4];
WNDays=[5:11, 13:16, 18, 21, 23];
ProbeDays= [12, 17, 19, 20, 22, 24, 25, 26, 27, 28, 29];
BaslineDays_trial2=37:51;
WNDays_trial2=52:55;

% PLOT PARAMETERS
% plotting across days
trn_to_plot='ab'; % for summary cross day data
num_renditions=6; % EDGES: how many songs to take at the edges
% plotting individual days
motifs_to_plot={trn_to_plot}; % for plotting each individual day
bin_size=3; % to change this you have to go back to making transitions, or incorporate that part here to make afresh

% ADDITIONAL INPUTS FOR PLOTTING
[birdname, bluejay_num]=lt_get_birdname_date_from_dir(0);
bird_dir=['/bluejay' num2str(bluejay_num) '/lucas/birds/' birdname];
phrase=save_phrase;

% RUN
lt_all_days_ContextSeq_PLOT



% FOURTH: Pulling out probe trials 

% First, load the transitions_all_days or transitions_all_days_PLOT
% structure. Then run following (DO EACH OF THE THREE SEPARATELY)
clear all;
% con and div
savedir='/bluejay3/lucas/birds/rd66gr93/all_days_transitions_ContextSeq_analysis/PLOT/31May2014_to_28Jul2014_ConAndDiv_ab_11Sep2014_1950/';
filename='transitions_all_days_PLOT_31May2014_to_28Jul2014_ConAndDiv_ab_11Sep2014_1950';
Ylimits=[0.2, 0.7];
% div
% savedir='/bluejay3/lucas/birds/rd66gr93/all_days_transitions_ContextSeq_analysis/PLOT/31May2014_to_04Jul2014_ConAndDiv_ab_11Sep2014_1711/';
% filename='transitions_all_days_PLOT_31May2014_to_04Jul2014_ConAndDiv_ab_11Sep2014_1711';
% Ylimits=[0.75, 1];
% % conv
% savedir='/bluejay3/lucas/birds/rd66gr93/all_days_transitions_ContextSeq_analysis/PLOT/31May2014_to_04Jul2014_ConAndDiv_ab_11Sep2014_1711/';
% filename='transitions_all_days_PLOT_31May2014_to_04Jul2014_ConAndDiv_ab_11Sep2014_1711';
% Ylimits=[0.2, 0.7];



% INPUT PARAMETERS
% enter the probe epochs
probes_contextB = {'11Jun2014-1307_1556','16Jun2014-1234_1423','18Jun2014-1207_1332','19Jun2014-1218_1244','21Jun2014-1254_1519','24Jun2014-1238_1349', '26Jun2014-1226_1329',...
    '28Jun2014-1447_1549','01Jul2014-1228_1317','04Jul2014-1239_1343'}; % these: WN off during CB
probes_contextA_early = {'23Jun2014-1138_1302','25Jun2014-1038_1108','27Jun2014-0926_1025','02Jul2014-1144_1234'}; % these are WN played as probe in CA
probes_WNoff_contextB_late = {'29Jun2014-1659_1738', '30Jun2014-1628_1719','03Jul2014-1627_1709'}; % i.e. turned off WN in end of context B


% for plotting
edge_bin_size=6;
trn_to_plot='ab';
Xlimits=[1.8, 3.3];
title_pos = [0.5,1.05, 1]; % for the global title
% for saving
save_yes_no=0; % 1 means save, 0 means no
save_label=''; % suffix to filename
load([savedir filename])
lt_all_days_ContextSeq_PROBE_CompilePlot

% ASIDE: to check that the probe times entered there correctly extract the
% data, use the following - it lists the timepoints for all songs, and what
% the program thought.  Compare to your notes on 1) timing and 2) number of
% songs labeled.
lt_all_days_ContextSeq_PROBE_CompilePlot_CHECK;


%% 9/11 - Up to 0704 (inclusive) (everything up to when started washout)


% FIRST, compile transition data:
% going into each folder and getting transition data - do this after labeling and before compiling data into structure below
% run the below for each day folder (run either C1 or C2)
% if C1, then first separate b.c.k into b.c.k.early and b.c.k.late. Then
% run functions.  For C2, just use b.c.k. and run function.
clear all;close all

% INPUTS
folder_phrase='ContextSeq'; % marking the save folder
[nameofbird, bluejaynum, date, ~]=lt_get_birdname_date_from_dir(1);
datestring=date{2};

% RUN DIFFERENT DEPENDING ON CONTEXT

% context A
edit batch.catch.keep
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep.early',nameofbird,folder_phrase,'contextA_early',datestring);
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep.late',nameofbird,folder_phrase,'contextA_late',datestring);

%  context B
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep',nameofbird,folder_phrase,'contextB',datestring);


% -------------------------------------------
% NOTE: DO EACH OF THE DIV/CONV/COMBINED SEPARATELY

% SECOND, COMPILE DATA for all contexts for a single day into one data structure.
% INSTRUCTIONS: 1) first run lt_get_all_transition_probabilities. 2) Then enter
% your parameters below and run to compile transition info over multiple
% contexts into one structure. 3) Run this in the bird folder!

% Con and Div combined
clear all; close all
% INPUTS
first_day='31May2014';
last_day='04Jul2014';
folder_phrase='ContextSeq'; %this marks the all_transitions folder (e.g. all_days_transition_matrix_ContextSeq)
motifs={'ab','aa','aj','an','bb','jb','nb'}; % BEST TO TAKE ALL TRANSITIONS AT A BRANCH POINT
context_label_set={'contextA_early','contextB','contextA_late'}; % enter the contexts that are stored in that structure (exactly as they are written in the saved structures (e.g. rd66gr93_01Jun2014_contextA_early.mat)
curr_dir=pwd;
save_phrase='ConAndDiv_ab';

lt_all_days_ContextSeq_COMPILE(first_day,last_day,folder_phrase,motifs,context_label_set,save_phrase,0)

cd(curr_dir);

% Divergence
clear all; close all
% INPUTS
first_day='31May2014';
last_day='04Jul2014';
folder_phrase='ContextSeq'; %this marks the all_transitions folder (e.g. all_days_transition_matrix_ContextSeq)
motifs={'ab','aa','aj','an'}; % BEST TO TAKE ALL TRANSITIONS AT A BRANCH POINT
context_label_set={'contextA_early','contextB','contextA_late'}; % enter the contexts that are stored in that structure (exactly as they are written in the saved structures (e.g. rd66gr93_01Jun2014_contextA_early.mat)
curr_dir=pwd;
save_phrase='div_a';

lt_all_days_ContextSeq_COMPILE(first_day,last_day,folder_phrase,motifs,context_label_set,save_phrase,0)

cd(curr_dir);

% Convergence
clear all; close all
% INPUTS
first_day='31May2014';
last_day='04Jul2014';
folder_phrase='ContextSeq'; %this marks the all_transitions folder (e.g. all_days_transition_matrix_ContextSeq)
motifs={'ab','bb','jb','nb'}; % BEST TO TAKE ALL TRANSITIONS AT A BRANCH POINT
context_label_set={'contextA_early','contextB','contextA_late'}; % enter the contexts that are stored in that structure (exactly as they are written in the saved structures (e.g. rd66gr93_01Jun2014_contextA_early.mat)
curr_dir=pwd;
save_phrase='conv_b';

lt_all_days_ContextSeq_COMPILE(first_day,last_day,folder_phrase,motifs,context_label_set,save_phrase,0)

cd(curr_dir);


% It will ask you for context switch times.  Keep track of them below:
% -------------------------------------------------------------
% LIST OF CONTEXT SWITCH TIMES
% rd66 trial1:
{'31May2014-1205','31May2014-1658'}
{'01Jun2014-1305','01Jun2014-1730','01Jun2014-2030'}
{'02Jun2014-1210','02Jun2014-1707','02Jun2014-2030'}
{'03Jun2014-1225','03Jun2014-1723','03Jun2014-2030'}
{'04Jun2014-1205','04Jun2014-1213','04Jun2014-1703','04Jun2014-1757','04Jun2014-2035'}
{'05Jun2014-1133','05Jun2014-1135','05Jun2014-1208','05Jun2014-1716'}
{'06Jun2014-1201','06Jun2014-1714','06Jun2014-2019'}

{'07Jun2014-1218','07Jun2014-1724','07Jun2014-2032'}
{'08Jun2014-1238','08Jun2014-1722','08Jun2014-2005'}
{'09Jun2014-1317','09Jun2014-1712','09Jun2014-2100'}



%___________________________________________________________________________
% THIRD: Plot
% Uses the same parameters in "SECOND" above.  

% PLOT PARAMETERS
BaselineDays=1:4;
WNDays=[5:11, 13:16, 18, 21, 23];
ProbeDays= [12, 17, 19, 20, 22, 24, 25, 26, 27, 28, 29];

% PLOT PARAMETERS
% plotting across days
trn_to_plot='ab'; % for summary cross day data
num_renditions=6; % EDGES: how many songs to take at the edges
% plotting individual days
motifs_to_plot={trn_to_plot}; % for plotting each individual day
bin_size=3; % to change this you have to go back to making transitions, or incorporate that part here to make afresh

% ADDITIONAL INPUTS FOR PLOTTING
[birdname, bluejay_num]=lt_get_birdname_date_from_dir(0);
bird_dir=['/bluejay' num2str(bluejay_num) '/lucas/birds/' birdname];
phrase=save_phrase;

% RUN
lt_all_days_ContextSeq_PLOT



% FOURTH: Pulling out probe trials 

% First, load the transitions_all_days or transitions_all_days_PLOT
% structure. Then run following (DO EACH OF THE THREE SEPARATELY)
clear all;
% con and div
savedir='/bluejay3/lucas/birds/rd66gr93/all_days_transitions_ContextSeq_analysis/PLOT/31May2014_to_04Jul2014_ConAndDiv_ab_11Sep2014_1900/';
filename='transitions_all_days_PLOT_31May2014_to_04Jul2014_ConAndDiv_ab_11Sep2014_1900';
Ylimits=[0.2, 0.7];
% div
% savedir='/bluejay3/lucas/birds/rd66gr93/all_days_transitions_ContextSeq_analysis/PLOT/31May2014_to_04Jul2014_ConAndDiv_ab_11Sep2014_1711/';
% filename='transitions_all_days_PLOT_31May2014_to_04Jul2014_ConAndDiv_ab_11Sep2014_1711';
% Ylimits=[0.75, 1];
% % conv
% savedir='/bluejay3/lucas/birds/rd66gr93/all_days_transitions_ContextSeq_analysis/PLOT/31May2014_to_04Jul2014_ConAndDiv_ab_11Sep2014_1711/';
% filename='transitions_all_days_PLOT_31May2014_to_04Jul2014_ConAndDiv_ab_11Sep2014_1711';
% Ylimits=[0.2, 0.7];



% INPUT PARAMETERS
% enter the probe epochs
probes_contextB = {'11Jun2014-1307_1556','16Jun2014-1234_1423','18Jun2014-1207_1332','19Jun2014-1218_1244','21Jun2014-1254_1519','24Jun2014-1238_1349', '26Jun2014-1226_1329',...
    '28Jun2014-1447_1549','01Jul2014-1228_1317','04Jul2014-1239_1343'}; % these: WN off during CB
probes_contextA_early = {'23Jun2014-1138_1302','25Jun2014-1038_1108','27Jun2014-0926_1025','02Jul2014-1144_1234'}; % these are WN played as probe in CA
probes_WNoff_contextB_late = {'29Jun2014-1659_1738', '30Jun2014-1628_1719','03Jul2014-1627_1709'}; % i.e. turned off WN in end of context B

% for plotting
edge_bin_size=6;
trn_to_plot='ab';
Xlimits=[1.8, 3.3];
title_pos = [0.5,1.05, 1]; % for the global title
% for saving
save_yes_no=1; % 1 means save, 0 means no
save_label=''; % suffix to filename
load([savedir filename])
lt_all_days_ContextSeq_PROBE_CompilePlot

% ASIDE: to check that the probe times entered there correctly extract the
% data, use the following - it lists the timepoints for all songs, and what
% the program thought.  Compare to your notes on 1) timing and 2) number of
% songs labeled.
lt_all_days_ContextSeq_PROBE_CompilePlot_CHECK;



%% 7/25 - looking at HIT RATE for jb/ab targetting (off target WN probe trial);

[a b]=triglabel2_LT('batch.catch.keep.OffTargWNe','b','a','',1,0,0,0);

[c d]=triglabel2_LT('batch.catch.keep.OffTargWNe','b','j','',1,0,0,0);

sum(a), sum(c),



%% 7/13 - looking at post (washout)days

% FIRST, compile transition data:
% going into each folder and getting transition data - do this after labeling and before compiling data into structure below
% run the below for each day folder (run either C1 or C2)
% if C1, then first separate b.c.k into b.c.k.early and b.c.k.late. Then
% run functions.  For C2, just use b.c.k. and run function.
clear all;close all

% INPUTS
folder_phrase='ContextSeq'; % marking the save folder
[nameofbird, bluejaynum, date, ~]=lt_get_birdname_date_from_dir(1);
datestring=date{2};

% RUN DIFFERENT DEPENDING ON CONTEXT

% context A
edit batch.catch.keep
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep.early',nameofbird,folder_phrase,'contextA_early',datestring);
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep.late',nameofbird,folder_phrase,'contextA_late',datestring);

%  context B
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep',nameofbird,folder_phrase,'contextB',datestring);

%% 6/25 - Compiling up to now

% FIRST, compile transition data:
% going into each folder and getting transition data - do this after labeling and before compiling data into structure below
% run the below for each day folder (run either C1 or C2)
% if C1, then first separate b.c.k into b.c.k.early and b.c.k.late. Then
% run functions.  For C2, just use b.c.k. and run function.
clear all;close all

% INPUTS
folder_phrase='ContextSeq'; % marking the save folder
[nameofbird, bluejaynum, date, ~]=lt_get_birdname_date_from_dir(1);
datestring=date{2};

% RUN DIFFERENT DEPENDING ON CONTEXT

% context A
edit batch.catch.keep
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep.early',nameofbird,folder_phrase,'contextA_early',datestring);
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep.late',nameofbird,folder_phrase,'contextA_late',datestring);

%  context B
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep',nameofbird,folder_phrase,'contextB',datestring);


% -------------------------------------------
% NOTE: DO EACH OF THE DIV/CONV/COMBINED SEPARATELY

% SECOND, COMPILE DATA for all contexts for a single day into one data structure.
% INSTRUCTIONS: 1) first run lt_get_all_transition_probabilities. 2) Then enter
% your parameters below and run to compile transition info over multiple
% contexts into one structure. 3) Run this in the bird folder!

% Con and Div combined
clear all; close all
% INPUTS
first_day='31May2014';
last_day='28Jun2014';
folder_phrase='ContextSeq'; %this marks the all_transitions folder (e.g. all_days_transition_matrix_ContextSeq)
motifs={'ab','aa','aj','an','bb','jb','nb'}; % BEST TO TAKE ALL TRANSITIONS AT A BRANCH POINT
context_label_set={'contextA_early','contextB','contextA_late'}; % enter the contexts that are stored in that structure (exactly as they are written in the saved structures (e.g. rd66gr93_01Jun2014_contextA_early.mat)
curr_dir=pwd;
save_phrase='ConAndDiv_ab';

lt_all_days_ContextSeq_COMPILE(first_day,last_day,folder_phrase,motifs,context_label_set,save_phrase,0)

cd(curr_dir);

% Divergence
clear all; close all
% INPUTS
first_day='31May2014';
last_day='28Jun2014';
folder_phrase='ContextSeq'; %this marks the all_transitions folder (e.g. all_days_transition_matrix_ContextSeq)
motifs={'ab','aa','aj','an'}; % BEST TO TAKE ALL TRANSITIONS AT A BRANCH POINT
context_label_set={'contextA_early','contextB','contextA_late'}; % enter the contexts that are stored in that structure (exactly as they are written in the saved structures (e.g. rd66gr93_01Jun2014_contextA_early.mat)
curr_dir=pwd;
save_phrase='div_a';

lt_all_days_ContextSeq_COMPILE(first_day,last_day,folder_phrase,motifs,context_label_set,save_phrase,0)

cd(curr_dir);
% 
% % Convergence
% clear all; close all
% % INPUTS
% first_day='31May2014';
% last_day='25Jun2014';
% folder_phrase='ContextSeq'; %this marks the all_transitions folder (e.g. all_days_transition_matrix_ContextSeq)
% motifs={'ab','bb','jb','nb'}; % BEST TO TAKE ALL TRANSITIONS AT A BRANCH POINT
% context_label_set={'contextA_early','contextB','contextA_late'}; % enter the contexts that are stored in that structure (exactly as they are written in the saved structures (e.g. rd66gr93_01Jun2014_contextA_early.mat)
% curr_dir=pwd;
% save_phrase='conv_b';
% 
% lt_all_days_ContextSeq_COMPILE(first_day,last_day,folder_phrase,motifs,context_label_set,save_phrase,0)
% 
% cd(curr_dir);


% It will ask you for context switch times.  Keep track of them below:
% -------------------------------------------------------------
% LIST OF CONTEXT SWITCH TIMES
% rd66 trial1:
{'31May2014-1205','31May2014-1658'}
{'01Jun2014-1305','01Jun2014-1730','01Jun2014-2030'}
{'02Jun2014-1210','02Jun2014-1707','02Jun2014-2030'}
{'03Jun2014-1225','03Jun2014-1723','03Jun2014-2030'}
{'04Jun2014-1205','04Jun2014-1213','04Jun2014-1703','04Jun2014-1757','04Jun2014-2035'}
{'05Jun2014-1133','05Jun2014-1135','05Jun2014-1208','05Jun2014-1716'}
{'06Jun2014-1201','06Jun2014-1714','06Jun2014-2019'}

{'07Jun2014-1218','07Jun2014-1724','07Jun2014-2032'}
{'08Jun2014-1238','08Jun2014-1722','08Jun2014-2005'}
{'09Jun2014-1317','09Jun2014-1712','09Jun2014-2100'}



%___________________________________________________________________________
% THIRD: Plot
% Uses the same parameters in "SECOND" above.  

% PLOT PARAMETERS
BaselineDays=1:4;
WNDays=[5:11, 13:16, 18, 21, 23];
ProbeDays= [12, 17, 19, 20, 22, 24, 25, 26, 27, 28, 29];

% PLOT PARAMETERS
% plotting across days
trn_to_plot='ab'; % for summary cross day data
num_renditions=6; % EDGES: how many songs to take at the edges
% plotting individual days
motifs_to_plot={trn_to_plot}; % for plotting each individual day
bin_size=3; % to change this you have to go back to making transitions, or incorporate that part here to make afresh

% ADDITIONAL INPUTS FOR PLOTTING
[birdname, bluejay_num]=lt_get_birdname_date_from_dir(0);
bird_dir=['/bluejay' num2str(bluejay_num) '/lucas/birds/' birdname];
phrase=save_phrase;

% RUN
lt_all_days_ContextSeq_PLOT


%___________________________________________________________________________
% FOURTH: Pulling out probe trials 

% First, load the transitions_all_days or transitions_all_days_PLOT
% structure. Then run following (DO EACH OF THE THREE SEPARATELY)
clear all;
% con and div
savedir='/bluejay3/lucas/birds/rd66gr93/all_days_transitions_ContextSeq_analysis/PLOT/31May2014_to_28Jun2014_ConAndDiv_ab_28Jun2014_1831/';
filename='transitions_all_days_PLOT_31May2014_to_28Jun2014_ConAndDiv_ab_28Jun2014_1831';
Ylimits=[0.2, 0.7];
% div
savedir='/bluejay3/lucas/birds/rd66gr93/all_days_transitions_ContextSeq_analysis/PLOT/31May2014_to_28Jun2014_div_a_28Jun2014_1843/';
filename='transitions_all_days_PLOT_31May2014_to_28Jun2014_div_a_28Jun2014_1843';
Ylimits=[0.75, 1];
% % conv
% savedir='/bluejay3/lucas/birds/rd66gr93/all_days_transitions_ContextSeq_analysis/PLOT/31May2014_to_25Jun2014_conv_b_25Jun2014_1436/';
% filename='transitions_all_days_PLOT_31May2014_to_25Jun2014_conv_b_25Jun2014_1436';
% Ylimits=[0.2, 0.7];



% INPUT PARAMETERS
% enter the probe epochs
probes_contextB = {'11Jun2014-1307_1556','16Jun2014-1234_1423','18Jun2014-1207_1332','19Jun2014-1218_1244','21Jun2014-1254_1519','24Jun2014-1238_1349', '26Jun2014-1226_1329',...
    '28Jun2014-1447_1549'}; % these: WN off during CB
probes_contextA_early = {'23Jun2014-1138_1302','25Jun2014-1038_1108','27Jun2014-0926_1025'}; % these are WN played as probe in CA

% for plotting
edge_bin_size=6;
trn_to_plot='ab';
Xlimits=[1.8, 3.3];
title_pos = [0.5,1.05, 1]; % for the global title
% for saving
save_yes_no=0; % 1 means save, 0 means no
save_label=''; % suffix to filename
load([savedir filename])
lt_all_days_ContextSeq_PROBE_CompilePlot

% ASIDE: to check that the probe times entered there correctly extract the
% data, use the following - it lists the timepoints for all songs, and what
% the program thought.  Compare to your notes on 1) timing and 2) number of
% songs labeled.
lt_all_days_ContextSeq_PROBE_CompilePlot_CHECK;



%% 6/25 - Compiling up to now

% FIRST, compile transition data:
% going into each folder and getting transition data - do this after labeling and before compiling data into structure below
% run the below for each day folder (run either C1 or C2)
% if C1, then first separate b.c.k into b.c.k.early and b.c.k.late. Then
% run functions.  For C2, just use b.c.k. and run function.
clear all;close all

% INPUTS
folder_phrase='ContextSeq'; % marking the save folder
[nameofbird, bluejaynum, date, ~]=lt_get_birdname_date_from_dir(1);
datestring=date{2};

% RUN DIFFERENT DEPENDING ON CONTEXT

% context A
edit batch.catch.keep
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep.early',nameofbird,folder_phrase,'contextA_early',datestring);
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep.late',nameofbird,folder_phrase,'contextA_late',datestring);

%  context B
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep',nameofbird,folder_phrase,'contextB',datestring);


% -------------------------------------------
% NOTE: DO EACH OF THE DIV/CONV/COMBINED SEPARATELY

% SECOND, COMPILE DATA for all contexts for a single day into one data structure.
% INSTRUCTIONS: 1) first run lt_get_all_transition_probabilities. 2) Then enter
% your parameters below and run to compile transition info over multiple
% contexts into one structure. 3) Run this in the bird folder!

% Con and Div combined
clear all; close all
% INPUTS
first_day='31May2014';
last_day='25Jun2014';
folder_phrase='ContextSeq'; %this marks the all_transitions folder (e.g. all_days_transition_matrix_ContextSeq)
motifs={'ab','aa','aj','an','bb','jb','nb'}; % BEST TO TAKE ALL TRANSITIONS AT A BRANCH POINT
context_label_set={'contextA_early','contextB','contextA_late'}; % enter the contexts that are stored in that structure (exactly as they are written in the saved structures (e.g. rd66gr93_01Jun2014_contextA_early.mat)
curr_dir=pwd;
save_phrase='ConAndDiv_ab';

lt_all_days_ContextSeq_COMPILE(first_day,last_day,folder_phrase,motifs,context_label_set,save_phrase,0)

cd(curr_dir);

% Divergence
clear all; close all
% INPUTS
first_day='31May2014';
last_day='25Jun2014';
folder_phrase='ContextSeq'; %this marks the all_transitions folder (e.g. all_days_transition_matrix_ContextSeq)
motifs={'ab','aa','aj','an'}; % BEST TO TAKE ALL TRANSITIONS AT A BRANCH POINT
context_label_set={'contextA_early','contextB','contextA_late'}; % enter the contexts that are stored in that structure (exactly as they are written in the saved structures (e.g. rd66gr93_01Jun2014_contextA_early.mat)
curr_dir=pwd;
save_phrase='div_a';

lt_all_days_ContextSeq_COMPILE(first_day,last_day,folder_phrase,motifs,context_label_set,save_phrase,0)

cd(curr_dir);

% Convergence
clear all; close all
% INPUTS
first_day='31May2014';
last_day='25Jun2014';
folder_phrase='ContextSeq'; %this marks the all_transitions folder (e.g. all_days_transition_matrix_ContextSeq)
motifs={'ab','bb','jb','nb'}; % BEST TO TAKE ALL TRANSITIONS AT A BRANCH POINT
context_label_set={'contextA_early','contextB','contextA_late'}; % enter the contexts that are stored in that structure (exactly as they are written in the saved structures (e.g. rd66gr93_01Jun2014_contextA_early.mat)
curr_dir=pwd;
save_phrase='conv_b';

lt_all_days_ContextSeq_COMPILE(first_day,last_day,folder_phrase,motifs,context_label_set,save_phrase,0)

cd(curr_dir);


% It will ask you for context switch times.  Keep track of them below:
% -------------------------------------------------------------
% LIST OF CONTEXT SWITCH TIMES
% rd66 trial1:
{'31May2014-1205','31May2014-1658'}
{'01Jun2014-1305','01Jun2014-1730','01Jun2014-2030'}
{'02Jun2014-1210','02Jun2014-1707','02Jun2014-2030'}
{'03Jun2014-1225','03Jun2014-1723','03Jun2014-2030'}
{'04Jun2014-1205','04Jun2014-1213','04Jun2014-1703','04Jun2014-1757','04Jun2014-2035'}
{'05Jun2014-1133','05Jun2014-1135','05Jun2014-1208','05Jun2014-1716'}
{'06Jun2014-1201','06Jun2014-1714','06Jun2014-2019'}

{'07Jun2014-1218','07Jun2014-1724','07Jun2014-2032'}
{'08Jun2014-1238','08Jun2014-1722','08Jun2014-2005'}
{'09Jun2014-1317','09Jun2014-1712','09Jun2014-2100'}



%___________________________________________________________________________
% THIRD: Plot
% Uses the same parameters in "SECOND" above.  

% PLOT PARAMETERS
BaselineDays=1:4;
WNDays=[5:11, 13:16, 18, 21, 23];
ProbeDays= [12, 17, 19, 20, 22, 24, 25, 26];

% PLOT PARAMETERS
% plotting across days
trn_to_plot='ab'; % for summary cross day data
num_renditions=6; % EDGES: how many songs to take at the edges
% plotting individual days
motifs_to_plot={trn_to_plot}; % for plotting each individual day
bin_size=3; % to change this you have to go back to making transitions, or incorporate that part here to make afresh

% ADDITIONAL INPUTS FOR PLOTTING
[birdname, bluejay_num]=lt_get_birdname_date_from_dir(0);
bird_dir=['/bluejay' num2str(bluejay_num) '/lucas/birds/' birdname];
phrase=save_phrase;

% RUN
lt_all_days_ContextSeq_PLOT


%___________________________________________________________________________
% FOURTH: Pulling out probe trials 

% First, load the transitions_all_days or transitions_all_days_PLOT
% structure. Then run following (DO EACH OF THE THREE SEPARATELY)
clear all;
% con and div
savedir='/bluejay3/lucas/birds/rd66gr93/all_days_transitions_ContextSeq_analysis/PLOT/31May2014_to_25Jun2014_ConAndDiv_ab_25Jun2014_1408/';
filename='transitions_all_days_PLOT_31May2014_to_25Jun2014_ConAndDiv_ab_25Jun2014_1408';
Ylimits=[0.2, 0.7];
% div
savedir='/bluejay3/lucas/birds/rd66gr93/all_days_transitions_ContextSeq_analysis/PLOT/31May2014_to_25Jun2014_div_a_25Jun2014_1434/';
filename='transitions_all_days_PLOT_31May2014_to_25Jun2014_div_a_25Jun2014_1434';
Ylimits=[0.75, 1];
% conv
savedir='/bluejay3/lucas/birds/rd66gr93/all_days_transitions_ContextSeq_analysis/PLOT/31May2014_to_25Jun2014_conv_b_25Jun2014_1436/';
filename='transitions_all_days_PLOT_31May2014_to_25Jun2014_conv_b_25Jun2014_1436';
Ylimits=[0.2, 0.7];



% INPUT PARAMETERS
% enter the probe epochs
probes_contextB = {'11Jun2014-1308_1556','16Jun2014-1235_1423','18Jun2014-1208_1332','19Jun2014-1219_1244','21Jun2014-1255_1519','24Jun2014-1239_1349'}; % these: WN off during CB
probes_contextA_early = {'23Jun2014-1138_1302','25Jun2014-1038_1108'}; % these are WN played as probe in CA
% for plotting
edge_bin_size=6;
trn_to_plot='ab';
Xlimits=[1.8, 3.3];
title_pos = [0.5,1.05, 1]; % for the global title
% for saving
save_yes_no=0; % 1 means save, 0 means no
save_label=''; % suffix to filename
load([savedir filename])
lt_all_days_ContextSeq_PROBE_CompilePlot

% ASIDE: to check that the probe times entered there correctly extract the
% data, use the following - it lists the timepoints for all songs, and what
% the program thought.  Compare to your notes on 1) timing and 2) number of
% songs labeled.
lt_all_days_ContextSeq_PROBE_CompilePlot_CHECK;


%% 6/24 - Compiling all data up to now

% FIRST, compile transition data:
% going into each folder and getting transition data - do this after labeling and before compiling data into structure below
% run the below for each day folder (run either C1 or C2)
% if C1, then first separate b.c.k into b.c.k.early and b.c.k.late. Then
% run functions.  For C2, just use b.c.k. and run function.
clear all;close all

% INPUTS
folder_phrase='ContextSeq'; % marking the save folder
[nameofbird, bluejaynum, date, ~]=lt_get_birdname_date_from_dir(1);
datestring=date{2};

% RUN DIFFERENT DEPENDING ON CONTEXT

% context A
edit batch.catch.keep
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep.early',nameofbird,folder_phrase,'contextA_early',datestring);
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep.late',nameofbird,folder_phrase,'contextA_late',datestring);

%  context B
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep',nameofbird,folder_phrase,'contextB',datestring);


% -------------------------------------------
% NOTE: DO EACH OF THE DIV/CONV/COMBINED SEPARATELY

% SECOND, COMPILE DATA for all contexts for a single day into one data structure.
% INSTRUCTIONS: 1) first run lt_get_all_transition_probabilities. 2) Then enter
% your parameters below and run to compile transition info over multiple
% contexts into one structure. 3) Run this in the bird folder!

% Con and Div combined
clear all; close all
% INPUTS
first_day='31May2014';
last_day='24Jun2014';
folder_phrase='ContextSeq'; %this marks the all_transitions folder (e.g. all_days_transition_matrix_ContextSeq)
motifs={'ab','aa','aj','an','bb','jb','nb'}; % BEST TO TAKE ALL TRANSITIONS AT A BRANCH POINT
context_label_set={'contextA_early','contextB','contextA_late'}; % enter the contexts that are stored in that structure (exactly as they are written in the saved structures (e.g. rd66gr93_01Jun2014_contextA_early.mat)
curr_dir=pwd;
save_phrase='ConAndDiv_ab';

lt_all_days_ContextSeq_COMPILE(first_day,last_day,folder_phrase,motifs,context_label_set,save_phrase)

cd(curr_dir);

% Divergence
clear all; close all
% INPUTS
first_day='31May2014';
last_day='24Jun2014';
folder_phrase='ContextSeq'; %this marks the all_transitions folder (e.g. all_days_transition_matrix_ContextSeq)
motifs={'ab','aa','aj','an'}; % BEST TO TAKE ALL TRANSITIONS AT A BRANCH POINT
context_label_set={'contextA_early','contextB','contextA_late'}; % enter the contexts that are stored in that structure (exactly as they are written in the saved structures (e.g. rd66gr93_01Jun2014_contextA_early.mat)
curr_dir=pwd;
save_phrase='div_a';

lt_all_days_ContextSeq_COMPILE(first_day,last_day,folder_phrase,motifs,context_label_set,save_phrase)

cd(curr_dir);

% Convergence
clear all; close all
% INPUTS
first_day='31May2014';
last_day='24Jun2014';
folder_phrase='ContextSeq'; %this marks the all_transitions folder (e.g. all_days_transition_matrix_ContextSeq)
motifs={'ab','bb','jb','nb'}; % BEST TO TAKE ALL TRANSITIONS AT A BRANCH POINT
context_label_set={'contextA_early','contextB','contextA_late'}; % enter the contexts that are stored in that structure (exactly as they are written in the saved structures (e.g. rd66gr93_01Jun2014_contextA_early.mat)
curr_dir=pwd;
save_phrase='conv_b';

lt_all_days_ContextSeq_COMPILE(first_day,last_day,folder_phrase,motifs,context_label_set,save_phrase)

cd(curr_dir);


% It will ask you for context switch times.  Keep track of them below:
% -------------------------------------------------------------
% LIST OF CONTEXT SWITCH TIMES
% rd66 trial1:
{'31May2014-1205','31May2014-1658'}
{'01Jun2014-1305','01Jun2014-1730','01Jun2014-2030'}
{'02Jun2014-1210','02Jun2014-1707','02Jun2014-2030'}
{'03Jun2014-1225','03Jun2014-1723','03Jun2014-2030'}
{'04Jun2014-1205','04Jun2014-1213','04Jun2014-1703','04Jun2014-1757','04Jun2014-2035'}
{'05Jun2014-1133','05Jun2014-1135','05Jun2014-1208','05Jun2014-1716'}
{'06Jun2014-1201','06Jun2014-1714','06Jun2014-2019'}

{'07Jun2014-1218','07Jun2014-1724','07Jun2014-2032'}
{'08Jun2014-1238','08Jun2014-1722','08Jun2014-2005'}
{'09Jun2014-1317','09Jun2014-1712','09Jun2014-2100'}



%___________________________________________________________________________
% THIRD: Plot
% Uses the same parameters in "SECOND" above.  

% PLOT PARAMETERS
BaselineDays=1:4;
WNDays=[5:11, 13:16, 18, 21, 23];
ProbeDays= [12, 17, 19, 20, 22, 24, 25];

% PLOT PARAMETERS
% plotting across days
trn_to_plot='ab'; % for summary cross day data
num_renditions=6; % EDGES: how many songs to take at the edges
% plotting individual days
motifs_to_plot={trn_to_plot}; % for plotting each individual day
bin_size=3; % to change this you have to go back to making transitions, or incorporate that part here to make afresh

% ADDITIONAL INPUTS FOR PLOTTING
[birdname, bluejay_num]=lt_get_birdname_date_from_dir(0);
bird_dir=['/bluejay' num2str(bluejay_num) '/lucas/birds/' birdname];
phrase=save_phrase;

% RUN
lt_all_days_ContextSeq_PLOT


%___________________________________________________________________________
% FOURTH: Pulling out probe trials 

% First, load the transitions_all_days or transitions_all_days_PLOT
% structure. Then run following (DO EACH OF THE THREE SEPARATELY)
clear all;
% con and div
savedir='/bluejay3/lucas/birds/rd66gr93/all_days_transitions_ContextSeq_analysis/PLOT/31May2014_to_24Jun2014_ConAndDiv_ab_24Jun2014_1959/';
filename='transitions_all_days_PLOT_31May2014_to_24Jun2014_ConAndDiv_ab_24Jun2014_1959';
Ylimits=[0.2, 0.7];
% div
savedir='/bluejay3/lucas/birds/rd66gr93/all_days_transitions_ContextSeq_analysis/PLOT/31May2014_to_24Jun2014_div_a_24Jun2014_2344/';
filename='transitions_all_days_PLOT_31May2014_to_24Jun2014_div_a_24Jun2014_2344';
Ylimits=[0.75, 1];
% conv
savedir='/bluejay3/lucas/birds/rd66gr93/all_days_transitions_ContextSeq_analysis/PLOT/31May2014_to_24Jun2014_conv_b_24Jun2014_2351/';
filename='transitions_all_days_PLOT_31May2014_to_24Jun2014_conv_b_24Jun2014_2351';
Ylimits=[0.2, 0.7];



% INPUT PARAMETERS
% enter the probe epochs
probes_contextB = {'11Jun2014-1308_1556','16Jun2014-1235_1423','18Jun2014-1208_1332','19Jun2014-1219_1244','21Jun2014-1255_1519','24Jun2014-1239_1348'}; % these: WN off during CB
probes_contextA_early = {'23Jun2014-1138_1301'}; % these are WN played as probe in CA
% for plotting
edge_bin_size=6;
trn_to_plot='ab';
Xlimits=[1.8, 3.3];
title_pos = [0.5,1.05, 1]; % for the global title
% for saving
save_yes_no=0; % 1 means save, 0 means no

load([savedir filename])
lt_all_days_ContextSeq_PROBE_CompilePlot


%% 6/24/14 - Writing event times to one structure to be used repeatedly, Will also be used to pull out all similar things, such as probe trials, etc
% IN PROGRESS
% num_days=5 % each successive day
% for i=1:num_days;
%     event_times.ALL_event_switch_times{i}=transitions_all_days.data{i}.context_switch_times;
%     %     event_times.just_context_switch_times=;
%     %     event_times.feed_times
%     event_times.contextA_probe{i}={};
%     event_times.contextB_probe{i}={};
% end
% 
% 
% % ENTER ANYTHING MANUALLY - compile over course of experiment
% event_times.ALL_event_switch_times{i}=transitions_all_days.data{i}.context_switch_times;
% %     event_times.just_context_switch_times=;
% %     event_times.feed_times
% event_times.contextA_probe{i}={};
% event_times.contextB_probe{i}={};
% 
% 



%% CONTEXT SEQ, DUR WN - 6/10 - (added 6/10 data for last section, but did not save)

% FIRST, compile transition data:
% going into each folder and getting transition data - do this after labeling and before compiling data into structure below
% run the below for each day folder (run either C1 or C2)
% if C1, then first separate b.c.k into b.c.k.early and b.c.k.late. Then
% run functions.  For C2, just use b.c.k. and run function.
clear all;close all

% INPUTS
folder_phrase='ContextSeq'; % marking the save folder
[nameofbird, bluejaynum, date, ~]=lt_get_birdname_date_from_dir(1);
datestring=date{2};

% RUN DIFFERENT DEPENDING ON CONTEXT

% context A
edit batch.catch.keep
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep.early',nameofbird,folder_phrase,'contextA_early',datestring);
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep.late',nameofbird,folder_phrase,'contextA_late',datestring);

%  context B
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep',nameofbird,folder_phrase,'contextB',datestring);


% __________________________________________________________
% SECOND, COMPILE DATA for all contexts for a single day into one data structure.
% INSTRUCTIONS: 1) first run lt_get_all_transition_probabilities. 2) Then enter
% your parameters below and run to compile transition info over multiple
% contexts into one structure. 3) Run this in the bird folder!

clear all; close all
% INPUTS
first_day='31May2014';
last_day='09Jun2014';
folder_phrase='ContextSeq'; %this marks the all_transitions folder (e.g. all_days_transition_matrix_ContextSeq)
motifs={'aa','ab','aj','an'}; % BEST TO TAKE ALL TRANSITIONS AT A BRANCH POINT
% motifs={'aa','ab','aj','an'}; % BEST TO TAKE ALL TRANSITIONS AT A BRANCH POINT
context_label_set={'contextA_early','contextB','contextA_late'}; % enter the contexts that are stored in that structure (exactly as they are written in the saved structures (e.g. rd66gr93_01Jun2014_contextA_early.mat)
curr_dir=pwd;
save_phrase='div_a';

lt_all_days_ContextSeq_COMPILE(first_day,last_day,folder_phrase,motifs,context_label_set,save_phrase)

cd(curr_dir);


% It will ask you for context switch times.  Keep track of them below:
% -------------------------------------------------------------
% LIST OF CONTEXT SWITCH TIMES
% rd66 trial1:
{'31May2014-1205','31May2014-1658'}
{'01Jun2014-1305','01Jun2014-1730','01Jun2014-2030'}
{'02Jun2014-1210','02Jun2014-1707','02Jun2014-2030'}
{'03Jun2014-1225','03Jun2014-1723','03Jun2014-2030'}
{'04Jun2014-1205','04Jun2014-1213','04Jun2014-1703','04Jun2014-1757','04Jun2014-2035'}
{'05Jun2014-1133','05Jun2014-1135','05Jun2014-1208','05Jun2014-1716'}
{'06Jun2014-1201','06Jun2014-1714','06Jun2014-2019'}

{'07Jun2014-1218','07Jun2014-1724','07Jun2014-2032'}
{'08Jun2014-1238','08Jun2014-1722','08Jun2014-2005'}
{'09Jun2014-1317','09Jun2014-1712','09Jun2014-2100'}



%___________________________________________________________________________
% THIRD: Plot
% Uses the same parameters in "SECOND" above.  

% PLOT PARAMETERS
BaselineDays=1:4;
WNDays=5:10;
ProbeDays=[];

% PLOT PARAMETERS
% plotting across days
trn_to_plot='ab'; % for summary cross day data
num_renditions=6; % EDGES: how many songs to take at the edges
% plotting individual days
motifs_to_plot={trn_to_plot}; % for plotting each individual day
bin_size=3; % to change this you have to go back to making transitions, or incorporate that part here to make afresh

% ADDITIONAL INPUTS FOR PLOTTING
[birdname, bluejay_num]=lt_get_birdname_date_from_dir(0);
bird_dir=['/bluejay' num2str(bluejay_num) '/lucas/birds/' birdname];
phrase='div_a';

% RUN
lt_all_days_ContextSeq_PLOT


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DOING SAME AS ABOVE, but for convergent transitions.

% __________________________________________________________
% SECOND, COMPILE DATA for all contexts for a single day into one data structure.
% INSTRUCTIONS: 1) first run lt_get_all_transition_probabilities. 2) Then enter
% your parameters below and run to compile transition info over multiple
% contexts into one structure. 3) Run this in the bird folder!

clear all; close all
% INPUTS
first_day='31May2014';
last_day='09Jun2014';
folder_phrase='ContextSeq'; %this marks the all_transitions folder (e.g. all_days_transition_matrix_ContextSeq)
% motifs={'aa','ab','aj','an'}; % BEST TO TAKE ALL TRANSITIONS AT A BRANCH POINT
motifs={'ab','bb','jb','nb'}; % BEST TO TAKE ALL TRANSITIONS AT A BRANCH POINT
context_label_set={'contextA_early','contextB','contextA_late'}; % enter the contexts that are stored in that structure (exactly as they are written in the saved structures (e.g. rd66gr93_01Jun2014_contextA_early.mat)
curr_dir=pwd;
save_phrase='conv_b';

lt_all_days_ContextSeq_COMPILE(first_day,last_day,folder_phrase,motifs,context_label_set,save_phrase)

cd(curr_dir);

%___________________________________________________________________________
% THIRD: Plot
% Uses the same parameters in "SECOND" above.  

% PLOT PARAMETERS
BaselineDays=1:4;
WNDays=5:10;
ProbeDays=[];

% PLOT PARAMETERS
% plotting across days
trn_to_plot='ab'; % for summary cross day data
num_renditions=6; % EDGES: how many songs to take at the edges
% plotting individual days
motifs_to_plot={trn_to_plot}; % for plotting each individual day
bin_size=3; % to change this you have to go back to making transitions, or incorporate that part here to make afresh

% ADDITIONAL INPUTS FOR PLOTTING
[birdname, bluejay_num]=lt_get_birdname_date_from_dir(0);
bird_dir=['/bluejay' num2str(bluejay_num) '/lucas/birds/' birdname];
phrase='conv_b';

% RUN
lt_all_days_ContextSeq_PLOT


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Same as above, but combining a[] (div from a) and []b conv to b, to
% quantify how well he adapts both transitions together.
% __________________________________________________________
% SECOND, COMPILE DATA for all contexts for a single day into one data structure.
% INSTRUCTIONS: 1) first run lt_get_all_transition_probabilities. 2) Then enter
% your parameters below and run to compile transition info over multiple
% contexts into one structure. 3) Run this in the bird folder!

clear all; close all
% INPUTS
first_day='31May2014';
last_day='10Jun2014';
folder_phrase='ContextSeq'; %this marks the all_transitions folder (e.g. all_days_transition_matrix_ContextSeq)
motifs={'ab','aa','aj','an','bb','jb','nb'}; % BEST TO TAKE ALL TRANSITIONS AT A BRANCH POINT
context_label_set={'contextA_early','contextB','contextA_late'}; % enter the contexts that are stored in that structure (exactly as they are written in the saved structures (e.g. rd66gr93_01Jun2014_contextA_early.mat)
curr_dir=pwd;
save_phrase='ConAndDiv_ab';

lt_all_days_ContextSeq_COMPILE(first_day,last_day,folder_phrase,motifs,context_label_set,save_phrase)

cd(curr_dir);


% It will ask you for context switch times.  Keep track of them below:
% -------------------------------------------------------------
% LIST OF CONTEXT SWITCH TIMES
% rd66 trial1:
{'31May2014-1205','31May2014-1658'}
{'01Jun2014-1305','01Jun2014-1730','01Jun2014-2030'}
{'02Jun2014-1210','02Jun2014-1707','02Jun2014-2030'}
{'03Jun2014-1225','03Jun2014-1723','03Jun2014-2030'}
{'04Jun2014-1205','04Jun2014-1213','04Jun2014-1703','04Jun2014-1757','04Jun2014-2035'}
{'05Jun2014-1133','05Jun2014-1135','05Jun2014-1208','05Jun2014-1716'}
{'06Jun2014-1201','06Jun2014-1714','06Jun2014-2019'}

{'07Jun2014-1218','07Jun2014-1724','07Jun2014-2032'}
{'08Jun2014-1238','08Jun2014-1722','08Jun2014-2005'}
{'09Jun2014-1317','09Jun2014-1712','09Jun2014-2100'}



%___________________________________________________________________________
% THIRD: Plot
% Uses the same parameters in "SECOND" above.  

% PLOT PARAMETERS
BaselineDays=1:4;
WNDays=5:11;
ProbeDays=[];

% PLOT PARAMETERS
% plotting across days
trn_to_plot='ab'; % for summary cross day data
num_renditions=3; % EDGES: how many songs to take at the edges
% plotting individual days
motifs_to_plot={trn_to_plot}; % for plotting each individual day
bin_size=3; % to change this you have to go back to making transitions, or incorporate that part here to make afresh

% ADDITIONAL INPUTS FOR PLOTTING
[birdname, bluejay_num]=lt_get_birdname_date_from_dir(0);
bird_dir=['/bluejay' num2str(bluejay_num) '/lucas/birds/' birdname];
phrase=save_phrase;

% RUN
lt_all_days_ContextSeq_PLOT




%% CONTEXT SEQ EXPERIMENT, DUR WN analysis - 6/7/14

% FIRST, compile transition data:
% going into each folder and getting transition data - do this after labeling and before compiling data into structure below
% run the below for each day folder (run either C1 or C2)
% if C1, then first separate b.c.k into b.c.k.early and b.c.k.late. Then
% run functions.  For C2, just use b.c.k. and run function.
clear all;close all

% INPUTS
folder_phrase='ContextSeq'; % marking the save folder
[nameofbird, bluejaynum, date, ~]=lt_get_birdname_date_from_dir(1);
datestring=date{2};

% RUN DIFFERENT DEPENDING ON CONTEXT

% context A
edit batch.catch.keep
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep.early',nameofbird,folder_phrase,'contextA_early',datestring);
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep.late',nameofbird,folder_phrase,'contextA_late',datestring);

%  context B
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep',nameofbird,folder_phrase,'contextB',datestring);


% __________________________________________________________
% SECOND, COMPILE DATA for all contexts for a single day into one data structure.
% INSTRUCTIONS: 1) first run lt_get_all_transition_probabilities. 2) Then enter
% your parameters below and run to compile transition info over multiple
% contexts into one structure. 3) Run this in the bird folder!

clear all; close all
% INPUTS
first_day='31May2014';
last_day='06Jun2014';
folder_phrase='ContextSeq'; %this marks the all_transitions folder (e.g. all_days_transition_matrix_ContextSeq)
motifs={'aa','ab','aj','an'}; % BEST TO TAKE ALL TRANSITIONS AT A BRANCH POINT
% motifs={'aa','ab','aj','an'}; % BEST TO TAKE ALL TRANSITIONS AT A BRANCH POINT
context_label_set={'contextA_early','contextB','contextA_late'}; % enter the contexts that are stored in that structure (exactly as they are written in the saved structures (e.g. rd66gr93_01Jun2014_contextA_early.mat)
curr_dir=pwd;
save_phrase='div_a';

lt_all_days_ContextSeq_COMPILE(first_day,last_day,folder_phrase,motifs,context_label_set,save_phrase)

cd(curr_dir);


% It will ask you for context switch times.  Keep track of them below:
% -------------------------------------------------------------
% LIST OF CONTEXT SWITCH TIMES
% rd66 trial1:
% {'31May2014-1205','31May2014-1658'}
% {'01Jun2014-1305','01Jun2014-1730','01Jun2014-2030'}
% {'02Jun2014-1210','02Jun2014-1707','02Jun2014-2030'}
% {'03Jun2014-1225','03Jun2014-1723','03Jun2014-2030'}
% {'04Jun2014-1205','04Jun2014-1213','04Jun2014-1703','04Jun2014-1757','04Jun2014-2035'}
% {'05Jun2014-1133','05Jun2014-1135','05Jun2014-1208','05Jun2014-1716'}
% {'06Jun2014-1201','06Jun2014-1714','06Jun2014-2019'}


%___________________________________________________________________________
% THIRD: Plot
% Uses the same parameters in "SECOND" above.  

% PLOT PARAMETERS
BaselineDays=1:4;
WNDays=5:7;
ProbeDays=[];

% PLOT PARAMETERS
% plotting across days
trn_to_plot='ab'; % for summary cross day data
num_renditions=8; % EDGES: how many songs to take at the edges
% plotting individual days
motifs_to_plot={trn_to_plot}; % for plotting each individual day
bin_size=3; % to change this you have to go back to making transitions, or incorporate that part here to make afresh

% ADDITIONAL INPUTS FOR PLOTTING
[birdname, bluejay_num]=lt_get_birdname_date_from_dir(0);
bird_dir=['/bluejay' num2str(bluejay_num) '/lucas/birds/' birdname];
phrase='div_a';

% RUN
lt_all_days_ContextSeq_PLOT





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DOING SAME AS ABOVE, but for convergent transitions.

% __________________________________________________________
% SECOND, COMPILE DATA for all contexts for a single day into one data structure.
% INSTRUCTIONS: 1) first run lt_get_all_transition_probabilities. 2) Then enter
% your parameters below and run to compile transition info over multiple
% contexts into one structure. 3) Run this in the bird folder!

clear all; close all
% INPUTS
first_day='31May2014';
last_day='06Jun2014';
folder_phrase='ContextSeq'; %this marks the all_transitions folder (e.g. all_days_transition_matrix_ContextSeq)
% motifs={'aa','ab','aj','an'}; % BEST TO TAKE ALL TRANSITIONS AT A BRANCH POINT
motifs={'ab','bb','jb','nb'}; % BEST TO TAKE ALL TRANSITIONS AT A BRANCH POINT
context_label_set={'contextA_early','contextB','contextA_late'}; % enter the contexts that are stored in that structure (exactly as they are written in the saved structures (e.g. rd66gr93_01Jun2014_contextA_early.mat)
curr_dir=pwd;
save_phrase='conv_b';

lt_all_days_ContextSeq_COMPILE(first_day,last_day,folder_phrase,motifs,context_label_set,save_phrase)

cd(curr_dir);


% It will ask you for context switch times.  Keep track of them below:
% -------------------------------------------------------------
% LIST OF CONTEXT SWITCH TIMES
% rd66 trial1:
{'31May2014-1205','31May2014-1658'}
{'01Jun2014-1305','01Jun2014-1730','01Jun2014-2030'}
{'02Jun2014-1210','02Jun2014-1707','02Jun2014-2030'}
{'03Jun2014-1225','03Jun2014-1723','03Jun2014-2030'}
{'04Jun2014-1205','04Jun2014-1213','04Jun2014-1703','04Jun2014-1757','04Jun2014-2035'}
{'05Jun2014-1133','05Jun2014-1135','05Jun2014-1208','05Jun2014-1716'}
{'06Jun2014-1201','06Jun2014-1714','06Jun2014-2019'}


%___________________________________________________________________________
% THIRD: Plot
% Uses the same parameters in "SECOND" above.  

% PLOT PARAMETERS
BaselineDays=1:4;
WNDays=5:7;
ProbeDays=[];

% PLOT PARAMETERS
% plotting across days
trn_to_plot='ab'; % for summary cross day data
num_renditions=20; % EDGES: how many songs to take at the edges
% plotting individual days
motifs_to_plot={trn_to_plot}; % for plotting each individual day
bin_size=3; % to change this you have to go back to making transitions, or incorporate that part here to make afresh

% ADDITIONAL INPUTS FOR PLOTTING
[birdname, bluejay_num]=lt_get_birdname_date_from_dir(0);
bird_dir=['/bluejay' num2str(bluejay_num) '/lucas/birds/' birdname];
phrase='conv_b';

% RUN
lt_all_days_ContextSeq_PLOT



%%

1/28
        'a'       'b'       'c'       'j'       'm'       'n'       'p'      'x'
         0    0.8904         0         0    0.0205    0.0890         0         0
    0.0032    0.2627    0.6108    0.0032    0.0127    0.1013    0.0032    0.0032
    0.4392         0         0    0.5556    0.0053         0         0         0
         0    1.0000         0         0         0         0         0         0
    1.0000         0         0         0         0         0         0         0
    1.0000         0         0         0         0         0         0         0
    1.0000         0         0         0         0         0         0         0
    1.0000         0         0         0         0         0         0         0

1/29


    'a'    'b'    'c'    'j'    'm'    'n'    'p'

         0    0.9850         0         0    0.0150         0         0
    0.0066    0.2881    0.6623         0    0.0132    0.0265    0.0033
    0.5670         0         0    0.4330         0         0         0
         0    1.0000         0         0         0         0         0
    1.0000         0         0         0         0         0         0
    1.0000         0         0         0         0         0         0
    1.0000         0         0         0         0         0         0

%% looking at specific transitions per day

% 1) ab, an, am, ----------------------
% 2) ab, jb, -----------------------------
% 3) b-->[]
% 4) n-->[]

% NOTES: 2/2 div from n seems to have many more options.
%  repeats of b increased so that b-b dominates divergence from b.
% targeted divergence not decreased substantially (ab). (LOW WN HIT RATE).
% No new conv or divergent.


% DIVERGENT -----------------------
first_syl='a';
transition_struct=struct2cell(all_trans.(first_syl).transition_to_);
% transition_array=cell2mat(transition_struct)

xlabels=[];
second_syl_names=fieldnames(all_trans.(first_syl).transition_to_);

figure; hold on
for i=1:size(transition_struct,1);
    scatter(i,transition_struct{i}.relative_fraction_of_trans,'k');
    xlabels{i}=[first_syl second_syl_names{i}];
end

set(gca,'XTickLabel',xlabels)
title(['fraction of divergent transitions from ' first_syl ' on ' all_trans.parameters.date_of_exp 'for bird ' all_trans.parameters.bird_name]);
ylabel('fraction')

% CONVERGENT ------------------------
second_syl='b';
transition_struct=struct2cell(all_trans.convergent_to.(second_syl).from);
% transition_array=cell2mat(transition_struct)

xlabels=[];
first_syl_names=fieldnames(all_trans.convergent_to.(second_syl).from);

figure; hold on
for i=1:size(transition_struct,1);
    scatter(i,transition_struct{i}.fraction_of_trans,'k');
    xlabels{i}=[first_syl_names{i} second_syl];
end

set(gca,'XTickLabel',xlabels)
title(['fraction of convergent transitions to ' second_syl ' on ' all_trans.parameters.date_of_exp 'for bird ' all_trans.parameters.bird_name]);
ylabel('fraction')

%%        in order  to check hit rate with birdtaf, use triglabel2

batch='batch.catch.keep';
[a b] = triglabel2(batch','b','a','',1,0,0,0);

sum(a)


%% in order to get transition probabilites
lt_get_all_transition_probabilities


%% 4/25/14 - are there more b's in repeats in adult WN learning (during)? 

% quick calculation: went to each date folder and ran following code (this
% plots histogram of repeats as well as mean and std

clear all
[ matrix_repeat_length, cell_repeat_length ]=db_repeat_syllable_count('batch.catch.keep', '[j]b','[^b]');

mat_repeat_overone=matrix_repeat_length(matrix_repeat_length>1);

figure; hold on;
hist(mat_repeat_overone,20)

mean(mat_repeat_overone)
std(mat_repeat_overone)

% RESULTS: mean(std)
% PRE:
% 4/8 -  6.7 (2.5)
% 4/9 -  6.4 (1.8)
% 4/10 - 6.5 (1.7)
% average: 6.53 (2)
% 
% DUR WN (started 4/11) (catch trials)
% 4/11 - 7.18 (2.1)
% 4/12 - 6.06 (2.16)
% 4/13 - 6.8 (2.9)
% 4/15 - 5.8 (1.8)
% 4/17 - 6.37 (1.6)
% 4/18 - 6.13 (2.07)
% average: 6.4 (2.1)

% CONCLUSION: not different.

%% 4/25 - analysis using all_days_all_analysis_25Apr2014_1343_adultseq_AllTrans_RendAmnt_WNtrigLabel

% PLOT transition matrices for all days
con_div = 'divergence';
all_days_all_analysis=lt_all_days_PLOT_AllTrans([1 2 3 4], '25Apr2014_1343', con_div);

con_div = 'convergence';
all_days_all_analysis=lt_all_days_PLOT_AllTrans([1 2 3 4], '25Apr2014_1343', con_div);


%___________________________________________--
%PLOT single divergent or convergent transition over days (run the above
%function first)
syl1='a';
% syl2='b';
syl2_list=all_days_all_analysis.data{1}.all_songs.all_trans.syllable_list;
num_syl=length(syl2_list);
% make syl colors
for i=1:length(syl2_list);
    syl_color{i}=[i/num_syl 1/num_syl 1] - [0 0 i/num_syl];
end

figure;  hold on; title([con_div ' transition probability from ' syl1 ' to (see legend): ']); 
for k=1:length(syl2_list);
    syl2=syl2_list{k};
for i=1:size(all_days_all_analysis.data,2);
try
    hscatter(k)=scatter(i,all_days_all_analysis.data{i}.all_songs.all_trans.(syl1).transition_to_.(syl2).relative_fraction_of_trans,...
        'MarkerFaceColor', syl_color{k}, 'MarkerEdgeColor',syl_color{k});
catch err
    continue
end
end
legend(hscatter,[syl2_list])
end
ylim([0 1]); xlabel('days'); ylabel('probability of transition')


% Convergence
%PLOT single divergent or convergent transition over days (run the above
%function first)
syl2='b';
syl1_list=all_days_all_analysis.data{1}.all_songs.all_trans.syllable_list;
num_syl=length(syl1_list);

% make syl colors
for i=1:length(syl1_list);
    syl_color{i}=[i/num_syl 1/num_syl 1] - [0 0 i/num_syl];
end

figure;  hold on; title(['Convergence transition probability to ' syl2 ' from to (see legend): ']); 
for k=1:length(syl1_list);
    syl1=syl1_list{k};
for i=1:size(all_days_all_analysis.data,2);
try
    hscatter2(k)=scatter(i,all_days_all_analysis.data{i}.all_songs.all_trans.convergent_to.(syl2).from.(syl1).fraction_of_trans,...
        'MarkerFaceColor', syl_color{k}, 'MarkerEdgeColor',syl_color{k});
catch err
    continue
end
end
legend(hscatter2,[syl1_list])
end
ylim([0 1]); xlabel('days'); ylabel('probability of transition')


%____________________________________
% HIT RATE
syllables=all_days_all_analysis.parameters.WN_trig.trig_syl;
for i=1:length(syllables);
    figure; hold on; title([syllables(i) ' green= WN hits/Labels; black= FalsePos/TotalWN'])
    for j=1:length(all_days_all_analysis.data); % num of days
        try
            scatter(j,all_days_all_analysis.data{j}.WN_hit_rate.all_songs.(syllables(i)).hits_divide_labels,'g','MarkerFaceColor','g');
            scatter(j,all_days_all_analysis.data{j}.WN_hit_rate.all_songs.(syllables(i)).FalsePos_divide_TotalWN,'k','MarkerFaceColor','k')
            %         scatter(j,all_days_all_analysis.data{j}.WN_hit_rate.all_songs.a.FalsePos/all_days_all_analysis.data{j}.WN_hit_rate.all_songs.a.hits_labels_allhits(1),'b','MarkerFaceColor','b')
        catch err
        end
    end
end

%___________________________________________-
% RENDITIONS OF SYL PER SONG

syllables={'a','b','j'};
plot_colors=lt_make_plot_colors(size(syllables,2));

figure; hold on
for s=1:size(syllables,2);
    for j=1:length(all_days_all_analysis.data); % num of days
        
        syl=syllables{s};
        rend_per_song.(syl){j}=all_days_all_analysis.data{j}.summary_of_day.(syl).syl_rendition_amount...
            /all_days_all_analysis.data{j}.summary_of_day.song_amount_labeled;
        try
            hscatter3(s)= scatter(j,rend_per_song.(syl){j},'k','MarkerFaceColor',plot_colors{s});
        catch err
        end
    end
end
legend(hscatter3,syllables)
title('# renditions of each syl per song, across days'), xlabel('days'); ylabel('renditions/song');




