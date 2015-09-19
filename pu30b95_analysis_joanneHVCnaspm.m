%% 1/23/14 - Comparing 2/25 (saline) to 2/26 (naspm), with latter combined all 3 concentrations 1hr post-treatment.

%--------------------------------
% Transition probabilities

date='26Feb2013';
transition={'ca','cd'};
ConOrDiv='div';

lt_db_mult_seq_analy_FUNCTION_pu30b95('/bluejay2/lucas/birds/from_other_people/from_joanne','pu30b95',date,'HVC_naspm','batch.keep',...
    2,transition,ConOrDiv);

%------------------
% 2/25 - SALINE
% con - 
%     ca: 15%, 0.18 HD 
%     cd: 85%, 0.18HD
% div - 
%     ab: 55%, 0.3HD
%     fb: 45%, 0.3HD
%     
% 2/26 - NASPM
% con - 
%     ca: 15%, 0.18HD (NO CHANGE)
%     cd: 85%, 0.18HD
% div - 
%     ab: 70%, 0.09HD (CHANGE)
%     fb: 30%, 0.09HD

%% REPEATS OF "b"

% date='26Feb2013';
[mat_rep_length, cell_rep_length]=db_repeat_syllable_count('batch.keep','[^b]b','[^b]');
% rep_length.([date])=mat_rep_length;

mean(mat_rep_length)
std(mat_rep_length)
figure; hist(mat_rep_length)

%-----------------------
% 2/25 - 
%     mean:   1.11
%     std:    0.31
%     
% 2/26 - 
%     mean: 1.02
%     std: 0.15
    
%% REPEATS OF "i" (intro)

% date='26Feb2013';
[mat_rep_length, cell_rep_length]=db_repeat_syllable_count('batch.keep','[^i]i','[^i]');
% rep_length.([date])=mat_rep_length;

mean(mat_rep_length)
std(mat_rep_length)
figure; hist(mat_rep_length)

%-----------------------
% 2/25 - 
%     mean:   5.17
%     std:    1.47
%     
% 2/26 - 
%     mean: 5
%     std: 1.6
    

%% -----------------

% CONCLUSION:
% seems to restart often, probably explaining the increased ab versus fb (latter only happens when end with f back to b).
% did not check, but would expect to see more j, which are intro to restarted motifs.
% would also see fewer complete motifs.


%% __________________________
% 1/28/14
% LOOKED AT ALL TRANSITIONS:
% 
% 2/25-saline

%           a         b         c         d         e         f         i         j 
% a         0    0.6383    0.2553         0         0         0         0    0.1064
% b         0    0.1000    0.8667         0         0         0         0    0.0333
% c    0.1406         0         0    0.8281         0         0         0    0.0312
% d         0         0         0         0    1.0000         0         0         0
% e         0         0         0         0         0    1.0000         0         0
% f         0    0.5208         0         0         0         0         0    0.4792
% i    0.1892         0         0         0         0         0    0.8108         0
% j    0.9412         0         0         0         0         0         0    0.0588

% 2/26 - SAline
%          0    0.6149    0.2609         0         0         0    0.0124    0.1118         0
%     0.0050    0.1940    0.7612         0         0         0         0    0.0398         0
%     0.1717         0         0    0.7980         0         0         0    0.0303         0
%          0         0         0         0    0.9684    0.0063         0    0.0190    0.0063
%          0         0    0.0196         0         0    0.9804         0         0         0
%          0    0.4923         0         0         0         0         0    0.5077         0
%     0.4615         0         0         0         0         0    0.5385         0         0
%     1.0000         0         0         0         0         0         0         0         0
%          0         0         0         0         0         0         0    1.0000         0

        % 2/26 - Saline (early only, about 1.5 hour)
        %          0    0.6239    0.2661         0         0         0    0.0183    0.0917         0
        %     0.0078    0.1938    0.7442         0         0         0         0    0.0543         0
        %     0.1811         0         0    0.8031         0         0         0    0.0157         0
        %          0         0         0         0    0.9510    0.0098         0    0.0294    0.0098
        %          0         0    0.0206         0         0    0.9794         0         0         0
        %          0    0.4512         0         0         0         0         0    0.5488         0
        %     0.4857         0         0         0         0         0    0.5143         0         0
        %     1.0000         0         0         0         0         0         0         0         0
        %          0         0         0         0         0         0         0    1.0000         0

        %         2/26 - saline, late (3-3.5 hours)
        %          0    0.5962    0.2500         0         0         0         0    0.1538
        %          0    0.1944    0.7917         0         0         0         0    0.0139
        %     0.1549         0         0    0.7887         0         0         0    0.0563
        %          0         0         0         0    1.0000         0         0         0
        %          0         0    0.0179         0         0    0.9821         0         0
        %          0    0.5625         0         0         0         0         0    0.4375
        %     0.4118         0         0         0         0         0    0.5882         0
        %     1.0000         0         0         0         0         0         0         0

        

% 2/26 - naspm
%           a         b         c         d         e         f         i         j 
% a    0.0460    0.7356    0.1379         0         0         0         0    0.0805
% b    0.0860    0.0215    0.8495         0         0         0         0    0.0430
% c    0.1429         0         0    0.8352         0         0         0    0.0220
% d    0.0135         0         0         0    0.9054         0         0    0.0811
% e    0.0299         0         0         0         0    0.9403         0    0.0299
% f    0.0192    0.5192         0         0         0         0         0    0.4615
% i    0.1912         0         0         0         0         0    0.8088         0
% j    0.9783         0         0         0         0         0         0    0.0217

        % 2/26 - NASPM (4nM), 1.5-2h post
        %     0.0323    0.6774    0.2065         0         0         0         0    0.0839
        %     0.0057    0.1714    0.7829         0         0         0         0    0.0400
        %     0.1716         0         0    0.7929         0         0         0    0.0355
        %     0.0075         0         0         0    0.9925         0         0         0
        %          0         0         0         0         0    1.0000         0         0
        %     0.0083    0.3388         0         0         0         0         0    0.6529
        %     0.2222         0         0         0         0         0    0.7778         0
        %     1.0000         0         0         0         0         0         0         0

        % 2/26 NASPM (6nM), 1.5 to 1.75 hr post
        %     0.0182    0.6727    0.1636         0         0         0    0.0182    0.1273
        %     0.0455    0.1515    0.7576         0         0         0         0    0.0455
        %     0.1525         0         0    0.8305         0         0         0    0.0169
        %     0.0204         0         0         0    0.9592         0         0    0.0204
        %          0         0         0         0         0    0.9787         0    0.0213
        %          0    0.5000         0         0         0         0         0    0.5000
        %     0.1702         0         0         0         0         0    0.8298         0
        %     0.9429         0         0         0         0         0         0    0.0571

        
% 2/26 - WASH
%     0.0526    0.6632    0.2000         0         0         0         0    0.0842
%     0.0382    0.2214    0.6947         0         0         0         0    0.0458
%     0.1636         0         0    0.8091         0         0         0    0.0273
%     0.0112         0         0         0    0.9775         0         0    0.0112
%     0.0115         0         0         0         0    0.9885         0         0
%          0    0.5200         0         0         0         0         0    0.4800
%     0.1733         0         0         0         0         0    0.8267         0
%     1.0000         0         0         0         0         0         0         0

% 2/28 -SALINE
%     0.0404    0.6162    0.2323         0         0         0         0    0.1111
%     0.0412    0.0722    0.8866         0         0         0         0         0
%     0.1364         0         0    0.8273    0.0091         0         0    0.0273
%          0         0    0.0110         0    0.9890         0         0         0
%          0         0    0.0110         0         0    0.9890         0         0
%          0    0.3625         0         0         0         0         0    0.6375
%     0.2609         0         0         0         0         0    0.7391         0
%     1.0000         0         0         0         0         0         0         0
% 

% 2/28 - IEM
%     0.1695    0.5763    0.1017         0         0         0         0    0.1525
%     0.0392    0.0392    0.7647         0         0         0         0    0.1569
%     0.1333         0    0.0222    0.8444         0         0         0         0
%          0         0         0         0    0.8919         0         0    0.1081
%          0         0         0         0         0    1.0000         0         0
%     0.1154    0.6154         0         0         0         0         0    0.2692
%     0.4286         0         0         0         0         0    0.5714         0
%     1.0000         0         0         0         0         0         0         0


% 
% all changes are result of:
% 1) increased ending from all syl
% 2) increased stereotypy for the non-ending transitions (i.e. ab/ac, and bb) - but not for cd/ca (which might or might not be non-ending). 
% *) might increased stereotypy be because only the "strongest signal" sequences are able to not truncate?
% SEE PAPER NOTES

% -------------------------------
% ISSUE: incraesed ab versus ac (in NASPM and IEM) coudl be because ab is truncated at ab, which would enrich for ab (relative to ac) IF
%     ab sometimes leads to ac.  

% to test, look for specific strings in the saline day:
findstr(all_trans.syl_order_compiled_across_songs,'abcd')


% 2/25 (sal):
% 0 cases of abcac
% 7 cases of bcac
% 25 cases of abcd
% 
% 2/26 (sal)
% 2 cases of abcac
% 33 cases of bcac
% 69 cases of abcd

% therefore whenever ab comes up it is likely to lead to be: abcd..., as opposed to abcac..., so truncations right after b 
%     are most likley not artifically reducing the % of ac (and so the
%     increased ab versus ac is likely to be true).
%     MIGHT ACCOUNT FOR MAX OF 3% drop in ac relative to ab.


%%
IMPORTANT:
want to compare the two motif probabilites:
ca to cd is better than comparing ab to ac (since not all of motif 1 have ab. some start with b), but has problems:
    1) truncation at c would also cause ac
    2) motif 2 has both ca and cd, leading us to undercount number of motif 2 (and thus make seem more stereotyped).  
    
% comparing two motifs
all_trans.c.transition_to_.a.number_of_instances
length(findstr(all_trans.syl_order_compiled_across_songs,'cac'))
all_trans.c.transition_to_.d.number_of_instances

% (# of cac)/(# of cd)
7/53    % sal 2/25
17/80 %sal 2/26
18/89 % wash 2/26
11/76,  % naspm 2/26, 13 instances of cac, but 2 were cab or caj, so they were interruptions.
14/91 % sal 2/28
6/38 % iem 2/28

% below, remove numerator from denom, since cac motif gets counted in both.
% more accurate number for motif occurences.
7/46
17/63
18/71
11/65
14/77
6/32
    
% Conclusion: seems more stereotyped for naspm/iem days.
 

%% ______________________
% FUTURE - 
% 1) gap duration
% 2) syl durations
% would need to relabel since thresholding not good.



%% LOOKING AT PITCH  (done 3/5/14) - 

% 2/26 - saline

clear all
batch='batch.keep.LT_all.allnotmat';
note={'d','f'};

for k=1:length(note);
    fval.(note{k})=findwnote2tw(batch,note{k},'',-0.016,[2500 4000],8000,0,'obs0');
    pitch_cont.(note{k})=jc_pitchcontourFV(fval.(note{k}),1024,1020,1, 2500,4000,[1 2],'obs0');
    figure; hold on;
    for i=1:size(pitch_cont.(note{k}),2);
        plot(pitch_cont.(note{k})(:,i),'r'); title(['syllable: ' note{k} ' pitch contours for batch ' batch '.']);
    end
end


%  choose x values of 160-245 for d (2/26 sal); 710:780 for f

x_window.d=[160 245];
x_window.f=[710 780];

% getting average pitch
for k=1:length(note);
    for i=1:size(pitch_cont.(note{k}),2); %num of rend
        pitch_stats.mean_per_rend.(note{k})(i)=mean(pitch_cont.(note{k})(x_window.(note{k}),i));
    end
    pitch_stats.mean_over_rend_and_time.(note{k})=mean(pitch_stats.mean_per_rend.(note{k}))
    pitch_stats.std_over_rend_and_time.(note{k})=std(pitch_stats.mean_per_rend.(note{k}))
end

save('/bluejay2/lucas/birds/from_other_people/from_joanne/pu30b95/saved_analysis/pitch_cont_022613_sal','pitch_cont')
save('/bluejay2/lucas/birds/from_other_people/from_joanne/pu30b95/saved_analysis/pitch_stats_022613_sal','pitch_stats')

% pitch_stats.mean_over_rend_and_time
%     d: 3.3072e+03
%     f: 3.2708e+03
% 
% pitch_stats.std_over_rend_and_time
%     d: 98.2464
%     f: 96.9953



%% SAME as above, but for naspm trials. (2_26_2013_naspmALL folder)

clear all
batch='batch.keep.allnotmat';
note={'d','f'};

for k=1:length(note);
    fval.(note{k})=findwnote2tw(batch,note{k},'',-0.016,[2500 4000],8000,0,'obs0');
    pitch_cont.(note{k})=jc_pitchcontourFV(fval.(note{k}),1024,1020,1, 2500,4000,[1 2],'obs0');
    figure; hold on;
    for i=1:size(pitch_cont.(note{k}),2);
        plot(pitch_cont.(note{k})(:,i),'r'); title(['syllable: ' note{k} ' pitch contours for batch ' batch '.']);
    end
end

x_window.d=[160 245];
x_window.f=[730 810];

% getting average pitch
for k=1:length(note);
    for i=1:size(pitch_cont.(note{k}),2); %num of rend
        pitch_stats.mean_per_rend.(note{k})(i)=mean(pitch_cont.(note{k})(x_window.(note{k}),i));
    end
    pitch_stats.mean_over_rend_and_time.(note{k})=mean(pitch_stats.mean_per_rend.(note{k}))
    pitch_stats.std_over_rend_and_time.(note{k})=std(pitch_stats.mean_per_rend.(note{k}))
end


save('/bluejay2/lucas/birds/from_other_people/from_joanne/pu30b95/saved_analysis/pitch_cont_022613_naspmALL','pitch_cont')
save('/bluejay2/lucas/birds/from_other_people/from_joanne/pu30b95/saved_analysis/pitch_stats_022613_naspmALL','pitch_stats');

% pitch_stats.mean_over_rend_and_time
%     d: 3.3162e+03
%     f: 3.2828e+03
% 
% pitch_stats.std_over_rend_and_time
%     d: 50.5699
%     f: 65.2071

%% same, but for 2/26 - WASH
clear all
batch='batch.keep.allnotmat';
note={'d','f'};

for k=1:length(note);
    fval.(note{k})=findwnote2tw(batch,note{k},'',-0.016,[2500 4000],8000,0,'obs0');
    pitch_cont.(note{k})=jc_pitchcontourFV(fval.(note{k}),1024,1020,1, 2500,4000,[1 2],'obs0');
    figure; hold on;
    for i=1:size(pitch_cont.(note{k}),2);
        plot(pitch_cont.(note{k})(:,i),'r'); title(['syllable: ' note{k} ' pitch contours for batch ' batch '.']);
    end
end

x_window.d=[160 245];
x_window.f=[710 790];

% getting average pitch
for k=1:length(note);
    for i=1:size(pitch_cont.(note{k}),2); %num of rend
        pitch_stats.mean_per_rend.(note{k})(i)=mean(pitch_cont.(note{k})(x_window.(note{k}),i));
    end
    pitch_stats.mean_over_rend_and_time.(note{k})=mean(pitch_stats.mean_per_rend.(note{k}))
    pitch_stats.std_over_rend_and_time.(note{k})=std(pitch_stats.mean_per_rend.(note{k}))
end


save('/bluejay2/lucas/birds/from_other_people/from_joanne/pu30b95/saved_analysis/pitch_cont_022613_wash','pitch_cont')
save('/bluejay2/lucas/birds/from_other_people/from_joanne/pu30b95/saved_analysis/pitch_stats_022613_wash','pitch_stats');

% pitch_stats.mean_over_rend_and_time
%     d: 3.3042e+03
%     f: 3.2829e+03
% 
% pitch_stats.stdover_rend_and_time
%     d: 107.6956
%     f: 77.8989

%% PLOTTING all 3 conditions together
clear all; close all
note={'d','f'};

% saline
load pitch_stats_022613_sal
for k=1:length(note);
    sample_size.(note{k})=size(pitch_stats.mean_per_rend.(note{k}),2);
    figure(k); title(['syllable ' note{k} ' pitch on 2/26/13; black=saline/wash; red=NASPM;']); hold on;
    scatter([1:sample_size.(note{k})]+50,pitch_stats.mean_per_rend.(note{k}),'ok');
    errorbar(220,pitch_stats.mean_over_rend_and_time.(note{k}),pitch_stats.std_over_rend_and_time.(note{k}),'o')
    
    figure(k+2); hold on;
    hist(pitch_stats.mean_per_rend.(note{k}),10,'k'); xlim([3000 3600]); title(['saline, syllable ' note{k}' ])

end



% naspm
load pitch_stats_022613_naspmALL
for k=1:length(note);
    figure(k);
    sample_size.(note{k})=size(pitch_stats.mean_per_rend.(note{k}),2);
    scatter([1:sample_size.(note{k})]+250, pitch_stats.mean_per_rend.(note{k}),'or');
    errorbar(350,pitch_stats.mean_over_rend_and_time.(note{k}),pitch_stats.std_over_rend_and_time.(note{k}),'o')
    
    figure(k+4); 
    hist(pitch_stats.mean_per_rend.(note{k}),10,'r'); xlim([3000 3600]); title(['NASPM, syllable ' note{k}' ])

end


% Wash
load pitch_stats_022613_wash
for k=1:length(note);
    figure(k);
    sample_size.(note{k})=size(pitch_stats.mean_per_rend.(note{k}),2);
    scatter([1:sample_size.(note{k})]+400,pitch_stats.mean_per_rend.(note{k}),'ok');
    errorbar(500,pitch_stats.mean_over_rend_and_time.(note{k}),pitch_stats.std_over_rend_and_time.(note{k}),'o')
    
    figure(k+6); 
    hist(pitch_stats.mean_per_rend.(note{k}),10,'r'); xlim([3000 3600]); title(['washout, syllable ' note{k}' ])


end


% CONCLUSION - a small effect if any, on pitch COV.  even smaller effect, if any,
% on pitch mean.

%% REDID pitch analysis, but using conservative timepoints for NASPM day (i.e. about 15-45min window post-drug)

clear all
batch='batch.keep.conservative.allnotmat';
note={'d','f'};

for k=1:length(note);
    fval.(note{k})=findwnote2tw(batch,note{k},'',-0.016,[2500 4000],8000,0,'obs0');
    pitch_cont.(note{k})=jc_pitchcontourFV(fval.(note{k}),1024,1020,1, 2500,4000,[1 2],'obs0');
    figure; hold on;
    for i=1:size(pitch_cont.(note{k}),2);
        plot(pitch_cont.(note{k})(:,i),'r'); title(['syllable: ' note{k} ' pitch contours for batch ' batch '.']);
    end
end

x_window.d=[160 245];
x_window.f=[735 800];

% getting average pitch
for k=1:length(note);
    for i=1:size(pitch_cont.(note{k}),2); %num of rend
        pitch_stats.mean_per_rend.(note{k})(i)=mean(pitch_cont.(note{k})(x_window.(note{k}),i));
    end
    pitch_stats.mean_over_rend_and_time.(note{k})=mean(pitch_stats.mean_per_rend.(note{k}))
    pitch_stats.std_over_rend_and_time.(note{k})=std(pitch_stats.mean_per_rend.(note{k}))
end


save('/bluejay2/lucas/birds/from_other_people/from_joanne/pu30b95/saved_analysis/pitch_cont_022613_naspmALLconservative','pitch_cont')
save('/bluejay2/lucas/birds/from_other_people/from_joanne/pu30b95/saved_analysis/pitch_stats_022613_naspmALLconservative','pitch_stats');

% pitch_stats.mean_over_rend_and_time
%     d: 3.3182e+03
%     f: 3.2792e+03
% 
% pitch_stats.std_over_rend_and_time
%     d: 46.5416
%     f: 70.7813
% 

%% REDID saline (2/26), but only last ~8-10 songs before NASPM.


clear all
batch='batch.keep.latest.allnotmat';
note={'d','f'};

for k=1:length(note);
    fval.(note{k})=findwnote2tw(batch,note{k},'',-0.016,[2500 4000],8000,0,'obs0');
    pitch_cont.(note{k})=jc_pitchcontourFV(fval.(note{k}),1024,1020,1, 2500,4000,[1 2],'obs0');
    figure; hold on;
    for i=1:size(pitch_cont.(note{k}),2);
        plot(pitch_cont.(note{k})(:,i),'r'); title(['syllable: ' note{k} ' pitch contours for batch ' batch '.']);
    end
end

x_window.d=[160 245];
x_window.f=[705 765];

% getting average pitch
for k=1:length(note);
    for i=1:size(pitch_cont.(note{k}),2); %num of rend
        pitch_stats.mean_per_rend.(note{k})(i)=mean(pitch_cont.(note{k})(x_window.(note{k}),i));
    end
    pitch_stats.mean_over_rend_and_time.(note{k})=mean(pitch_stats.mean_per_rend.(note{k}))
    pitch_stats.std_over_rend_and_time.(note{k})=std(pitch_stats.mean_per_rend.(note{k}))
end


save('/bluejay2/lucas/birds/from_other_people/from_joanne/pu30b95/saved_analysis/pitch_cont_022613_salLastSongs','pitch_cont')
save('/bluejay2/lucas/birds/from_other_people/from_joanne/pu30b95/saved_analysis/pitch_stats_022613_salLastSongs','pitch_stats');

% pitch_stats.mean_over_rend_and_time
%     d: 3.3437e+03
%     f: 3.3259e+03
% 
% pitch_stats.std_over_rend_and_time
%     d: 66.3920
%     f: 57.6601


% CONCLUSION - redoing by looking at NASPM conservatively vs. immedaite 10
% songs before (both 2/26) found no strong difference in variability.  NEXT: should
% compare across days as NASPM treatment was over many hours.

