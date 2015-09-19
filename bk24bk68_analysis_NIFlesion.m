%% 2/17 comparing motif duration post vs. pre vs. post dir

% TO DO:
% 1) relabel 2/9 with normal threshold
% 2) label more songs all days.

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
