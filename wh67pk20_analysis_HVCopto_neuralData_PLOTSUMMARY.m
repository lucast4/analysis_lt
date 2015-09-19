%% make structure, and input day data by hand. - ONLY NEED TO DO 1ST TIME. Else load structure
clear all;close all;
SummaryData=struct;

SummaryData.Params.FirstDay='11Jan2015';
SummaryData.Params.LastDay='26Jan2015';


%% TO LOAD STRUCTURE


%% Go to the folder holding Params and StatsStruct and run.
load Params
load StatsStruct

% convert date to index
tmp_fields=fieldnames(StatsStruct);
tmp_date=StatsStruct.(tmp_fields{1}).datenum(1);
tmp_date=datestr(tmp_date,'ddmmmyyyy');
DateInd=lt_convert_EventTimes_to_RelTimes(SummaryData.Params.FirstDay...
,{tmp_date});

disp(DateInd.JustDays_rel);
disp(DateInd.JustDays_actual);


%% RUN BELOW FOR StimOFF - before WN start, or during but using catch songs, 
for i=1:length(Params.TimeField);
timefield=Params.TimeField{i};

    SummaryData.Data.StimOFF.pitch.mean{i}(DateInd.JustDays_rel)=...
StatsStruct.All.WINDOWED.(timefield).Pitch.mean; % no stimulation being delivered

    SummaryData.Data.StimOFF.pitch.sd{i}(DateInd.JustDays_rel)=...
StatsStruct.All.WINDOWED.(timefield).Pitch.SD; % no stimulation being delivered

    SummaryData.Data.StimOFF.pitch.sem{i}(DateInd.JustDays_rel)=...
StatsStruct.All.WINDOWED.(timefield).Pitch.SEM; % no stimulation being delivered

    SummaryData.Data.StimOFF.pitch.N{i}(DateInd.JustDays_rel)=...
length(StatsStruct.All.WINDOWED.(timefield).Pitch.vals); % no stimulation being delivered

% time
    SummaryData.Data.StimOFF.pitch.time_vals{i}{DateInd.JustDays_rel}(:,1)=...
StatsStruct.All.WINDOWED.(timefield).Time.days; % in units of days
    SummaryData.Data.StimOFF.pitch.time_vals{i}{DateInd.JustDays_rel}(:,2)=...
StatsStruct.All.WINDOWED.(timefield).Time.hours; % in units of hours
% vals
    SummaryData.Data.StimOFF.pitch.time_vals{i}{DateInd.JustDays_rel}(:,3)=...
StatsStruct.All.WINDOWED.(timefield).Pitch.vals; % no stimulation being delivered

end

disp('done')

%% RUN BELOW FOR StimOFF - If it is during WN epoch, catch trials (not songs)
for i=1:length(Params.TimeField);
timefield=Params.TimeField{i};

    SummaryData.Data.StimOFF.pitch.mean{i}(DateInd.JustDays_rel)=...
StatsStruct.COMBO_TargAllCatch.WINDOWED.(timefield).Pitch.mean; % no stimulation being delivered

    SummaryData.Data.StimOFF.pitch.sd{i}(DateInd.JustDays_rel)=...
StatsStruct.COMBO_TargAllCatch.WINDOWED.(timefield).Pitch.SD; % no stimulation being delivered

    SummaryData.Data.StimOFF.pitch.sem{i}(DateInd.JustDays_rel)=...
StatsStruct.COMBO_TargAllCatch.WINDOWED.(timefield).Pitch.SEM; % no stimulation being delivered

    SummaryData.Data.StimOFF.pitch.N{i}(DateInd.JustDays_rel)=...
length(StatsStruct.COMBO_TargAllCatch.WINDOWED.(timefield).Pitch.vals); % no stimulation being delivered

% time
    SummaryData.Data.StimOFF.pitch.time_vals{i}{DateInd.JustDays_rel}(:,1)=...
StatsStruct.COMBO_TargAllCatch.WINDOWED.(timefield).Time.days; % in units of days
    SummaryData.Data.StimOFF.pitch.time_vals{i}{DateInd.JustDays_rel}(:,2)=...
StatsStruct.COMBO_TargAllCatch.WINDOWED.(timefield).Time.hours; % in units of hours
% vals
    SummaryData.Data.StimOFF.pitch.time_vals{i}{DateInd.JustDays_rel}(:,3)=...
StatsStruct.COMBO_TargAllCatch.WINDOWED.(timefield).Pitch.vals; % no stimulation being delivered

end

disp('done')



%% STIM OFF2 (end of day)
% before WN start, or after but using catch songs, 
for i=1:length(Params.TimeField);
timefield=Params.TimeField{i};

    SummaryData.Data.StimOFF_2.pitch.mean{i}(DateInd.JustDays_rel)=...
StatsStruct.All.WINDOWED.(timefield).Pitch.mean; % no stimulation being delivered

    SummaryData.Data.StimOFF_2.pitch.sd{i}(DateInd.JustDays_rel)=...
StatsStruct.All.WINDOWED.(timefield).Pitch.SD; % no stimulation being delivered

    SummaryData.Data.StimOFF_2.pitch.sem{i}(DateInd.JustDays_rel)=...
StatsStruct.All.WINDOWED.(timefield).Pitch.SEM; % no stimulation being delivered

    SummaryData.Data.StimOFF_2.pitch.N{i}(DateInd.JustDays_rel)=...
length(StatsStruct.All.WINDOWED.(timefield).Pitch.vals); % no stimulation being delivered

% time
    SummaryData.Data.StimOFF_2.pitch.time_vals{i}{DateInd.JustDays_rel}(:,1)=...
StatsStruct.All.WINDOWED.(timefield).Time.days; % in units of days
    SummaryData.Data.StimOFF_2.pitch.time_vals{i}{DateInd.JustDays_rel}(:,2)=...
StatsStruct.All.WINDOWED.(timefield).Time.hours; % in units of hours
% vals
    SummaryData.Data.StimOFF_2.pitch.time_vals{i}{DateInd.JustDays_rel}(:,3)=...
StatsStruct.All.WINDOWED.(timefield).Pitch.vals; % no stimulation being delivered

end

disp('done')

%% If it is during WN epoch, catch trials (not songs)
for i=1:length(Params.TimeField);
timefield=Params.TimeField{i};

    SummaryData.Data.StimOFF_2.pitch.mean{i}(DateInd.JustDays_rel)=...
StatsStruct.COMBO_TargAllCatch.WINDOWED.(timefield).Pitch.mean; % no stimulation being delivered

    SummaryData.Data.StimOFF_2.pitch.sd{i}(DateInd.JustDays_rel)=...
StatsStruct.COMBO_TargAllCatch.WINDOWED.(timefield).Pitch.SD; % no stimulation being delivered

    SummaryData.Data.StimOFF_2.pitch.sem{i}(DateInd.JustDays_rel)=...
StatsStruct.COMBO_TargAllCatch.WINDOWED.(timefield).Pitch.SEM; % no stimulation being delivered

    SummaryData.Data.StimOFF_2.pitch.N{i}(DateInd.JustDays_rel)=...
length(StatsStruct.COMBO_TargAllCatch.WINDOWED.(timefield).Pitch.vals); % no stimulation being delivered

% time
    SummaryData.Data.StimOFF_2.pitch.time_vals{i}{DateInd.JustDays_rel}(:,1)=...
StatsStruct.COMBO_TargAllCatch.WINDOWED.(timefield).Time.days; % in units of days
    SummaryData.Data.StimOFF_2.pitch.time_vals{i}{DateInd.JustDays_rel}(:,2)=...
StatsStruct.COMBO_TargAllCatch.WINDOWED.(timefield).Time.hours; % in units of hours
% vals
    SummaryData.Data.StimOFF_2.pitch.time_vals{i}{DateInd.JustDays_rel}(:,3)=...
StatsStruct.COMBO_TargAllCatch.WINDOWED.(timefield).Pitch.vals; % no stimulation being delivered

end

disp('done')


%% RUN BELOW FOR STIM (pulse)  (not during WN epoch)
% Catch
for i=1:length(Params.TimeField);
timefield=Params.TimeField{i};

    SummaryData.Data.StimCatch_pulse.pitch.mean{i}(DateInd.JustDays_rel)=...
StatsStruct.StimCatch.WINDOWED.(timefield).Pitch.mean; % no stimulation being delivered

    SummaryData.Data.StimCatch_pulse.pitch.sd{i}(DateInd.JustDays_rel)=...
StatsStruct.StimCatch.WINDOWED.(timefield).Pitch.SD; % no stimulation being delivered

    SummaryData.Data.StimCatch_pulse.pitch.sem{i}(DateInd.JustDays_rel)=...
StatsStruct.StimCatch.WINDOWED.(timefield).Pitch.SEM; % no stimulation being delivered

    SummaryData.Data.StimCatch_pulse.pitch.N{i}(DateInd.JustDays_rel)=...
length(StatsStruct.StimCatch.WINDOWED.(timefield).Pitch.vals); % no stimulation being delivered

% time
    SummaryData.Data.StimCatch_pulse.pitch.time_vals{i}{DateInd.JustDays_rel}(:,1)=...
StatsStruct.StimCatch.WINDOWED.(timefield).Time.days; % in units of days
    SummaryData.Data.StimCatch_pulse.pitch.time_vals{i}{DateInd.JustDays_rel}(:,2)=...
StatsStruct.StimCatch.WINDOWED.(timefield).Time.hours; % in units of hours
% vals
    SummaryData.Data.StimCatch_pulse.pitch.time_vals{i}{DateInd.JustDays_rel}(:,3)=...
StatsStruct.StimCatch.WINDOWED.(timefield).Pitch.vals; % no stimulation being delivered




end
% not catch
for i=1:length(Params.TimeField);
timefield=Params.TimeField{i};

    SummaryData.Data.StimNotCatch_pulse.pitch.mean{i}(DateInd.JustDays_rel)=...
StatsStruct.StimNotCatch.WINDOWED.(timefield).Pitch.mean; % no stimulation being delivered

    SummaryData.Data.StimNotCatch_pulse.pitch.sd{i}(DateInd.JustDays_rel)=...
StatsStruct.StimNotCatch.WINDOWED.(timefield).Pitch.SD; % no stimulation being delivered

    SummaryData.Data.StimNotCatch_pulse.pitch.sem{i}(DateInd.JustDays_rel)=...
StatsStruct.StimNotCatch.WINDOWED.(timefield).Pitch.SEM; % no stimulation being delivered

    SummaryData.Data.StimNotCatch_pulse.pitch.N{i}(DateInd.JustDays_rel)=...
length(StatsStruct.StimNotCatch.WINDOWED.(timefield).Pitch.vals); % no stimulation being delivered

% time
    SummaryData.Data.StimNotCatch_pulse.pitch.time_vals{i}{DateInd.JustDays_rel}(:,1)=...
StatsStruct.StimNotCatch.WINDOWED.(timefield).Time.days; % in units of days
    SummaryData.Data.StimNotCatch_pulse.pitch.time_vals{i}{DateInd.JustDays_rel}(:,2)=...
StatsStruct.StimNotCatch.WINDOWED.(timefield).Time.hours; % in units of hours
% vals
    SummaryData.Data.StimNotCatch_pulse.pitch.time_vals{i}{DateInd.JustDays_rel}(:,3)=...
StatsStruct.StimNotCatch.WINDOWED.(timefield).Pitch.vals; % no stimulation being delivered

end

disp('done')

%% RUN BELOW FOR STIM (Constant) (not during WN epoch)
% Catch
for i=1:length(Params.TimeField);
timefield=Params.TimeField{i};

    SummaryData.Data.StimCatch_const.pitch.mean{i}(DateInd.JustDays_rel)=...
StatsStruct.StimCatch.WINDOWED.(timefield).Pitch.mean; % no stimulation being delivered

    SummaryData.Data.StimCatch_const.pitch.sd{i}(DateInd.JustDays_rel)=...
StatsStruct.StimCatch.WINDOWED.(timefield).Pitch.SD; % no stimulation being delivered

    SummaryData.Data.StimCatch_const.pitch.sem{i}(DateInd.JustDays_rel)=...
StatsStruct.StimCatch.WINDOWED.(timefield).Pitch.SEM; % no stimulation being delivered

    SummaryData.Data.StimCatch_const.pitch.N{i}(DateInd.JustDays_rel)=...
length(StatsStruct.StimCatch.WINDOWED.(timefield).Pitch.vals); % no stimulation being delivered

% time
    SummaryData.Data.StimCatch_const.pitch.time_vals{i}{DateInd.JustDays_rel}(:,1)=...
StatsStruct.StimCatch.WINDOWED.(timefield).Time.days; % in units of days
    SummaryData.Data.StimCatch_const.pitch.time_vals{i}{DateInd.JustDays_rel}(:,2)=...
StatsStruct.StimCatch.WINDOWED.(timefield).Time.hours; % in units of hours
% vals
    SummaryData.Data.StimCatch_const.pitch.time_vals{i}{DateInd.JustDays_rel}(:,3)=...
StatsStruct.StimCatch.WINDOWED.(timefield).Pitch.vals; % no stimulation being delivered

end
% Not catch
for i=1:length(Params.TimeField);
timefield=Params.TimeField{i};

    SummaryData.Data.StimNotCatch_const.pitch.mean{i}(DateInd.JustDays_rel)=...
StatsStruct.StimNotCatch.WINDOWED.(timefield).Pitch.mean; % no stimulation being delivered

    SummaryData.Data.StimNotCatch_const.pitch.sd{i}(DateInd.JustDays_rel)=...
StatsStruct.StimNotCatch.WINDOWED.(timefield).Pitch.SD; % no stimulation being delivered

    SummaryData.Data.StimNotCatch_const.pitch.sem{i}(DateInd.JustDays_rel)=...
StatsStruct.StimNotCatch.WINDOWED.(timefield).Pitch.SEM; % no stimulation being delivered

    SummaryData.Data.StimNotCatch_const.pitch.N{i}(DateInd.JustDays_rel)=...
length(StatsStruct.StimNotCatch.WINDOWED.(timefield).Pitch.vals); % no stimulation being delivered

% time
    SummaryData.Data.StimNotCatch_const.pitch.time_vals{i}{DateInd.JustDays_rel}(:,1)=...
StatsStruct.StimNotCatch.WINDOWED.(timefield).Time.days; % in units of days
    SummaryData.Data.StimNotCatch_const.pitch.time_vals{i}{DateInd.JustDays_rel}(:,2)=...
StatsStruct.StimNotCatch.WINDOWED.(timefield).Time.hours; % in units of hours
% vals
    SummaryData.Data.StimNotCatch_const.pitch.time_vals{i}{DateInd.JustDays_rel}(:,3)=...
StatsStruct.StimNotCatch.WINDOWED.(timefield).Pitch.vals; % no stimulation being delivered

end


disp('done')

%% RUN BELOW FOR STIM (Constant) (COMBO- if using catch trials)
% Catch
for i=1:length(Params.TimeField);
timefield=Params.TimeField{i};

    SummaryData.Data.StimCatch_const.pitch.mean{i}(DateInd.JustDays_rel)=...
StatsStruct.COMBO_StimCatch_TargAllCatch.WINDOWED.(timefield).Pitch.mean; % no stimulation being delivered

    SummaryData.Data.StimCatch_const.pitch.sd{i}(DateInd.JustDays_rel)=...
StatsStruct.COMBO_StimCatch_TargAllCatch.WINDOWED.(timefield).Pitch.SD; % no stimulation being delivered

    SummaryData.Data.StimCatch_const.pitch.sem{i}(DateInd.JustDays_rel)=...
StatsStruct.COMBO_StimCatch_TargAllCatch.WINDOWED.(timefield).Pitch.SEM; % no stimulation being delivered

    SummaryData.Data.StimCatch_const.pitch.N{i}(DateInd.JustDays_rel)=...
length(StatsStruct.COMBO_StimCatch_TargAllCatch.WINDOWED.(timefield).Pitch.vals); % no stimulation being delivered

% time
    SummaryData.Data.StimCatch_const.pitch.time_vals{i}{DateInd.JustDays_rel}(:,1)=...
StatsStruct.COMBO_StimCatch_TargAllCatch.WINDOWED.(timefield).Time.days; % in units of days
    SummaryData.Data.StimCatch_const.pitch.time_vals{i}{DateInd.JustDays_rel}(:,2)=...
StatsStruct.COMBO_StimCatch_TargAllCatch.WINDOWED.(timefield).Time.hours; % in units of hours
% vals
    SummaryData.Data.StimCatch_const.pitch.time_vals{i}{DateInd.JustDays_rel}(:,3)=...
StatsStruct.COMBO_StimCatch_TargAllCatch.WINDOWED.(timefield).Pitch.vals; % no stimulation being delivered

end
% Not catch
for i=1:length(Params.TimeField);
timefield=Params.TimeField{i};

    SummaryData.Data.StimNotCatch_const.pitch.mean{i}(DateInd.JustDays_rel)=...
StatsStruct.COMBO_StimNotCatch_TargAllCatch.WINDOWED.(timefield).Pitch.mean; % no stimulation being delivered

    SummaryData.Data.StimNotCatch_const.pitch.sd{i}(DateInd.JustDays_rel)=...
StatsStruct.COMBO_StimNotCatch_TargAllCatch.WINDOWED.(timefield).Pitch.SD; % no stimulation being delivered

    SummaryData.Data.StimNotCatch_const.pitch.sem{i}(DateInd.JustDays_rel)=...
StatsStruct.COMBO_StimNotCatch_TargAllCatch.WINDOWED.(timefield).Pitch.SEM; % no stimulation being delivered

    SummaryData.Data.StimNotCatch_const.pitch.N{i}(DateInd.JustDays_rel)=...
length(StatsStruct.COMBO_StimNotCatch_TargAllCatch.WINDOWED.(timefield).Pitch.vals); % no stimulation being delivered

% time
    SummaryData.Data.StimNotCatch_const.pitch.time_vals{i}{DateInd.JustDays_rel}(:,1)=...
StatsStruct.COMBO_StimNotCatch_TargAllCatch.WINDOWED.(timefield).Time.days; % in units of days
    SummaryData.Data.StimNotCatch_const.pitch.time_vals{i}{DateInd.JustDays_rel}(:,2)=...
StatsStruct.COMBO_StimNotCatch_TargAllCatch.WINDOWED.(timefield).Time.hours; % in units of hours
% vals
    SummaryData.Data.StimNotCatch_const.pitch.time_vals{i}{DateInd.JustDays_rel}(:,3)=...
StatsStruct.COMBO_StimNotCatch_TargAllCatch.WINDOWED.(timefield).Pitch.vals; % no stimulation being delivered

end

disp('done')

%% RUN BELOW FOR STIM (Pulse) (COMBO- if using catch trials)
% Catch
for i=1:length(Params.TimeField);
timefield=Params.TimeField{i};

    SummaryData.Data.StimCatch_pulse.pitch.mean{i}(DateInd.JustDays_rel)=...
StatsStruct.COMBO_StimCatch_TargAllCatch.WINDOWED.(timefield).Pitch.mean; % no stimulation being delivered

    SummaryData.Data.StimCatch_pulse.pitch.sd{i}(DateInd.JustDays_rel)=...
StatsStruct.COMBO_StimCatch_TargAllCatch.WINDOWED.(timefield).Pitch.SD; % no stimulation being delivered

    SummaryData.Data.StimCatch_pulse.pitch.sem{i}(DateInd.JustDays_rel)=...
StatsStruct.COMBO_StimCatch_TargAllCatch.WINDOWED.(timefield).Pitch.SEM; % no stimulation being delivered

    SummaryData.Data.StimCatch_pulse.pitch.N{i}(DateInd.JustDays_rel)=...
length(StatsStruct.COMBO_StimCatch_TargAllCatch.WINDOWED.(timefield).Pitch.vals); % no stimulation being delivered

% time
    SummaryData.Data.StimCatch_pulse.pitch.time_vals{i}{DateInd.JustDays_rel}(:,1)=...
StatsStruct.COMBO_StimCatch_TargAllCatch.WINDOWED.(timefield).Time.days; % in units of days
    SummaryData.Data.StimCatch_pulse.pitch.time_vals{i}{DateInd.JustDays_rel}(:,2)=...
StatsStruct.COMBO_StimCatch_TargAllCatch.WINDOWED.(timefield).Time.hours; % in units of hours
% vals
    SummaryData.Data.StimCatch_pulse.pitch.time_vals{i}{DateInd.JustDays_rel}(:,3)=...
StatsStruct.COMBO_StimCatch_TargAllCatch.WINDOWED.(timefield).Pitch.vals; % no stimulation being delivered

end
% Not catch
for i=1:length(Params.TimeField);
timefield=Params.TimeField{i};

    SummaryData.Data.StimNotCatch_pulse.pitch.mean{i}(DateInd.JustDays_rel)=...
StatsStruct.COMBO_StimNotCatch_TargAllCatch.WINDOWED.(timefield).Pitch.mean; % no stimulation being delivered

    SummaryData.Data.StimNotCatch_pulse.pitch.sd{i}(DateInd.JustDays_rel)=...
StatsStruct.COMBO_StimNotCatch_TargAllCatch.WINDOWED.(timefield).Pitch.SD; % no stimulation being delivered

    SummaryData.Data.StimNotCatch_pulse.pitch.sem{i}(DateInd.JustDays_rel)=...
StatsStruct.COMBO_StimNotCatch_TargAllCatch.WINDOWED.(timefield).Pitch.SEM; % no stimulation being delivered

    SummaryData.Data.StimNotCatch_pulse.pitch.N{i}(DateInd.JustDays_rel)=...
length(StatsStruct.COMBO_StimNotCatch_TargAllCatch.WINDOWED.(timefield).Pitch.vals); % no stimulation being delivered

% time
    SummaryData.Data.StimNotCatch_pulse.pitch.time_vals{i}{DateInd.JustDays_rel}(:,1)=...
StatsStruct.COMBO_StimNotCatch_TargAllCatch.WINDOWED.(timefield).Time.days; % in units of days
    SummaryData.Data.StimNotCatch_pulse.pitch.time_vals{i}{DateInd.JustDays_rel}(:,2)=...
StatsStruct.COMBO_StimNotCatch_TargAllCatch.WINDOWED.(timefield).Time.hours; % in units of hours
% vals
    SummaryData.Data.StimNotCatch_pulse.pitch.time_vals{i}{DateInd.JustDays_rel}(:,3)=...
StatsStruct.COMBO_StimNotCatch_TargAllCatch.WINDOWED.(timefield).Pitch.vals; % no stimulation being delivered

end

disp('done')


%% SAVE
tstamp=lt_get_timestamp(0);

savedir=['/bluejay3/lucas/birds/wh73pk61/SummaryData/StimAndLearn'];

save([savedir '/SummaryData_' tstamp '.mat'],'SummaryData');

disp('done')


%% run once - troubleshoot

% fields=fieldnames(SummaryData.Data);
% 
% for i=1:length(fields);
% fieldname=fields{i};
% 
% SummaryData.Data.(fieldname).pitch.N=SummaryData.Data.(fieldname).pitch.sem;
% end
% 
% 
% for i=1:length(fields);
% fieldname=fields{i};
% for j=1:4;
% 
%     SummaryData.Data.(fieldname).pitch.sem{j}=SummaryData.Data.(fieldname).pitch.sd{j}./real(sqrt(SummaryData.Data.(fieldname).pitch.sd{j}-1));
% end
% end


%% NOTE TO SELF:

% TO DO:
% Check values against recorded
% find out if stimming affects entire song
% annotate with stim parameters and p values




















%% PLOT

% plot params
timewind=3; % which temporal window (i.e. ms window)
NumDays=datenum(SummaryData.Params.LastDay)-datenum(SummaryData.Params.FirstDay)+1;
smthbin=25;

FieldNames={'StimOFF','StimCatch_pulse','StimNotCatch_pulse','StimCatch_const','StimNotCatch_const'};
PlotColors=lt_make_plot_colors(length(FieldNames),0);



% 1) Plot day means
figure; hold on;
title(['Day pitch (SEM) averages from ' SummaryData.Params.FirstDay ' to ' SummaryData.Params.LastDay]);
xlabel('Days');
ylabel('Pitch (hz)');

for i=1:length(FieldNames);
fieldname=FieldNames{i};
hmeans(i)=errorbar(SummaryData.Data.(fieldname).pitch.mean{timewind}, SummaryData.Data.(fieldname).pitch.sem{timewind},...
'o','Color',PlotColors{i},'MarkerFaceColor',PlotColors{i},'MarkerSize',7); 
end
% ylim([3200 3700])
legend(hmeans,FieldNames);


% 2) Plot variability
figure; hold on;
title(['Epoch CVs from ' SummaryData.Params.FirstDay ' to ' SummaryData.Params.LastDay]);
xlabel('Days');
ylabel('CV');

for i=1:length(FieldNames);
fieldname=FieldNames{i};
hmeans(i)=plot(SummaryData.Data.(fieldname).pitch.sd{timewind}./SummaryData.Data.(fieldname).pitch.mean{timewind},...
'o','Color',PlotColors{i},'MarkerFaceColor',PlotColors{i},'MarkerSize',7); 
end
legend(hmeans,FieldNames);


% 3) PLOT ALL RENDS
% collect all time and vals
times=struct;
vals=struct;

% to collect all values in one thing
AllTimes{timewind}=[];
AllVals.pitch{timewind}=[];

for i=1:length(FieldNames);
    fieldname=FieldNames{i};
    
    times.(fieldname)=[];
    vals.pitch.(fieldname){timewind}=[];

    for ii=1:NumDays;
        if length(SummaryData.Data.(fieldname).pitch.time_vals{timewind})>=ii; % if this day is an index
            if ~isempty(SummaryData.Data.(fieldname).pitch.time_vals{timewind}{ii}); % if has values this day
                
                times.(fieldname)=[times.(fieldname); SummaryData.Data.(fieldname).pitch.time_vals{timewind}{ii}(:,1)+ii-1]; % gets times, in units of days
                vals.pitch.(fieldname){timewind}=[vals.pitch.(fieldname){timewind};...
                    SummaryData.Data.(fieldname).pitch.time_vals{timewind}{ii}(:,3)];


        % all vals combined
        AllTimes{timewind}=[AllTimes{timewind}; SummaryData.Data.(fieldname).pitch.time_vals{timewind}{ii}(:,1)+ii-1];
        AllVals.pitch{timewind}=[AllVals.pitch{timewind}; SummaryData.Data.(fieldname).pitch.time_vals{timewind}{ii}(:,3)];


            end
        end
    end
    
end
% sort so all values are in order
[AllTimes{timewind}, tmp_Ind]=sort(AllTimes{timewind});
AllVals.pitch{timewind}=AllVals.pitch{timewind}(tmp_Ind);

% Plot
figure; hold on;
title('All renditions');
xlabel('Days');
ylabel('Pitch (hz)');

for i=1:length(FieldNames);
    fieldname=FieldNames{i};

hfig(i)=plot(times.(fieldname),vals.pitch.(fieldname){timewind},'o','Color',...
PlotColors{i},'MarkerFaceColor',PlotColors{i},'MarkerSize',4);
plot(AllTimes{timewind},smooth(AllVals.pitch{timewind},smthbin),'-k')


end
legend(hfig, FieldNames)


% Calculate local variability
% RunningSTD=movingstd(AllVals.pitch{timewind},smthbin,'c');
% RunningCV=RunningSTD./smooth(AllVals.pitch{timewind});
% 
% figure; hold on;
% hsp(1)=subplot(2,1,1); hold on
% for i=1:length(FieldNames);
%     fieldname=FieldNames{i};
% 
% hfig(i)=plot(times.(fieldname),vals.pitch.(fieldname){timewind},'o','Color',PlotColors{i},'MarkerFaceColor',PlotColors{i});
% 
% 
% end
% hsp(2)=subplot(2,1,2); hold on;
% plot(AllTimes{timewind},RunningCV,'-');
% 
% legend(hfig, FieldNames)
% linkaxes(hsp,'x')
% 
% 
% 







