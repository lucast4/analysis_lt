% 11/1/13 - HVC microlesions

%% to make batch file and subsample randomly to then analyze with evsonganaly

batchname = 'batch';
% batchname = input('What is the name of the batch file?  ', 's');

%makes a batch file
db_write_batch(batchname)
edit batch

cleandirAuto('batch',1000,4,4)
lt_batch_all_clean(1000,4,2)

cleandirAuto('batch.rec_noFB',1000,4,4)

%% looking automatically at syllable morphology for each day

lt_db_contour_and_FF_analysis_over_time_v4 %analyzes pitch and other spectral features each day. also tries to add parameters
% for lesions, but it became a slight mess.
lt_db_contour_and_FF_analysis_over_time_v3_2 % slightly modified from v3 - trivial differences
db_contour_and_FF_analysis_over_time_v3  % use this one. 


%% looking at syllable morphology

% important: syntax related: durations, intersyllable durations, # of notes
% structure only: freq, entropy, FM, goodness of pitch, and variance of all
% those.

% NOTE: go to day song folder

%  manually input the day argument, motif, 
lt_db_seq_func_day_save_rd3gr35('batch.catch.keep','', 'rd3gr35', '18Sep2013', 1, 'd', 'HVCml') 
% the v2 version only difference is looking at gap duration instead of syl duration.  
lt_db_seq_func_day_save_v2_rd3gr35('batch.catch.keep','', 'rd3gr35', '20Sep2013', 1, 'ft', 'HVCml') %STILL need to work on this.

%% comparing dir to undir song

% use this to get pitch contour and FF for individual days:
lt_calc_day_pitch

% comparing the three DIR days to UNDIR:
% 10/10 - 3468 for dir, 3415 for undir, 
% 10/17 - 3450 for dir, 3350 for undir
% 11/04 - 3480 for dir, 3375 for undir
% They are all higher for dir. Baseline is 3375. don't have baseline DIR data.

%% Lesion lead to immediate increase in variability?

% Looking at pitch, lesion 1 and 3 yes, 2 showed decrease.  (see all_days
% and individual_days).  Seems to still be the case even when looking at
% immediate song after lesion.

%% looking at amounts of each rendition class for abc...

% perform lt_all_days_various_calculations... (to get syl amounts), and then load the all_days_various..
% structure and perform the following.

% FIRST, convert syl amounts into amounts for each repeat class.
rendition_classes_amounts=nan(size(all_days_various.syl_rendition_amount.syl_renditions));
for i=1:size(all_days_various.syl_rendition_amount.syl_renditions,1);
    if i~=size(all_days_various.syl_rendition_amount.syl_renditions,1);
        rendition_classes_amounts(i,:)=all_days_various.syl_rendition_amount.syl_renditions(i,:)-...
            all_days_various.syl_rendition_amount.syl_renditions(i+1,:);
    elseif i==size(all_days_various.syl_rendition_amount.syl_renditions,1);
        rendition_classes_amounts(i,:)=all_days_various.syl_rendition_amount.syl_renditions(i,:);
    end
end

% convert to fractions
for j=1:size(rendition_classes_amounts,2);
    rendition_classes_fraction(:,j)=rendition_classes_amounts(:,j)/sum(rendition_classes_amounts(:,j));
end

% SECOND, calculate entropy (sigma(-plogp), for p = probabilty for each
% repeat class
temp=rendition_classes_fraction; 
temp(temp<=0)=0; % removes any negatives first
temp(temp>1)=1; % removes prob >1

repeat_entropy_temp=-1*temp.*log2(temp); %-plogp
repeat_entropy_temp(isnan(repeat_entropy_temp))=0; % removes any nan (i.e. % was 0)
repeat_entropy=sum(repeat_entropy_temp,1); % performs "sigma"

repeat_entropy(all_days_various.syl_rendition_amount.song_amount==0)=nan; % puts a nan in place of data for any day that did not have analysis.

% THIRD, plot
% getting baseline average of entropy
baseline_days=4;
baseline_mean_entropy=mean(repeat_entropy(1:baseline_days));

% plots entropy
figure; plot(repeat_entropy,'.','MarkerSize',30,'LineStyle','-');
title('repeat entropy for each day. vertical lines represent lesions'); ylabel('entropy'), xlabel('days')

% adding lines for baseline and manipulation dates
line(get(gca,'Xlim'), [baseline_mean_entropy baseline_mean_entropy],'Color',[0.5 0.5 0.5], 'LineStyle','--') %baseline

lesion_dates=[4 19 27]+0.5;
for i=1:length(lesion_dates);
    line([lesion_dates(i) lesion_dates(i)],get(gca,'Ylim'),'Color',[0.7 0.2 0.2], 'LineStyle','--')
end

% PLOT all rendition classes
figure; plot(rendition_classes_fraction','.','MarkerSize',30,'LineStyle','-')
title('probably of occurrence of motif classes vs. day')
legend('1 repeat','2 repeats','3 repeats','4 repeats','5 repeats');
ylim([0 1.1])
% adding lines for lesion dates
for i=1:length(lesion_dates);
    line([lesion_dates(i) lesion_dates(i)],get(gca,'Ylim'),'Color',[0.7 0.2 0.2], 'LineStyle','--')
end

% plot as bar graph, binning over days
% for each lesion, bin the 4 days before and after (i.e. 2 columns)

bin_size=4;
for i=1:length(lesion_dates);
    rendition_classes_fraction_binned{i}(:,1)=nanmean(rendition_classes_fraction(:,lesion_dates(i)-(bin_size-0.5):lesion_dates(i)-0.5),2); % 1st column is pre-lesion
    rendition_classes_fraction_binned{i}(:,2)=nanmean(rendition_classes_fraction(:,lesion_dates(i)+0.5:lesion_dates(i)+(bin_size-0.5)),2); %2nd column is post lesion
%     rendition_classes_fraction_binned{i}(:,3)=nanmean(rendition_classes_fraction(:,lesion_dates(i)+(bin_size+0.5):lesion_dates(i)+(bin_size+3.5)),2); %2nd column is post lesion

    % plot for each lesion
    figure; bar(rendition_classes_fraction_binned{i}'); title(['4 days averaged pre and post lesion # ' num2str(i) ' or rendition class probabilities. bin size: ' ...
        num2str(bin_size)]);
    legend('1 repeat','2 repeats','3 repeats','4 repeats','5 repeats')
end


%% for every rendition, plotting entropy vs. amplitude
% are entropy changes entirely explained by changes in amplitude?

lt_all_days_all_analysis_PLOT



% CONCLUSION: lesion 1 and 3 with entropy increase (even taking into
% account amplitude increase.  lesion 2 without entropy increase.

% Also, timing increased for all surgeries, then decreasd over time (even
% accounting for amplitude). 

% LOOKING at histogram of durations pf all vocalziations: lesion 1 made it
% seem gausian, lesion 2 and 3 less effect. did not look closely at
% distributions. 


%% looking at duration distributions
figure; hold on
for i=1:all_days_all_analysis.summary_of_experiment.inter_lesion_days(1);
    figure; hold on
    hist(all_days_all_analysis.data{i}.all_songs.a.timing(:,2)');
end


figure; hold on
for i=all_days_all_analysis.summary_of_experiment.inter_lesion_days(1)+1:all_days_all_analysis.summary_of_experiment.inter_lesion_days(1)+1;
    figure; hold on
    hist(all_days_all_analysis.data{i}.all_songs.a.timing(:,2)');
end


