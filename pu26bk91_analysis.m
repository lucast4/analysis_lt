%% Pull out all the songs into a single batch

% first pull out all songs with FB.
% second, out of left over songs, some had trigger, but "catch", so no FB.
% Pull those out by using cleandirAuto on the non-WN songs.
% third, combine those two to get all songs.

% MAKE a batch file with all songs
batchname = 'batch';
db_write_batch(batchname)

% PULL out all songs with WN FB given.
lt_rec_files_find_FB 

% CLEAN the leftovers to find remaining non-WN songs.
% batch='batch.rec_noFB'; % name of batch without WN FB.
% cleandirAuto('batch.rec_noFB',1000,4,4) % these parameters tailored for bk51bk59.

% cleandir5('batch',12000,1000,6,6)

%% MAKE a new total batch file by combining the two above.
% this shoudl contain all songs.
% 
% batch.rec_FB
% batch.rec_noFB.keep
% 
% batch_one=textread(batch.rec_FB
% batch_two=
% 
% %sort:
% 




%% ALTERNATIVE METHODS TO PULL SONGS

batchname = 'batch';% make batch
db_write_batch(batchname)

cleandirAuto('batch',1000,5,5); % clean

cleandirAuto('batch.dcrd',1000,4,4); % clean the dscrd pile with more lenient params to make sure got all songs.

cleandir5('batch',1000,1000,1,3)

%% analyze pitch

db_contour_and_FF_analysis_over_time_v3_pu26bk91 % modified sigma from 1 to 1.2


%% Analysis of sequence:

% trajectory of recovery of singing complete motif. 


%% make new template from missed syl

mkdir('temp_folder') 
!cp *.not.mat* temp_folder
db_change_miss_label('batch.catch.keep','f','x')

db_make_template

!cp temp_folder/*.not.mat* . 
!rm -r temp_folder


%% looking at amounts of each rendition class for abc...

% perform lt_all_days... (to get syl amounts), and then load the all_days..
% structure and perform the following.
lesion_dates=[3 18 40]+0.5; % numbers correspond to days before lsion
baseline_days=4;
bin_size=3;

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
baseline_mean_entropy=mean(repeat_entropy(1:baseline_days));

% plots entropy
figure; plot(repeat_entropy,'.','MarkerSize',30,'LineStyle','-');
title('motif length entropy for each day. vertical lines represent lesions'); ylabel('entropy'), xlabel('days')

% adding lines for baseline and manipulation dates
line(get(gca,'Xlim'), [baseline_mean_entropy baseline_mean_entropy],'Color',[0.5 0.5 0.5], 'LineStyle','--') %baseline


for i=1:length(lesion_dates);
    line([lesion_dates(i) lesion_dates(i)],get(gca,'Ylim'),'Color',[0.7 0.2 0.2], 'LineStyle','--')
end

% PLOT all rendition classes
figure; plot(rendition_classes_fraction','.','MarkerSize',30,'LineStyle','-')
title('probably of occurrence of motif length class vs. day')
legend('1 syllable','2 syllables','3 syllables','4 syllables','5 syllables','6 syllables');
ylim([0 1.1])
% adding lines for lesion dates
for i=1:length(lesion_dates);
    line([lesion_dates(i) lesion_dates(i)],get(gca,'Ylim'),'Color',[0.7 0.2 0.2], 'LineStyle','--')
end

% plot as bar graph, binning over days
% for each lesion, bin the 4 days before and after (i.e. 2 columns)

for i=1:length(lesion_dates);
    rendition_classes_fraction_binned{i}(:,1)=nanmean(rendition_classes_fraction(:,lesion_dates(i)-(bin_size-0.5):lesion_dates(i)-0.5),2); % 1st column is pre-lesion
    rendition_classes_fraction_binned{i}(:,2)=nanmean(rendition_classes_fraction(:,lesion_dates(i)+0.5:lesion_dates(i)+(bin_size-0.5)),2); %2nd column is post lesion
%     rendition_classes_fraction_binned{i}(:,3)=nanmean(rendition_classes_fraction(:,lesion_dates(i)+(bin_size+0.5):lesion_dates(i)+(bin_size+3.5)),2); %2nd column is post lesion

    % plot for each lesion
    figure; bar(rendition_classes_fraction_binned{i}'); title(['4 days averaged pre and post lesion # ' num2str(i) ' or rendition class probabilities. bin size: ' ...
        num2str(bin_size)]);
%     legend('1 repeat','2 repeats','3 repeats','4 repeats','5 repeats')
end

