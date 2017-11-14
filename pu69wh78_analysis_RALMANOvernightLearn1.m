%% ####################################### quick analysis scripts

%% 1) DIR vs. UNDIR throughout leanring (comapring target to nontarg)

%% A) midday neuron on 11/11/17 (see ppt for results)
clear all; close all;
DATSTRUCT = struct;

% ============== 1) UNDIR
songdir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/MorningDIRtest/UNDIR';
% where the songs and batch are located
batchf = 'batchall'; % contains .rhd names
chanstoplot = [9 14 21]; % chip channels. leave empty to get all
motifstoplot = {'abh', 'jbh', 'abhh', 'jbhh'}; % cell arary of motifs, strings
sylstoalign = [3 3 4 4]; % which syl in that motif? (one for each motif
pretime = 0.1; % sec, from onset
posttime = 0.15; % sec, from offset
plotRaw = 0; % plot each extracted trial (raw, smoothed, and spec)

DATSTRUCT.UNDIR = lt_neural_BatchSmth(songdir, batchf, chanstoplot, motifstoplot, ...
    sylstoalign, pretime, posttime, plotRaw);


% ================= DIR
songdir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/MorningDIRtest/DIR';
% where the songs and batch are located
batchf = 'batchall'; % contains .rhd names
chanstoplot = [9 14 21]; % chip channels. leave empty to get all
motifstoplot = {'abh', 'jbh', 'abhh', 'jbhh'}; % cell arary of motifs, strings
sylstoalign = [3 3 4 4]; % which syl in that motif? (one for each motif
pretime = 0.1; % sec, from onset
posttime = 0.15; % sec, from offset
plotRaw = 0; % plot each extracted trial (raw, smoothed, and spec)

DATSTRUCT.DIR = lt_neural_BatchSmth(songdir, batchf, chanstoplot, motifstoplot, ...
    sylstoalign, pretime, posttime, plotRaw);



% ============================ PLOT RESULTS
figcount=1;
subplotrows=4;
subplotcols=3;
fignums_alreadyused=[];
hfigs=[];

% ==== three subplots for each motif, dir, undir, and overlay dir and undir
nummotifs = length(DATSTRUCT.UNDIR.motifnum);
numchannels = length(chanstoplot);
for i=1:nummotifs
    motifname = DATSTRUCT.UNDIR.motifnum(i).motifname;
    
    %     = ~cellfun('isempty', DATSTRUCT_DIR.motifnum(i).DatAll)
    
    for cc=chanstoplot
        hsplots = [];
        % ----- UNDIR
        Ymean_UNDIR = [];
        Ysem_UNDIR = [];
        dirfield = 'UNDIR';
        
        [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
        title(['[' dirfield ']' motifname '-ch' num2str(cc)]);
        hsplots = [hsplots hsplot];
        datmat = DATSTRUCT.(dirfield).motifnum(i).DatAll{cc};
        t = DATSTRUCT.(dirfield).motifnum(i).t;
        % -- plot raw
        plot(t, datmat, 'Color', [0.7 0.7 0.7]);
        % -- overlay median, with 75th tiles
        datmedian = median(datmat,1);
        datCI = prctile(datmat, [75 25]);
        datSEM = lt_sem(datmat);
        shadedErrorBar(t, datmedian, datSEM, {'Color','r'}, 1);
        line([pretime pretime],ylim);
        lt_plot_zeroline;
        
        Ymean_UNDIR = datmedian;
        Ysem_UNDIR = datSEM;
        
        % ---- DIR
        Ymean_DIR = [];
        Ysem_DIR = [];
        dirfield = 'DIR';
        
        [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
        hsplots = [hsplots hsplot];
        title(['[' dirfield ']' motifname '-ch' num2str(cc)]);
        datmat = DATSTRUCT.(dirfield).motifnum(i).DatAll{cc};
        t = DATSTRUCT.(dirfield).motifnum(i).t;
        % -- plot raw
        plot(t, datmat, 'Color', [0.7 0.7 0.7]);
        % -- overlay median, with 75th tiles
        datmedian = median(datmat,1);
        datCI = prctile(datmat, [75 25]);
        datSEM = lt_sem(datmat);
        shadedErrorBar(t, datmedian, datSEM, {'Color','r'}, 1);
        line([pretime pretime],ylim);
        lt_plot_zeroline;
        
        Ymean_DIR = datmedian;
        Ysem_DIR = datSEM;
        
        % ----- COMBINED
        [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
        hsplots = [hsplots hsplot];
        title(['[DIR(r) AND UNDIR(k)]' motifname '-ch' num2str(cc)]);
        
        shadedErrorBar(t, Ymean_UNDIR, Ysem_UNDIR, {'Color','k'}, 1);
        shadedErrorBar(t, Ymean_DIR, Ysem_DIR, {'Color','r'}, 1);
        line([pretime pretime],ylim);
        lt_plot_zeroline;
        
        % ---
        linkaxes(hsplots, 'xy');
        
    end
end

%% A) LATE neuron on 11/11/17 
clear all; close all;
DATSTRUCT = struct;

% ============== 1) UNDIR
songdir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/EveningDIRtest/UNDIR';
% where the songs and batch are located
batchf = 'batchall'; % contains .rhd names
chanstoplot = [9 14 21]; % chip channels. leave empty to get all
motifstoplot = {'abh', 'jbh', 'abhh', 'jbhh'}; % cell arary of motifs, strings
sylstoalign = [3 3 4 4]; % which syl in that motif? (one for each motif
pretime = 0.1; % sec, from onset
posttime = 0.15; % sec, from offset
plotRaw = 0; % plot each extracted trial (raw, smoothed, and spec)

DATSTRUCT.UNDIR = lt_neural_BatchSmth(songdir, batchf, chanstoplot, motifstoplot, ...
    sylstoalign, pretime, posttime, plotRaw);


% ================= DIR
songdir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/EveningDIRtest/DIR';
% where the songs and batch are located
batchf = 'batchall'; % contains .rhd names
chanstoplot = [9 14 21]; % chip channels. leave empty to get all
motifstoplot = {'abh', 'jbh', 'abhh', 'jbhh'}; % cell arary of motifs, strings
sylstoalign = [3 3 4 4]; % which syl in that motif? (one for each motif
pretime = 0.1; % sec, from onset
posttime = 0.15; % sec, from offset
plotRaw = 1; % plot each extracted trial (raw, smoothed, and spec)
plotSpecifics = {'abh', 14}; % {motif, chan}
DATSTRUCT.DIR = lt_neural_BatchSmth(songdir, batchf, chanstoplot, motifstoplot, ...
    sylstoalign, pretime, posttime, plotRaw, plotSpecifics);



% ============================ PLOT RESULTS
figcount=1;
subplotrows=4;
subplotcols=3;
fignums_alreadyused=[];
hfigs=[];

% ==== three subplots for each motif, dir, undir, and overlay dir and undir
nummotifs = length(DATSTRUCT.UNDIR.motifnum);
numchannels = length(chanstoplot);
for i=1:nummotifs
    motifname = DATSTRUCT.UNDIR.motifnum(i).motifname;
    
    %     = ~cellfun('isempty', DATSTRUCT_DIR.motifnum(i).DatAll)
    
    for cc=chanstoplot
        hsplots = [];
        % ----- UNDIR
        Ymean_UNDIR = [];
        Ysem_UNDIR = [];
        dirfield = 'UNDIR';
        
        [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
        title(['[' dirfield ']' motifname '-ch' num2str(cc)]);
        hsplots = [hsplots hsplot];
        datmat = DATSTRUCT.(dirfield).motifnum(i).DatAll{cc};
        t = DATSTRUCT.(dirfield).motifnum(i).t;
        % -- plot raw
        plot(t, datmat, 'Color', [0.7 0.7 0.7]);
        % -- overlay median, with 75th tiles
        datmedian = median(datmat,1);
        datCI = prctile(datmat, [75 25]);
        datSEM = lt_sem(datmat);
        shadedErrorBar(t, datmedian, datSEM, {'Color','r'}, 1);
        line([pretime pretime],ylim);
        lt_plot_zeroline;
        
        Ymean_UNDIR = datmedian;
        Ysem_UNDIR = datSEM;
        
        % ---- DIR
        Ymean_DIR = [];
        Ysem_DIR = [];
        dirfield = 'DIR';
        
        [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
        hsplots = [hsplots hsplot];
        title(['[' dirfield ']' motifname '-ch' num2str(cc)]);
        datmat = DATSTRUCT.(dirfield).motifnum(i).DatAll{cc};
        t = DATSTRUCT.(dirfield).motifnum(i).t;
        % -- plot raw
        plot(t, datmat, 'Color', [0.7 0.7 0.7]);
        % -- overlay median, with 75th tiles
        datmedian = median(datmat,1);
        datCI = prctile(datmat, [75 25]);
        datSEM = lt_sem(datmat);
        shadedErrorBar(t, datmedian, datSEM, {'Color','r'}, 1);
        line([pretime pretime],ylim);
        lt_plot_zeroline;
        
        Ymean_DIR = datmedian;
        Ysem_DIR = datSEM;
        
        % ----- COMBINED
        [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
        hsplots = [hsplots hsplot];
        title(['[DIR(r) AND UNDIR(k)]' motifname '-ch' num2str(cc)]);
        
        shadedErrorBar(t, Ymean_UNDIR, Ysem_UNDIR, {'Color','k'}, 1);
        shadedErrorBar(t, Ymean_DIR, Ysem_DIR, {'Color','r'}, 1);
        line([pretime pretime],ylim);
        lt_plot_zeroline;
        
        % ---
        linkaxes(hsplots, 'xy');
        
    end
end



%% A) AM NEURONS ON 11/12
clear all; close all;
DATSTRUCT = struct;

% ============== 1) UNDIR
songdir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111217_Morning_DirUndir/UNDIR';
% where the songs and batch are located
batchf = 'batchall'; % contains .rhd names
chanstoplot = [9 14 21]; % chip channels. leave empty to get all
motifstoplot = {'abh', 'jbh', 'abhh', 'jbhh'}; % cell arary of motifs, strings
sylstoalign = [3 3 4 4]; % which syl in that motif? (one for each motif
pretime = 0.1; % sec, from onset
posttime = 0.15; % sec, from offset
plotRaw = 0; % plot each extracted trial (raw, smoothed, and spec)

DATSTRUCT.UNDIR = lt_neural_BatchSmth(songdir, batchf, chanstoplot, motifstoplot, ...
    sylstoalign, pretime, posttime, plotRaw);


% ================= DIR
songdir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111217_Morning_DirUndir/DIR';
% where the songs and batch are located
batchf = 'batchall'; % contains .rhd names
chanstoplot = [9 14 21]; % chip channels. leave empty to get all
motifstoplot = {'abh', 'jbh', 'abhh', 'jbhh'}; % cell arary of motifs, strings
sylstoalign = [3 3 4 4]; % which syl in that motif? (one for each motif
pretime = 0.1; % sec, from onset
posttime = 0.15; % sec, from offset
plotRaw = 0; % plot each extracted trial (raw, smoothed, and spec)
plotSpecifics = {'abh', 14}; % {motif, chan}
DATSTRUCT.DIR = lt_neural_BatchSmth(songdir, batchf, chanstoplot, motifstoplot, ...
    sylstoalign, pretime, posttime, plotRaw, plotSpecifics);


% ============= save DATSTRUCT
fname = ['/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111217_Morning_DirUndir/DATSTRUCT_BatchSm.mat'];
save(fname, 'DATSTRUCT');

% ========================= PLOT RAW DAT
dirfield = 'DIR';
mm = 2;
chan = 21;

figcount=1;
subplotrows=5;
subplotcols=2;
fignums_alreadyused=[];
hfigs=[];

datraw = DATSTRUCT.(dirfield).motifnum(mm).DatAllRaw{chan};
datsm = DATSTRUCT.(dirfield).motifnum(mm).DatAll{chan};
t = DATSTRUCT.(dirfield).motifnum(mm).t;
for k =1 :size(datraw,1)
    motifname = DATSTRUCT.(dirfield).motifnum(mm).motifname;
    
    % --- raw dat    
    [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
    title(['[' dirfield ']' motifname '-ch' num2str(chan)]);
    plot(t, datraw(k,:), 'b');
    xlim([pretime-0.05 pretime+0.1]);
    ylim([-200 200])
    line([pretime pretime], ylim);
    lt_plot_zeroline;
    
    % -- smoothed
    [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
    title(['[' dirfield ']' motifname '-ch' num2str(chan)]);
    plot(t, datsm(k, :), 'k', 'LineWidth', 2);
    xlim([pretime-0.05 pretime+0.1]);
    ylim([0 50]);
    line([pretime pretime], ylim);
    lt_plot_zeroline;
end


% ========================= PLOT RAW DAT [compare 2 chans]
dirfield = 'UNDIR';
mm = 1;
chan1 = 14;
chan2 = 21;

figcount=1;
subplotrows=5;
subplotcols=2;
fignums_alreadyused=[];
hfigs=[];

% -- chan1
datraw1 = DATSTRUCT.(dirfield).motifnum(mm).DatAllRaw{chan1};
% datsm1 = DATSTRUCT.(dirfield).motifnum(mm).DatAll{chan1};
datraw2 = DATSTRUCT.(dirfield).motifnum(mm).DatAllRaw{chan2};
% datsm2 = DATSTRUCT.(dirfield).motifnum(mm).DatAll{chan2};
t = DATSTRUCT.(dirfield).motifnum(mm).t;
assert(all(size(datraw1) == size(datraw2)), 'diff sample siezes?');
for k =1 :size(datraw1,1)
    motifname = DATSTRUCT.(dirfield).motifnum(mm).motifname;
    
    % --- raw dat (chan1)   
    [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
    title(['[' dirfield ']' motifname '-ch' num2str(chan1)]);
    plot(t, datraw1(k,:), 'b');
    xlim([pretime-0.05 pretime+0.1]);
    ylim([-200 200])
    line([pretime pretime], ylim);
    lt_plot_zeroline;
    
    % -- raw (chan2)
    [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
    title(['[' dirfield ']' motifname '-ch' num2str(chan2)]);
    plot(t, datraw2(k,:), 'b');
    xlim([pretime-0.05 pretime+0.1]);
    ylim([-200 200])
    line([pretime pretime], ylim);
    lt_plot_zeroline;
    
%     % -- smoothed
%     [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
%     title(['[' dirfield ']' motifname '-ch' num2str(chan)]);
%     plot(t, datsm(k, :), 'k', 'LineWidth', 2);
%     xlim([pretime-0.05 pretime+0.1]);
%     ylim([0 50]);
%     line([pretime pretime], ylim);
%     lt_plot_zeroline;
end


% ========================= PLOT RAW DAT [compare 3 chans]
dirfield = 'DIR';
mm = 1;
chan1 = 9;
chan2 = 14;
chan3 = 21;

figcount=1;
subplotrows=8;
subplotcols=3;
fignums_alreadyused=[];
hfigs=[];

% -- chan1
datraw1 = DATSTRUCT.(dirfield).motifnum(mm).DatAllRaw{chan1};
% datsm1 = DATSTRUCT.(dirfield).motifnum(mm).DatAll{chan1};
datraw2 = DATSTRUCT.(dirfield).motifnum(mm).DatAllRaw{chan2};
datraw3 = DATSTRUCT.(dirfield).motifnum(mm).DatAllRaw{chan3};
% datsm2 = DATSTRUCT.(dirfield).motifnum(mm).DatAll{chan2};
t = DATSTRUCT.(dirfield).motifnum(mm).t;
assert(all(size(datraw1) == size(datraw2)), 'diff sample siezes?');
assert(all(size(datraw1) == size(datraw3)), 'diff sample siezes?');
for k =1 :size(datraw1,1)
    motifname = DATSTRUCT.(dirfield).motifnum(mm).motifname;
    
    % --- raw dat (chan1)   
    [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
    title(['[' dirfield ']' motifname '-ch' num2str(chan1)]);
    plot(t, datraw1(k,:), 'b');
    xlim([pretime-0.05 pretime+0.1]);
    ylim([-200 200])
    line([pretime pretime], ylim);
    lt_plot_zeroline;
    
    % -- raw (chan2)
    [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
    title(['[' dirfield ']' motifname '-ch' num2str(chan2)]);
    plot(t, datraw2(k,:), 'b');
    xlim([pretime-0.05 pretime+0.1]);
    ylim([-200 200])
    line([pretime pretime], ylim);
    lt_plot_zeroline;
    
        % --- raw dat (chan3)   
    [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
    title(['[' dirfield ']' motifname '-ch' num2str(chan3)]);
    plot(t, datraw3(k,:), 'b');
    xlim([pretime-0.05 pretime+0.1]);
    ylim([-200 200])
    line([pretime pretime], ylim);
    lt_plot_zeroline;
    

%     % -- smoothed
%     [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
%     title(['[' dirfield ']' motifname '-ch' num2str(chan)]);
%     plot(t, datsm(k, :), 'k', 'LineWidth', 2);
%     xlim([pretime-0.05 pretime+0.1]);
%     ylim([0 50]);
%     line([pretime pretime], ylim);
%     lt_plot_zeroline;
end


% ========================= PLOT
close all;
fs = 30000;
lt_neural_BatchSmthPLOT(DATSTRUCT, chanstoplot, motifstoplot, ...
    sylstoalign, pretime, posttime, plotRaw, fs)


%% PM neurons, 11/13/17
clear all; close all;
DATSTRUCT = struct;

% ============== 1) UNDIR
songdir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111317_Afternoon_DirUndir/UNDIR';
% where the songs and batch are located
batchf = 'batchall'; % contains .rhd names
chanstoplot = [9 14 17 21]; % chip channels. leave empty to get all
motifstoplot = {'abh', 'jbh', 'abhh', 'jbhh', 'abhhg', 'jbhhg'}; % cell arary of motifs, strings
sylstoalign = [3 3 4 4 5 5]; % which syl in that motif? (one for each motif
pretime = 0.1; % sec, from onset
posttime = 0.15; % sec, from offset
plotRaw = 0; % plot each extracted trial (raw, smoothed, and spec)

DATSTRUCT.UNDIR = lt_neural_BatchSmth(songdir, batchf, chanstoplot, motifstoplot, ...
    sylstoalign, pretime, posttime, plotRaw);


% ================= DIR
songdir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111317_Afternoon_DirUndir/DIR';
% where the songs and batch are located
batchf = 'batchall'; % contains .rhd names
chanstoplot = [9 14 17 21]; % chip channels. leave empty to get all
motifstoplot = {'abh', 'jbh', 'abhh', 'jbhh', 'abhhg', 'jbhhg'}; % cell arary of motifs, strings
sylstoalign = [3 3 4 4 5 5]; % which syl in that motif? (one for each motif
pretime = 0.1; % sec, from onset
posttime = 0.15; % sec, from offset
plotRaw = 0; % plot each extracted trial (raw, smoothed, and spec)
plotSpecifics = {'abh', 14}; % {motif, chan}
DATSTRUCT.DIR = lt_neural_BatchSmth(songdir, batchf, chanstoplot, motifstoplot, ...
    sylstoalign, pretime, posttime, plotRaw, plotSpecifics);


% ====== plot
close all;
fs = 30000;
lt_neural_BatchSmthPLOT(DATSTRUCT, chanstoplot, motifstoplot, ...
    sylstoalign, pretime, posttime, plotRaw, fs)


%% A) EVENING NEURONS ON 11/13
clear all; close all;
DATSTRUCT = struct;

% ============== 1) UNDIR
songdir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111317_Evening_DirUndir/UNDIR';
% where the songs and batch are located
batchf = 'batchall'; % contains .rhd names
chanstoplot = [9 14 21]; % chip channels. leave empty to get all
motifstoplot = {'abh', 'jbh', 'abhh', 'jbhh'}; % cell arary of motifs, strings
sylstoalign = [3 3 4 4]; % which syl in that motif? (one for each motif
pretime = 0.1; % sec, from onset
posttime = 0.15; % sec, from offset
plotRaw = 0; % plot each extracted trial (raw, smoothed, and spec)

DATSTRUCT.UNDIR = lt_neural_BatchSmth(songdir, batchf, chanstoplot, motifstoplot, ...
    sylstoalign, pretime, posttime, plotRaw);


% ================= DIR
songdir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111317_Evening_DirUndir/DIR';
% where the songs and batch are located
batchf = 'batchall'; % contains .rhd names
chanstoplot = [9 14 21]; % chip channels. leave empty to get all
motifstoplot = {'abh', 'jbh', 'abhh', 'jbhh'}; % cell arary of motifs, strings
sylstoalign = [3 3 4 4]; % which syl in that motif? (one for each motif
pretime = 0.1; % sec, from onset
posttime = 0.15; % sec, from offset
plotRaw = 0; % plot each extracted trial (raw, smoothed, and spec)
plotSpecifics = {'abh', 14}; % {motif, chan}
DATSTRUCT.DIR = lt_neural_BatchSmth(songdir, batchf, chanstoplot, motifstoplot, ...
    sylstoalign, pretime, posttime, plotRaw, plotSpecifics);


% ====== plot
close all;
fs = 30000;
lt_neural_BatchSmthPLOT(DATSTRUCT, chanstoplot, motifstoplot, ...
    sylstoalign, pretime, posttime, plotRaw, fs)

%% ##################################### LEARNING TRAJECTORY

%% calc FF for all syls, save next to song file
clear all; close all;

% ListOfDirs_UNDIR = {...
%     '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111217_Morning_DirUndir/UNDIR'};
% 
% ListOfDirs_DIR = {...
%     '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111217_Morning_DirUndir/DIR'};

ListOfDirs_UNDIR = {...
        '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111017_PreWN_DirUndir/UNDIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111017_Evening_DirUndir/UNDIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111117_Morning_DirUndir/UNDIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111117_Evening_DirUndir/UNDIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111217_Morning_DirUndir/UNDIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111317_Afternoon_DirUndir/UNDIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111317_Evening_DirUndir/UNDIR'};


ListOfDirs_DIR = {...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111017_PreWN_DirUndir/DIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111017_Evening_DirUndir/DIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111117_Morning_DirUndir/DIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111117_Evening_DirUndir/DIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111217_Morning_DirUndir/DIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111317_Afternoon_DirUndir/DIR', ...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111317_Evening_DirUndir/DIR'};

ListOfDirs_ALL = [ListOfDirs_UNDIR ListOfDirs_DIR];

ListOfBatch = {...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall', ...
    'batchall'};

FFparams.cell_of_freqwinds={'h', [3000 3800], 'b', [2900 3800]}; % 'j', [950 1450], 'l', [1200 1600], 't', [3590 4960]
FFparams.cell_of_FFtimebins={'h', [0.033 0.042], 'b', [0.033 0.045]}; % 'j', [0.04 0.045], 'l', [0.035 0.039], 't', [0.026 0.033], ...

plotAllPC = 1;
plotEachSyl = 0;

% ==================== CALCULATE AND SAVE FF
lt_batchsong_calcFF(ListOfDirs_ALL, ListOfBatch, FFparams, plotAllPC, plotEachSyl);

% ==== EXTRACT FF
MotifsToExtract = {'ab(h)', 'jb(h)'};
DATSTRUCT = lt_batchsong_extractFF(ListOfDirs_UNDIR, ListOfDirs_DIR, ListOfBatch, MotifsToExtract);


%% ============== PLOT
TrainON = '10Nov2017-1157';
subtractMean = 1;

TrainON_dnum = datenum(TrainON, 'ddmmmyyyy-HHMM');

figcount=1;
subplotrows=4;
subplotcols=2;
fignums_alreadyused=[];
hfigs=[];
hsplots = [];

for i = 1:length(MotifsToExtract);
    [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
    hsplots = [hsplots hsplot];
    title(MotifsToExtract{i});
    
    % ####################################### UNDIR
    inds = [DATSTRUCT.motif(i).rendnum.isDIR]==0;
    plotcol = 'k';
    
    % ----------------- RUN
    ffvals = [DATSTRUCT.motif(i).rendnum(inds).ff];
    tvals = [DATSTRUCT.motif(i).rendnum(inds).datenum_song_SecRes];
    
    % ------- subtract baseline FF
    if subtractMean==1
    baseinds = tvals < TrainON_dnum;
    ffvals = ffvals - mean(ffvals(baseinds));
    end
    
    % -- convert tvals to days from start
    firstday = datestr(floor(min(tvals)), 'ddmmmyyyy');
    tvals = lt_convert_EventTimes_to_RelTimes(firstday, tvals);
    tvals = tvals.FinalValue;
    
    % ----- plot
    plot(tvals, ffvals, 'o', 'Color', plotcol);
  
    % ----- plot day means
    numdays = floor(max(tvals));
    for j=1:numdays
       
        indstmp = floor(tvals)==j;
        tt = tvals(indstmp);
        ff = ffvals(indstmp);
        
        if isempty(ff)
            continue
        end
            
        lt_plot(max(tt)+0.1, mean(ff), {'Errors', lt_sem(ff), 'Color', plotcol});
    end
    
    % ####################################### DIR
    inds = [DATSTRUCT.motif(i).rendnum.isDIR]==1;
    plotcol = 'b';
    
    % ----------------- RUN
    ffvals = [DATSTRUCT.motif(i).rendnum(inds).ff];
    tvals = [DATSTRUCT.motif(i).rendnum(inds).datenum_song_SecRes];
    
    % ------- subtract baseline FF
    if subtractMean==1
    baseinds = tvals < TrainON_dnum;
    ffvals = ffvals - mean(ffvals(baseinds));
    end
    
    % -- convert tvals to days from start
    tvals = lt_convert_EventTimes_to_RelTimes(firstday, tvals);
    tvals = tvals.FinalValue;
    
    % ----- plot
    lt_plot(tvals, ffvals, {'Color', plotcol});
%      plot(tvals, ffvals, 'o', 'Color', plotcol);

        % ----- plot day means
    numdays = floor(max(tvals));
    for j=1:numdays
       
        indstmp = floor(tvals)==j;
        tt = tvals(indstmp);
        ff = ffvals(indstmp);
        
        if isempty(ff)
            continue
        end
            
        lt_plot(max(tt)+0.15, mean(ff), {'Errors', lt_sem(ff), 'Color', plotcol});
    end

    % ######################### lines
    % --- train onset
    tmp = lt_convert_EventTimes_to_RelTimes(firstday, TrainON_dnum);
    line([tmp.FinalValue tmp.FinalValue], ylim, 'Color', 'r');
    
    lt_plot_zeroline;
    
end
linkaxes(hsplots, 'xy');
    

