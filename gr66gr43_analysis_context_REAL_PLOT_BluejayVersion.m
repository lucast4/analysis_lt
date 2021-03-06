%% LT 6/2/14 - started editing and using in bluejay, where the analysis for context learning 2 will take place

%% LT 5/27/14 - using transitions_all_days structure that is made from gr66gr43_analysis_context_REAL. Plots stuff over all days.

close all
if (0); % these carry over from gr66gr43_analysis_context_REAL
clear all

% INPUT PARAMETERS - these are from compiling data, and can use those
% instead
first_day='028May2014';
last_day='06Jun2014';
folder_phrase='ContextSeq2'; %this marks the all_transitions folder
birdname='gr66gr43';
motifs={'am','ab','aj','ak','ar','as'};
bluejay_num=2;
context_label_set={'contextA_early','contextB','contextA_late'}; % enter the contexts that are stored in that structure (exactly as they are written)
bird_dir=['/bluejay' num2str(bluejay_num) '/lucas/birds/' birdname];
phrase='div_a';
path_main=[bird_dir '/all_days_transition_matrix_' folder_phrase '/'];
end

% NEW PARAMETERS
BaselineDays=1:7;
WNDays=8:10;
ProbeDays=[];

% PLOT PARAMETERS
% plotting across days
trn_to_plot='ab'; % for summary cross day data
num_renditions=10; % EDGES: how many songs to take at the edges
% plotting individual days
motifs_to_plot={trn_to_plot}; % for plotting each individual day
bin_size=5; % to change this you have to go back to making transitions, or incorporate that part here to make afresh

% AUTOMATIC PARAMETERS
CTXT_list=context_label_set;
analysis_days=[first_day '_to_' last_day];
fname_incompl=[bird_dir '/all_days_transitions_' folder_phrase '_analysis/transitions_all_days_' analysis_days '_' phrase '*'];
[transitions_all_days, fname_complete]=lt_load_struct_incomplete_name(fname_incompl);

%% PLOTTING
% ________________________________________________________________________
% 1) PLOT EDGES of contexts 
% METRICS - trns prob, singing rate, branches per song


% AUTO INPUTS
rend_field=['size' num2str(num_renditions)];

% Transform data
for ii=1:size(CTXT_list,2);
    CTXT=CTXT_list{ii};
    for i=1:size(transitions_all_days.data,2); % days
        if isfield(transitions_all_days.data{i},CTXT); % if this context has any data
            try
                edge.(rend_field).(CTXT).early.(trn_to_plot).num_rends(i)=sum(transitions_all_days.data{i}.(CTXT).(trn_to_plot)(1:num_renditions));
                edge.(rend_field).(CTXT).early.all_trans.num_rends(i)=sum(transitions_all_days.data{i}.(CTXT).num_trans(1:num_renditions));
                edge.(rend_field).(CTXT).early.all_trans.num_songs(i)=num_renditions;
               
                edge.(rend_field).(CTXT).late.(trn_to_plot).num_rends(i)=sum(transitions_all_days.data{i}.(CTXT).(trn_to_plot)(end-num_renditions-1:end));
                edge.(rend_field).(CTXT).late.all_trans.num_rends(i)=sum(transitions_all_days.data{i}.(CTXT).num_trans(end-num_renditions-1:end));
                edge.(rend_field).(CTXT).late.all_trans.num_songs(i)=num_renditions;
               
                
            catch err
                disp(['error, not enough renditions (compile whatever remained), day: ' transitions_all_days.data{i}.parameters.date ' for ' CTXT]);
                % sum over whatever renditions remain - should indicate as
                % such on the plot
                edge.(rend_field).(CTXT).early.(trn_to_plot).num_rends(i)=sum(transitions_all_days.data{i}.(CTXT).(trn_to_plot)(1:end));
                edge.(rend_field).(CTXT).early.all_trans.num_rends(i)=sum(transitions_all_days.data{i}.(CTXT).num_trans(1:end));
                edge.(rend_field).(CTXT).early.all_trans.num_songs(i)=size(transitions_all_days.data{i}.(CTXT).num_trans,2);
                
                edge.(rend_field).(CTXT).late.(trn_to_plot).num_rends(i)=sum(transitions_all_days.data{i}.(CTXT).(trn_to_plot)(1:end));
                edge.(rend_field).(CTXT).late.all_trans.num_rends(i)=sum(transitions_all_days.data{i}.(CTXT).num_trans(1:end));
                edge.(rend_field).(CTXT).late.all_trans.num_songs(i)=size(transitions_all_days.data{i}.(CTXT).num_trans,2);
                
                edge.(rend_field).(CTXT).warning_note{i}=['only ' num2str(edge.(rend_field).(CTXT).late.all_trans.num_songs(i)) ' songs in this day/context'];

            end
            % convert the sums above into fractions
            edge.(rend_field).(CTXT).early.(trn_to_plot).fraction(i)=edge.(['size' num2str(num_renditions)]).(CTXT).early.(trn_to_plot).num_rends(i)/...
                edge.(['size' num2str(num_renditions)]).(CTXT).early.all_trans.num_rends(i);
            edge.(rend_field).(CTXT).late.(trn_to_plot).fraction(i)=edge.(['size' num2str(num_renditions)]).(CTXT).late.(trn_to_plot).num_rends(i)/...
                edge.(['size' num2str(num_renditions)]).(CTXT).late.all_trans.num_rends(i);
            
            % convert to branch point renditions
            edge.(rend_field).(CTXT).early.all_trans.BranchesPerSong(i)=edge.(rend_field).(CTXT).early.all_trans.num_rends(i)/...
                edge.(rend_field).(CTXT).early.all_trans.num_songs(i);
             edge.(rend_field).(CTXT).late.all_trans.BranchesPerSong(i)=edge.(rend_field).(CTXT).late.all_trans.num_rends(i)/...
                edge.(rend_field).(CTXT).late.all_trans.num_songs(i);
           

            % convert to songs/hr
            
            
        else % if this context has no data at all, put a nan.
            edge.(rend_field).(CTXT).early.(trn_to_plot).num_rends(i)=nan;
            edge.(rend_field).(CTXT).early.all_trans.num_rends(i)=nan;
            edge.(rend_field).(CTXT).early.(trn_to_plot).fraction(i)=nan;
            edge.(rend_field).(CTXT).early.all_trans.num_songs(i)=nan;
            edge.(rend_field).(CTXT).early.all_trans.BranchesPerSong(i)=nan;
            
            edge.(rend_field).(CTXT).late.(trn_to_plot).num_rends(i)=nan;
            edge.(rend_field).(CTXT).late.all_trans.num_rends(i)=nan;
            edge.(rend_field).(CTXT).late.(trn_to_plot).fraction(i)=nan;
            edge.(rend_field).(CTXT).late.all_trans.num_songs(i)=nan;
            edge.(rend_field).(CTXT).late.all_trans.BranchesPerSong(i)=nan;
        end
    end
end

% Plot (fractions)
figure; hold on; title(['Transition probability of ' trn_to_plot ' at context edges (' num2str(num_renditions) ' songs averaged)']);
xlabel(['Days (' analysis_days ')']); ylabel('Trn Prob');

for i=1:size(transitions_all_days.data,2); % days
    X=[];
    for ii=1:size(context_label_set,2);
        CTXT=context_label_set{ii};
        X(ii*2-1)=edge.(rend_field).(CTXT).early.(trn_to_plot).fraction(i);
        X(ii*2)=edge.(rend_field).(CTXT).late.(trn_to_plot).fraction(i);
    end
    plot([1:2]+(i-1)*6, X(1:2),'ok','MarkerFaceColor','k');
    plot([3:4]+(i-1)*6, X(3:4),'or','MarkerFaceColor','r');
    plot([5:6]+(i-1)*6, X(5:6),'ok','MarkerFaceColor','k');
    plot([1:6]+(i-1)*6, X,'-k');
end
ylim([0 1])

% Indicate types of days (WN, probe, baseline);
PtsPerDay=6; % number of points for each day (e.g. context 1, 2, 1, would be 3)
% first, line for WN
for i=1:length(WNDays);
    WNind=[1:PtsPerDay]+(WNDays(i)-1)*PtsPerDay;
    line([WNind(1)-0.5 WNind(PtsPerDay)+0.5], [0.7 0.7],'Color','r')
end
% second, line for probe day
for i=1:length(ProbeDays);
    ProbeInd=[1:PtsPerDay]+(ProbeDays(i)-1)*PtsPerDay;
    line([ProbeInd(1)-0.5 ProbeInd(PtsPerDay)+0.5], [0.7 0.7],'Color','b')
end
% third, line for baseline
BaselineInd=(BaselineDays(end))*PtsPerDay+0.5;
line([BaselineInd BaselineInd],ylim,'Color','k','LineStyle','--')


% PLOT branch renditions per song
figure; hold on; title(['Number of branch points per song at context edges (' num2str(num_renditions) ' songs averaged)']);
xlabel(['Days (' analysis_days ')']); ylabel('Trn Prob');

for i=1:size(transitions_all_days.data,2); % days
    X=[];
    for ii=1:size(context_label_set,2);
        CTXT=context_label_set{ii};
        X(ii*2-1)=edge.(rend_field).(CTXT).early.all_trans.BranchesPerSong(i);
        X(ii*2)=edge.(rend_field).(CTXT).late.all_trans.BranchesPerSong(i);
    end
    plot([1:2]+(i-1)*6, X(1:2),'ok','MarkerFaceColor','k');
    plot([3:4]+(i-1)*6, X(3:4),'or','MarkerFaceColor','r');
    plot([5:6]+(i-1)*6, X(5:6),'ok','MarkerFaceColor','k');
    plot([1:6]+(i-1)*6, X,'-k');
end
ylim([0 10])

% Indicate types of days (WN, probe, baseline);
PtsPerDay=6; % number of points for each day (e.g. context 1, 2, 1, would be 3)
% first, line for WN
for i=1:length(WNDays);
    WNind=[1:PtsPerDay]+(WNDays(i)-1)*PtsPerDay;
    line([WNind(1)-0.5 WNind(PtsPerDay)+0.5], [0.7 0.7],'Color','r')
end
% second, line for probe day
for i=1:length(ProbeDays);
    ProbeInd=[1:PtsPerDay]+(ProbeDays(i)-1)*PtsPerDay;
    line([ProbeInd(1)-0.5 ProbeInd(PtsPerDay)+0.5], [0.7 0.7],'Color','b')
end
% third, line for baseline
BaselineInd=(BaselineDays(end))*PtsPerDay+0.5;
line([BaselineInd BaselineInd],ylim,'Color','k','LineStyle','--')





% ________________________________________________________________________
% 2) PLOT mean for each contexts
% metrics: trns prob, branches per song

% Transform data
for ii=1:size(CTXT_list,2);
    CTXT=CTXT_list{ii};
    for i=1:size(transitions_all_days.data,2); % days
        if isfield(transitions_all_days.data{i},CTXT); % if this context has any data
            EntireCtxtMean.(CTXT).(trn_to_plot).num_rends(i)=sum(transitions_all_days.data{i}.(CTXT).(trn_to_plot)(1:end));
            EntireCtxtMean.(CTXT).all_trans.num_rends(i)=sum(transitions_all_days.data{i}.(CTXT).num_trans(1:end));
            EntireCtxtMean.(CTXT).all_trans.num_songs(i)=size(transitions_all_days.data{i}.(CTXT).num_trans,2);
            
            % convert the sums above into fractions
            EntireCtxtMean.(CTXT).(trn_to_plot).fraction(i)=EntireCtxtMean.(CTXT).(trn_to_plot).num_rends(i)/...
                EntireCtxtMean.(CTXT).all_trans.num_rends(i);
            EntireCtxtMean.(CTXT).all_trans.BranchesPerSong(i)=EntireCtxtMean.(CTXT).all_trans.num_rends(i)/...
                EntireCtxtMean.(CTXT).all_trans.num_songs(i); % average num of rend of branch per song
            
            
        else % if this context has no data at all, put a nan.
            EntireCtxtMean.(CTXT).(trn_to_plot).num_rends(i)=nan;
            EntireCtxtMean.(CTXT).all_trans.num_rends(i)=nan;
            EntireCtxtMean.(CTXT).(trn_to_plot).fraction(i)=nan;
            EntireCtxtMean.(CTXT).all_trans.BranchesPerSong(i)=nan;
        end
    end
end

% PLOT - Transition probs
figure; hold on; title(['Transition probability of ' trn_to_plot ' averaged over entire context']);
xlabel(['Days (' analysis_days ')']); ylabel('Trn Prob');

for i=1:size(transitions_all_days.data,2); % days
    X=[];
    for ii=1:size(context_label_set,2);
        CTXT=context_label_set{ii};
        X(ii)=EntireCtxtMean.(CTXT).(trn_to_plot).fraction(i);
    end
    plot(1+(i-1)*3, X(1),'ok','MarkerFaceColor','k');
    plot(2+(i-1)*3, X(2),'or','MarkerFaceColor','r');
    plot(3+(i-1)*3, X(3),'ok','MarkerFaceColor','k');
    plot([1:3]+(i-1)*3, X,'-k');
end
ylim([0 1])

% Indicate types of days (WN, probe, baseline);
PtsPerDay=3; % number of points for each day (e.g. context 1, 2, 1, would be 3)
% first, line for WN
for i=1:length(WNDays);
    WNind=[1:PtsPerDay]+(WNDays(i)-1)*PtsPerDay;
    line([WNind(1)-0.5 WNind(PtsPerDay)+0.5], [0.7 0.7],'Color','r')
end
% second, line for probe day
for i=1:length(ProbeDays);
    ProbeInd=[1:PtsPerDay]+(ProbeDays(i)-1)*PtsPerDay;
    line([ProbeInd(1)-0.5 ProbeInd(PtsPerDay)+0.5], [0.7 0.7],'Color','b')
end
% third, line for baseline
BaselineInd=(BaselineDays(end))*PtsPerDay+0.5;
line([BaselineInd BaselineInd],ylim,'Color','k','LineStyle','--')


% PLOT - Branch renditions per song
figure; hold on; title(['Branch point renditions per song averaged over entire context']);
xlabel(['Days (' analysis_days ')']); ylabel('Branch rends per song');

for i=1:size(transitions_all_days.data,2); % days
    X=[];
    for ii=1:size(context_label_set,2);
        CTXT=context_label_set{ii};
        X(ii)=EntireCtxtMean.(CTXT).all_trans.BranchesPerSong(i);
    end
    plot(1+(i-1)*3, X(1),'ok','MarkerFaceColor','k');
    plot(2+(i-1)*3, X(2),'or','MarkerFaceColor','r');
    plot(3+(i-1)*3, X(3),'ok','MarkerFaceColor','k');
    plot([1:3]+(i-1)*3, X,'-k');
end
ylim([0 10])

% Indicate types of days (WN, probe, baseline);
PtsPerDay=3; % number of points for each day (e.g. context 1, 2, 1, would be 3)
% first, line for WN
for i=1:length(WNDays);
    WNind=[1:PtsPerDay]+(WNDays(i)-1)*PtsPerDay;
    line([WNind(1)-0.5 WNind(PtsPerDay)+0.5], [0.7 0.7],'Color','r')
end
% second, line for probe day
for i=1:length(ProbeDays);
    ProbeInd=[1:PtsPerDay]+(ProbeDays(i)-1)*PtsPerDay;
    line([ProbeInd(1)-0.5 ProbeInd(PtsPerDay)+0.5], [0.7 0.7],'Color','b')
end
% third, line for baseline
BaselineInd=(BaselineDays(end))*PtsPerDay+0.5;
line([BaselineInd BaselineInd],ylim,'Color','k','LineStyle','--')

% NOTE: put in sinign rate.  problem is did not label all songs.

% _________________________________________________________________________
% 3) Plot each individual day separately (individual songs and binned)
for dd=1:size(transitions_all_days.data,2); % num of days
    transitions=transitions_all_days.data{dd};
    
    figure;hold on;
    for i=1:size(motifs_to_plot,2);
        motif=motifs_to_plot{i};
        for ii=1:size(context_label_set,2);
            context_label=context_label_set{ii};
            try
                transitions.(context_label); % test whether that is a field
            catch err % error if that context has no data for this day
                continue
            end
            
            % PLOT bins
            subplot(3,1,1); hold on; title([transitions.parameters.date '. Songs binned; red: ' motif '(bin size: ' num2str(bin_size) ')'])
            for j=1:size(transitions.(context_label).binned_renditions.num_trans,2);
                plot(transitions.(context_label).binned_renditions.time_hours(j)+0.01,transitions.(context_label).binned_renditions.(motif)(j),'xr');
                %             plot(transitions.(context_label).binned_renditions.time_hours(j),transitions.(context_label).binned_renditions.(motif)(j),'xb');
                plot(transitions.(context_label).binned_renditions.time_hours(j),transitions.(context_label).binned_renditions.num_trans(j),'ok');
            end
            
            
            % plot fractions
            subplot(3,1,2); hold on; title(['fractions (for each bin (bin size: ' num2str(bin_size) ')'])
            
            for j=1:size(transitions.(context_label).binned_renditions.num_trans,2);
                plot(transitions.(context_label).binned_renditions.time_hours(j)+0.01,transitions.(context_label).binned_renditions.fractions.(motif)(j),'xr');
                %             plot(transitions.(context_label).binned_renditions.time_hours(j),transitions.(context_label).binned_renditions.fractions.(motif)(j),'xb');
                %    plot(transitions.(context_label).binned_renditions.time_hours(j),transitions.(context_label).binned_renditions.num_trans(j),'ok');
            end
            
            % plot each song
            subplot(3,1,3); title(['each song plotted individually; red: ' motif]); hold on;
            for j=1:size(transitions.(context_label).(motif),2);
                plot(transitions.(context_label).time_hours(j)+0.01,transitions.(context_label).(motif)(j),'xr');
                %             plot(transitions.(context_label).time_hours(j),transitions.(context_label).(motif)(j),'xb');
                plot(transitions.(context_label).time_hours(j),transitions.(context_label).num_trans(j),'ok');
            end
        end
    end
    
    % PUT lines to mark context changes
    try
        context_switch_times=transitions.context_switch_times;
        for ff=1:3; %num of subplots
            subplot(3,1,ff)
            for k=1:length(context_switch_times);
                line([context_switch_times(k) context_switch_times(k)], ylim)
            end
        end
    catch err
    end
end


%% SAVE

% COMPILE STRUCTURES
transitions_all_days.PLOT.edge=edge;
transitions_all_days.PLOT.EntireCtxtMean=EntireCtxtMean;
transitions_all_days.PLOT.parameters.BaselineDays=BaselineDays;
transitions_all_days.PLOT.parameters.WNDays=WNDays;
transitions_all_days.PLOT.parameters.ProbeDays=ProbeDays;
transitions_all_days.PLOT.parameters.analysis_days=analysis_days;
transitions_all_days.PLOT.parameters.fname_complete=fname_complete;
transitions_all_days.PLOT.parameters.trn_to_plot=trn_to_plot;
transitions_all_days.PLOT.parameters.CTXT_list=CTXT_list;

% Save
timestamp=transitions_all_days.parameters.timestamp; % use same timestamp as data structure

save_dir=[bird_dir '/all_days_transitions_' folder_phrase '_analysis/PLOT'];
try cd(save_dir);
catch err
    mkdir(save_dir); cd(save_dir);
end


mkdir([analysis_days '_' phrase '_' timestamp]);
cd([analysis_days '_' phrase '_' timestamp]);
save(['transitions_all_days_PLOT_' analysis_days '_' phrase '_' timestamp],'transitions_all_days');

if strcmp(input('save figures? (y or n)','s'),'y');
    %     saveas(figure(f1),[analysis_days '_fig_' num2str(f1)],'fig');
    % saveas(figure(f2),[analysis_days '_fig_' num2str(f2)],'fig');
    
    savemultfigs
end