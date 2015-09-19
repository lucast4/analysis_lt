%% 09/19/13
% for pu13bk43, did 7/16, 7/17, label all songs, very conservatively
% and look at labels.  do below, open labels... file, and see that much more
% of the canonical motif is in the WN days, (i.e. replace motif with a single LETTER).


% SAME AS lt_sequence_analysis


%% days done:

% 7/15
% 7/16
% 7/17
% 7/19
% 7/28



%%

clear all; close all
% batch=input('batch name? ','s');
batch='batch.catch.keep_AllSylLabeled_091913';
fid=fopen(batch);

clock=1;
fid_labels=fopen('labels_compiled','w');
while 1
    fn=fgetl(fid);
    if ~ischar(fn),
    break; 
    end
    temp=open([fn '.not.mat']);
    labels{clock}=temp.labels;
    fprintf(fid_labels,'%s\n',temp.labels);
    clock=clock+1;
%     suffix_start_index=findstr(fn,'.cbin');
%     rec_name_from_cbin=[fn(1:suffix_start_index-1) '.rec'];
%     rec_files_list(clock)=dir(rec_name_from_cbin);
%     clock=clock+1;
end
fclose(fid_labels);




%% try using db_mult_seq to analyze sequence

% go to each day and do lt_db_mult_seq
% do "dp" and "da" as they are variable.

lt_db_mult_seq_analy

lt_db_seq_over_days

% NO changes in anything for those two transitions.


%% 10/6/13 
% used lt_get_all_transitions... to get transition matrix.  no obvious
% change with the five days: 
% 7/15
% 7/16
% 7/17
% 7/19
% 7/28
% other than 2-3 extra syllables on 7/28.  maybe decreased entropy on 7/28?
