%% 5/19 - ADULT summary - 19May2014_2256
clear all
ADAAind='19May2014_2256';

lt_all_days_PLOT_WN_stats(ADAAind);

% PLOT transition matrices and difference matrices for all days

con_div = 'divergence';
all_days_all_analysis=lt_all_days_PLOT_AllTrans([1 2 3], ADAAind, con_div);
lt_all_days_PLOT_AllTrans_specific_trans(con_div,1,'',ADAAind) % run this in bird folder.  

con_div = 'convergence';
all_days_all_analysis=lt_all_days_PLOT_AllTrans([1 2 3], ADAAind, con_div);
lt_all_days_PLOT_AllTrans_specific_trans(con_div,1,'',ADAAind) % run this in bird folder.  




%% 4/28 - ADULT (preWN)

con_div = 'divergence';
all_days_all_analysis=lt_all_days_PLOT_AllTrans([1], '28Apr2014_2254', con_div);

con_div = 'convergence';
all_days_all_analysis=lt_all_days_PLOT_AllTrans([1], '28Apr2014_2254', con_div);



%% 4/28 - SUMMARY FIGS FOR CP

% PLOT transition matrices and difference matrices for all days
con_div = 'divergence';
all_days_all_analysis=lt_all_days_PLOT_AllTrans([1 2 3], '27Mar2014_0115', con_div);

con_div = 'convergence';
all_days_all_analysis=lt_all_days_PLOT_AllTrans([1 2 3], '27Mar2014_0115', con_div);


%---------------------------------------------------------------------------------
%PLOT single divergent or convergent transition over days (load all_days... first)
load /bluejay3/lucas/birds/bk75bk84/all_days_all_analysis/all_days_all_analysis_27Mar2014_0115_CPseq_AllTrans_WNtrigLabel

con_div = 'divergence';
% syl1_list={'a','b','c','d','g','j'};
syl1_list=all_days_all_analysis.data{1}.all_songs.all_trans.syllable_list;
for kk=1:length(syl1_list);
    syl1=syl1_list{kk};
    % syl2='b';
    syl2_list=all_days_all_analysis.data{1}.all_songs.all_trans.syllable_list;
    num_syl=length(syl2_list);
    % make syl colors
    syl_color=lt_make_plot_colors(length(syl2_list));
    
    figure;  hold on; title([con_div ' transition probability from ' syl1 ' to (see legend): ']);
    for k=1:length(syl2_list);
        syl2=syl2_list{k};
        dummy=[];
        for i=1:size(all_days_all_analysis.data,2);
            try
                dummy=[dummy; [i all_days_all_analysis.data{i}.all_songs.all_trans.(syl1).transition_to_.(syl2).relative_fraction_of_trans]];
            catch err
                continue
            end
        end
        %     plot(dummy,'Marker','o','Color',syl_color{k},'MarkerEdgeColor','black','MarkerFaceColor',syl_color{k},'MarkerSize',8);
        hplot(k)=plot(dummy(:,1), dummy(:,2),'Marker','o','Color',syl_color{k},'MarkerEdgeColor','black','MarkerFaceColor',syl_color{k},'MarkerSize',8);
    end
    legend(hplot,[syl2_list]);
    ylim([0 1]); xlabel('days'); ylabel('probability of transition')
end

% Convergence
%PLOT single divergent or convergent transition over days (run the above
%function first)
con_div = 'convergence';
% syl2_list={'a','b','c','d','g','j'}; % all the 2nd-syls that you are interested in (one plot each)
syl2_list=all_days_all_analysis.data{1}.all_songs.all_trans.syllable_list;

for kk=1:length(syl2_list)
    syl2=syl2_list{kk};
    syl1_list=all_days_all_analysis.data{1}.all_songs.all_trans.syllable_list;
    num_syl=length(syl1_list);
    
    % make syl colors
    syl_color=lt_make_plot_colors(length(syl1_list));
    
    figure;  hold on; title(['Convergence transition probability to ' syl2 ' from (see legend): ']);
    for k=1:length(syl1_list);
        syl1=syl1_list{k};
        dummy = [];
        for i=1:size(all_days_all_analysis.data,2);
            try
                dummy = [dummy; [i all_days_all_analysis.data{i}.all_songs.all_trans.convergent_to.(syl2).from.(syl1).fraction_of_trans]];
            catch err
                continue
            end
        end
        hplot2(k)= plot(dummy(:,1), dummy(:,2),'Marker','o','Color',syl_color{k},'MarkerEdgeColor','black','MarkerFaceColor',syl_color{k},'MarkerSize',8);
    end
    legend(hplot2,[syl1_list]);
    ylim([0 1]); xlabel('days'); ylabel('probability of transition')
end





%% hit rate


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


%% PLOT entropy over all transitions and over the desired transition

clear all
load all_days_all_analysis_27Mar2014_0115_CPseq_AllTrans_WNtrigLabel

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
load all_days_all_analysis_27Mar2014_0115_CPseq_AllTrans_WNtrigLabel

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
load all_days_all_analysis_27Mar2014_0115_CPseq_AllTrans_WNtrigLabel

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



%% THIRD, plot average matrices for pre, during, and post WN.





%% PLOT OVER DAYS, any type of analysis.
close all
analysis_type='gap_duration';
first_day_num=datenum(all_days_all_analysis.parameters.first_day);

if strcmp(analysis_type,'gap_duration')==1;
    transitions=all_days_all_analysis.parameters.gap_duration.transitions;
    
    for j=1:length(transitions);
        figure(j); hold on;
        for i=1:length(all_days_all_analysis.data); % number of days
            try
                num_of_renditions=length(all_days_all_analysis.data{i}.all_songs.(transitions{j}).gap_duration);
                scatter(i-1.25+[1:num_of_renditions]./(2*num_of_renditions),all_days_all_analysis.data{i}.all_songs.(transitions{j}).(analysis_type),'b');
            catch err
                continue
            end
        end
        
        % Put in medians, std
        for i=1:length(all_days_all_analysis.data); % number of days
            try
                errorbar(i-1,median(all_days_all_analysis.data{i}.all_songs.(transitions{j}).(analysis_type)),...
                    std(all_days_all_analysis.data{i}.all_songs.(transitions{j}).(analysis_type)),'Marker','.','MarkerSize',27,'Color','k');
            catch err
                continue
            end
        end
        
        % put in baseline lines (specifically for lesion experimnets)  aLSO pUT IN VERTICAL LINES FOR important dates (e.g. lesions)
        if isfield(all_days_all_analysis.summary_of_experiment,'inter_lesion_days')==1;
            disp('adding line for baseline value');
            baseline_values_temp=[];
            for i=1:all_days_all_analysis.summary_of_experiment.inter_lesion_days(1);
                baseline_values_temp=[baseline_values_temp all_days_all_analysis.data{i}.all_songs.transitions{j}.(analysis_type)'];
            end
            baseline_mean=median(baseline_values_temp);
            baseline_std=std(baseline_values_temp);
            line(xlim, [baseline_mean baseline_mean],'Color','r','LineWidth',0.4); % mean lines
            line(xlim, [baseline_mean+baseline_std baseline_mean+baseline_std],'LineStyle','--','Color',[0.7 0.1 0.1],'LineWidth',0.3); % variance lines
            line(xlim, [baseline_mean-baseline_std baseline_mean-baseline_std],'LineStyle','--','Color', [0.7 0.1 0.1],'LineWidth',0.3);
            
            disp('adding lines for lesion days');
            % lesion 1
            for i=1:length(all_days_all_analysis.summary_of_experiment.inter_lesion_days);
                
                line([all_days_all_analysis.summary_of_experiment.inter_lesion_days(i)+0.1, ...
                    all_days_all_analysis.summary_of_experiment.inter_lesion_days(i)+0.1],ylim,'Color',[0.2 0.6 0.2],'LineWidth',1.8);
            end
        end
        
        % BASELINE AND IMPORTANT DATES FOR WN EXPERIMENTS
        if isfield(all_days_all_analysis.summary_of_experiment,'WN_baseline_days')==1;
            disp('adding line for baseline value');
            baseline_values_temp=[];
            for i=1:all_days_all_analysis.summary_of_experiment.WN_baseline_days;
                baseline_values_temp=[baseline_values_temp all_days_all_analysis.data{i}.all_songs.(transitions{j}).(analysis_type)'];
            end
            baseline_mean=median(baseline_values_temp);
            baseline_std=std(baseline_values_temp);
            line(xlim, [baseline_mean baseline_mean],'Color','r','LineWidth',0.4); % mean lines
            line(xlim, [baseline_mean+baseline_std baseline_mean+baseline_std],'LineStyle','--','Color',[0.7 0.1 0.1],'LineWidth',0.3); % variance lines
            line(xlim, [baseline_mean-baseline_std baseline_mean-baseline_std],'LineStyle','--','Color', [0.7 0.1 0.1],'LineWidth',0.3);
            
            disp('adding lines for WN on, driving--> consolid, and off days');
            line([all_days_all_analysis.summary_of_experiment.WN_baseline_days-0.5, ...
                all_days_all_analysis.summary_of_experiment.WN_baseline_days-0.5],ylim,'Color',[0.2 0.6 0.2],'LineWidth',1.8);% WN start
            
            line([all_days_all_analysis.summary_of_experiment.WN_baseline_days+all_days_all_analysis.summary_of_experiment.WN_driving_days-0.5, ...
                all_days_all_analysis.summary_of_experiment.WN_baseline_days+all_days_all_analysis.summary_of_experiment.WN_driving_days-0.5],ylim,'Color',[0.2 0.6 0.2],'LineWidth',1.8); % WN driving--> consolidation
            
            line([all_days_all_analysis.summary_of_experiment.WN_baseline_days+all_days_all_analysis.summary_of_experiment.WN_driving_days+all_days_all_analysis.summary_of_experiment.WN_consolidation_days-0.5, ...
                all_days_all_analysis.summary_of_experiment.WN_baseline_days+all_days_all_analysis.summary_of_experiment.WN_driving_days+all_days_all_analysis.summary_of_experiment.WN_consolidation_days-0.5],ylim,'Color',[0.2 0.6 0.2],'LineWidth',1.8);  % WN end
        end
        
        title([analysis_type ' over days for transition: ' transitions{j} '; dots and lines are medians']); xlabel('days');
    end
    
end

%% for individual syllable analyses (plotting across days)
analysis_type='pitch';
syllables = 'fhi';
first_day_num=datenum(all_days_all_analysis.parameters.first_day);


for j=1:length(syllables);
    figure(j); hold on;
    for i=1:length(all_days_all_analysis.data); % number of days
        try
            scatter(all_days_all_analysis.data{i}.all_songs.(syllables(j)).(analysis_type)(:,1)-first_day_num,all_days_all_analysis.data{i}.all_songs.(syllables(j)).(analysis_type)(:,2),'b');
        catch err
            continue
        end
    end
    
    % Put in medians, std
    for i=1:length(all_days_all_analysis.data); % number of days
        try
            errorbar(median(all_days_all_analysis.data{i}.all_songs.(syllables(j)).(analysis_type)(:,1)-first_day_num),median(all_days_all_analysis.data{i}.all_songs.(syllables(j)).(analysis_type)(:,2)),...
                std(all_days_all_analysis.data{i}.all_songs.(syllables(j)).(analysis_type)(:,2)),'Marker','.','MarkerSize',27,'Color','k');
        catch err
            continue
        end
    end
    
    % put in baseline lines (specifically for lesion experimnets, and PUT IN VERTICAL LINES FOR important dates (e.g. lesions)
    
    if isfield(all_days_all_analysis.summary_of_experiment,'inter_lesion_days')==1;
        disp('adding line for baseline value');
        baseline_values_temp=[];
        for i=1:all_days_all_analysis.summary_of_experiment.inter_lesion_days(1);
            baseline_values_temp=[baseline_values_temp all_days_all_analysis.data{i}.all_songs.(syllables(j)).(analysis_type)(:,2)'];
        end
        baseline_mean=median(baseline_values_temp);
        baseline_std=std(baseline_values_temp);
        line(xlim, [baseline_mean baseline_mean],'Color','r','LineWidth',0.4); % mean lines
        line(xlim, [baseline_mean+baseline_std baseline_mean+baseline_std],'LineStyle','--','Color',[0.7 0.1 0.1],'LineWidth',0.3); % variance lines
        line(xlim, [baseline_mean-baseline_std baseline_mean-baseline_std],'LineStyle','--','Color', [0.7 0.1 0.1],'LineWidth',0.3);
        
        disp('adding lines for lesion days');
        % lesion 1
        for i=1:length(all_days_all_analysis.summary_of_experiment.inter_lesion_days);
            
            line([all_days_all_analysis.summary_of_experiment.inter_lesion_days(i)+0.1, ...
                all_days_all_analysis.summary_of_experiment.inter_lesion_days(i)+0.1],ylim,'Color',[0.2 0.6 0.2],'LineWidth',1.8);
        end
    end
    % MODIFY BELOW FROM TRANSITION TO SYLLABLE INPUTS
%     % BASELINE AND IMPORTANT DATES FOR WN EXPERIMENTS
%     if isfield(all_days_all_analysis.summary_of_experiment,'WN_baseline_days')==1;
%         disp('adding line for baseline value');
%         baseline_values_temp=[];
%         for i=1:all_days_all_analysis.summary_of_experiment.WN_baseline_days;
%             baseline_values_temp=[baseline_values_temp all_days_all_analysis.data{i}.all_songs.(transitions{j}).(analysis_type)'];
%         end
%         baseline_mean=median(baseline_values_temp);
%         baseline_std=std(baseline_values_temp);
%         line(xlim, [baseline_mean baseline_mean],'Color','r','LineWidth',0.4); % mean lines
%         line(xlim, [baseline_mean+baseline_std baseline_mean+baseline_std],'LineStyle','--','Color',[0.7 0.1 0.1],'LineWidth',0.3); % variance lines
%         line(xlim, [baseline_mean-baseline_std baseline_mean-baseline_std],'LineStyle','--','Color', [0.7 0.1 0.1],'LineWidth',0.3);
%         
%         disp('adding lines for WN on, driving--> consolid, and off days');
%         line([all_days_all_analysis.summary_of_experiment.WN_baseline_days-0.5, ...
%             all_days_all_analysis.summary_of_experiment.WN_baseline_days-0.5],ylim,'Color',[0.2 0.6 0.2],'LineWidth',1.8);% WN start
%         
%         line([all_days_all_analysis.summary_of_experiment.WN_baseline_days+all_days_all_analysis.summary_of_experiment.WN_driving_days-0.5, ...
%             all_days_all_analysis.summary_of_experiment.WN_baseline_days+all_days_all_analysis.summary_of_experiment.WN_driving_days-0.5],ylim,'Color',[0.2 0.6 0.2],'LineWidth',1.8); % WN driving--> consolidation
%         
%         line([all_days_all_analysis.summary_of_experiment.WN_baseline_days+all_days_all_analysis.summary_of_experiment.WN_driving_days+all_days_all_analysis.summary_of_experiment.WN_consolidation_days-0.5, ...
%             all_days_all_analysis.summary_of_experiment.WN_baseline_days+all_days_all_analysis.summary_of_experiment.WN_driving_days+all_days_all_analysis.summary_of_experiment.WN_consolidation_days-0.5],ylim,'Color',[0.2 0.6 0.2],'LineWidth',1.8);  % WN end
%     end
    
    title([analysis_type ' over days for syllable: ' syllables(j) '; dots and lines are medians']); xlabel('days');
end
