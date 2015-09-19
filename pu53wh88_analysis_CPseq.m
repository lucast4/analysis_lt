%% 5/15/14 - Summary of adult WN - 17May2014_2020 (ADAA)

% HIT RATE (RENDITION also) per song and syl

clear all;
ADAAind='17May2014_2020';
all_days_all_analysis=lt_load_all_days_all_analysis(ADAAind);

for i=1:size(all_days_all_analysis.data,2);
    num_songs=size(all_days_all_analysis.data{i}.WN_hit_rate.per_song.b.hits_labels_allhits,1);
    if num_songs>0;
        hit_rate_Mean_PerSong(i)=all_days_all_analysis.data{i}.WN_hit_rate.all_songs.b.hits_labels_allhits(1)/num_songs;
        rend_rate_Mean_PerSong(i)=all_days_all_analysis.data{i}.WN_hit_rate.all_songs.b.hits_labels_allhits(2)/num_songs;
        song_length_Mean(i)=length(all_days_all_analysis.data{i}.all_songs.all_trans.syl_order_compiled_across_songs)/num_songs;
        
        hit_rate_Mean_PerSyl(i)=hit_rate_Mean_PerSong(i)/song_length_Mean(i);
        rend_rate_Mean_PerSyl(i)=rend_rate_Mean_PerSong(i)/song_length_Mean(i);
        
    elseif num_songs==0;
        hit_rate_Mean_PerSong(i)=nan;
        rend_rate_Mean_PerSong(i)=nan;
        song_length_Mean(i)=nan;
        
        hit_rate_Mean_PerSyl(i)=nan;
        rend_rate_Mean_PerSyl(i)=nan;
    end
end

figure; hold on;
plot(hit_rate_Mean_PerSong,'sr'); 
plot(rend_rate_Mean_PerSong,'ob');
title('Mean per song: RED: hits/song; BLUE: renditions of target/song; (all catch)');

figure; hold on;
plot(hit_rate_Mean_PerSyl,'sr'); 
plot(rend_rate_Mean_PerSyl,'ob');
title('Mean per all syllables sang: RED: hits/syl; BLUE: renditions of target/syl; (all catch)');

figure; hold on;
plot(song_length_Mean,'or');
title('mean song length across days'); 
ylim([0 max(song_length_Mean)+5])


% HIT RATE (per rendition of that syllable, how good template)
ADAAind='17May2014_2020';
lt_load_all_days_all_analysis(ADAAind);

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



% TRANSITIONS
ADAAind='17May2014_2020';

con_div = 'divergence';
all_days_all_analysis=lt_all_days_PLOT_AllTrans([1 2 3 4], ADAAind, con_div);
lt_all_days_PLOT_AllTrans_specific_trans(con_div,1,'',ADAAind) % run this in bird folder.  

con_div = 'convergence';
all_days_all_analysis=lt_all_days_PLOT_AllTrans([1 2 3 4], ADAAind, con_div);
lt_all_days_PLOT_AllTrans_specific_trans(con_div,1,'',ADAAind) % run this in bird folder.  





%% 4/28/14 - ADULT (pre days)
clear all; close all;

lt_all_days_various_calculations
lt_all_days_all_analysis

% ___________________________________________
% PLOT transition matrices

load /bluejay3/lucas/birds/pu53wh88/all_days_all_analysis/all_days_all_analysis_28Apr2014_1650_adult_AllTrans.mat

con_div='divergence';
lt_all_days_PLOT_AllTrans([1],'28Apr2014_1650',con_div)

con_div='convergence';
lt_all_days_PLOT_AllTrans([1],'28Apr2014_1650',con_div)

% _____________________________________________________
%PLOT single divergent or convergent transition over days (load all_days... first)
clear all; close all;
load /bluejay3/lucas/birds/pu53wh88/all_days_all_analysis/all_days_all_analysis_28Apr2014_1650_adult_AllTrans.mat

% DIVERGENCE
con_div = 'divergence';
syl1_list={'a','b','c','d','g','j'};
for kk=1:length(syl1_list);
    syl1=syl1_list{kk};
    % syl2='b';
    syl2_list=all_days_all_analysis.data{2}.all_songs.all_trans.syllable_list;
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
syl2_list={'a','b','c','d','g','j'}; % all the 2nd-syls that you are interested in (one plot each)
for kk=1:length(syl2_list)
    syl2=syl2_list{kk};
    syl1_list=all_days_all_analysis.data{2}.all_songs.all_trans.syllable_list;
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
%% 2/28/14 - looking at all of young data - making summary figure of transitions

clear all; close all;
load /bluejay3/lucas/birds/pu53wh88/all_days_all_analysis/all_days_all_analysis_28Mar2014_1925_CPseq_AllTrans

% ____________________________________________________________________
% for a[] divergence

%PLOT single divergent or convergent transition over days (load all_days... first)
con_div = 'divergence';
syl1_list={'a','b','c','d','g','j'};
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
syl2_list={'a','b','c','d','g','j'}; % all the 2nd-syls that you are interested in (one plot each)
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

