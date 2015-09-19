%% PLOT entropy over all transitions and over the desired transition
%% plotting WN hit rate over all things, see bk51bk59 analysis script for details.
clear all
load all_days_all_analysis_27Mar2014_1354_CPseq_AllTrans_WNtrigLabel

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

%%
clear all
load all_days_all_analysis_26Mar2014_1804_CPseq_AllTrans_WNtrigLabel

% Input parameters
baseline_days=[1 2 3]; %in 1,2,3,... indices, not days with gaps.
WN_days= 9;
thresh_prob=[0.005 0.01 0.02]; % ignore transitions with prob lower than this number
    
% Figure out the syllables that were sang every day.
for j=1:length(thresh_prob);
    for i=1:size(all_days_all_analysis.data,2);
        try
            dummy=all_days_all_analysis.data{i}.all_songs.all_trans.summary.matrix_of_fraction_of_all_trans(all_days_all_analysis.data{i}.all_songs.all_trans.summary.matrix_of_fraction_of_all_trans>thresh_prob(j));
            entropy.all_FractionOfAll(i,j)=sum(-dummy.*log2(dummy));
            %         below, do for specific transitions (div or conv specific)
            %         dummy2=all_days_all_analysis.data{i}.all_songs.all_trans.summary.divergence.matrix_of_
            %         entropy.all_Conv
        catch err
            entropy.all_FractionOfAll(i,j)=nan;
            continue
        end
    end
end

figure;hold on;
for j=1:length(thresh_prob)
    plot(entropy.all_FractionOfAll(:,j),'Color',[(j/length(thresh_prob))*1 0.5 0.5],'Marker','o');
    legend
end

all_days_all_analysis
line([baseline_days(end)+0.5 baseline_days(end)+0.5],ylim,'Color','g')
line([baseline_days(end)+WN_days+0.5 baseline_days(end)+WN_days+0.5],ylim,'Color','r')

    
    


% entropy
%% PLOT changes to transitions, using all_trans data - DIVERGENCE
close all
clear all
load all_days_all_analysis_19Mar2014_2300_NIFlesion_AllTrans

% Input parameters
baseline_days=[1 2 3]; %in 1,2,3,... indices, not days with gaps.

% FIRST, plotting heat map of change (rel to baseline) for every sun
% transition, across days.

% Figure out the syllables that were sang every day.
days_with_analysis=[];
for i=1:size(all_days_all_analysis.data,2);
    try
        if ~isempty(all_days_all_analysis.data{i}.all_songs.all_trans);
            days_with_analysis=[days_with_analysis i];
        end
    catch err
        continue
    end
end

num_of_days=length(days_with_analysis);

for j=1:num_of_days;
    syl_labels_concatenated{j}=all_days_all_analysis.data{days_with_analysis(j)}.all_songs.all_trans.summary.syl_labels_in_order;
end

[common_syls syl_indices]=mintersect_array(syl_labels_concatenated); % find common syls and their indices in each day


% FIRST-part A, DIVERGENCE
% get baseline
clear dummy
for j=1:length(baseline_days);
    dummy(:,:,j)=all_days_all_analysis.data{baseline_days(j)}.all_songs.all_trans.summary.divergence.matrix_of_fractions(syl_indices{j},syl_indices{j});
end
all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.baseline=mean(dummy,3);


for i=1:num_of_days;
    all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.all_days_incl_pre(:,:,days_with_analysis(i))=...
        all_days_all_analysis.data{days_with_analysis(i)}.all_songs.all_trans.summary.divergence.matrix_of_fractions(syl_indices{i},syl_indices{i})...
        -all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.baseline;
end

% convert from fraction to percent
all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.all_days_incl_pre=... 
    100*all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.all_days_incl_pre
all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.baseline=...
    100*all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.baseline;

% plot
num_figures=ceil((num_of_days+1)/9); % +1 becuase have a baseline mean figure as well.
for i=1:num_figures;
    if i==num_figures;
        row_plots(i)=ceil((num_of_days+1-(i-1)*9)/3);
        col_plots(i)=ceil((num_of_days+1-(i-1)*9)/row_plots(i));
    else
        row_plots(i)=3;
        col_plots(i)=3;
    end
end

% 
% if num_of_days<6;
%     row_plots(1)=min(ceil(num_of_days+1)/2,4);
%     num_figures=1;
%     col_plots=ceil((num_of_days+1)/row_plots);
% elseif num_of_days>5 && num_of_days<9;
%     row_plots(1)=4;
%     num_figures=1;
%     col_plots=ceil((num_of_days+1)/row_plots);
% elseif num_of_days>8 && num_of_days<18;
%     num_figures=2;
%     row_plots(1)=4;
%     row_plots(2)=ceil((num_of_days-8)/3);
%     col_plots(1)=ceil((num_of_days+1)/row_plots(1));
%     col_plots(2)=ceil((num_of_days+1)/row_plots(2)); 
% end

counter = 1; % count goes up 1 after each day plotted
while counter<=num_of_days+1;
    figure_num=ceil(counter/9);
    figure(figure_num); hold on;
    
    syl_num=size(common_syls,2);
    syl_labels=common_syls;
    
    if counter==1; %only plot baseline for 1st figure
        %PLOT THE BASELINE FRACTION MATRIX
        subplot(col_plots(figure_num),row_plots(figure_num),1);
        syl_mat = all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.baseline;
        imagesc(syl_mat);
        colormap(flipud(gray))
        textStrings = num2str(syl_mat(:),'%0.0f');
        textStrings = strtrim(cellstr(textStrings));
        [x,y]=meshgrid(1:syl_num);
        hStrings = text(x(:),y(:),textStrings(:), 'HorizontalAlignment','center');
        midValue = mean(get(gca,'CLim'));
        textColors = repmat(syl_mat(:) > midValue,1,3);
        set(hStrings,{'Color'},num2cell(textColors,2));
        set(gca,'XTick',1:syl_num,'XTickLabel',syl_labels, 'YTick',1:syl_num,...
            'YTickLabel',syl_labels, 'TickLength',[0 0]);
        ylabel('transition from:')
        xlabel('transition to:')
        title('\bf Baseline fractions (mean)');
        freezeColors
        counter=2;
    end
    
    % determine a common color scale across all days - normalize by max element
    % out of entire matrix
    max_value=max(max(max(all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.all_days_incl_pre)));
    min_value=min(min(min(all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.all_days_incl_pre)));
    absolute_max=max(min_value,max_value);
    
    % grayscale=[hot(100); flipud(cool(100))];
    % grayscale=cool(200)
    
    colorscale = [flipud([0.01:0.01:1; zeros(1,100); zeros(1,100)]'); [zeros(1,100); zeros(1,100); 0.01:0.01:1]'];

    %PLOT THE DIFFERENCE MATRICES
    i=counter-(figure_num-1)*9; % index for specific figure
    j=counter-1; %index out of all days with data
        subplot(col_plots(figure_num),row_plots(figure_num),i);
        syl_mat = all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.all_days_incl_pre(:,:,days_with_analysis(j));
        max_value_local=max(max(all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.all_days_incl_pre(:,:,days_with_analysis(j))));
        min_value_local=min(min(all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.all_days_incl_pre(:,:,days_with_analysis(j))));
        imagesc(syl_mat,[-absolute_max absolute_max]);
        %     colormap(grayscale(50+floor(min_value/2):50+ceil(max_value/2),:,:)); colorbar;
        colormap(colorscale);
        %     if i==num_of_days;
        %         h_bar=colorbar;
        %     end
        textStrings = num2str(syl_mat(:),'%0.0f');
        textStrings = strtrim(cellstr(textStrings));
        [x,y]=meshgrid(1:syl_num);
        hStrings = text(x(:),y(:),textStrings(:), 'HorizontalAlignment','center');
        %     midValue = mean(get(gca,'CLim'));
        textColors = repmat(syl_mat(:) >= 10,1,3)+repmat(syl_mat(:) <= -10,1,3); %only put in text of those that are past + or - 10.
        textColors_weak=0.35.*repmat(syl_mat(:) <10 & syl_mat(:) > -10,1,3);
        textColors=textColors+textColors_weak;
        
        set(hStrings,{'Color'},num2cell(textColors,2));
%         set(hStrings,{'Color'},num2cell(textColors_weak,2));
        
        %     set(hStrings,{'Color'},{'w'})
        set(gca,'XTick',1:syl_num,'XTickLabel',syl_labels, 'YTick',1:syl_num,...
            'YTickLabel',syl_labels, 'TickLength',[0 0]);
        ylabel('transition from:')
        xlabel('transition to:')
        title(['day # ' num2str(days_with_analysis(j)) ', ' all_days_all_analysis.data{days_with_analysis(j)}.date]);
        freezeColors
        
    
    if counter == num_of_days+1;
    % make one colorbar
    ax=gca;
    pos=get(gca,'pos'); % to arrange colorbar relative to the last plot
    % set(gca,'pos',[pos(1) pos(2) pos(3)*0.95 pos(4)]);
    % pos=get(gca,'pos');
    % hc=colorbar('position',[pos(1) pos(2) pos(3) 0.5*pos4]);
    hc=colorbar('position',[pos(1)+1.2*pos(3) pos(2)+(0.2*pos(4)) 0.05*pos(3) 0.7*pos(4)]);
    % hc=colorbar('location','eastoutside')
    % set(hc,'xaxisloc','top');
    
    
    % give a general title
    ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 1,['\bf Divergent transitions: difference from baseline (first ' num2str(max(baseline_days)) ' days)'],'HorizontalAlignment'...
        ,'center','VerticalAlignment', 'top')
    end
    counter = counter+1;
end

% all_days_all_analysis.PLOT.all_trans.difference_matrices.common_syls=common_syls;
% all_days_all_analysis.PLOT.all_trans.difference_matrices.syl_indices=syl_indices;

% save
% cd PLOT/
% save('all_days_all_analysis',all_days_all_analysis




%% ----------------------------------------------------------------
% FIRST - part B - CONVERGENCE
% get baseline
close all
clear all
load all_days_all_analysis_19Mar2014_2300_NIFlesion_AllTrans

% Input parameters
baseline_days=[1 2 3]; %in 1,2,3,... indices, not days with gaps.

% FIRST, plotting heat map of change (rel to baseline) for every sun
% transition, across days.

% Figure out the syllables that were sang every day.
days_with_analysis=[];
for i=1:size(all_days_all_analysis.data,2);
    try
        if ~isempty(all_days_all_analysis.data{i}.all_songs.all_trans);
            days_with_analysis=[days_with_analysis i];
        end
    catch err
        continue
    end
end

num_of_days=length(days_with_analysis);

for j=1:num_of_days;
    syl_labels_concatenated{j}=all_days_all_analysis.data{days_with_analysis(j)}.all_songs.all_trans.summary.syl_labels_in_order;
end

[common_syls syl_indices]=mintersect_array(syl_labels_concatenated); % find common syls and their indices in each day


for j=1:length(baseline_days);
    dummy(:,:,j)=all_days_all_analysis.data{baseline_days(j)}.all_songs.all_trans.summary.convergence.matrix_of_fractions(syl_indices{j},syl_indices{j});
end
all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.baseline=mean(dummy,3);


for i=1:num_of_days;
    all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.all_days_incl_pre(:,:,days_with_analysis(i))=...
        all_days_all_analysis.data{days_with_analysis(i)}.all_songs.all_trans.summary.convergence.matrix_of_fractions(syl_indices{i},syl_indices{i})...
        -all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.baseline;
end

% convert from fraction to percent
all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.all_days_incl_pre=... 
    100*all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.all_days_incl_pre
all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.baseline=...
    100*all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.baseline;

% plot
num_figures=ceil((num_of_days+1)/9); % +1 becuase have a baseline mean figure as well.
for i=1:num_figures;
    if i==num_figures;
        row_plots(i)=ceil((num_of_days+1-(i-1)*9)/3);
        col_plots(i)=ceil((num_of_days+1-(i-1)*9)/row_plots(i));
    else
        row_plots(i)=3;
        col_plots(i)=3;
    end
end

% 
% if num_of_days<6;
%     row_plots(1)=min(ceil(num_of_days+1)/2,4);
%     num_figures=1;
%     col_plots=ceil((num_of_days+1)/row_plots);
% elseif num_of_days>5 && num_of_days<9;
%     row_plots(1)=4;
%     num_figures=1;
%     col_plots=ceil((num_of_days+1)/row_plots);
% elseif num_of_days>8 && num_of_days<18;
%     num_figures=2;
%     row_plots(1)=4;
%     row_plots(2)=ceil((num_of_days-8)/3);
%     col_plots(1)=ceil((num_of_days+1)/row_plots(1));
%     col_plots(2)=ceil((num_of_days+1)/row_plots(2)); 
% end

counter = 1; % count goes up 1 after each day plotted
while counter<=num_of_days+1;
    figure_num=ceil(counter/9);
    figure(figure_num); hold on;
    
    syl_num=size(common_syls,2);
    syl_labels=common_syls;
    
    if counter==1; %only plot baseline for 1st figure
        %PLOT THE BASELINE FRACTION MATRIX
        subplot(col_plots(figure_num),row_plots(figure_num),1);
        syl_mat = all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.baseline;
        imagesc(syl_mat);
        colormap(flipud(gray))
        textStrings = num2str(syl_mat(:),'%0.0f');
        textStrings = strtrim(cellstr(textStrings));
        [x,y]=meshgrid(1:syl_num);
        hStrings = text(x(:),y(:),textStrings(:), 'HorizontalAlignment','center');
        midValue = mean(get(gca,'CLim'));
        textColors = repmat(syl_mat(:) > midValue,1,3);
        set(hStrings,{'Color'},num2cell(textColors,2));
        set(gca,'XTick',1:syl_num,'XTickLabel',syl_labels, 'YTick',1:syl_num,...
            'YTickLabel',syl_labels, 'TickLength',[0 0]);
        ylabel('transition from:')
        xlabel('transition to:')
        title('\bf Baseline fractions (mean)');
        freezeColors
        counter=2;
    end
    
    % determine a common color scale across all days - normalize by max element
    % out of entire matrix
    max_value=max(max(max(all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.all_days_incl_pre)));
    min_value=min(min(min(all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.all_days_incl_pre)));
    absolute_max=max(min_value,max_value);
    
    % grayscale=[hot(100); flipud(cool(100))];
    % grayscale=cool(200)
    
    colorscale = [flipud([0.01:0.01:1; zeros(1,100); zeros(1,100)]'); [zeros(1,100); zeros(1,100); 0.01:0.01:1]'];

    %PLOT THE DIFFERENCE MATRICES
    i=counter-(figure_num-1)*9; % index for specific figure
    j=counter-1; %index out of all days with data
        subplot(col_plots(figure_num),row_plots(figure_num),i);
        syl_mat = all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.all_days_incl_pre(:,:,days_with_analysis(j));
        max_value_local=max(max(all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.all_days_incl_pre(:,:,days_with_analysis(j))));
        min_value_local=min(min(all_days_all_analysis.PLOT.all_trans.difference_matrices.convergence.all_days_incl_pre(:,:,days_with_analysis(j))));
        imagesc(syl_mat,[-absolute_max absolute_max]);
        %     colormap(grayscale(50+floor(min_value/2):50+ceil(max_value/2),:,:)); colorbar;
        colormap(colorscale);
        %     if i==num_of_days;
        %         h_bar=colorbar;
        %     end
        textStrings = num2str(syl_mat(:),'%0.0f');
        textStrings = strtrim(cellstr(textStrings));
        [x,y]=meshgrid(1:syl_num);
        hStrings = text(x(:),y(:),textStrings(:), 'HorizontalAlignment','center');
        %     midValue = mean(get(gca,'CLim'));
        textColors = repmat(syl_mat(:) >= 10,1,3)+repmat(syl_mat(:) <= -10,1,3); %only put in text of those that are past + or - 10.
        textColors_weak=0.35.*repmat(syl_mat(:) <10 & syl_mat(:) > -10,1,3);
        textColors=textColors+textColors_weak;
        
        set(hStrings,{'Color'},num2cell(textColors,2));
%         set(hStrings,{'Color'},num2cell(textColors_weak,2));
        
        %     set(hStrings,{'Color'},{'w'})
        set(gca,'XTick',1:syl_num,'XTickLabel',syl_labels, 'YTick',1:syl_num,...
            'YTickLabel',syl_labels, 'TickLength',[0 0]);
        ylabel('transition from:')
        xlabel('transition to:')
        title(['day # ' num2str(days_with_analysis(j)) ', ' all_days_all_analysis.data{days_with_analysis(j)}.date]);
        freezeColors
        
    
    if counter == num_of_days+1;
    % make one colorbar
    ax=gca;
    pos=get(gca,'pos'); % to arrange colorbar relative to the last plot
    % set(gca,'pos',[pos(1) pos(2) pos(3)*0.95 pos(4)]);
    % pos=get(gca,'pos');
    % hc=colorbar('position',[pos(1) pos(2) pos(3) 0.5*pos4]);
    hc=colorbar('position',[pos(1)+1.2*pos(3) pos(2)+(0.2*pos(4)) 0.05*pos(3) 0.7*pos(4)]);
    % hc=colorbar('location','eastoutside')
    % set(hc,'xaxisloc','top');
    
    
    % give a general title
    ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 1,['\bf Divergent transitions: difference from baseline (first ' num2str(max(baseline_days)) ' days)'],'HorizontalAlignment'...
        ,'center','VerticalAlignment', 'top')
    end
    counter = counter+1;
end




%% SECOND, plot transition matrices for all days. (instead of difference matrices)\
% DIVERGENCE

close all
clear all
load all_days_all_analysis_27Mar2014_1354_CPseq_AllTrans_WNtrigLabel

% Input parameters
baseline_days=[1 2 3]; %in 1,2,3,... indices, not days with gaps.

% Figure out the syllables that were sang every day.
days_with_analysis=[];
for i=1:size(all_days_all_analysis.data,2);
    try
        if ~isempty(all_days_all_analysis.data{i}.all_songs.all_trans);
            days_with_analysis=[days_with_analysis i];
        end
    catch err
        continue
    end
end

num_of_days=length(days_with_analysis);

% concatenate syl labels and data matrices
for j=1:num_of_days;
    syl_labels_concatenated{j}=all_days_all_analysis.data{days_with_analysis(j)}.all_songs.all_trans.summary.syl_labels_in_order;
end

for i=1:num_of_days;
    syl_labels{i}=all_days_all_analysis.data{days_with_analysis(i)}.all_songs.all_trans.summary.syl_labels_in_order;
    all_days_all_analysis.PLOT.all_trans.divergence.fractions{days_with_analysis(i)}=...
        all_days_all_analysis.data{days_with_analysis(i)}.all_songs.all_trans.summary.divergence.matrix_of_fractions; 
    all_days_all_analysis.PLOT.all_trans.divergence.fractions{days_with_analysis(i)}=100.*...
        all_days_all_analysis.PLOT.all_trans.divergence.fractions{days_with_analysis(i)}; %convert from fraction to percent
end
    
% PLOT THE TRANSITION MATRICES

num_figures=ceil((num_of_days)/9); 
for i=1:num_figures;
    if i==num_figures;
        row_plots(i)=ceil((num_of_days-(i-1)*9)/3);
        col_plots(i)=ceil((num_of_days-(i-1)*9)/row_plots(i));
    else
        row_plots(i)=3;
        col_plots(i)=3;
    end
end

counter = 1; % count goes up 1 after each day plotted
while counter<=num_of_days;
    figure_num=ceil(counter/9);
    figure(figure_num); hold on;
    
    

    
    i=counter-(figure_num-1)*9; % index for specific figure
    j=counter; %index out of all days with data (same as i, but i resets with each figure)    
    syl_num=size(syl_labels{j},2);

        subplot(col_plots(figure_num),row_plots(figure_num),i);
        syl_mat = all_days_all_analysis.PLOT.all_trans.divergence.fractions{days_with_analysis(j)};
%         max_value_local=max(max(all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.all_days_incl_pre(:,:,days_with_analysis(j))));
%         min_value_local=min(min(all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.all_days_incl_pre(:,:,days_with_analysis(j))));
        imagesc(syl_mat,[0 100]);
        colormap(flipud(gray))
        textStrings = num2str(syl_mat(:),'%0.0f');
        textStrings = strtrim(cellstr(textStrings));
        [x,y]=meshgrid(1:syl_num);
        hStrings = text(x(:),y(:),textStrings(:), 'HorizontalAlignment','center');
        midValue = mean(get(gca,'CLim'));
        textColors = repmat(syl_mat(:) > midValue,1,3);
        set(hStrings,{'Color'},num2cell(textColors,2));
        set(gca,'XTick',1:syl_num,'XTickLabel',syl_labels{j}, 'YTick',1:syl_num,...
            'YTickLabel',syl_labels{j}, 'TickLength',[0 0]);
        ylabel('transition from:')
        xlabel('transition to:')
        title('\bf Baseline fractions (mean)');
        freezeColors

        set(gca,'XTick',1:syl_num,'XTickLabel',syl_labels{j}, 'YTick',1:syl_num,...
            'YTickLabel',syl_labels{j}, 'TickLength',[0 0]);
        ylabel('transition from:')
        xlabel('transition to:')
        title(['day # ' num2str(days_with_analysis(j)) ', ' all_days_all_analysis.data{days_with_analysis(j)}.date]);
        freezeColors
        
        
        if counter == num_of_days;
            % make one colorbar
            ax=gca;
            pos=get(gca,'pos'); % to arrange colorbar relative to the last plot
            hc=colorbar('position',[pos(1)+1.2*pos(3) pos(2)+(0.2*pos(4)) 0.05*pos(3) 0.7*pos(4)]);
            % hc=colorbar('location','eastoutside')
            % set(hc,'xaxisloc','top');
            
            
            % give a general title
            ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
            text(0.5, 1,['\bf Divergent transition matrices for each day'],'HorizontalAlignment'...
                ,'center','VerticalAlignment', 'top')
        end
        counter = counter+1;
end

% all_days_all_analysis.PLOT.all_trans.difference_matrices.common_syls=common_syls;
% all_days_all_analysis.PLOT.all_trans.difference_matrices.syl_indices=syl_indices;

% save
% cd PLOT/
% save('all_days_all_analysis',all_days_all_analysis



%% -----------------------------------------------------------------
% TRANSITION MATRICES, but for convergence
close all
clear all
load all_days_all_analysis_27Mar2014_1354_CPseq_AllTrans_WNtrigLabel

% Input parameters
baseline_days=[1 2 3]; %in 1,2,3,... indices, not days with gaps.

% Figure out the syllables that were sang every day.
days_with_analysis=[];
for i=1:size(all_days_all_analysis.data,2);
    try
        if ~isempty(all_days_all_analysis.data{i}.all_songs.all_trans);
            days_with_analysis=[days_with_analysis i];
        end
    catch err
        continue
    end
end

num_of_days=length(days_with_analysis);

% concatenate syl labels and data matrices
for j=1:num_of_days;
    syl_labels_concatenated{j}=all_days_all_analysis.data{days_with_analysis(j)}.all_songs.all_trans.summary.syl_labels_in_order;
end

for i=1:num_of_days;
    syl_labels{i}=all_days_all_analysis.data{days_with_analysis(i)}.all_songs.all_trans.summary.syl_labels_in_order;
    all_days_all_analysis.PLOT.all_trans.convergence.fractions{days_with_analysis(i)}=...
        all_days_all_analysis.data{days_with_analysis(i)}.all_songs.all_trans.summary.convergence.matrix_of_fractions; 
    all_days_all_analysis.PLOT.all_trans.convergence.fractions{days_with_analysis(i)}=100.*...
        all_days_all_analysis.PLOT.all_trans.convergence.fractions{days_with_analysis(i)}; %convert from fraction to percent
end
    
% PLOT THE TRANSITION MATRICES

num_figures=ceil((num_of_days)/9); 
for i=1:num_figures;
    if i==num_figures;
        row_plots(i)=ceil((num_of_days-(i-1)*9)/3);
        col_plots(i)=ceil((num_of_days-(i-1)*9)/row_plots(i));
    else
        row_plots(i)=3;
        col_plots(i)=3;
    end
end

counter = 1; % count goes up 1 after each day plotted
while counter<=num_of_days;
    figure_num=ceil(counter/9);
    figure(figure_num); hold on;
    
    

    
    i=counter-(figure_num-1)*9; % index for specific figure
    j=counter; %index out of all days with data (same as i, but i resets with each figure)    
    syl_num=size(syl_labels{j},2);

        subplot(col_plots(figure_num),row_plots(figure_num),i);
        syl_mat = all_days_all_analysis.PLOT.all_trans.convergence.fractions{days_with_analysis(j)};
%         max_value_local=max(max(all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.all_days_incl_pre(:,:,days_with_analysis(j))));
%         min_value_local=min(min(all_days_all_analysis.PLOT.all_trans.difference_matrices.divergence.all_days_incl_pre(:,:,days_with_analysis(j))));
        imagesc(syl_mat,[0 100]);
        colormap(flipud(gray))
        textStrings = num2str(syl_mat(:),'%0.0f');
        textStrings = strtrim(cellstr(textStrings));
        [x,y]=meshgrid(1:syl_num);
        hStrings = text(x(:),y(:),textStrings(:), 'HorizontalAlignment','center');
        midValue = mean(get(gca,'CLim'));
        textColors = repmat(syl_mat(:) > midValue,1,3);
        set(hStrings,{'Color'},num2cell(textColors,2));
        
        set(gca,'XTick',1:syl_num,'XTickLabel',syl_labels{j}, 'YTick',1:syl_num,...
            'YTickLabel',syl_labels{j}, 'TickLength',[0 0]);
        ylabel('transition from:')
        xlabel('transition to:')
        title(['day # ' num2str(days_with_analysis(j)) ', ' all_days_all_analysis.data{days_with_analysis(j)}.date]);
        freezeColors

        
        if counter == num_of_days;
            % make one colorbar
            ax=gca;
            pos=get(gca,'pos'); % to arrange colorbar relative to the last plot
            hc=colorbar('position',[pos(1)+1.2*pos(3) pos(2)+(0.2*pos(4)) 0.05*pos(3) 0.7*pos(4)]);
            % hc=colorbar('location','eastoutside')
            % set(hc,'xaxisloc','top');
            
            
            % give a general title
            ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
            text(0.5, 1,['\bf Convergent transition matrices for each day'],'HorizontalAlignment'...
                ,'center','VerticalAlignment', 'top')
        end
        counter = counter+1;
end
