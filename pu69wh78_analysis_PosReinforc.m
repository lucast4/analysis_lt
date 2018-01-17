%% TO DO:

% 1) get back of all actual songs (split into notcatch and catch)
% 2) count number of template matches for those songs
% 3) then make plots

%% ====== AUTOLABEL

batch = 'batch.CATCH.keep';
config= '/bluejay5/lucas/birds/pu69wh78/config_autolabel_abhh.evconfig2';

syl.targ='h';
syl.pre='abh';
syl.post=''; 
NoteNum=0; 

ampThresh=10000;
min_dur=30;
min_int=5;

overwrite_notmat=1; % will always make backup folder

[fnames, sylnum, vlsorfn, vlsorind]=lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat);


% ============ 2) Use evsonganaly manually on the .wav file created above
% (contains only the syls you chose)
% INSTRUCTIONS: 
% 1) open .wav file using evsonganaly
% 2) change threshold to segment all syls indivudally
% 3) any syl labeled "-" (default) will remain unchanged (i.e. will stay autolabeled). 
%     give a new label to any mislabeled syl - that will be its new actual label
evsonganaly


% ============ 3) Replace hand-checekd mislabeld syls 
lt_autolabel_FixHandCheckedSyls(fnames, sylnum, vlsorfn, vlsorind)





%% ====== plot spectrograms + triggers + light

% ================ 1) EXTRACT BATCH FILE OF SONGS


% ================ 2) PLOT SPECTROGRAMS
close all; clear all; 
plotspec = 1;
batchf = 'batch.rec_FB';
trignote = 0;
plotAdjacSongIfTrig=1; % if 1, then plots the song file directly after (searches directory), if there is trigger 
plotPreviousSongIfTrig = 1;
lt_batchsong_PlotSongTrigs(batchf, trignote, plotspec, plotAdjacSongIfTrig, ...
    plotPreviousSongIfTrig)


%% ============ plot fraction of songs with a hit
close all;
batchf = 'batch.keep';

% ============================= go thur all songs in batch
fid = fopen(batchf);
songf = fgetl(fid);

AllTrigs = [];
while ischar(songf)
    

    % -- ad trig time with rec file ...
    rd = readrecf_LT_evtafv4(songf);
    istrig =0;
    if ~isempty(rd.ttimes)
        for i=1:length(rd.ttimes)
            if rd.trignote(i)==trignote
                if rd.catch(i) ==1
                    plot(rd.ttimes(i)/1000, 0, '^g');
                else
                    plot(rd.ttimes(i)/1000, 0, '^r');
                    lt_plot_text(rd.ttimes(i)/1000 +0.05, 0, 'hit', 'r');
                    
                end
                
                istrig =1;
                
            end
            
        end
    end
    
    AllTrigs = [AllTrigs istrig];
    
    % ------------ next song
    songf = fgetl(fid);
end

lt_figure; hold on;
lt_plot_histogram(AllTrigs)


%% ============ plot motif frequency/song across song renditions
batchf = 'batch.keep';
% [INSERT CODE HERE]

% [NOTE: should make sure does not include any song files that might be DIR
% (e.g., could throw out songs that start during glass opening]

% ============================= go thur all songs in batch
fid = fopen(batchf);
songf = fgetl(fid);

AllTrigs = [];
while ischar(songf)
    

    % -- ad trig time with rec file ...
    rd = readrecf_LT_evtafv4(songf);
    istrig =0;
    if ~isempty(rd.ttimes)
        for i=1:length(rd.ttimes)
            if rd.trignote(i)==trignote
                if rd.catch(i) ==1
                    plot(rd.ttimes(i)/1000, 0, '^g');
                else
                    plot(rd.ttimes(i)/1000, 0, '^r');
                    lt_plot_text(rd.ttimes(i)/1000 +0.05, 0, 'hit', 'r');
                    
                end
                
                istrig =1;
                
            end
            
        end
    end
    
    AllTrigs = [AllTrigs istrig];
    
    % ------------ next song
    songf = fgetl(fid);
end

lt_figure; hold on;
plot

%% ============ Plot relative frequency of the target motif vs. other motifs
% [COULD COMBINE WITH CODE ABOVE OR INSERT HERE]


%% =========== Does singing rate increase?

