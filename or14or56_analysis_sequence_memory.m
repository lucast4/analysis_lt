% NOTES for analysis:
% On 1/2/14 - 
%     SEE abedcbb (do we see this in preWN?)
% 
% 

%% 
% to check template efficacy first label only ab, then run lt_db_check...
% DOING this will only give me percent of labeled that were hit. The
% program will grossly overestimate number of false positives, since it
% does not take into account birdtaf. 
% then label anything else you want to label.  

% After labeling ab:
lt_db_check_template_timing_and_hit_rate % I used fake params for the 2nd and 3rd columns ("a" and "b_edge"), since I am just checking "b".


% move these "ab only" .not.mat files to a new folder, then relabel
% everything
if isdir('old_notmat_labeled_ab_only')==0
    mkdir('old_notmat_labeled_ab_only');
end

!cp *.not.mat* old_notmat_labeled_ab_only

disp('done copying old notmat to subfolder!')

% label the rest now.
