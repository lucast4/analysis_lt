%% LT - 4/18/14 - Context dependent learning

% Goals:
% 1) plot in bins (# rendition) transition probabilties for targets
% 2) plot rate of song halting
% 3) plot sining rate
% 4) put all on same graph that shows across day sand context switches

%% 
load /bluejay2/lucas/birds/gr66gr43/all_days_transition_matrix_context/gr66gr43_17Apr2014_context1
transitions.motifs={'ab','aj'};
num_songs=size(all_trans.syl_order,2);
context_label='context1';
date='17Apr2014';

% compiles transition numbers and song time into one structure.
for j=1:size(all_trans.syl_order,2) ; % song number
    for t=1:size(transitions.motifs,2);
        tt=transitions.motifs{t};
        transitions.(context_label).(tt)(j)=all_trans.(tt(1)).transition_to_.(tt(2)).number_of_instances_persong{j};
        transitions.(context_label).time_actual{j}=datestr(all_trans.syl_times{j}(1),'ddmmmyyyy-HHMM');
        [days withinday]=lt_convert_datenum_to_hour(all_trans.syl_times{j}(1));
        transitions.(context_label).time_hours(j)=withinday.hours;
        transitions.(context_label).num_trans(j)=all_trans.(tt(1)).total_number_of_transitions_persong{j};
    end
end

%% bin songs to get transition probabilities

bin_size = 4; % in number of renditions
num_bins = ceil(num_songs/bin_size);

tt=transitions.motifs;

for i=1:num_bins;
    try
        for j=1:length(tt);
            transitions.(context_label).binned_renditions.(tt{j})(i)=sum(transitions.(context_label).(tt{j})(1+(i-1)*bin_size:i*bin_size));
        end
        transitions.(context_label).binned_renditions.time_hours(i)=mean([transitions.(context_label).time_hours(i*bin_size) transitions.time_hours(1+(i-1)*bin_size)]); % takes midpoint of binned songs
    catch err % error if this is last bin and there are not enough songs.
        for j=1:length(tt);
            transitions.(context_label).binned_renditions.(tt{j})(i)=sum(transitions.(context_label).(tt{j})(1+(i-1)*bin_size:end));
        end
        transitions.(context_label).binned_renditions.time_hours(i)=mean([transitions.(context_label).time_hours(end) transitions.(context_label).time_hours(1+(i-1)*bin_size)]); % takes midpoint of binned songs
    end
end

transitions.(context_label).binned_renditions.bin_size=bin_size;
   

transitions.(context_label).binned_renditions.ab
transitions.(context_label).binned_renditions.aj


% PLOT

%% plot WN episodes



%% plot number of transitions
figure; title('red:ab  blue:aj'); hold on;


for j=1:size(transitions.context1.ab,2);
   plot(transitions.context1.time_hours(j),transitions.context1.ab(j),'xr');
   plot(transitions.context1.time_hours(j),transitions.context1.aj(j),'xb');
   plot(transitions.context1.time_hours(j),transitions.context1.num_trans(j),'ok');
end
    

for j=1:size(transitions.context2.ab,2);
   plot(transitions.context2.time_hours(j),transitions.context2.ab(j),'xr');
   plot(transitions.context2.time_hours(j),transitions.context2.aj(j),'xb');
   plot(transitions.context2.time_hours(j),transitions.context2.num_trans(j),'ok');
end

    

    
    