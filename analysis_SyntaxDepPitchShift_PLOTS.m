%% PLOT STUFF - specifically using all_days_various_COMPILED
% USED FOR pu11 and pu53

% INPUTS - run folling in calling script.
% Save?
% save_plots=1;
% % What to get? (1 = get , 0 = skip)
% get_thr=0;
% plot_baseline=1;
% baseline_days=1:3;
% plot_WN=1;
%     WN_dates={'08Jul2014-1232','16Jul2014-0000','21Jul2014-1624'};
%     WNevents=lt_convert_EventTimes_to_RelTimes(first_day_str,WN_dates);
%     WN_switch_days=WNevents.FinalValue;
% plot_lesions=0;
% %     lesion_dates={''};
% %     lesionEvents=lt_convert_EventTimes_to_RelTimes(first_day_str,lesion_dates);
% %     lesion_days=lesionEvents.FinalValue;
% plot_pitch_thresholds=0;
% %     threshold_switch_RealTimes={'20Mar2014-0029','20Mar2014-1739','21Mar2014-1234','24Mar2014-1651','25Mar2014-1808',...
% %         '26Mar2014-1347','27Mar2014-0207','27Mar2014-1127','28Mar2014-0103','28Mar2014-1320','30Mar2014-1951'}; % real times for threshold values switches in format e.g. 20Mar2014-1645
% %     thresh_values=[2583 2615 2639 2706 2685 2675 2665 2680 2720 2710 2720]; % values of threshold corresponding to switch times
% %     hit_conting='below'; % hit renditions "below" or "above" threshold?
%
% % running average
% run_wind=[10 20 50];


% AUTOMATIC PARAMS
bird_dir=['/bluejay3/lucas/birds/' all_days_various_COMPILED.parameters_COMPILATION.birdname];



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

%% PLOTS not summary

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

%% SUMMARY FIGURES all syllables in one plot, across days:


TargSyl=2;
NonTargSyl=[1:TargSyl-1 TargSyl+1:num_syl];

% PITCH
hfig_allpitch=figure; hold on;
H=[];
for j=1:num_syl;
    X=[];
    Xstd=[];
    all_days_various=all_days_various_COMPILED.all_days_various(syllables_COMPILED{j,1}); % extract relevant structure from compiled structures
    for i=1:num_days; % number of days
        try
            X(i)=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).mean_FF;
            Xstd(i)=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).sd_FF;
            Xn(i)=size(all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF,1); % sample size
            Xse(i)=Xstd(i)/sqrt(Xn(i));
        catch err
            X(i)=nan;
            Xstd(i)=nan;
            Xn(i)=nan;
            Xse(i)=nan;
            continue
        end
    end
    %     errorbar(X,Xstd,'o','Color',plot_colors{j});
    %     H(j)=plot(X,'o-','Color',plot_colors{j},'MarkerFaceColor',plot_colors{j},'MarkerSize',7);
    H(j)=errorbar(X,Xse,'o-','Color',plot_colors{j},'MarkerFaceColor',plot_colors{j},'MarkerSize',7);
    errorbar_tick(H(j),200);
end

try
    legend(H, motif_table(:,1));
catch err
    legend(H, motif_table(:,2));
end
title('Pitch over days for all analyzed motifs');
xlabel('days');
ylabel('Pitch (hz)');

if (0)
    % GIVEN THE CHANGE IN PITCH OF TARGET SYL, WHAT IS CHANGE IN PITCH OF THE
    % OTHER SYLS?
    DayLag=1; % i.e. 1 means: does targ syl predict tomorrow for non-targ?
    hfig_PitchDiffScatter=figure; hold on;
    H=[];
    Xdiff=[];
    for j=1:num_syl;
        all_days_various=all_days_various_COMPILED.all_days_various(syllables_COMPILED{j,1}); % extract relevant structure from compiled structures
        for i=1:num_days; % number of days
            try
                X(i)=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).mean_FF;
            catch err
                X(i)=nan;
                continue
            end
        end
        Xdiff(:,j)=100*diff(X)./X(1:end-1); % difference values from day to day, in percent (1 to 100)
        %     H(j)=errorbar(X,Xse,'o-','Color',plot_colors{j},'MarkerFaceColor',plot_colors{j},'MarkerSize',7);
        %     errorbar_tick(H(j),200);
    end
    
    % get lagged diff values
    Xdiff_lag=Xdiff(1+DayLag:end,:);
    NewNumDays_lag=size(Xdiff_lag,1);
    
    for jj=NonTargSyl;
        figure; hold on;
        scatter(Xdiff(:,TargSyl),Xdiff(:,jj));
        xlabel(['Target: ' motif_table(TargSyl,1)]);
        ylabel(['Non-target: ' motif_table(jj,1)]);
        % linear regression
        [B,Bint,R,Rint,Stats]=regress(Xdiff(:,jj),[ones(size(Xdiff,1),1) Xdiff(:,TargSyl)]);
        R2=Stats(1);
        xlimits=xlim;
        ylimits=ylim;
        Y(1)=B(2)*xlimits(1)+B(1);
        Y(2)=B(2)*xlimits(2)+B(1);
        plot(xlimits,Y,'-');
        % plot r2 and slope
        text(xlimits(1)+0.1,ylimits(2)-0.1,['r2 = ' num2str(R2)]);
    end
    
    % scatter, with lag
    for jj=NonTargSyl;
        figure; hold on;
        scatter(Xdiff(1:NewNumDays_lag,TargSyl),Xdiff_lag(:,jj));
        title(['Target syl compared to non-target with lag:' num2str(DayLag) ' (positive means non-target later)'])
        xlabel(['Target: ' motif_table(TargSyl,1)]);
        ylabel(['Non-target: ' motif_table(jj,1)]);
        % linear regression
        [B,Bint,R,Rint,Stats]=regress(Xdiff(:,jj),[ones(size(Xdiff,1),1) Xdiff(:,TargSyl)]);
        R2=Stats(1);
        xlimits=xlim;
        ylimits=ylim;
        Y(1)=B(2)*xlimits(1)+B(1);
        Y(2)=B(2)*xlimits(2)+B(1);
        plot(xlimits,Y,'-');
        % plot r2 and slope
        text(xlimits(1)+0.1,ylimits(2)-0.1,['r2 = ' num2str(R2)]);
    end
    
    % Scatter, but only look at learning days
    LearningDays=[4:12];
    for jj=NonTargSyl;
        figure; hold on;
        scatter(Xdiff(LearningDays-1,TargSyl),Xdiff(LearningDays-1,jj));
        title(['Only looking at learning days: ' num2str(LearningDays)]);
        xlabel(['Target: ' motif_table(TargSyl,1)]);
        ylabel(['Non-target: ' motif_table(jj,1)]);
        % linear regression
        [B,Bint,R,Rint,Stats]=regress(Xdiff(:,jj),[ones(size(Xdiff,1),1) Xdiff(:,TargSyl)]);
        R2=Stats(1);
        xlimits=xlim;
        ylimits=ylim;
        Y(1)=B(2)*xlimits(1)+B(1);
        Y(2)=B(2)*xlimits(2)+B(1);
        plot(xlimits,Y,'-');
        % plot r2 and slope
        text(xlimits(1)+0.1,ylimits(2)-0.1,['r2 = ' num2str(R2)]);
    end
    
    
    % Other Things
    for jj=NonTargSyl;
        figure;
        bar(Xdiff(:,[TargSyl jj]));
        xlabel(['Target: ' motif_table(TargSyl,1) ';Non-target: ' motif_table(jj,1)]);
        % adding WN day lines
        ylimits=ylim;
        for i=1:size(WN_switch_days,1)
            % commented out as could not handle consolidation days
            %             if mod(i,2)==1; %i.e. i odd means this is start of WN
            %                 rectangle('Position',[WN_switch_days(i), ylimits(1)+20, WN_switch_days(i+1)-WN_switch_days(i),ylimits(2)-ylimits(1)-40],...
            %                     'EdgeColor','r')
            line([WN_switch_days(i)-0.5 WN_switch_days(i)-0.5], [ylimits(1) ylimits(2)],'Color',[0.8 0.8 0.8])
        end
    end
    
    % Xdiff_ratio=[];
    for jj=NonTargSyl;
        Xdiff_ratio=Xdiff(:,jj)./Xdiff(:,TargSyl);
        figure;
        bar(Xdiff_ratio);
        xlabel(['Target: ' motif_table(TargSyl,1) '; Non-target: ' motif_table(jj,1)]);
        % adding WN day lines
        ylimits=ylim;
        for i=1:size(WN_switch_days,1)
            % commented out as could not handle consolidation days
            %             if mod(i,2)==1; %i.e. i odd means this is start of WN
            %                 rectangle('Position',[WN_switch_days(i), ylimits(1)+20, WN_switch_days(i+1)-WN_switch_days(i),ylimits(2)-ylimits(1)-40],...
            %                     'EdgeColor','r')
            line([WN_switch_days(i)-0.5 WN_switch_days(i)-0.5], [ylimits(1) ylimits(2)],'Color',[0.8 0.8 0.8])
        end
    end
    
    try
        legend(H, motif_table(:,1));
    catch err
        legend(H, motif_table(:,2));
    end
    
    
    
    
    % combine different syllable data ----------------------------------------
    SylsToCombine=[1 2 4 5]; % cb and cbb
    motif_table;
    Ycomb=cell(num_days,1);
    for jj=SylsToCombine;
        for kk=1:num_days;
            Ytemp=all_days_various_COMPILED.all_days_various(syllables_COMPILED{jj,1}).lt_calc_day_pitch{kk}.FF.(syllables{jj}).time_and_FF;
            Ycomb{kk}=[Ycomb{kk};Ytemp];
        end
    end
    
    Ycombined.raw=Ycomb;
    Ycombined.SylsCombined=SylsToCombine;
    for i=1:num_days;
        Ycombined.DayMeans(i)=mean(Ycombined.raw{i}(:,2));
        Ycombined.DaySD(i)=std(Ycombined.raw{i}(:,2));
        Ycombined.DaySE(i)=Ycombined.DaySD(i)/sqrt(size(Ycombined.raw{i},1));
        
    end
    Ycombined.DayDiffs=100*diff(Ycombined.DayMeans)./Ycombined.DayMeans(1:end-1); % in percents
    
    % Combined different set of syllables
    SylsToCombine2=[1 2 3 4 5]; % all other than target
    motif_table;
    Ycomb2=cell(num_days,1);
    for jj=SylsToCombine2;
        for kk=1:num_days;
            Ytemp2=all_days_various_COMPILED.all_days_various(syllables_COMPILED{jj,1}).lt_calc_day_pitch{kk}.FF.(syllables{jj}).time_and_FF;
            Ycomb2{kk}=[Ycomb2{kk};Ytemp2];
        end
    end
    
    Ycombined2.raw=Ycomb2;
    Ycombined2.SylsCombined=SylsToCombine2;
    for i=1:num_days;
        Ycombined2.DayMeans(i)=mean(Ycombined2.raw{i}(:,2));
        Ycombined2.DaySD(i)=std(Ycombined2.raw{i}(:,2));
        Ycombined2.DaySE(i)=Ycombined2.DaySD(i)/sqrt(size(Ycombined2.raw{i},1));
        
    end
    Ycombined2.DayDiffs=100*diff(Ycombined2.DayMeans)./Ycombined2.DayMeans(1:end-1); % in percents
    
    % combined different sets of syl.
    SylsToCombine3=[1 4]; % all cb
    motif_table;
    Ycomb3=cell(num_days,1);
    for jj=SylsToCombine3;
        for kk=1:num_days;
            Ytemp3=all_days_various_COMPILED.all_days_various(syllables_COMPILED{jj,1}).lt_calc_day_pitch{kk}.FF.(syllables{jj}).time_and_FF;
            Ycomb3{kk}=[Ycomb3{kk};Ytemp3];
        end
    end
    
    Ycombined3.raw=Ycomb3;
    Ycombined3.SylsCombined=SylsToCombine3;
    for i=1:num_days;
        Ycombined3.DayMeans(i)=mean(Ycombined3.raw{i}(:,2));
        Ycombined3.DaySD(i)=std(Ycombined3.raw{i}(:,2));
        Ycombined3.DaySE(i)=Ycombined3.DaySD(i)/sqrt(size(Ycombined3.raw{i},1));
        
    end
    Ycombined3.DayDiffs=100*diff(Ycombined3.DayMeans)./Ycombined3.DayMeans(1:end-1); % in percents
    
    
    
    % PLOT scatter for Ycombined
    figure; hold on;
    scatter(Xdiff(:,TargSyl),Ycombined.DayDiffs);
    xlabel(['Target: ' motif_table(TargSyl,1)]);
    ylabel(['Non-target: Combined: ' num2str(SylsToCombine)]);
    % linear regression
    [B,Bint,R,Rint,Stats]=regress(Ycombined.DayDiffs',[ones(size(Xdiff,1),1) Xdiff(:,TargSyl)]);
    R2=Stats(1);
    xlimits=xlim;
    ylimits=ylim;
    Yfit(1)=B(2)*xlimits(1)+B(1);
    Yfit(2)=B(2)*xlimits(2)+B(1);
    plot(xlimits,Yfit,'-');
    % plot r2 and slope
    text(xlimits(1)+0.1,ylimits(2)-0.1,['r2 = ' num2str(R2)]);
    
    % Scatter, but only look at learning days
    LearningDays=[4:8];
    figure; hold on;
    scatter(Xdiff(LearningDays-1,TargSyl),Ycombined.DayDiffs(LearningDays-1));
    xlabel(['Target: ' motif_table(TargSyl,1)]);
    ylabel(['Non-target: Combined: ' num2str(SylsToCombine)]);
    % linear regression
    [B,Bint,R,Rint,Stats]=regress(Ycombined.DayDiffs',[ones(size(Xdiff,1),1) Xdiff(:,TargSyl)]);
    R2=Stats(1);
    xlimits=xlim;
    ylimits=ylim;
    Yfit(1)=B(2)*xlimits(1)+B(1);
    Yfit(2)=B(2)*xlimits(2)+B(1);
    plot(xlimits,Yfit,'-');
    % plot r2 and slope
    text(xlimits(1)+0.1,ylimits(2)-0.1,['r2 = ' num2str(R2)]);
    
    % BAR PLOT over days
    figure;
    bar([Xdiff(:,[TargSyl]) Ycombined.DayDiffs]);
    xlabel(['Target: ' motif_table(TargSyl,1) ';Non-target: Combined syls']);
    % adding WN day lines
    ylimits=ylim;
    for i=1:size(WN_switch_days,1)
        % commented out as could not handle consolidation days
        %             if mod(i,2)==1; %i.e. i odd means this is start of WN
        %                 rectangle('Position',[WN_switch_days(i), ylimits(1)+20, WN_switch_days(i+1)-WN_switch_days(i),ylimits(2)-ylimits(1)-40],...
        %                     'EdgeColor','r')
        line([WN_switch_days(i)-0.5 WN_switch_days(i)-0.5], [ylimits(1) ylimits(2)],'Color',[0.8 0.8 0.8])
    end
    
    % Plot pitch over days (of selected + combined)
    figure; hold on;
    SylsToPlot=[TargSyl 3];
    X=[];
    Xstd=[];
    for j=SylsToPlot;
        all_days_various=all_days_various_COMPILED.all_days_various(syllables_COMPILED{j,1}); % extract relevant structure from compiled structures
        for i=1:num_days; % number of days
            try
                X(i)=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).mean_FF;
                Xstd(i)=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).sd_FF;
                Xn(i)=size(all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF,1); % sample size
                Xse(i)=Xstd(i)/sqrt(Xn(i));
            catch err
                X(i)=nan;
                Xstd(i)=nan;
                Xn(i)=nan;
                Xse(i)=nan;
                continue
            end
        end
        h=errorbar(X,Xse,'o-','Color',plot_colors{j},'MarkerFaceColor',plot_colors{j},'MarkerSize',7);
        errorbar_tick(h,200);
    end
    legend(syl_title{TargSyl}, syl_title{3});
    title('Pitch (mean +/- SEM) for each day of training');
    xlabel('days');
    ylabel('Pitch (hz)');
    
    % Add WN lines
    ylimits=ylim;
    for i=1:size(WN_switch_days,1)
        % commented out as could not handle consolidation days
        %             if mod(i,2)==1; %i.e. i odd means this is start of WN
        %                 rectangle('Position',[WN_switch_days(i), ylimits(1)+20, WN_switch_days(i+1)-WN_switch_days(i),ylimits(2)-ylimits(1)-40],...
        %                     'EdgeColor','r')
        line([WN_switch_days(i)-0.5 WN_switch_days(i)-0.5], [ylimits(1) ylimits(2)],'Color',[0.7 0.7 0.7])
        
    end
    
    
    figure; hold on;
    SylsToPlot=[TargSyl];
    X=[];
    Xstd=[];
    for j=SylsToPlot;
        all_days_various=all_days_various_COMPILED.all_days_various(syllables_COMPILED{j,1}); % extract relevant structure from compiled structures
        for i=1:num_days; % number of days
            try
                X(i)=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).mean_FF;
                Xstd(i)=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).sd_FF;
                Xn(i)=size(all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF,1); % sample size
                Xse(i)=Xstd(i)/sqrt(Xn(i));
            catch err
                X(i)=nan;
                Xstd(i)=nan;
                Xn(i)=nan;
                Xse(i)=nan;
                continue
            end
        end
        h=errorbar(X,Xse,'o-','Color',plot_colors{j},'MarkerFaceColor',plot_colors{j},'MarkerSize',7);
        errorbar_tick(h,200);
    end
    
    % plot Ycombined3
    h=errorbar(Ycombined3.DayMeans,Ycombined3.DaySE,'o-','Color',plot_colors{2},'MarkerFaceColor',plot_colors{2},'MarkerSize',7);
    errorbar_tick(h,200);
    
    legend(syl_title{TargSyl}, 'cb');
    
    title('Pitch (mean +/- SEM) for each day of training');
    xlabel('days');
    ylabel('Pitch (hz)');
    
    
    % Add WN lines
    ylimits=ylim;
    for i=1:size(WN_switch_days,1)
        % commented out as could not handle consolidation days
        %             if mod(i,2)==1; %i.e. i odd means this is start of WN
        %                 rectangle('Position',[WN_switch_days(i), ylimits(1)+20, WN_switch_days(i+1)-WN_switch_days(i),ylimits(2)-ylimits(1)-40],...
        %                     'EdgeColor','r')
        line([WN_switch_days(i)-0.5 WN_switch_days(i)-0.5], [ylimits(1) ylimits(2)],'Color',[0.7 0.7 0.7])
        
    end
    
    
    
    
    
    
    
    
    try
        legend(H, motif_table(:,1));
    catch err
        legend(H, motif_table(:,2));
    end
    title('Pitch over days for all analyzed motifs');
    xlabel('days');
    ylabel('Pitch (hz)');
    
    
    
    % ------------------------------------------------------------------
    
    
    % WN HITS
    hfig_WNhit=figure; hold on;
    title('WN hit rate over days (possibly catch songs)');
    ylabel('WN hit rate');
    xlabel('Days');
    X=[];
    H=[];
    c=1;
    try
        for i=1:size(all_days_various_COMPILED.all_days_various,2); % how many data structures
            all_days_various=all_days_various_COMPILED.all_days_various(i);
            syls_and_params=fieldnames(all_days_various.lt_check_hit_templ_freq);
            num_syls=size(syls_and_params,1)-1;
            for ii=1:num_syls;
                if ~strcmp(syls_and_params(ii),'parameters');
                    for j=1:num_days;
                        try % maybe no data
                            X(j)=all_days_various.lt_check_hit_templ_freq.(syls_and_params{ii}){j}.(syls_and_params{ii}(end)).hit.sum(1)/...
                                all_days_various.lt_check_hit_templ_freq.(syls_and_params{ii}){j}.(syls_and_params{ii}(end)).hit.sum(2);
                        catch err
                            X(j)=nan;
                        end
                    end
                end
                H(c)=plot(X,'o-','Color',plot_colors{c},'MarkerFaceColor',plot_colors{c},'MarkerSize',7);
                c=c+1;
            end
        end
        legend(H, motif_table(:,1));
    catch err
    end
    
    % TEMPLATE MATCHES
    if (0);
        hfig_TemplMatch=figure; hold on;
        title('Template match rate over days (regardless of WN hit %)');
        ylabel('Match rate');
        xlabel('Days');
        X=[];
        H=[];
        c=1;
        for i=1:size(all_days_various_COMPILED.all_days_various,2); % how many data structures
            all_days_various=all_days_various_COMPILED.all_days_various(i);
            syls_and_params=fieldnames(all_days_various.lt_check_hit_templ_freq);
            num_syls=size(syls_and_params,1)-1;
            for ii=1:num_syls;
                if ~strcmp(syls_and_params(ii),'parameters');
                    for j=1:num_days;
                        try % maybe no data
                            X(j)=all_days_various.lt_check_hit_templ_freq.(syls_and_params{ii}){j}.(syls_and_params{ii}(end)).match.sum(1)/...
                                all_days_various.lt_check_hit_templ_freq.(syls_and_params{ii}){j}.(syls_and_params{ii}(end)).match.sum(2);
                        catch err
                            X(j)=nan;
                        end
                    end
                end
                H(c)=plot(X,'o-','Color',plot_colors{c},'MarkerFaceColor',plot_colors{c},'MarkerSize',7);
                c=c+1;
            end
        end
        legend(H, motif_table(:,1));
    end
    
    % ADD ANNOTATIONS TO SUMMARY PLOTS
    figures_to_annotate={hfig_allpitch, hfig_WNhit};
    % WN epochs
    if plot_WN==1;
        WNevents=lt_convert_EventTimes_to_RelTimes(first_day_str,WN_dates);
        WN_switch_days=WNevents.JustDays_rel;
        for i=1:length(figures_to_annotate);
            ff=figures_to_annotate{i};
            figure(ff);
            ylimits=ylim;
            if plot_WN==1;
                % adding grey boxes for WN days
                figure(ff);
                ylimits=ylim;
                for i=1:size(WN_switch_days,1)
                    % commented out as could not handle consolidation days
                    %             if mod(i,2)==1; %i.e. i odd means this is start of WN
                    %                 rectangle('Position',[WN_switch_days(i), ylimits(1)+20, WN_switch_days(i+1)-WN_switch_days(i),ylimits(2)-ylimits(1)-40],...
                    %                     'EdgeColor','r')
                    line([WN_switch_days(i)-0.5 WN_switch_days(i)-0.5], [ylimits(1) ylimits(2)],'Color',[0.8 0.8 0.8])
                    
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
    end
end

%% SAVING
if save_plots==1;
    timestampS=lt_get_timestamp(0);
    currdir=pwd;
    try 
        phrase = all_days_various_COMPILED.all_days_various(1).parameters.phrase;
    catch
    end
    
    higherdir=[bird_dir '/' phrase '_analysis'];
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

    save(['all_days_various_MOTIF_COMPILED_' all_days_various_COMPILED.parameters_COMPILATION.time_of_analysis],'all_days_various_COMPILED')
    savemultfigs;
end

