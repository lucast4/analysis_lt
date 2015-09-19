%% LT 6/10/14 - Using an updated version of stuff below. new version is general and useful for any bird.


%% LT 6/2/14 - modifying this for context experiment 2, whcih will be done on bluejay, not gullserver
% (code copied from lt_all_days_ContextSeq)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIRST, going into each folder and getting transition data - do this after labeling and before compiling data into structure below
% run the below for each day folder (run either C1 or C2)
% if C1, then first separate b.c.k into b.c.k.early and b.c.k.late. Then
% run functions.  For C2, just use b.c.k. and run function.
clear all;close all

% INPUTS
folder_phrase='ContextSeq2'; % marking the save folder
[nameofbird, bluejaynum, date, ~]=lt_get_birdname_date_from_dir(1);
datestring=date{2};

% RUN DIFFERENT DEPENDING ON CONTEXT

% BASELINE - no switching yet

% context A
edit batch.catch.keep
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep.early',nameofbird,folder_phrase,'contextA_early',datestring);
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep.late',nameofbird,folder_phrase,'contextA_late',datestring);

%  context B
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep',nameofbird,folder_phrase,'contextB',datestring);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECOND, COMPILE DATA for all contexts for a single day into one data structure.
% INSTRUCTIONS: 1) first run lt_get_all_transition_probabilities. 2) Then enter
% your parameters below and run to compile transition info over multiple
% contexts into one structure. 3) Run this in the bird folder!

clear all; close all
% INPUTS
first_day='28May2014';
last_day='09Jun2014';
folder_phrase='ContextSeq2'; %this marks the all_transitions folder (e.g. all_days_transition_matrix_ContextSeq)
motifs={'am','ab','aj','ak','ar','as','ax'}; % BEST TO TAKE ALL TRANSITIONS AT A BRANCH POINT
context_label_set={'contextA_early','contextB','contextA_late'}; % enter the contexts that are stored in that structure (exactly as they are written in the saved structures (e.g. rd66gr93_01Jun2014_contextA_early.mat)
curr_dir=pwd;
save_phrase='div_a';

lt_all_days_ContextSeq_COMPILE(first_day,last_day,folder_phrase,motifs,context_label_set,save_phrase)

cd(curr_dir);


% It will ask you for context switch times.  Keep track of them below:
% -------------------------------------------------------------
% LIST OF CONTEXT SWITCH TIMES
% gr66 trial 2:
{'30May2014-1209','30May2014-1309','30May2014-1727'}
{'31May2014-1205','31May2014-1658'}
{'01Jun2014-1305','01Jun2014-1730','01Jun2014-2030'}
{'02Jun2014-1210','02Jun2014-1707','02Jun2014-2030'}
{'03Jun2014-1225','03Jun2014-1723','03Jun2014-2028'}
{'04Jun2014-1213','04Jun2014-1703','04Jun2014-2035'}
{'05Jun2014-1208','05Jun2014-1716'}
{'06Jun2014-1201','06Jun2014-1714','06Jun2014-2019'}
{'07Jun2014-1218','07Jun2014-1724','07Jun2014-2032'}
{'08Jun2014-1238','08Jun2014-1722','08Jun2014-2005'}
{'09Jun2014-1317','09Jun2014-1712','09Jun2014-2100'}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT
% Uses the same parameters in "SECOND" above.  
% GO INTO PROGRAM AND CHANGE PARAMETERS

% Uses the same parameters in "SECOND" above.  

% PLOT PARAMETERS
BaselineDays=1:7;
WNDays=8:13;
ProbeDays=[];

% PLOT PARAMETERS
% plotting across days
trn_to_plot='ab'; % for summary cross day data
num_renditions=15; % EDGES: how many songs to take at the edges
% plotting individual days
motifs_to_plot={trn_to_plot}; % for plotting each individual day
bin_size=3; % to change this you have to go back to making transitions, or incorporate that part here to make afresh

% ADDITIONAL INPUTS FOR PLOTTING
[birdname, bluejay_num]=lt_get_birdname_date_from_dir(0);
bird_dir=['/bluejay' num2str(bluejay_num) '/lucas/birds/' birdname];
phrase='div_a';

% RUN
lt_all_days_ContextSeq_PLOT


%% NOTE: THIS is the latest version (5/26/14) that is being edited on gullserver.


%% LT - 4/18/14 - Context dependent learning

%% going into each folder and getting transition data - do this after labeling and before compiling data into structure below
% run the below for each day folder (run either C1 or C2)
% if C1, then first separate b.c.k into b.c.k.early and b.c.k.late. Then
% run functions.  For C2, just use b.c.k. and run function.
clear all;close all

phrase='ContextSeq2'; % marking the save folder
[nameofbird, bluejaynum, date, ~]=lt_get_birdname_date_from_dir(1);
datestring=date{2};

% RUN DIFFERENT DEPENDING ON CONTEXT

% BASELINE - no switching yet
% context A
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep',nameofbird,phrase,'contextA_early',datestring); % just call it contextA_early instead of contextA (for ease of code)

% context A
edit batch.catch.keep
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep.early',nameofbird,phrase,'contextA_early',datestring);
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep.late',nameofbird,phrase,'contextA_late',datestring);

%  context B
lt_get_all_transition_probabilities_FUNCTION('batch.catch.keep',nameofbird,phrase,'contextB',datestring);



%% NOTE TO SELF
% 1) make the data acquisition iterate over all contexts.
% 2) make the plots bars or lines
% 3) also plot total length of song (not just renditions of a) --> a halting effect?
%

%% Goals:
% 1) plot in bins (# rendition) transition probabilties for targets
% 2) plot rate of song halting
% 3) plot sining rate
% 4) put all on same graph that shows across day sand context switches

%% COMPILE DATA for all contexts for a single day into one data structure.
% INSTRUCTIONS: first run lt_get_all_transition_probabilities. Then enter
% your parameters below and run to compile transition info over multiple
% contexts into one structure.

clear all; close all
timestamp=lt_get_timestamp;

% INPUTS
first_day='28May2014';
last_day='06Jun2014';
folder_phrase='ContextSeq2'; %this marks the all_transitions folder
birdname='gr66gr43';
motifs={'am','ab','aj','ak','ar','as','ax'};
bluejay_num=2;
context_label_set={'contextA_early','contextB','contextA_late'}; % enter the contexts that are stored in that structure (exactly as they are written)

% for binning songs
bin_size = 5; % in number of songs

% for saving
phrase='div_a'; % a phrase to add to the save file for record keeping


% -------------------------------------------------------------
% LIST OF CONTEXT SWITCH TIMES
% gr66 trial 2:
% {'30May2014-1209','30May2014-1309','30May2014-1727'}
% {'31May2014-1205','31May2014-1658'}
% {'01Jun2014-1305','01Jun2014-1730','01Jun2014-2030'}
% {'02Jun2014-1210','02Jun2014-1707','02Jun2014-2030'}
% {'03Jun2014-1225','03Jun2014-1723','03Jun2014-2028'}
% {'04Jun2014-1213','04Jun2014-1703','04Jun2014-2035'}
% {'05Jun2014-1208','05Jun2014-1716'}
% {'06Jun2014-1201','06Jun2014-1714','06Jun2014-2019'}


% AUTOMATIC PARAMETERS
first_day_num=datenum(first_day,'ddmmmyyyy');
last_day_num=datenum(last_day,'ddmmmyyyy');
num_days=last_day_num-first_day_num+1;
bird_dir=['/bluejay' num2str(bluejay_num) '/lucas/birds/' birdname];
path_main=[bird_dir '/all_days_transition_matrix_' folder_phrase '/'];
path_save= [bird_dir '/all_days_transitions_' folder_phrase '_analysis'];

% START
for dd=1:num_days;
    clear transitions
    date=datestr(first_day_num+dd-1,'ddmmmyyyy');
    % ask user to input context switch times for record keeping
    try
        context_switch_times_temp=input(['what are context switch times for ' date '? (format: {"16Apr2014-1200", "16Apr2014-1538","16Apr2014-2145"}) (type nothing to skip)']);
        [switch_times]=lt_convert_EventTimes_to_RelTimes(date,context_switch_times_temp);
        context_switch_times=(switch_times.FinalValue-1)*24;
        transitions.context_switch_times=context_switch_times;
    catch err % if you enter crap
    end
    
    % this puts the parameters into structure:
    transitions.motifs=motifs;
    transitions.parameters.birdname=birdname;
    transitions.parameters.date=date;
    transitions.parameters.path_main=path_main;
    transitions.folder_phrase=folder_phrase;
    
    % Run analysis
    for kk=1:size(context_label_set,2);
        context_label=context_label_set{kk};
        try
            load([path_main birdname '_' date '_' context_label]);
        catch err % if that date does not have data for that context
            continue
        end
        num_songs=size(all_trans.syl_order,2);
        
        % FIRST compiles transition numbers and song time into one structure.
        for j=1:size(all_trans.syl_order,2) ; % song number
            for t=1:size(transitions.motifs,2);
                try
                    tt=transitions.motifs{t};
                    transitions.(context_label).(tt)(j)=all_trans.(tt(1)).transition_to_.(tt(2)).number_of_instances_persong{j};
                    transitions.(context_label).time_actual{j}=datestr(all_trans.syl_times{j}(1),'ddmmmyyyy-HHMM');
                    [days withinday]=lt_convert_datenum_to_hour(all_trans.syl_times{j}(1));
                    transitions.(context_label).time_hours(j)=withinday.hours;
                    transitions.(context_label).num_trans(j)=all_trans.(tt(1)).total_number_of_transitions_persong{j};
                catch err
                end
            end
        end
        
        % SECOND bin songs to get transition probabilities
        num_bins = ceil(num_songs/bin_size);
        
        tt=transitions.motifs;
        for i=1:num_bins;
            for t=1:size(transitions.motifs,2)
                tt=transitions.motifs{t};
                try
                    try
                        for j=1:length(tt);
                            transitions.(context_label).binned_renditions.(tt)(i)=sum(transitions.(context_label).(tt)(1+(i-1)*bin_size:i*bin_size));
                        end
                        transitions.(context_label).binned_renditions.num_trans(i)=sum(transitions.(context_label).num_trans(1+(i-1)*bin_size:i*bin_size));
                        transitions.(context_label).binned_renditions.time_hours(i)=mean(transitions.(context_label).time_hours(1+(i-1)*bin_size:i*bin_size)); % takes mean of binned songs
                    catch err % error if this is last bin an5d there are not enough songs.
                        for j=1:length(tt);
                            transitions.(context_label).binned_renditions.(tt)(i)=sum(transitions.(context_label).(tt)(1+(i-1)*bin_size:end));
                        end
                        transitions.(context_label).binned_renditions.time_hours(i)=mean(transitions.(context_label).time_hours(1+(i-1)*bin_size:end)); % takes midpoint of binned songs
                        transitions.(context_label).binned_renditions.num_trans(i)=sum(transitions.(context_label).num_trans(1+(i-1)*bin_size:end));
                    end
                    
                    % convert amounts to fractions.
                    for j=1:length(tt);
                        transitions.(context_label).binned_renditions.fractions.(tt)(i)=transitions.(context_label).binned_renditions.(tt)(i)...
                            /transitions.(context_label).binned_renditions.num_trans(i);
                    end
                catch err % this catch is for when the motif does not exist.
                end
            end
        end
        
        % get summary data
        transitions.(context_label).binned_renditions.bin_size=bin_size;
        
    end
    
    % SAVE transitions structure
    %input parameter
    curr_dir=pwd;
    
    % make the save dir if it has not been made yet.
    try cd(path_save);
    catch err
        mkdir(path_save);
        cd(path_save);
    end
    
    save(['transitions_' date '_' phrase], 'transitions');
    cd(curr_dir);
end

%% GET SONG DURATIONS AND RENDITIONS PER SONG



%% COMPILE TRANSITIONS OVER DAYS INTO ONE STRUCTURE
% run and save the above transitions structure, then run below to compile
% all days

% INPUTS
% birdname='gr66gr43';
% folder_phrase='ContextSeq2';
% first_day= '13Apr2014'; % first day to loop over, including baseline data.
% last_day= '24Apr2014';

% AUTOMATIC PARAMETERS
path_trans=path_save;
% first_day_num=datenum(first_day,'ddmmmyyyy');
% last_day_num=datenum(last_day,'ddmmmyyyy');
% num_days=last_day_num-first_day_num+1;

% COMPILE
cd(path_trans);
for i=1:num_days;
    transitions=[]; % clear transitions
    day=datestr(first_day_num+i-1,'ddmmmyyyy');
    load(['transitions_' day '_' phrase]);
    %     ls;
    %     display(['manually load transitions data structure for ' day ', then type return; if doesnt exist, then dont load']);
    %     keyboard;
    transitions_all_days.data{i}=transitions;
end


% SAVE
transitions_all_days.parameters.timestamp=timestamp;
transitions_all_days.parameters.phrase=phrase;
transitions_all_days.parameters.birdname=birdname;
transitions_all_days.parameters.folder_phrase=folder_phrase;

save(['transitions_all_days_' first_day '_to_' last_day '_' phrase '_' timestamp],'transitions_all_days');




%% OBSOLETE, USE THE ALL DAYS VERSION INSTEAD in gr66gr43_analysis_context_REAL_PLOT_BluejayVersion
% PLOT - AFTER COMPILE ALL DATA FOR ONE DAY


motifs_to_plot={'ab'};

figure;hold on;
for i=1:size(motifs_to_plot,2);
    motif=motifs_to_plot{i};
    for ii=1:size(context_label_set,2);
        context_label=context_label_set{ii};
        % PLOT bins
        subplot(3,1,1); hold on; title(['binned; red:ab  blue:aj (bin size: ' num2str(bin_size) ')'])
        for j=1:size(transitions.(context_label).binned_renditions.num_trans,2);
            plot(transitions.(context_label).binned_renditions.time_hours(j)+0.05,transitions.(context_label).binned_renditions.(motif)(j),'xr');
            %             plot(transitions.(context_label).binned_renditions.time_hours(j),transitions.(context_label).binned_renditions.(motif)(j),'xb');
            plot(transitions.(context_label).binned_renditions.time_hours(j),transitions.(context_label).binned_renditions.num_trans(j),'ok');
        end
        
        
        % plot fractions
        subplot(3,1,2); hold on; title(['fractions (for each bin (bin size: ' num2str(bin_size) ')'])
        
        for j=1:size(transitions.(context_label).binned_renditions.num_trans,2);
            plot(transitions.(context_label).binned_renditions.time_hours(j)+0.05,transitions.(context_label).binned_renditions.fractions.(motif)(j),'xr');
            %             plot(transitions.(context_label).binned_renditions.time_hours(j),transitions.(context_label).binned_renditions.fractions.(motif)(j),'xb');
            %    plot(transitions.(context_label).binned_renditions.time_hours(j),transitions.(context_label).binned_renditions.num_trans(j),'ok');
        end
        
        % plot each song
        subplot(3,1,3); title('each song plotted individually; red:ab  blue:aj'); hold on;
        for j=1:size(transitions.(context_label).ab,2);
            plot(transitions.(context_label).time_hours(j)+0.05,transitions.(context_label).(motif)(j),'xr');
            %             plot(transitions.(context_label).time_hours(j),transitions.(context_label).(motif)(j),'xb');
            plot(transitions.(context_label).time_hours(j),transitions.(context_label).num_trans(j),'ok');
        end
    end
end

% PUT lines to mark context changes
for ff=1:3; %num of subplots
    subplot(3,1,ff)
    for k=1:length(context_switch_times);
        line([context_switch_times(k) context_switch_times(k)], ylim)
    end
end

% PLOT as scatters comparing distributions during context 1 and 2

%% random analyses

sum(transitions.context1_early_AllSyl.ab)/...
    sum(transitions.context1_early_AllSyl.num_trans)

% sum(transitions.context2_AllSyl.ab)/...
% sum(transitions.context2_AllSyl.num_trans)
%
%
sum(transitions.context2_AllSyl_early.ab)/...
    sum(transitions.context2_AllSyl_early.num_trans)

sum(transitions.context2_AllSyl_late.ab)/...
    sum(transitions.context2_AllSyl_late.num_trans)


%% PLOT

gr66gr43_analysis_context_REAL_PLOT_BluejayVersion



