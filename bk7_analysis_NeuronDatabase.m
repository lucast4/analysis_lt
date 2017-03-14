%% NOTE: this file called by lt_neural_MasterScript_AcrossNeurons -
% this file should contain only neuron database information, and when
% executed should append to NeuronDatabase structure


%% neuron database [NONLEARNING (CODING)]
clear NeuronDatabase;
NeuronDatabase.global.basedir='/bluejay4/lucas/birds/bk7/NEURAL';
ind=0;

% ======== add neurons
ind=ind+1;
NeuronDatabase.neurons(ind).date='080916'; % date
NeuronDatabase.neurons(ind).batchfile='BatchChan14good_v4'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=14; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='yes'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='TOO MANYS SONGS, LABELED MANY, NOT ALL. excluded some noises songs'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='yes'; % 
% DONE

ind=ind+1;
NeuronDatabase.neurons(ind).date='080916'; % date
NeuronDatabase.neurons(ind).batchfile='BatchChan14good_v4'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=9; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='TOO MANYS SONGS, LABELED MANY, NOT ALL. incr or decrease threshold'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='yes'; % 
% DONE

ind=ind+1;
NeuronDatabase.neurons(ind).date='080916'; % date
NeuronDatabase.neurons(ind).batchfile='BatchChan14Late'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=14; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='yes'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='MANY SONGS, LABELED MANY NOT ALL. last song miss some spikes - excluded some noisy songs'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='yes'; % 
% DONE

ind=ind+1;
NeuronDatabase.neurons(ind).date='081616'; % date
NeuronDatabase.neurons(ind).batchfile='BatchMidDayChan18SU'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=23; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='could get more song; missing some spikes'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='yes'; % 
% DONE

ind=ind+1;
NeuronDatabase.neurons(ind).date='080916'; % date
NeuronDatabase.neurons(ind).batchfile='BatchChan9Midday'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=9; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='[CHECKED - DOES LOOK SIMILAR. COMBINE THEM]. IMPORTANT: is likely similar, but not identical, MU to BatchChan14good_v4 [Could combine or only use one, but should not consider them as independent] [C'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='yes'; % 
% DONE

ind=ind+1;
NeuronDatabase.neurons(ind).date='081616'; % date
NeuronDatabase.neurons(ind).batchfile='BatchMidDayChan18SU'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=18; % channel
NeuronDatabase.neurons(ind).clustnum=2; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='yes'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='IDENTICAL TO PREVIOUS NEURON 4 (already removed)'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='yes'; % 
% DONE


ind=ind+1;
NeuronDatabase.neurons(ind).date='081616'; % date
NeuronDatabase.neurons(ind).batchfile='BatchChan14MidDay'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=14; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='[still more songs to label] some noise (Intan LVDS problem), usually outside song [song mod is clear, so noise not likely issue]; long duration - confirm that similar modulation througout [yes is similar]'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='yes'; % 
% DONE

ind=ind+1;
NeuronDatabase.neurons(ind).date='081616'; % date
NeuronDatabase.neurons(ind).batchfile='BatchMidDayChan18SU'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=18; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='could get more song'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='yes'; % 
% DONE


% ======================= IGNORE THIS ONE, LIKELY NOT LMAN
% ind=9;
% NeuronDatabase.neurons(ind).date='081616'; % date
% NeuronDatabase.neurons(ind).batchfile='BatchChan10Early'; % batchfile (songs)
% NeuronDatabase.neurons(ind).chan=10; % channel
% NeuronDatabase.neurons(ind).clustnum=1; % cluster
% NeuronDatabase.neurons(ind).NOTE_is_single_unit='yes'; % is_single_unit
% NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
% NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
% NeuronDatabase.neurons(ind).NOTE_random='IMPORTANT: good chance is not in LMAN, not bursty and lack syl modulation'; % random note
%

ind=ind+1;
NeuronDatabase.neurons(ind).date='081916'; % date
NeuronDatabase.neurons(ind).batchfile='BatchChan18Early'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=18; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='yes'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='looks good'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='yes'; % 
% DONE


% ------------------- CHECK SONG MOD BELOW:
ind=ind+1;
NeuronDatabase.neurons(ind).date='082216'; % date
NeuronDatabase.neurons(ind).batchfile='BatchChan23EarlyNeg'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=23; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='ok'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='[CHECKED - LOOKS SIMILAR FOR SOME MOTIFS, NOT OTHERS, LOOK AT MORE MOTIFS TO MAKE SURE] CHECK: no overlap with other from this batch [CHECKED - looks different]'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='yes'; % 


ind=ind+1;
NeuronDatabase.neurons(ind).date='082216'; % date
NeuronDatabase.neurons(ind).batchfile='BatchChan23EarlyPos'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=23; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='ok'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='Potentially SU, but maybe 2 units, also not perfectly clean'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='yes'; % 






% ================ NOISY MU, FOR CHECKING STABILITY OF MU OVER DAYS AND
% WITHIN DAY
ind=ind+1;
NeuronDatabase.neurons(ind).date='081916'; % date
NeuronDatabase.neurons(ind).batchfile='batchall_MU_sub'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=18; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='IMPORTANT: to check MU stability - compare to chan 18 other days; also compare to chan 18 this day; likely overlap with preceding SU [CHECK], if so then throw this one out [CHECKED, different - therefore should extract and label more for this MU]'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='yes'; % 



% ======== CONVERT TO TABLE
NeuronDatabase_table=struct2table(NeuronDatabase.neurons);
summary(NeuronDatabase_table);
disp(NeuronDatabase_table)
NumNeurons=length(NeuronDatabase.neurons);

f = figure('Position',[200 200 1000 500]);
dat=table2cell(NeuronDatabase_table);
cnames=fieldnames(NeuronDatabase_table);
t = uitable('Parent', f, 'Data',dat,'ColumnName',cnames, 'Position',[0 0 900 450]);

% === if there are any empty neurons, then move another neuron

%% neuron database [CHAN 18 ONLY] - for comparing MU activity across days.
clear NeuronDatabase;
NeuronDatabase.global.basedir='/bluejay4/lucas/birds/bk7/NEURAL';
ind=0;

% ======== add neurons
% ind=ind+1;
% NeuronDatabase.neurons(ind).date='080916'; % date
% NeuronDatabase.neurons(ind).batchfile='BatchChan14good_v4'; % batchfile (songs)
% NeuronDatabase.neurons(ind).chan=14; % channel
% NeuronDatabase.neurons(ind).clustnum=1; % cluster
% NeuronDatabase.neurons(ind).NOTE_is_single_unit='yes'; % is_single_unit
% NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
% NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
% NeuronDatabase.neurons(ind).NOTE_random='excluded some noises songs'; % random note

ind=ind+1;
NeuronDatabase.neurons(ind).date='080916'; % date
NeuronDatabase.neurons(ind).batchfile='BatchChan14good_v4'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=9; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='incr or decrease threshold'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 

% ind=ind+1;
% NeuronDatabase.neurons(ind).date='080916'; % date
% NeuronDatabase.neurons(ind).batchfile='BatchChan14Late'; % batchfile (songs)
% NeuronDatabase.neurons(ind).chan=14; % channel
% NeuronDatabase.neurons(ind).clustnum=1; % cluster
% NeuronDatabase.neurons(ind).NOTE_is_single_unit='yes'; % is_single_unit
% NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
% NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
% NeuronDatabase.neurons(ind).NOTE_random='last song miss some spikes - excluded some noisy songs'; % random note


% ind=ind+1;
% NeuronDatabase.neurons(ind).date='081616'; % date
% NeuronDatabase.neurons(ind).batchfile='BatchMidDayChan18SU'; % batchfile (songs)
% NeuronDatabase.neurons(ind).chan=23; % channel
% NeuronDatabase.neurons(ind).clustnum=1; % cluster
% NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
% NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
% NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
% NeuronDatabase.neurons(ind).NOTE_random='could get more song; missing some spikes'; % random note


ind=ind+1;
NeuronDatabase.neurons(ind).date='080916'; % date
NeuronDatabase.neurons(ind).batchfile='BatchChan9Midday'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=9; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='IMPORTANT: is likely similar, but not identical, MU to BatchChan14good_v4 [Could combine or only use one, but should not consider them as independent]'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 

ind=ind+1;
NeuronDatabase.neurons(ind).date='081616'; % date
NeuronDatabase.neurons(ind).batchfile='BatchMidDayChan18SU'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=18; % channel
NeuronDatabase.neurons(ind).clustnum=2; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='yes'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='IDENTICAL TO PREVIOUS NEURON 4 (already removed)'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 

% ind=ind+1;
% NeuronDatabase.neurons(ind).date='081616'; % date
% NeuronDatabase.neurons(ind).batchfile='BatchChan14MidDay'; % batchfile (songs)
% NeuronDatabase.neurons(ind).chan=14; % channel
% NeuronDatabase.neurons(ind).clustnum=1; % cluster
% NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
% NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
% NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
% NeuronDatabase.neurons(ind).NOTE_random='some noise (Intan LVDS problem), usually outside song [song mod is clear, so noise not likely issue]; long duration - confirm that similar modulation througout [yes is similar]'; % random note


ind=ind+1;
NeuronDatabase.neurons(ind).date='081616'; % date
NeuronDatabase.neurons(ind).batchfile='BatchMidDayChan18SU'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=18; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='could get more song'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 

% ======================= IGNORE THIS ONE, LIKELY NOT LMAN
% ind=9;
% NeuronDatabase.neurons(ind).date='081616'; % date
% NeuronDatabase.neurons(ind).batchfile='BatchChan10Early'; % batchfile (songs)
% NeuronDatabase.neurons(ind).chan=10; % channel
% NeuronDatabase.neurons(ind).clustnum=1; % cluster
% NeuronDatabase.neurons(ind).NOTE_is_single_unit='yes'; % is_single_unit
% NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
% NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
% NeuronDatabase.neurons(ind).NOTE_random='IMPORTANT: good chance is not in LMAN, not bursty and lack syl modulation'; % random note
%

ind=ind+1;
NeuronDatabase.neurons(ind).date='081916'; % date
NeuronDatabase.neurons(ind).batchfile='BatchChan18Early'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=18; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='yes'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='looks good'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 

% ------------------- CHECK SONG MOD BELOW:
% ind=ind+1;
% NeuronDatabase.neurons(ind).date='082216'; % date
% NeuronDatabase.neurons(ind).batchfile='BatchChan23EarlyNeg'; % batchfile (songs)
% NeuronDatabase.neurons(ind).chan=23; % channel
% NeuronDatabase.neurons(ind).clustnum=1; % cluster
% NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
% NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='ok'; % cluster_quality_confirmed
% NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
% NeuronDatabase.neurons(ind).NOTE_random='CHECK: no overlap with other from this batch'; % random note

% ind=ind+1;
% NeuronDatabase.neurons(ind).date='082216'; % date
% NeuronDatabase.neurons(ind).batchfile='BatchChan23EarlyPos'; % batchfile (songs)
% NeuronDatabase.neurons(ind).chan=23; % channel
% NeuronDatabase.neurons(ind).clustnum=1; % cluster
% NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
% NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='ok'; % cluster_quality_confirmed
% NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
% NeuronDatabase.neurons(ind).NOTE_random='Potentially SU, but maybe 2 units, also not perfectly clean'; % random note

% ================ NOISY MU, FOR CHECKING STABILITY OF MU OVER DAYS AND
% WITHIN DAY
ind=ind+1;
NeuronDatabase.neurons(ind).date='081916'; % date
NeuronDatabase.neurons(ind).batchfile='batchall_MU_sub'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=18; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='yes'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='IMPORTANT: to check MU stability - compare to chan 18 other days; also compare to chan 18 this day'; % random note
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 



% ======== CONVERT TO TABLE
NeuronDatabase_table=struct2table(NeuronDatabase.neurons);
summary(NeuronDatabase_table);
disp(NeuronDatabase_table)
NumNeurons=length(NeuronDatabase.neurons);

f = figure('Position',[200 200 1000 500]);
dat=table2cell(NeuronDatabase_table);
cnames=fieldnames(NeuronDatabase_table);
t = uitable('Parent', f, 'Data',dat,'ColumnName',cnames, 'Position',[0 0 900 450]);

% === if there are any empty neurons, then move another neuron




%% neuron database [LEARNING]
clear NeuronDatabase;
NeuronDatabase.global.basedir='/bluejay4/lucas/birds/bk7/NEURAL';
ind=0;

% ======================================== [LearnLMAN1 - first epoch]
ind=ind+1;
NeuronDatabase.neurons(ind).date='100516'; % date
NeuronDatabase.neurons(ind).batchfile='Batch1860_DurLearn'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=10; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='HAVE NOT LOOKED THRU CLUSTER RESULTS REL SONG'; % random note
NeuronDatabase.neurons(ind).LEARN_exptID='LearnLMAN1';
NeuronDatabase.neurons(ind).LEARN_WNonDatestr='05Oct2016-1348';
NeuronDatabase.neurons(ind).LEARN_WNotherImportantDates={}; % leave empty if nothing.
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 

ind=ind+1;
NeuronDatabase.neurons(ind).date='100516'; % date
NeuronDatabase.neurons(ind).batchfile='Batch1860DurLearnChan23'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=23; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='HAVE NOT LOOKED THRU CLUSTER RESULTS REL SONG'; % random note
NeuronDatabase.neurons(ind).LEARN_exptID='LearnLMAN1';
NeuronDatabase.neurons(ind).LEARN_WNonDatestr='05Oct2016-1348';
NeuronDatabase.neurons(ind).LEARN_WNotherImportantDates={}; % leave empty if nothing.
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 

% -------- LATE, WN ACUTE RESPONSE?
ind=ind+1;
NeuronDatabase.neurons(ind).date='100516'; % date
NeuronDatabase.neurons(ind).batchfile='Batch1980PeakLearnChan10MUearly'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=10; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='ok'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='yes'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='have not looked thru clust closely - potentially more MU after SU that comes after this>?'; % random note
NeuronDatabase.neurons(ind).LEARN_exptID='LearnLMAN1';
NeuronDatabase.neurons(ind).LEARN_WNonDatestr='05Oct2016-1348';
NeuronDatabase.neurons(ind).LEARN_WNotherImportantDates={}; % leave empty if nothing.
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 



% ======================================== [LearnLMAN1 - second epoch]
ind=ind+1;
NeuronDatabase.neurons(ind).date='100616'; % date
NeuronDatabase.neurons(ind).batchfile='BatchChan10oppdirlearn'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=10; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='HAVE NOT LOOKED THRU CLUSTER RESULTS REL SONG. Have not labeled all.'; % random note
NeuronDatabase.neurons(ind).LEARN_exptID='LearnLMAN1';
NeuronDatabase.neurons(ind).LEARN_WNonDatestr='06Oct2016-1225';
NeuronDatabase.neurons(ind).LEARN_WNotherImportantDates={}; % leave empty if nothing.
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 


% ======================================== [LearnLMAN2 - first epoch]
ind=ind+1;
NeuronDatabase.neurons(ind).date='101716'; % date
NeuronDatabase.neurons(ind).batchfile='batchall'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=23; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='no'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='QUICK LOOK, have not verified anything'; % random note
NeuronDatabase.neurons(ind).LEARN_exptID='LearnLMAN1';
NeuronDatabase.neurons(ind).LEARN_WNonDatestr='17Oct2016-1332';
NeuronDatabase.neurons(ind).LEARN_WNotherImportantDates={}; % leave empty if nothing.
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 


% =========================== [LearnLMAN2 - second epoch]
ind=ind+1;
NeuronDatabase.neurons(ind).date='101716'; % date
NeuronDatabase.neurons(ind).batchfile='BatchLate2700um'; % batchfile (songs)
NeuronDatabase.neurons(ind).chan=23; % channel
NeuronDatabase.neurons(ind).clustnum=1; % cluster
NeuronDatabase.neurons(ind).NOTE_is_single_unit='yes'; % is_single_unit
NeuronDatabase.neurons(ind).NOTE_clust_qual_confirmed='no'; % cluster_quality_confirmed
NeuronDatabase.neurons(ind).NOTE_all_songs_gotten='no'; % all_songs_gotten
NeuronDatabase.neurons(ind).NOTE_random='HAVE NOT GONE THRU CLUST RESULTS'; % random note
NeuronDatabase.neurons(ind).LEARN_exptID='LearnLMAN1';
NeuronDatabase.neurons(ind).LEARN_WNonDatestr='17Oct2016-1940';
NeuronDatabase.neurons(ind).LEARN_WNotherImportantDates={}; % leave empty if nothing.
NeuronDatabase.neurons(ind).NOTE_all_labeled='no'; % 




