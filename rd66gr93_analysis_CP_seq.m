1/28
        'a'       'b'       'c'       'j'       'm'       'n'       'p'      'x'
         0    0.8904         0         0    0.0205    0.0890         0         0
    0.0032    0.2627    0.6108    0.0032    0.0127    0.1013    0.0032    0.0032
    0.4392         0         0    0.5556    0.0053         0         0         0
         0    1.0000         0         0         0         0         0         0
    1.0000         0         0         0         0         0         0         0
    1.0000         0         0         0         0         0         0         0
    1.0000         0         0         0         0         0         0         0
    1.0000         0         0         0         0         0         0         0

1/29


    'a'    'b'    'c'    'j'    'm'    'n'    'p'

         0    0.9850         0         0    0.0150         0         0
    0.0066    0.2881    0.6623         0    0.0132    0.0265    0.0033
    0.5670         0         0    0.4330         0         0         0
         0    1.0000         0         0         0         0         0
    1.0000         0         0         0         0         0         0
    1.0000         0         0         0         0         0         0
    1.0000         0         0         0         0         0         0

%% looking at specific transitions per day

% 1) ab, an, am, ----------------------
% 2) ab, jb, -----------------------------
% 3) b-->[]
% 4) n-->[]

% NOTES: 2/2 div from n seems to have many more options.
%  repeats of b increased so that b-b dominates divergence from b.
% targeted divergence not decreased substantially (ab). (LOW WN HIT RATE).
% No new conv or divergent.


% DIVERGENT -----------------------
first_syl='a';
transition_struct=struct2cell(all_trans.(first_syl).transition_to_);
% transition_array=cell2mat(transition_struct)

xlabels=[];
second_syl_names=fieldnames(all_trans.(first_syl).transition_to_);

figure; hold on
for i=1:size(transition_struct,1);
    scatter(i,transition_struct{i}.relative_fraction_of_trans,'k');
    xlabels{i}=[first_syl second_syl_names{i}];
end

set(gca,'XTickLabel',xlabels)
title(['fraction of divergent transitions from ' first_syl ' on ' all_trans.parameters.date_of_exp 'for bird ' all_trans.parameters.bird_name]);
ylabel('fraction')

% CONVERGENT ------------------------
second_syl='b';
transition_struct=struct2cell(all_trans.convergent_to.(second_syl).from);
% transition_array=cell2mat(transition_struct)

xlabels=[];
first_syl_names=fieldnames(all_trans.convergent_to.(second_syl).from);

figure; hold on
for i=1:size(transition_struct,1);
    scatter(i,transition_struct{i}.fraction_of_trans,'k');
    xlabels{i}=[first_syl_names{i} second_syl];
end

set(gca,'XTickLabel',xlabels)
title(['fraction of convergent transitions to ' second_syl ' on ' all_trans.parameters.date_of_exp 'for bird ' all_trans.parameters.bird_name]);
ylabel('fraction')

%%        in order  to check hit rate with birdtaf, first change motif labels to something not used, then do triglabel./

db_change_syllable_in_batchfile('batch.catch.keep','ab','AB')

[trigs]=triglabel('batch.catch.keep','B',1,0,0,0);

sum(trigs)

db_change_syllable_in_batchfile('batch.catch.keep','AB','ab')