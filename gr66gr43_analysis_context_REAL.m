%% NOTE: THIS is the latest version (5/26/14) that is being edited on gullserver.

%% LT - 4/18/14 - Context dependent learning


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



% PARAMETERS
birdname='gr66gr43';
% context_label_set={'context1_early','context2','context1_late'}; % enter the contexts that are stored in that structure, in order to plot all on same fig.
context_label_set={'context1_early','context2'};
% context_label_set={'context1_early_AllSyl','context2_AllSyl_early','context2_AllSyl_late'};
% context_label_set={'context1_early','context2_AllSyl'};
date='16Apr2014';
% context_switch_times_temp={'18Apr2014-1139', '18Apr2014-1306', '18Apr2014-1748'}; % enter the times when yo switched contexts (or other important events).
% context_switch_times_temp={'19Apr2014-1313'};
% context_switch_times_temp={'20Apr2014-1415', '20Apr2014-1812'};
% context_switch_times_temp={'15Apr2014-1214', '15Apr2014-1853'};
context_switch_times_temp={'16Apr2014-1200', '16Apr2014-1538','16Apr2014-2145'};
% context_switch_times_temp={'17Apr2014-1150', '17Apr2014-1904'};
folder_phrase='Context';
path_main=['/data2/storkmount/rachel/' birdname '/all_days_transition_matrix_Context/'];
transitions.motifs={'ab','aj','ak','ar','as'};
[switch_times]=lt_convert_EventTimes_to_RelTimes(date,context_switch_times_temp);
context_switch_times=(switch_times.FinalValue-1)*24;

% this puts the parameters into structure:
transitions.context_switch_times=context_switch_times;
transitions.parameters.birdname=birdname;
transitions.parameters.date=date;
transitions.parameters.path_main=path_main;
transitions.folder_phrase=folder_phrase;

% Run analysis
for kk=1:size(context_label_set,2);
    context_label=context_label_set{kk};
    load([path_main birdname '_' date '_' context_label]);
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
    
    bin_size = 5; % in number of renditions
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
                catch err % error if this is last bin and there are not enough songs.
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



%% SAVING

%input parameter
phrase='div_a'; % a phrase to add to the save file for record keeping

path_save= ['/data2/storkmount/rachel/' birdname '/all_days_transitions_' folder_phrase '_analysis'];
curr_dir=pwd;

% make the save dir if it has not been made yet.
try cd(path_save);
catch err
    mkdir(path_save);
    cd(path_save);
end

save(['transitions_' date '_' phrase], 'transitions');

cd(curr_dir);

%% PLOT - AFTER COMPILE ALL DATA FOR ONE DAY


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

%% plot WN episodes



%% plot number of transitions


    

    
    
