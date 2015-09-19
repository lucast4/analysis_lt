%% 2/17 comparing motif duration post vs. pre vs. post dir

% TO DO (4/2/14):
% 1) label post days
% 2) label one more pre day
% 3) fix up plot functions (i.e. make variable filled with values (either data pts or day means) and then can plot any variable same way.
% 4) history dependence
% 5) change all_days to put day number at end.

%% PART 1

clear all
[labels.labels, labels.times, labels.filenames, labels.onsets, labels.offsets] = lt_db_get_labels('batch.catch.keep','n');

motif_durations_mat=[];
for i=1:size(labels.labels,2);
    string=labels.labels{i};
%     [startInd{i}, endInd{i}]=regexp(string,'ab(\w?)g','start','end');
%       [startInd{i}, endInd{i}]=regexp(string,'abcddeefg','start','end');
      [startInd{i}, endInd{i}]=regexp(string,'mbcddeefg','start','end');
  
    motif_durations{i}=labels.offsets{i}(endInd{i})-labels.onsets{i}(startInd{i});
    motif_durations_mat=[motif_durations_mat; motif_durations{i}]
end

motif_duration.sample_size=size(motif_durations_mat,1)
motif_duration.mean=mean(motif_durations_mat)
motif_duration.STD=std(motif_durations_mat)
motif_duration.COV=motif_duration.STD/motif_duration.mean
motif_duration.SE=motif_duration.STD/sqrt(motif_duration.sample_size)

figure; plot(sort(motif_durations_mat),'o')


% 2/5 - 
%     sample_size: 29
%            mean: 1.0889e+03
%             STD: 60.9025
%             COV: 0.0559
%              SE: 11.3093

% 2/8 -
%     sample_size: 36
%            mean: 1.0532e+03
%             STD: 38.2287
%             COV: 0.0363
%              SE: 6.3715
% 2/9 (pre) - 
%     sample_size: 39
%            mean: 1.0948e+03
%             STD: 53.2124
%             COV: 0.0486
%              SE: 8.5208

% 2/16 
%     sample_size: 34
%            mean: 1.1714e+03
%             STD: 37.6061
%             COV: 0.0321
%              SE: 6.4494

% 2/17 (DIR)
%     sample_size: 12
%            mean: 1.0680e+03
%             STD: 19.8433
%             COV: 0.0186
%              SE: 5.7283


%% PART 2. ANALYSIS using all_days_various_18Feb2014_2114.mat

%FIRST - GREATER duration for all motifs below, and decreased COV for the
%ends of the motifs (i.e. ddeefg and ckeefg)

% COMPARING motif durations and variability of that.
%input variables
clear all; close all;
load all_days_various_18Feb2014_2114
% motif={'abcddeefg','abckeefg','mbcddeefg','mbckeefg','jabcddeefg','bcddeefg'};
motif={'abcddeefg','abckeefg','mbcddeefg','keefg','ddeefg','abc','mbc'};

onsets_or_offsets={'onsets','onsets'}; % arguments say how to threshold the motif (e.g. onset to onset). 

for kk=1:size(motif,2);
    figure(kk);
    subplot(2,1,1); hold on; title(['Durations (individual points) of ' motif{kk} ' with mean and STD, each day']); ylabel('seconds'); xlabel('day')
    
    for jj=1:size(all_days_various.lt_db_get_labels.labels,2); % no of days
        motif_durations_mat=[];
        for i=1:size(all_days_various.lt_db_get_labels.labels{jj},2); % no of songs in day jj
            %     [startInd{i}, endInd{i}]=regexp(string,'ab(\w?)g','start','end');
            %       [startInd{i}, endInd{i}]=regexp(string,'abcddeefg','start','end');
            [startInd{kk,jj,i}, endInd{kk,jj,i}]=regexp(all_days_various.lt_db_get_labels.labels{jj}{i},motif{kk},'start','end');
            dummy=all_days_various.lt_db_get_labels.(onsets_or_offsets{2}){jj}{i}(endInd{kk,jj,i})-all_days_various.lt_db_get_labels.(onsets_or_offsets{1}){jj}{i}(startInd{kk,jj,i});
            motif_durations_mat=[motif_durations_mat; dummy];
            clear dummy
        end
        motif_duration.data.(motif{kk}){jj}=motif_durations_mat/1000;
        motif_duration.mean.(motif{kk}){jj}=mean(motif_duration.data.(motif{kk}){jj});
        motif_duration.STD.(motif{kk}){jj}=std(motif_duration.data.(motif{kk}){jj});
        motif_duration.COV.(motif{kk}){jj}=motif_duration.STD.(motif{kk}){jj}/motif_duration.mean.(motif{kk}){jj};
        scatter(jj+[-0.35:(0.7/(size(motif_duration.data.(motif{kk}){jj},1)-1)):0.35], motif_duration.data.(motif{kk}){jj},'r');
        %     figure(jj); plot(sort(motif_duration.data{jj}),'o'); title(['day: ' datestr(all_days_various.parameters.days{3}+jj-1, 'ddmmmyyyy')])
        %
    end
    
    errorbar(cell2mat(motif_duration.mean.(motif{kk})),cell2mat(motif_duration.STD.(motif{kk})),'o')
    
    % ax1=gca;
    %
    % ax2=axes('Position',get(ax1,'Position'),'YAxisLocation','right','Color','none','XColor','r','YColor','r');
    subplot(2,1,2); title('COV of motif duration');
    bar(cell2mat(motif_duration.COV.(motif{kk})))
    % set(gca,'YAxisLocation','right')
        %OUTPUT; 1) motif duration structure with data over entire day.
end

%% PART 3. REDO ABOVE BUT WITH all_days_various_19Feb2014_0007.mat

%FIRST - GREATER duration for all motifs below, and decreased COV for the
%ends of the motifs (i.e. ddeefg and ckeefg)

% COMPARING motif durations and variability of that.
%input variables
clear all; close all;
load all_days_various_19Feb2014_0007.mat
% motif={'abcddeefg','abckeefg','mbcddeefg','mbckeefg','jabcddeefg','bcddeefg'};
motif={'abcddeefg','abckeefg','mbcddeefg','keefg','ddeefg','abc','mbc'};

onsets_or_offsets={'onsets','offsets'}; % arguments say how to threshold the motif (e.g. onset to onset). 

for kk=1:size(motif,2);
    figure(kk);
    subplot(2,1,1); hold on; title(['Durations (individual points) of ' motif{kk} ' with mean and STD, each day']); ylabel('seconds'); xlabel('day')
    
    for jj=1:size(all_days_various.lt_db_get_labels.labels,2); % no of days
        motif_durations_mat=[];
        for i=1:size(all_days_various.lt_db_get_labels.labels{jj},2); % no of songs in day jj
            %     [startInd{i}, endInd{i}]=regexp(string,'ab(\w?)g','start','end');
            %       [startInd{i}, endInd{i}]=regexp(string,'abcddeefg','start','end');
            [startInd{kk,jj,i}, endInd{kk,jj,i}]=regexp(all_days_various.lt_db_get_labels.labels{jj}{i},motif{kk},'start','end');
            dummy=all_days_various.lt_db_get_labels.(onsets_or_offsets{2}){jj}{i}(endInd{kk,jj,i})-all_days_various.lt_db_get_labels.(onsets_or_offsets{1}){jj}{i}(startInd{kk,jj,i});
            motif_durations_mat=[motif_durations_mat; dummy];
            clear dummy
        end
        motif_duration.data.(motif{kk}){jj}=motif_durations_mat/1000;
        motif_duration.mean.(motif{kk}){jj}=mean(motif_duration.data.(motif{kk}){jj});
        motif_duration.STD.(motif{kk}){jj}=std(motif_duration.data.(motif{kk}){jj});
        motif_duration.COV.(motif{kk}){jj}=motif_duration.STD.(motif{kk}){jj}/motif_duration.mean.(motif{kk}){jj};
        scatter(jj+[-0.35:(0.7/(size(motif_duration.data.(motif{kk}){jj},1)-1)):0.35], motif_duration.data.(motif{kk}){jj},'r');
        %     figure(jj); plot(sort(motif_duration.data{jj}),'o'); title(['day: ' datestr(all_days_various.parameters.days{3}+jj-1, 'ddmmmyyyy')])
        %
    end
    
    errorbar(cell2mat(motif_duration.mean.(motif{kk})),cell2mat(motif_duration.STD.(motif{kk})),'o')
    
    % ax1=gca;
    %
    % ax2=axes('Position',get(ax1,'Position'),'YAxisLocation','right','Color','none','XColor','r','YColor','r');
    subplot(2,1,2); title('COV of motif duration');
    bar(cell2mat(motif_duration.COV.(motif{kk})))
    % set(gca,'YAxisLocation','right')
        %OUTPUT; 1) motif duration structure with data over entire day.
end
close all
%SECOND, checking whether post songs have drift
for kk=1:size(motif,2);
    figure(kk); hold on
    for jj=1:size(all_days_various.lt_db_get_labels.labels,2); % no of days
        try
            motif_duration.running_avg.(motif{kk}){jj}=runningaverage(motif_duration.data.(motif{kk}){jj},8);
        catch err
            continue
        end
        plot(jj+[-0.35:(0.7/(size(motif_duration.running_avg.(motif{kk}){jj},2)-1)):0.35], motif_duration.running_avg.(motif{kk}){jj},'.r')
    end
end

 %% 4. REDO ABOVE BUT looking at single (syl + gaps)

% CONCLUSION - all the gaps seem to be longer, and some have greater, some
% less variability.
 
% COMPARING motif durations and variability of that.
%input variables
clear all; close all;
load all_days_various_19Feb2014_0007.mat
% motif={'abcddeefg','abckeefg','mbcddeefg','mbckeefg','jabcddeefg','bcddeefg'};
motif={'ab','bcd','dde','eef','fg','mb'};
onsets_or_offsets={'onsets','onsets'}; % arguments say how to threshold the motif (e.g. onset to onset). 

for kk=1:size(motif,2);
    figure(kk);
    subplot(2,1,1); hold on; title(['Durations (individual points) of ' motif{kk} ' with mean and STD, each day']); ylabel('seconds'); xlabel('day')
    
    for jj=1:size(all_days_various.lt_db_get_labels.labels,2); % no of days
        motif_durations_mat=[];
        for i=1:size(all_days_various.lt_db_get_labels.labels{jj},2); % no of songs in day jj
            %     [startInd{i}, endInd{i}]=regexp(string,'ab(\w?)g','start','end');
            %       [startInd{i}, endInd{i}]=regexp(string,'abcddeefg','start','end');
            [startInd{kk,jj,i}, endInd{kk,jj,i}]=regexp(all_days_various.lt_db_get_labels.labels{jj}{i},motif{kk},'start','end');
            dummy=all_days_various.lt_db_get_labels.(onsets_or_offsets{2}){jj}{i}(endInd{kk,jj,i})-all_days_various.lt_db_get_labels.(onsets_or_offsets{1}){jj}{i}(startInd{kk,jj,i});
            motif_durations_mat=[motif_durations_mat; dummy];
            clear dummy
        end
        motif_duration.data.(motif{kk}){jj}=motif_durations_mat/1000;
        motif_duration.mean.(motif{kk}){jj}=mean(motif_duration.data.(motif{kk}){jj});
        motif_duration.STD.(motif{kk}){jj}=std(motif_duration.data.(motif{kk}){jj});
        motif_duration.COV.(motif{kk}){jj}=motif_duration.STD.(motif{kk}){jj}/motif_duration.mean.(motif{kk}){jj};
        scatter(jj+[-0.35:(0.7/(size(motif_duration.data.(motif{kk}){jj},1)-1)):0.35], motif_duration.data.(motif{kk}){jj},'r');
        %     figure(jj); plot(sort(motif_duration.data{jj}),'o'); title(['day: ' datestr(all_days_various.parameters.days{3}+jj-1, 'ddmmmyyyy')])
        %
    end
    
    errorbar(cell2mat(motif_duration.mean.(motif{kk})),cell2mat(motif_duration.STD.(motif{kk})),'o')
    
    % ax1=gca;
    %
    % ax2=axes('Position',get(ax1,'Position'),'YAxisLocation','right','Color','none','XColor','r','YColor','r');
    subplot(2,1,2); title('COV of motif duration');
    bar(cell2mat(motif_duration.COV.(motif{kk})))
    % set(gca,'YAxisLocation','right')
        %OUTPUT; 1) motif duration structure with data over entire day.
end

%% 5. Same as 3, but added up to 02/19. using all_days_various_20Feb2014_1508.mat

%FIRST - GREATER duration for all motifs below, and decreased COV for the
%ends of the motifs (i.e. ddeefg and ckeefg)

% COMPARING motif durations and variability of that.
%input variables
clear all; close all;
load all_days_various_20Feb2014_1508.mat
% motif={'abcddeefg','abckeefg','mbcddeefg','mbckeefg','jabcddeefg','bcddeefg'};
motif={'abcddeefg','abckeefg','mbcddeefg','keefg','ddeefg','abc','mbc'};

onsets_or_offsets={'onsets','offsets'}; % arguments say how to threshold the motif (e.g. onset to onset). 

for kk=1:size(motif,2);
    figure(kk);
    subplot(2,1,1); hold on; title(['Durations (individual points) of ' motif{kk} ' with mean and STD, each day']); ylabel('seconds'); xlabel('day')
    
    for jj=1:size(all_days_various.lt_db_get_labels.labels,2); % no of days
        motif_durations_mat=[];
        for i=1:size(all_days_various.lt_db_get_labels.labels{jj},2); % no of songs in day jj
            %     [startInd{i}, endInd{i}]=regexp(string,'ab(\w?)g','start','end');
            %       [startInd{i}, endInd{i}]=regexp(string,'abcddeefg','start','end');
            [startInd{kk,jj,i}, endInd{kk,jj,i}]=regexp(all_days_various.lt_db_get_labels.labels{jj}{i},motif{kk},'start','end');
            dummy=all_days_various.lt_db_get_labels.(onsets_or_offsets{2}){jj}{i}(endInd{kk,jj,i})-all_days_various.lt_db_get_labels.(onsets_or_offsets{1}){jj}{i}(startInd{kk,jj,i});
            motif_durations_mat=[motif_durations_mat; dummy];
            clear dummy
        end
        motif_duration.data.(motif{kk}){jj}=motif_durations_mat/1000;
        motif_duration.mean.(motif{kk}){jj}=mean(motif_duration.data.(motif{kk}){jj});
        motif_duration.STD.(motif{kk}){jj}=std(motif_duration.data.(motif{kk}){jj});
        motif_duration.COV.(motif{kk}){jj}=motif_duration.STD.(motif{kk}){jj}/motif_duration.mean.(motif{kk}){jj};
        scatter(jj+[-0.35:(0.7/(size(motif_duration.data.(motif{kk}){jj},1)-1)):0.35], motif_duration.data.(motif{kk}){jj},'r');
        %     figure(jj); plot(sort(motif_duration.data{jj}),'o'); title(['day: ' datestr(all_days_various.parameters.days{3}+jj-1, 'ddmmmyyyy')])
        %
    end
    
    errorbar(cell2mat(motif_duration.mean.(motif{kk})),cell2mat(motif_duration.STD.(motif{kk})),'o')
    
    % ax1=gca;
    %
    % ax2=axes('Position',get(ax1,'Position'),'YAxisLocation','right','Color','none','XColor','r','YColor','r');
    subplot(2,1,2); title('COV of motif duration');
    bar(cell2mat(motif_duration.COV.(motif{kk})))
    % set(gca,'YAxisLocation','right')
        %OUTPUT; 1) motif duration structure with data over entire day.
end
% close all
% %SECOND, checking whether post songs have drift
% for kk=1:size(motif,2);
%     figure(kk); hold on
%     for jj=1:size(all_days_various.lt_db_get_labels.labels,2); % no of days
%         try
%             motif_duration.running_avg.(motif{kk}){jj}=runningaverage(motif_duration.data.(motif{kk}){jj},8);
%         catch err
%             continue
%         end
%         plot(jj+[-0.35:(0.7/(size(motif_duration.running_avg.(motif{kk}){jj},2)-1)):0.35], motif_duration.running_avg.(motif{kk}){jj},'.r')
%     end
% end

%------------------------------------------------------
% LOOKING AT MOTIF DURATION DEVIATION FROM RUNNING AVERAGE


% running_window=

for kk=1:size(motif,2);
    for jj=1:size(all_days_various.lt_db_get_labels.labels,2); % no of days
        motif_duration.running_average_window_.(running_window)=motif_duration.data.abcddeefg{jj};
        
        motif_duration.adjacent_diff.(motif{kk}){jj}=diff(motif_duration.data.(motif{kk}{jj});
        motif_duration.adjacent_diff_sqr.(motif{kk}){jj}=(motif_duration.adjacent_diff{jj}).*(motif_duration.adjacent_diff{jj});
        motif_duration.adjacent_diff_mean_sqr{jj}=mean(motif_duration.adjacent_diff_sqr{jj});
        motif_duration.adjacent_diff_mean{jj}=mean(motif_duration.adjacent_diff{jj});
    end
end

dummy=cell2mat(motif_duration.adjacent_diff_mean_sqr);
figure; plot(dummy);

%% 6. Same as above, but for up to 2/25, using all_days_various_26Feb2014_1943.mat

%FIRST - GREATER duration for all motifs below, and decreased COV for the
%ends of the motifs (i.e. ddeefg and ckeefg)

% COMPARING motif durations and variability of that.
%input variables
clear all; close all;
load all_days_various_26Feb2014_1943.mat
% motif={'abcddeefg','abckeefg','mbcddeefg','mbckeefg','jabcddeefg','bcddeefg'};
motif={'abcddeefg','abckeefg','mbcddeefg','keefg','ddeefg','abc','mbc'};

onsets_or_offsets={'onsets','offsets'}; % arguments say how to threshold the motif (e.g. onset to onset). 

for kk=1:size(motif,2);
    figure(kk);
    subplot(2,1,1); hold on; title(['Durations (individual points) of ' motif{kk} ' with mean and STD, each day']); ylabel('seconds'); xlabel('day')
    
    for jj=1:size(all_days_various.lt_db_get_labels.labels,2); % no of days
        motif_durations_mat=[];
        for i=1:size(all_days_various.lt_db_get_labels.labels{jj},2); % no of songs in day jj
            %     [startInd{i}, endInd{i}]=regexp(string,'ab(\w?)g','start','end');
            %       [startInd{i}, endInd{i}]=regexp(string,'abcddeefg','start','end');
            [startInd{kk,jj,i}, endInd{kk,jj,i}]=regexp(all_days_various.lt_db_get_labels.labels{jj}{i},motif{kk},'start','end');
            dummy=all_days_various.lt_db_get_labels.(onsets_or_offsets{2}){jj}{i}(endInd{kk,jj,i})-all_days_various.lt_db_get_labels.(onsets_or_offsets{1}){jj}{i}(startInd{kk,jj,i});
            motif_durations_mat=[motif_durations_mat; dummy];
            clear dummy
        end
        motif_duration.data.(motif{kk}){jj}=motif_durations_mat/1000;
        motif_duration.mean.(motif{kk}){jj}=mean(motif_duration.data.(motif{kk}){jj});
        motif_duration.STD.(motif{kk}){jj}=std(motif_duration.data.(motif{kk}){jj});
        motif_duration.COV.(motif{kk}){jj}=motif_duration.STD.(motif{kk}){jj}/motif_duration.mean.(motif{kk}){jj};
        scatter(jj+[-0.35:(0.7/(size(motif_duration.data.(motif{kk}){jj},1)-1)):0.35], motif_duration.data.(motif{kk}){jj},'r');
        %     figure(jj); plot(sort(motif_duration.data{jj}),'o'); title(['day: ' datestr(all_days_various.parameters.days{3}+jj-1, 'ddmmmyyyy')])
        %
    end
    
    errorbar(cell2mat(motif_duration.mean.(motif{kk})),cell2mat(motif_duration.STD.(motif{kk})),'o')
    
    % ax1=gca;
    %
    % ax2=axes('Position',get(ax1,'Position'),'YAxisLocation','right','Color','none','XColor','r','YColor','r');
    subplot(2,1,2); title('COV of motif duration');
    bar(cell2mat(motif_duration.COV.(motif{kk})))
    % set(gca,'YAxisLocation','right')
        %OUTPUT; 1) motif duration structure with data over entire day.
end
% close all
% %SECOND, checking whether post songs have drift
% for kk=1:size(motif,2);
%     figure(kk); hold on
%     for jj=1:size(all_days_various.lt_db_get_labels.labels,2); % no of days
%         try
%             motif_duration.running_avg.(motif{kk}){jj}=runningaverage(motif_duration.data.(motif{kk}){jj},8);
%         catch err
%             continue
%         end
%         plot(jj+[-0.35:(0.7/(size(motif_duration.running_avg.(motif{kk}){jj},2)-1)):0.35], motif_duration.running_avg.(motif{kk}){jj},'.r')
%     end
% end

%------------------------------------------------------
% LOOKING AT MOTIF DURATION DEVIATION FROM RUNNING AVERAGE


% % running_window=
% 
% for kk=1:size(motif,2);
%     for jj=1:size(all_days_various.lt_db_get_labels.labels,2); % no of days
%         motif_duration.running_average_window_.(running_window)=motif_duration.data.abcddeefg{jj};
%         
%         motif_duration.adjacent_diff.(motif{kk}){jj}=diff(motif_duration.data.(motif{kk}{jj});
%         motif_duration.adjacent_diff_sqr.(motif{kk}){jj}=(motif_duration.adjacent_diff{jj}).*(motif_duration.adjacent_diff{jj});
%         motif_duration.adjacent_diff_mean_sqr{jj}=mean(motif_duration.adjacent_diff_sqr{jj});
%         motif_duration.adjacent_diff_mean{jj}=mean(motif_duration.adjacent_diff{jj});
%     end
% end
% 
% dummy=cell2mat(motif_duration.adjacent_diff_mean_sqr);
% figure; plot(dummy);


%% TO analyze each day's transitions

date = '24Feb2014';
% DIVERGENT:
lt_db_mult_seq_analy_FUNCTION(3,'bk24bk63',date,'NIFlesion','batch.catch.keep',2,{'cd','ck'},'div')
% CONVERGENT:
lt_db_mult_seq_analy_FUNCTION(3,'bk24bk63',date,'NIFlesion','batch.catch.keep',3,{'mb','ab','jb'},'con')


%% WN training PITCH - 3/19/14
clear all;
% use below to get percentiles each day
freq_vals = evtaf_freq('batch.catch.keep', [2000 3500], 'd', 128, 'obs0', 0); % after labeling, only get actually triggered syl

ptiles=prctile(freq_vals(:,2),[5 30 50 70 95])
cov=std(freq_vals(:,2))/mean(freq_vals(:,2))
figure; hist(freq_vals(:,2),20);


hit_rate=triglabel2('batch.catch.keep','d','c','',1,0,0,0)
hitrate=sum(hit_rate)



% PERCENTILES - [5 30 50 70 95]
% 3/16 -
% ptiles =
% 
%    1.0e+03 *8
% 
%     2.3903    2.4656    2.5018    2.5726    2.6218

% 3/17
% ptiles =
% 
%    1.0e+03 *
% 
%     2.3740    2.4785    2.5221    2.5972    2.6487
% hitrate =
% 
%     58    59    60
% cov =
% 
%     0.0321
    
% 3/18 
% ptiles =
% 
%    1.0e+03 *
% 
%     2.4076    2.4741    2.5131    2.5828    2.6322
% hitrate =
% 
%     63    63    67
    
% 3/19
% ptiles =
% 
%    1.0e+03 *
% 
%     2.4076    2.4741    2.5131    2.5828    2.6322
    
%     hitrate =
% 
%     62    63    66
% cov =
% 
%     0.0306
    
%% ANALYZING transitions from WN training - modified from all_days_all_analysis_PLOT.

% PLOT changes to transitions, using all_trans data.
close all
clear all
load all_days_all_analysis_19Mar2014_2300_NIFlesion_AllTrans

% FIRST, plotting heat map of change (rel to baseline) for every sun
% transition, across days.

% first, figure out the syllables that were sang every day.
days_with_analysis=[];
for i=1:size(all_days_all_analysis.data,2);
    if ~isempty(all_days_all_analysis.data{i});
        days_with_analysis=[days_with_analysis i];
    end
end

num_of_days=length(days_with_analysis);

for j=1:num_of_days;
    syl_labels_concatenated{j}=all_days_all_analysis.data{days_with_analysis(j)}.all_songs.all_trans.summary.syl_labels_in_order;
end

[common_syls syl_indices]=mintersect_array(syl_labels_concatenated); % find common syls and their indices in each day

% get baseline
baseline_days=[1 2 3]; %in 1,2,3,... indices, not days with gaps.
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
while counter<num_of_days+1;
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
        textColors = repmat(syl_mat(:) > max_value/4,1,3)+repmat(syl_mat(:) < min_value/4,1,3); %only put in text of those that are past 1/4 of max diff value.
        set(hStrings,{'Color'},num2cell(textColors,2));
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

all_days_all_analysis.PLOT.all_trans.difference_matrices.common_syls=common_syls;
all_days_all_analysis.PLOT.all_trans.difference_matrices.syl_indices=syl_indices;



%% POST-LESION - pitch training

times=lt_convert_datenum_to_hour(syllables.d.freq.vals(:,1));
values=syllables.d.freq.vals(:,2);

figure; hold on;
plot(times,values,'o');

% plot thresholds at all times
thresh_start_times=[8 9 10 12];
thresh_values=[2400 2500 2300 2450];

for i=1:length(thresh_start_times);
    if i==length(thresh_start_times);
        dummy=xlim;
        line([thresh_start_times(i) dummy(2)], [thresh_values(i) thresh_values(i)])
        line([thresh_start_times(i) thresh_start_times(i)], [thresh_values(i-1) thresh_values(i)])
    elseif i==1;
        line([thresh_start_times(i) thresh_start_times(i+1)], [thresh_values(i) thresh_values(i)])
    else
        line([thresh_start_times(i) thresh_start_times(i+1)], [thresh_values(i) thresh_values(i)])
        line([thresh_start_times(i) thresh_start_times(i)], [thresh_values(i-1) thresh_values(i)])
    end
end

% plot hit rate for all times


hit_rate=0.9;
fp_rate=0.1;
hStrings1=text(9,2500,'Hit:')
hStrings2=text(9,2400,'FP:')
set(hStrings1,'Color',[0 0.5 0])
set(hStrings2,'Color','r')

% plot singing rate for all times

singing_rate=50
hStrings3=text(9,2600,'Singing rate:')
set(hStrings3,'Color',[0 0.5 0])

%% looking at freq over all time, using 
close all
clear all
load /bluejay3/lucas/birds/bk24bk63/all_days_various_calculations/all_days_various_01Apr2014_1735.mat

%INPUT parameters
baseline_days=3;
lesion_dates={'10Feb2014-2000'};
WN_dates={'01Mar2014-1541','15Mar2014-1458','20Mar2014-0029','31Mar2014-0400'};

% calc other parameters
syllables=all_days_various.lt_db_check_templ_freq.parameters.syllables{1};
first_day_str=all_days_various.parameters.days{1};
first_day_datenum=all_days_various.parameters.days{3};
num_days=size(all_days_various.lt_db_check_templ_freq.data,2);
NumToAddToAllDays= -first_day_datenum;% this is to make day 1 = day 0 (instead of in the thousands).

WNevents=lt_convert_EventTimes_to_RelTimes(first_day_str,WN_dates);
WN_switch_days=WNevents.FinalValue;
lesionEvents=lt_convert_EventTimes_to_RelTimes(first_day_str,lesion_dates);
lesion_days=lesionEvents.FinalValue;

% compiles data values


%PLOTTING
for j=1:length(syllables);
    figure(j); hold on;
    
    
    for i=1:num_days; % number of days
        try
            [~, WithinDayValues]=lt_convert_datenum_to_hour(all_days_various.lt_db_check_templ_freq.data{i}.(syllables(j)).freq.vals(:,1)); %convert datenum to hours
            times_days=WithinDayValues.days;
            freq_values=all_days_various.lt_db_check_templ_freq.data{i}.(syllables(j)).freq.vals(:,2);
            hscatter=scatter(times_days+(i),freq_values,'b','.');
        catch err
            continue
        end
    end
    
    % Put in medians, std
    for i=1:num_days; % number of days
        try
            day_median=all_days_various.lt_db_check_templ_freq.data{i}.(syllables(j)).freq.median;
            day_std=all_days_various.lt_db_check_templ_freq.data{i}.(syllables(j)).freq.sd;
            errorbar(i+0.5,day_median,day_std,'Marker','.','MarkerSize',27,'Color','k');
        catch err
            continue
        end
    end
    
    
    
    ylimits=ylim;
    ylim([ylimits(1)-200 ylimits(2)+200])
    title(['Pitch over days for syllable: ' syllables(j) '; dots and lines are medians+S.D.']);xlabel('')
    ax1=gca;
    ax1_pos=get(ax1,'Position')
    
    % put in baseline lines (specifically for lesion experimnets, and PUT IN VERTICAL LINES FOR important dates (e.g. lesions)
    
    %     if isfield(all_days_all_analysis.summary_of_experiment,'inter_lesion_days')==1;
    %         disp('adding line for baseline value');
    %         baseline_values_temp=[];
    %         for i=1:all_days_all_analysis.summary_of_experiment.inter_lesion_days(1);
    %             baseline_values_temp=[baseline_values_temp all_days_all_analysis.data{i}.all_songs.(syllables(j)).(analysis_type).FF(:,2)'];
    %         end
    %         baseline_mean=median(baseline_values_temp);
    %         baseline_std=std(baseline_values_temp);
    %         line(xlim, [baseline_mean baseline_mean],'Color','r','LineWidth',0.4); % mean lines
    %         line(xlim, [baseline_mean+baseline_std baseline_mean+baseline_std],'LineStyle','--','Color',[0.7 0.1 0.1],'LineWidth',0.3); % variance lines
    %         line(xlim, [baseline_mean-baseline_std baseline_mean-baseline_std],'LineStyle','--','Color', [0.7 0.1 0.1],'LineWidth',0.3);
    %
    %         disp('adding lines for lesion days');
    %         % lesion 1
    %         %         for i=1:length(all_days_all_analysis.summary_of_experiment.inter_lesion_days);
    %         %             line([all_days_all_analysis.summary_of_experiment.inter_lesion_days(i)+0.1, ...
    %         %                 all_days_all_analysis.summary_of_experiment.inter_lesion_days(i)+0.1],ylim,'Color',[0.2 0.6 0.2],'LineWidth',1.8);
    %         %         end
    %         for i=1:length(all_days_all_analysis.summary_of_experiment.inter_lesion_days); % USE THE GREEN VERSION ABOVE IF YOU KEEP AS DAYS IN BETWEEN LESIONS
    %             absolute_lesion_day= sum(all_days_all_analysis.summary_of_experiment.inter_lesion_days(1:i)); % i.e. 3 pre-lesion days implies lesion 1 on day 3 (since day 1 is really 0)
    %             line([absolute_lesion_day+0.1, ...
    %                 absolute_lesion_day+0.1],ylim,'Color',[0.2 0.6 0.2],'LineWidth',1.8);
    %         end
    %     end
    %         if isfield(all_days_all_analysis.summary_of_experiment,'WN_baseline_days')==1;
    
    % adding lines for important dates - baseline end, lesion, WN start.
    disp('adding line for baseline value');
    baseline_values_temp=[];
    for i=1:baseline_days;
        baseline_values_temp=[baseline_values_temp all_days_various.lt_db_check_templ_freq.data{i}.(syllables(j)).freq.vals(:,2)'];
    end
    baseline_median=median(baseline_values_temp);
    baseline_std=std(baseline_values_temp);
    line(xlim, [baseline_median baseline_median],'Color','r','LineWidth',0.4); % mean lines
    line(xlim, [baseline_median+baseline_std baseline_median+baseline_std],'LineStyle','--','Color',[0.7 0.1 0.1],'LineWidth',0.3); % variance lines
    line(xlim, [baseline_median-baseline_std baseline_median-baseline_std],'LineStyle','--','Color', [0.7 0.1 0.1],'LineWidth',0.3);
    
    line([baseline_days+1 baseline_days+1],ylim,'Color','k','LineWidth',1.8);% line after last baseline day
    
    disp('adding lines for WN epochs');
    % adding grey boxes for WN days
    ylimits=ylim;
    for i=1:size(WN_switch_days,1)
        if mod(i,2)==1; %i.e. i odd means this is start of WN
            rectangle('Position',[WN_switch_days(i), ylimits(1)+20, WN_switch_days(i+1)-WN_switch_days(i),ylimits(2)-ylimits(1)-40],...
                'EdgeColor','r')
        end
    end
    
    % adding lines for lesions
    for i=1:length(lesion_days);
        line([lesion_days(i) lesion_days(i)], ylim,'Color','g','LineWidth',0.4); % mean lines
    end
    
    
    
% adding lines for pitch training WN thresholds
threshold_switch_RealTimes={'20Mar2014-0029','20Mar2014-1739','21Mar2014-1234','24Mar2014-1651','25Mar2014-1808',...
    '26Mar2014-1347','27Mar2014-0207','27Mar2014-1127','28Mar2014-0103','28Mar2014-1320','30Mar2014-1951'}; % real times for threshold values switches in format e.g. 20Mar2014-1645
[EventTimes]= lt_convert_EventTimes_to_RelTimes(first_day_str,threshold_switch_RealTimes); % convert to numerical format
thresh_start_times=EventTimes.FinalValue;
thresh_values=[2583 2615 2639 2706 2685 2675 2665 2680 2720 2710 2720]; % values of threshold corresponding to switch times
hit_conting='below'; % hit renditions "below" or "above" threshold?

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



%% PLOT CV 
close all
clear all
load /bluejay3/lucas/birds/bk24bk63/all_days_various_calculations/all_days_various_01Apr2014_1735.mat

%INPUT parameters
baseline_days=3;
lesion_dates={'10Feb2014-2000'};
WN_dates={'01Mar2014-1541','15Mar2014-1458','20Mar2014-0029','31Mar2014-0400'};

% calc other parameters
syllables=all_days_various.lt_db_check_templ_freq.parameters.syllables{1};
first_day_str=all_days_various.parameters.days{1};
first_day_datenum=all_days_various.parameters.days{3};
num_days=size(all_days_various.lt_db_check_templ_freq.data,2);
NumToAddToAllDays= -first_day_datenum;% this is to make day 1 = day 0 (instead of in the thousands).

WNevents=lt_convert_EventTimes_to_RelTimes(first_day_str,WN_dates);
WN_switch_days=WNevents.FinalValue;
lesionEvents=lt_convert_EventTimes_to_RelTimes(first_day_str,lesion_dates);
lesion_days=lesionEvents.FinalValue;

%PLOTTING
for j=1:length(syllables);
    figure(j); hold on;
    
       
    % Put in medians, std
    for i=1:num_days; % number of days
        try
            day_COV=all_days_various.lt_db_check_templ_freq.data{i}.(syllables(j)).freq.sd/all_days_various.lt_db_check_templ_freq.data{i}.(syllables(j)).freq.mean;
            
            plot(i+0.5,day_COV,'Marker','.','MarkerSize',27,'Color','k');
        catch err
            continue
        end
    end
    
    
    
%     ylimits=ylim;
%     ylim([ylimits(1)-200 ylimits(2)+200])
    title(['COV of pitch over days for syllable: ' syllables(j) '; dots and lines are medians+S.D.']);xlabel('')
    ax1=gca;
    ax1_pos=get(ax1,'Position')
    
    % put in baseline lines (specifically for lesion experimnets, and PUT IN VERTICAL LINES FOR important dates (e.g. lesions)
    
    %     if isfield(all_days_all_analysis.summary_of_experiment,'inter_lesion_days')==1;
    %         disp('adding line for baseline value');
    %         baseline_values_temp=[];
    %         for i=1:all_days_all_analysis.summary_of_experiment.inter_lesion_days(1);
    %             baseline_values_temp=[baseline_values_temp all_days_all_analysis.data{i}.all_songs.(syllables(j)).(analysis_type).FF(:,2)'];
    %         end
    %         baseline_mean=median(baseline_values_temp);
    %         baseline_std=std(baseline_values_temp);
    %         line(xlim, [baseline_mean baseline_mean],'Color','r','LineWidth',0.4); % mean lines
    %         line(xlim, [baseline_mean+baseline_std baseline_mean+baseline_std],'LineStyle','--','Color',[0.7 0.1 0.1],'LineWidth',0.3); % variance lines
    %         line(xlim, [baseline_mean-baseline_std baseline_mean-baseline_std],'LineStyle','--','Color', [0.7 0.1 0.1],'LineWidth',0.3);
    %
    %         disp('adding lines for lesion days');
    %         % lesion 1
    %         %         for i=1:length(all_days_all_analysis.summary_of_experiment.inter_lesion_days);
    %         %             line([all_days_all_analysis.summary_of_experiment.inter_lesion_days(i)+0.1, ...
    %         %                 all_days_all_analysis.summary_of_experiment.inter_lesion_days(i)+0.1],ylim,'Color',[0.2 0.6 0.2],'LineWidth',1.8);
    %         %         end
    %         for i=1:length(all_days_all_analysis.summary_of_experiment.inter_lesion_days); % USE THE GREEN VERSION ABOVE IF YOU KEEP AS DAYS IN BETWEEN LESIONS
    %             absolute_lesion_day= sum(all_days_all_analysis.summary_of_experiment.inter_lesion_days(1:i)); % i.e. 3 pre-lesion days implies lesion 1 on day 3 (since day 1 is really 0)
    %             line([absolute_lesion_day+0.1, ...
    %                 absolute_lesion_day+0.1],ylim,'Color',[0.2 0.6 0.2],'LineWidth',1.8);
    %         end
    %     end
    %         if isfield(all_days_all_analysis.summary_of_experiment,'WN_baseline_days')==1;
    
    % adding lines for important dates - baseline end, lesion, WN start.
%     disp('adding line for baseline value');
%     baseline_values_temp=[];
%     for i=1:baseline_days;
%         baseline_values_temp=[baseline_values_temp all_days_various.lt_db_check_templ_freq.data{i}.(syllables(j)).freq.vals(:,2)'];
%     end
%     baseline_median=median(baseline_values_temp);
%     baseline_std=std(baseline_values_temp);
%     line(xlim, [baseline_median baseline_median],'Color','r','LineWidth',0.4); % mean lines
%     line(xlim, [baseline_median+baseline_std baseline_median+baseline_std],'LineStyle','--','Color',[0.7 0.1 0.1],'LineWidth',0.3); % variance lines
%     line(xlim, [baseline_median-baseline_std baseline_median-baseline_std],'LineStyle','--','Color', [0.7 0.1 0.1],'LineWidth',0.3);
%     
%     line([baseline_days+1 baseline_days+1],ylim,'Color','k','LineWidth',1.8);% line after last baseline day
    
    disp('adding lines for WN epochs');
    % adding grey boxes for WN days
    ylimits=ylim;
    for i=1:size(WN_switch_days,1)
        if mod(i,2)==1; %i.e. i odd means this is start of WN
            rectangle('Position',[WN_switch_days(i), ylimits(1), WN_switch_days(i+1)-WN_switch_days(i),ylimits(2)-ylimits(1)],...
                'EdgeColor','r')
        end
    end
    
    % adding lines for lesions
    for i=1:length(lesion_days);
        line([lesion_days(i) lesion_days(i)], ylim,'Color','g','LineWidth',0.4); % mean lines
    end
    
    
    
% % adding lines for pitch training WN thresholds
% threshold_switch_RealTimes={'20Mar2014-0029','20Mar2014-1739','21Mar2014-1234','24Mar2014-1651','25Mar2014-1808',...
%     '26Mar2014-1347','27Mar2014-0207','27Mar2014-1127','28Mar2014-0103','28Mar2014-1320','30Mar2014-1951'}; % real times for threshold values switches in format e.g. 20Mar2014-1645
% [EventTimes]= lt_convert_EventTimes_to_RelTimes(first_day_str,threshold_switch_RealTimes); % convert to numerical format
% thresh_start_times=EventTimes.FinalValue;
% thresh_values=[2583 2615 2639 2706 2685 2675 2665 2680 2720 2710 2720]; % values of threshold corresponding to switch times
% hit_conting='below'; % hit renditions "below" or "above" threshold?
% 
% for i=1:length(thresh_start_times);
%     if i==length(thresh_start_times);
%         dummy=xlim;
%         line([thresh_start_times(i) dummy(2)], [thresh_values(i) thresh_values(i)],'Color','g')
%         line([thresh_start_times(i) thresh_start_times(i)], [thresh_values(i-1) thresh_values(i)],'Color','g')
%     elseif i==1;
%         line([thresh_start_times(i) thresh_start_times(i+1)], [thresh_values(i) thresh_values(i)],'Color','g')
%     else
%         line([thresh_start_times(i) thresh_start_times(i+1)], [thresh_values(i) thresh_values(i)],'Color','g')
%         line([thresh_start_times(i) thresh_start_times(i)], [thresh_values(i-1) thresh_values(i)],'Color','g')
%     end
% end
% 
%     
%     ax2 = axes('Position',[ax1_pos(1) ax1_pos(2)-0.05 ax1_pos(3) ax1_pos(4)/100],'YGrid','off','Color','none');
    
    
end

%% PLOT TRANSITION PROBS
load all_days_all_analysis_02Apr2014_1416_NIFlesion_AllTrans_WNtrigLabel

%PLOT single divergent or convergent transition over days
figure;  hold on;
for i=1:size(all_days_all_analysis.data,2);
try
    scatter(i,all_days_all_analysis.data{i}.all_songs.all_trans.c.transition_to_.d.relative_fraction_of_trans)
catch err
    continue
end
end

load /bluejay3/lucas/birds/bk24bk63/all_days_various_calculations/all_days_various_01Apr2014_1735.mat

%INPUT parameters
baseline_days=3;
lesion_dates={'10Feb2014-2000'};
WN_dates={'01Mar2014-1541','15Mar2014-1458','20Mar2014-0029','31Mar2014-0400'};

% calc other parameters
syllables=all_days_various.lt_db_check_templ_freq.parameters.syllables{1};
first_day_str=all_days_various.parameters.days{1};
first_day_datenum=all_days_various.parameters.days{3};
num_days=size(all_days_various.lt_db_check_templ_freq.data,2);
NumToAddToAllDays= -first_day_datenum;% this is to make day 1 = day 0 (instead of in the thousands).

WNevents=lt_convert_EventTimes_to_RelTimes(first_day_str,WN_dates);
WN_switch_days=WNevents.FinalValue;
lesionEvents=lt_convert_EventTimes_to_RelTimes(first_day_str,lesion_dates);
lesion_days=lesionEvents.FinalValue;

%PLOTTING

    disp('adding lines for WN epochs');
    % adding grey boxes for WN days
    ylimits=ylim;
    for i=1:size(WN_switch_days,1)
        if mod(i,2)==1; %i.e. i odd means this is start of WN
            rectangle('Position',[WN_switch_days(i), ylimits(1), WN_switch_days(i+1)-WN_switch_days(i),ylimits(2)-ylimits(1)],...
                'EdgeColor','r')
        end
    end
    
    % adding lines for lesions
    for i=1:length(lesion_days);
        line([lesion_days(i) lesion_days(i)], ylim,'Color','g','LineWidth',0.4); % mean lines
    end
    






%% also plot for all stack syllables (4 tyotal).
