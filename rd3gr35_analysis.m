%% to make batch file and subsample randomly to then analyze with evsonganaly

batchname = 'batch';
% batchname = input('What is the name of the batch file?  ', 's');

%makes a batch file
db_write_batch(batchname)
edit batch


lt_batch_all_clean

randsamp('batch.catch.keep',0.3)


%% visually inspecting all labels to find the transitions that are most variable.

label_array=getlabels('batch.catch.keep')

for i=1:size(label_array,2);
    label_array{i}
end


%% 9/27/13
% SECTION changed all labels (saved old notmat) so that k and u become f and r respectively.  they are similar.  

% to save old .not.mat:
mkdir('saved_notmat_alllabeled_includes_ku')
!cp *.not.mat* saved_notmat_alllabeled_includes_ku

db_change_syllable_in_batchfile('batch.catch.keep','k','f')
db_change_syllable_in_batchfile('batch.catch.keep','u','r')

% label more songs
randsamp('batch.keep',0.1)


evsonganaly

%NOTE: did more labeling for 18, 19th, and 20th. should try analysis now.  
% should analyze intervals as well.  

%% SEQUENCE ANALYSIS

% do this for each day first
lt_db_mult_seq_analy % analyzes transisions with more than one transition

% then do this to summmarize over all days.
lt_db_seq_over_days

%% 

%% SECTION: modifying db_transition_probability_for_sequence



%% counting the number of transition points in total, for all possible transitions (i.e. make a matrix)
%10/6/13  Using lt_get_all_trans... I looked at transition matrix off all
%syl for 9/18 , 19, and 20, and found no gross difference (looking at heat
%map).  

lt_get_all_transition_probabilities % use to get all letters used as labels, for a day, and transition matrix.  


%% want to include metric of distance between each susequent transition, to ask how history dependence depends on time interval.

should go into the "Gets all syllables per song" section

%% 9/30/13 - looking at syllable morphology

% important: syntax related: durations, intersyllable durations, # of notes
% structure only: freq, entropy, FM, goodness of pitch, and variance of all
% those.

% NOTE: go to day song folder

%  manually input the day argument, motif, 
lt_db_seq_func_day_save_rd3gr35('batch.catch.keep','', 'rd3gr35', '18Sep2013', 1, 'd', 'HVCml') 
% the v2 version only difference is looking at gap duration instead of syl duration.  
lt_db_seq_func_day_save_v2_rd3gr35('batch.catch.keep','', 'rd3gr35', '20Sep2013', 1, 'ft', 'HVCml') %STILL need to work on this.


%% PLOT OVER DAYS
% compile all data .mat files into a new batch file
lt_write_all_folder_contents_to_batch;

% to plot above data
batch=input('what is name of batch? ','s');
syllable=input('what is the name of the syllable? ','s');
metric=input('what metric is this? (e.g. entropy, pitch, amplitude; all lower case)', 's');



lt_db_plot_over_experiment(batch,'r', 1, 1,1,0) % with removal of tukey outliers

title([metric ' vs. day; tukey outliers removed. Syllable: ' num2str(syllable)])
% figure; lt_db_plot_over_experiment(batch,'g', 1, 0,1,0) % without removal of tukey outliers
% title('entropy vs. day; tukey outliers not removed')


saveas(figure(gcf),[metric '_vs_day_all_points_of_' num2str(syllable),'fig'])


%% SPECIAL CASE for syllable percentages
% for the case of percentages, "data" is replaced by "bootstrap" (variable), 
% and we won't use time data, since datapoints are entire songs, not syllables
clear all
lt_write_all_folder_contents_to_batch;

% to plot above data
batch=input('what is name of batch? ','s');


lt_db_plot_over_experiment(batch,'d', 1, 0,0,1)

%% getting FF information


% do this starting from bird folder
db_contour_and_FF_analysis_over_time_v3
% lt_db_FF_mult_bootstrap_v2
db_FF_mult_bootstrap_v2

% To check for multimodal FF distribution for one syllable:


%% looking at variability of pitch contours

% go to all_days... folder and load [birdname].mat.

% looking at day 3, which is postlesion 2

figure; plot(multiple_pitch.pc_all.t{3});

figure; plot(multiple_pitch.pc_all.t{2});

% do the same, but for each contour subtract the mean (of that single
% contour)
clear all; close all; load rd3gr35.mat

contour_start=220;
contour_end=650;

for day=1:10;
    for i=1:size(multiple_pitch.pc_all.t{day},2);
        mean_pitch_of_contour{day}(i)=mean(multiple_pitch.pc_all.t{day}(contour_start:contour_end,i),1);
        multiple_pitch.pc_all_TrialMeanSubtracted.t{day}(:,i)=multiple_pitch.pc_all.t{day}(:,i)-mean_pitch_of_contour{day}(i);
    end
    figure(day); plot(multiple_pitch.pc_all_TrialMeanSubtracted.t{day}(:,1:50)); title(['P.C. for day' num2str(day)]);
end

% finding STD of deviation from mean (of PC) at each timepoint (across
% renditions)

for day=1:10;
    for ii=1:size(multiple_pitch.pc_all.t{day},1);
        STDAcrossRenditions_OfDeviationFromMean_ofPC{day}(ii)=std(multiple_pitch.pc_all_TrialMeanSubtracted.t{day}(ii,:));
    end
     figure(day+3); plot(STDAcrossRenditions_OfDeviationFromMean_ofPC{day}(180:600)); title(['STD of P.C. across renditions for day' num2str(day)]);   
end

% CONLCUSION: MORE FINE STRUCTURE IN PC STD FOR DAY 3?  NEED TO REMOVE
% AVERAGE POINT FOR EACH TIMEPOINT, NOT JUST AVERAGE OVER TIMEPOINTS, IN
% ORDER TO LOOK AT DEVIATION.  ABOVE i AM ACTUALLY ASKING MORE ABOUT fm.
% QUANTIFY THE INTEGRAL UNDER THE DEVIATION CURVE, ETC.  



%% OTHER THINGS


db_plot_bootstrap_over_days ... - to plot bootstrap results. 

db_gap timing

% ways to get FF info
findnotetw
dbcontour
db_check... see what he uses.
db_repeat_syllable_count

% run db_contour, then on those results run db_FF_mult_bootstrap_v2

db_day_order
db_pool_data_across_days
% those two above related.


%% getting transition entropies

% load all_trans... structure with data.

temp=-1*all_trans.summary.transition_matrix.matrix_of_relative_fractions.*log2(all_trans.summary.transition_matrix.matrix_of_relative_fractions); % has all fractions (i.e. sums all to 1)
nansum(nansum(temp))

% 18: 8.75
% 19: 7.71
% 20: 9.9
% on 12/4 - above are entropy values I calculated for days sep 18-20

