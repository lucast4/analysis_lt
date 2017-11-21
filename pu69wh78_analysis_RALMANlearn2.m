%% calc FF for all syls, save next to song file
clear all; close all;

% ListOfDirs_WNON = {...
%     '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111217_Morning_DirUndir/UNDIR'};
%
% ListOfDirs_WNOFF = {...
%     '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/111217_Morning_DirUndir/DIR'};


ListOfDirs_ALL = {...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/110517_RALMANlearn2'};

ListOfBatch = {...
    'batchall.LABELED'};

FFparams.cell_of_freqwinds={'a', [1000 2600], 'g', [2000 3400], ...
    'h', [2900 3800], 'b', [2900 3800]}; % 'j', [950 1450], 'l', [1200 1600], 't', [3590 4960]
FFparams.cell_of_FFtimebins={'a', [0.068 0.078], 'g', [0.04 0.06], ...
    'h', [0.033 0.042], 'b', [0.033 0.04]}; % 'j', [0.04 0.045], 'l', [0.035 0.039], 't', [0.026 0.033], ...

plotAllPC = 1;
plotEachSyl = 0;
overwrite = 0;

% ==================== CALCULATE AND SAVE FF
lt_batchsong_calcFF(ListOfDirs_ALL, ListOfBatch, FFparams, plotAllPC, plotEachSyl, ...
    overwrite);

%% ==== EXTRACT FF
MotifsToExtract = {'a(b)', 'j(b)', 'ab(h)', 'jb(h)',  'jbh(h)', '(g)'};
DATSTRUCT = lt_batchsong_extractFF(ListOfDirs_ALL, {}, ListOfBatch, MotifsToExtract);


%% ============== PLOT
close all;
TrainON = '05Nov2017-1125';
SwitchTimes = {'05Nov2017-1235', '05Nov2017-1355', '05Nov2017-1548', ...
    '05Nov2017-1811'}; % will places lines in plot at these times
subtractMean = 0;

lt_batchsong_plotFF(DATSTRUCT, MotifsToExtract, TrainON, SwitchTimes, subtractMean);

%% #############################
%% #############################  PLOT NEURAL CHANGES AT SWITCHES
%% ====================== SWITCH ONE (11:25a)
clear all; close all;
% ----- different datasets, each with different batch/dir combination
basedir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110517_RALMANlearn2/';
subdirs = {'', ''}; % these must be dirs within basedir. they will be used as fieldnames in extracted structure
Batchfiles = {'BatchSw1Pre', 'BatchSw1Post'}; % must be one for each subdir;
Conditions = {'base', 'WNon'};

% ------ params for all subdirs
chanstoplot = [9 14 17 21]; % chip channels. leave empty to get all
motifstoplot = {'(a)ab', 'a(a)b', 'a(b)', '(j)jb', 'j(j)b', 'jj(b)', ...
    'jb(h)', 'jbh(h)', 'h(g)'}; % cell arary of motifs, strings
% sylstoalign = [2 2 3 4 1]; % which syl in that motif? (one for each motif
pretime = 0.1; % sec, from onset
posttime = 0.1; % sec, from offset
plotRaw = 0; % plot each extracted trial (raw, smoothed, and spec)


DATSTRUCT = lt_neural_BatchSmthEXTRACT(basedir, subdirs, Batchfiles, chanstoplot, motifstoplot, ...
    '', pretime, posttime, plotRaw, Conditions);



%% ====================== SWITCH TWO (a)
close all;
% ----- different datasets, each with different batch/dir combination
basedir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110517_RALMANlearn2/';
subdirs = {'', ''}; % these must be dirs within basedir. they will be used as fieldnames in extracted structure
Batchfiles = {'BatchSw2Pre', 'BatchSw2Post'}; % must be one for each subdir;
Conditions = {'WNon', 'WNoff'};


DATSTRUCT = lt_neural_BatchSmthEXTRACT(basedir, subdirs, Batchfiles, chanstoplot, motifstoplot, ...
    '', pretime, posttime, plotRaw, Conditions);



%% ====================== SWITCH THREE
close all;
% ----- different datasets, each with different batch/dir combination
basedir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110517_RALMANlearn2/';
subdirs = {'', ''}; % these must be dirs within basedir. they will be used as fieldnames in extracted structure
Batchfiles = {'BatchSw3Pre', 'BatchSw3Post'}; % must be one for each subdir;
Conditions = {'WNoff', 'WNon'};

DATSTRUCT = lt_neural_BatchSmthEXTRACT(basedir, subdirs, Batchfiles, chanstoplot, motifstoplot, ...
    '', pretime, posttime, plotRaw, Conditions);

%% ====================== SWITCH FOUR
close all;
% ----- different datasets, each with different batch/dir combination
basedir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110517_RALMANlearn2/';
subdirs = {'', ''}; % these must be dirs within basedir. they will be used as fieldnames in extracted structure
Batchfiles = {'BatchSw4Pre', 'BatchSw4Post'}; % must be one for each subdir;
Conditions = {'WNon', 'WNoff'};

DATSTRUCT = lt_neural_BatchSmthEXTRACT(basedir, subdirs, Batchfiles, chanstoplot, motifstoplot, ...
    '', pretime, posttime, plotRaw, Conditions);


%% ====================== SWITCH FIVE
close all;
% ----- different datasets, each with different batch/dir combination
basedir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110517_RALMANlearn2/';
subdirs = {'', ''}; % these must be dirs within basedir. they will be used as fieldnames in extracted structure
Batchfiles = {'BatchSw5Pre', 'BatchSw5Post'}; % must be one for each subdir;
Conditions = {'WNoff', 'WNon'};

DATSTRUCT = lt_neural_BatchSmthEXTRACT(basedir, subdirs, Batchfiles, chanstoplot, motifstoplot, ...
    '', pretime, posttime, plotRaw, Conditions);

%%
% ======================== PLOT RAW
% go to:
lt_neural_BatchSmth_ALLPLOTS;

% ======================== XCOV OF FIRING BETWEEN CHANNELS
close all;
windowmax = 0.05;
binsize = 0.005;
premotorwind = [-0.035 0.025]; % use for ch14-21 on 11/12, morning.
% premotorwind = [-0.8 0.02];
chan1 = 14;
chan2 = 17;
mm = 1;
dirfield = 'WNon';

lt_neural_BatchSmthXCOV(DATSTRUCT, windowmax, binsize, premotorwind, chan1, ...
    chan2, mm, dirfield, pretime);


% ========================= PLOT
close all;
fs = 30000;
fnames  = fieldnames(DATSTRUCT);
chanstoplot = DATSTRUCT.(fnames{1}).params.chanstoplot;
motifstoplot = DATSTRUCT.(fnames{1}).params.Motifstoplot;
motifstoplot = {'a(b)', 'j(b)'};
lt_neural_BatchSmthPLOT(DATSTRUCT, chanstoplot, motifstoplot, ...
    '', pretime, posttime, plotRaw, fs)


%% ================ COMBINE MULTIPLE SWITCHES AND PLOT
clear all; close all;

basedir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110517_RALMANlearn2/';
ListOfDatstructs = {...
    'DATSTRUCT_BatchSm_16Nov2017_2047',...
    'DATSTRUCT_BatchSm_16Nov2017_2052', ...
    'DATSTRUCT_BatchSm_16Nov2017_2059', ...
    'DATSTRUCT_BatchSm_16Nov2017_2108', ...
    'DATSTRUCT_BatchSm_16Nov2017_2115'};


DATAllSwitches = struct;
for i=1:length(ListOfDatstructs)
    
    datstruct = load([basedir ListOfDatstructs{i}]);
    dirfields = fieldnames(datstruct.DATSTRUCT);
    
    DATAllSwitches.switch(i).datstructname = ListOfDatstructs{i};
    DATAllSwitches.switch(i).basedir = basedir;
    DATAllSwitches.switch(i).params = datstruct.DATSTRUCT.(dirfields{1}).params;
    
    % ---- figure out order of dirfields (chronoligcla)
    tmins = []; % first and last song in each field
    tmaxs = [];
    for dd = 1:length(dirfields)
        t = datstruct.DATSTRUCT.(dirfields{dd}).motifnum(1).t;
        
        tmins = [tmins min(t)];
        tmaxs = [tmaxs max(t)];
    end
    [~, inds1] = sort(tmins);
    [~, inds2] = sort(tmaxs);
    assert(all(inds1 == inds2), 'mixed ordering ...');
    dirfields = dirfields(inds1); % put in correct order!
    
    
    % =============== for each channel and motif, plot post and pre
    nummotifs = length(datstruct.DATSTRUCT.(dirfields{1}).motifnum);
    allchans = find(~cellfun('isempty', datstruct.DATSTRUCT.(dirfields{1}).motifnum(1).DatAll));
    
    for mm = 1:nummotifs
        
        %         for cc = allchans
        %
        %             for dd =1:length(dirfields)
        %             Datsm = datstruct.DATSTRUCT.(dirfields{dd}).motifnum(mm).DatAll{cc};
        %             datstruct.DATSTRUCT.(dirfields{dd}).motifnum(mm)
        %
        %             % ========= out
        %             DATAllSwitches.switch(i).motif(mm).chan(cc).batchinorder(dd).condition = dirfields{dd};
        %             DATAllSwitches.switch(i).motif(mm).chan(cc).batchinorder(dd).Datsm = Datsm;
        %
        %
        %             DATAllSwitches.switch(i).motif(mm).chan(cc).batchinorder(dd) = ...
        %                 datstruct.DATSTRUCT.(dirfields{dd}).motifnum(mm);
        %             end
        %         end
        
        DATAllSwitches.switch(i).motif(mm).batchinorder = [];
        
        for dd =1:length(dirfields)
            
            datstruct.DATSTRUCT.(dirfields{dd}).motifnum(mm).condition = dirfields{dd};
            
            
            % ========= out
            DATAllSwitches.switch(i).motif(mm).batchinorder = ...
                [DATAllSwitches.switch(i).motif(mm).batchinorder ...
                datstruct.DATSTRUCT.(dirfields{dd}).motifnum(mm)];
        end
        
    end
end


% ====================== SAVE
fname = [basedir 'DATSTRUCT_BatchSmCombined.mat'];
save(fname, 'DATAllSwitches', '-v7.3');


%% ====================== PLOT RAW FOR EACH CHANNEL
close all;
motiftoplot = 'j(j)b';
chanstoplot = find(~cellfun('isempty', DATAllSwitches.switch(1).motif(1).batchinorder(1).DatAll));

for cc = chanstoplot
    for i=1:length(DATAllSwitches.switch)
        
        nummotifs = length(DATAllSwitches.switch(i).motif);
        
        for ii=1:nummotifs
            
            numbatches = length(DATAllSwitches.switch(i).motif(ii).batchinorder);
            figcount=1;
            subplotrows=6;
            subplotcols=3;
            fignums_alreadyused=[];
            hfigs=[];
            hsplots = [];
            
            if ~strcmp(DATAllSwitches.switch(i).motif(ii).batchinorder(1).motifname, ...
                    motiftoplot)
                continue
            end
            for bb = 1:numbatches
                
                
                motif = DATAllSwitches.switch(i).motif(ii).batchinorder(bb).motifname;
                cond = DATAllSwitches.switch(i).motif(ii).batchinorder(bb).condition;
                % ========= plot
                datmat = DATAllSwitches.switch(i).motif(ii).batchinorder(bb).DatAllRaw{cc};
                t = DATAllSwitches.switch(i).motif(ii).batchinorder(bb).t;
                
                for j = 1:size(datmat,1);
                    [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
                    hsplots = [hsplots hsplot];
                    title(['ch' num2str(cc) ',' motif ',sw' num2str(i) ',[' cond ']']);
                    
                    plot(t, datmat(j,:), 'k');
                    axis tight;
                    ylim([-175 175]);
                end
                
            end
            
            %             linkaxes(hsplots, 'xy');
            pause;
            close all;
            
        end
        
    end
end

%% ==== 1) PLOT, each channel, plot each trial + mean, comparing conditions
close all;

% ====== input params
motifstoplot = {'ab', 'jb'}; % if empty, plots all
fs = 30000;


chanstoplot = find(~cellfun('isempty', DATAllSwitches.switch(1).motif(1).batchinorder(1).DatAll));
numswitches = length(DATAllSwitches.switch);
nummotifs = length(DATAllSwitches.switch(1).motif);

for cc = chanstoplot
    
    for mm = 1:nummotifs
        
        motif = DATAllSwitches.switch(1).motif(mm).batchinorder(1).motifname;
        if ~isempty(motifstoplot)
            if ~any(ismember(motifstoplot, motif))
                continue
            end
        end
        
        figcount=1;
        subplotrows=4;
        subplotcols=6;
        fignums_alreadyused=[];
        hfigs=[];
        hsplots = [];
        
        for i=1:numswitches
            
            DatMeans ={};
            DatSEMs = {};
            CondAll = {};
            
            for bb = 1:length(DATAllSwitches.switch(i).motif(mm).batchinorder)
                % i.e., each batch corresponds to a "condition" (e.g.
                % WNon/off; or DIR/UNDIR);
                datmat = DATAllSwitches.switch(i).motif(mm).batchinorder(bb).DatAll{cc};
                t = DATAllSwitches.switch(i).motif(mm).batchinorder(bb).t;
                FF = DATAllSwitches.switch(i).motif(mm).batchinorder(bb).FF;
                cond = DATAllSwitches.switch(i).motif(mm).batchinorder(bb).condition;
                motif = DATAllSwitches.switch(i).motif(mm).batchinorder(bb).motifname;
                
                
                try
                    pretime = DATAllSwitches.switch(i).params.pretime;
                    pretime = pretime/fs;
                catch err
                    disp('NOTE!!! making pretime 0.1');
                    pretime = 0.1;
                end
                
                % ======== plot all dats, and overlay median
                [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
                hsplots = [hsplots hsplot];
                title(['ch' num2str(cc) '-sw' num2str(i) '-' motif '[' cond ']']);
                
                plot(t, datmat, 'Color', [0.7 0.7 0.7]);
                % -- overlay median, with 75th tiles
                datmedian = median(datmat,1);
                datSEM = lt_sem(datmat);
                shadedErrorBar(t, datmedian, datSEM, {'Color','r'}, 1);
                line([pretime pretime],ylim);
                lt_plot_zeroline;
                axis tight;
                
                % ============ save
                DatMeans = [DatMeans datmedian];
                DatSEMs = [DatSEMs datSEM];
                CondAll = [CondAll cond];
            end
            
            % ================= PLOT EACH BATCH'S MEAN, OVERLAYED
            [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
            hsplots = [hsplots hsplot];
            
            for bb = 1:length(DatMeans)
                
                if strcmp(CondAll{bb}, 'WNon')
                    plotcol = 'r';
                elseif strcmp(CondAll{bb}, 'DIR')
                    plotcol = 'b';
                else
                    plotcol = 'k';
                end
                
                shadedErrorBar(t, DatMeans{bb}, DatSEMs{bb}, {'Color', plotcol}, 1);
                line([pretime pretime],ylim);
                lt_plot_zeroline;
                axis tight;
            end
            
        end
        linkaxes(hsplots, 'xy');
    end
end

%% ==== for each channel, PLOT get deviation for each switch, distribution across switches

close all;

% ====== input params
motifstoplot = {'ab', 'jb', 'g'}; % if empty, plots all
fs = 30000;


chanstoplot = find(~cellfun('isempty', DATAllSwitches.switch(1).motif(1).batchinorder(1).DatAll));
numswitches = length(DATAllSwitches.switch);
nummotifs = length(DATAllSwitches.switch(1).motif);
assert(length(DATAllSwitches.switch(1).motif(1).batchinorder)==2, 'note, this code wont work since tries to take diference');


for cc = chanstoplot
    
    figcount=1;
    subplotrows=4;
    subplotcols=6;
    fignums_alreadyused=[];
    hfigs=[];
    hsplots = [];
    for mm = 1:nummotifs
        
        motif = DATAllSwitches.switch(1).motif(mm).batchinorder(1).motifname;
        if ~isempty(motifstoplot)
            if ~any(ismember(motifstoplot, motif))
                continue
            end
        end
        
        
        DprimeAll = []; % one collect, one row for each switch
        
        for i=1:numswitches
            
            DatMeans ={};
            DatMedians = {};
            DatSEMs = {};
            CondAll = {};
            DatSTDs = {};
            for bb = 1:length(DATAllSwitches.switch(i).motif(mm).batchinorder)
                % i.e., each batch corresponds to a "condition" (e.g.
                % WNon/off; or DIR/UNDIR);
                datmat = DATAllSwitches.switch(i).motif(mm).batchinorder(bb).DatAll{cc};
                t = DATAllSwitches.switch(i).motif(mm).batchinorder(bb).t;
                FF = DATAllSwitches.switch(i).motif(mm).batchinorder(bb).FF;
                cond = DATAllSwitches.switch(i).motif(mm).batchinorder(bb).condition;
                motif = DATAllSwitches.switch(i).motif(mm).batchinorder(bb).motifname;
                
                try
                    pretime = DATAllSwitches.switch(i).params.pretime;
                    pretime = pretime/fs;
                catch err
                    disp('NOTE!!! making pretime 0.1');
                    pretime = 0.1;
                end
                
                % --- [INDIVIDUAL TRIALS] mean FR in a premotor window
                
                
                % --- [STATS FOR THIS SWITCH]
                datmedian = median(datmat,1);
                datmean = mean(datmat,1);
                datSTD = std(datmat);
                datSEM = lt_sem(datmat);
                
                
                
                
                % ============ save
                DatMeans = [DatMeans datmean];
                DatSEMs = [DatSEMs datSEM];
                CondAll = [CondAll cond];
                DatSTDs = [DatSTDs datSTD];
                DatMedians = [DatMedians datmedian];
            end
            
            % ----------- take difference of means, scaled by standard
            % deviation (d')
            numer = (DatMeans{2}-DatMeans{1});
            denom = sqrt(0.5*(DatSTDs{1}.^2 + DatSTDs{2}.^2));
            dprime = numer./denom;
            
            medianDiff = DatMedians{2} - DatMedians{1};
            
            [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
            hsplots = [hsplots hsplot];
            title(['ch' num2str(cc) '-sw' num2str(i) '-' motif '[' CondAll{2} 'minus' CondAll{1} ']']);
            ylabel('dprime');
            
            plot(t, dprime, 'k');
            
            line([pretime pretime],ylim);
            lt_plot_zeroline;
            axis tight;
            
            % ================= collect
            DprimeAll = [DprimeAll; dprime];
            
        end
        
        [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
        hsplots = [hsplots hsplot];
        title('mean of abs');
        shadedErrorBar(t, mean(abs(DprimeAll),1), lt_sem(abs(DprimeAll)), {'Color', 'r'}, 1);
        
        % ======== mean for this motif, across all switches
        
        linkaxes(hsplots, 'xy');
    end
end


close all;

%% ====== INDIVIDUAL TRIALS
motifstoplot = {'ab', 'jb', 'g'}; % if empty, plots all
fs = 30000;
premotor_window = [-0.035 0.025]; % rel onset

chanstoplot = find(~cellfun('isempty', DATAllSwitches.switch(1).motif(1).batchinorder(1).DatAll));
numswitches = length(DATAllSwitches.switch);
nummotifs = length(DATAllSwitches.switch(1).motif);
assert(length(DATAllSwitches.switch(1).motif(1).batchinorder)==2, 'note, this code wont work since tries to take diference');


for cc = chanstoplot
    
    figcount=1;
    subplotrows=4;
    subplotcols=6;
    fignums_alreadyused=[];
    hfigs=[];
    for mm = 1:nummotifs
        
        motif = DATAllSwitches.switch(1).motif(mm).batchinorder(1).motifname;
        if ~isempty(motifstoplot)
            if ~any(ismember(motifstoplot, motif))
                continue
            end
        end
        
        
        FrateAllAll = []; % all trials for this motif and chan (i.e. across all switches)
        PitchAllAll = [];
        hsplots1 = [];
        hsplots2 = [];
        
        for i=1:numswitches
            
            CondAll = {}; % one entry for each block
            condmat = []; % one entry fro each trial
            FrateAllTrials = [];
            PitchAllTrials = [];
            
            for bb = 1:length(DATAllSwitches.switch(i).motif(mm).batchinorder)
                % i.e., each batch corresponds to a "condition" (e.g.
                % WNon/off; or DIR/UNDIR);
                datmat = DATAllSwitches.switch(i).motif(mm).batchinorder(bb).DatAll{cc};
                t = DATAllSwitches.switch(i).motif(mm).batchinorder(bb).t;
                FF = DATAllSwitches.switch(i).motif(mm).batchinorder(bb).FF;
                cond = DATAllSwitches.switch(i).motif(mm).batchinorder(bb).condition;
                motif = DATAllSwitches.switch(i).motif(mm).batchinorder(bb).motifname;
                
                try
                    pretime = DATAllSwitches.switch(i).params.pretime;
                    pretime = pretime/fs;
                catch err
                    disp('NOTE!!! making pretime 0.1');
                    pretime = 0.1;
                end
                
                % --- [INDIVIDUAL TRIALS] mean FR in a premotor window
                windwind = premotor_window+pretime;
                indtmp = t>=windwind(1) & t<windwind(2);
                FrateAllTrials = [FrateAllTrials; mean(datmat(:,indtmp),2)];
                PitchAllTrials = [PitchAllTrials; FF];
                condmat = [condmat; bb*ones(size(FF))];
                
                CondAll = [CondAll cond]; % length 2
                
                % -------------- collect across all switches
                FrateAllAll = [FrateAllAll; mean(datmat(:,indtmp),2)]; % all trials for this motif and chan (i.e. across all switches)
                PitchAllAll = [PitchAllAll; FF];
                
            end
            
            % =================== 1) PLOT regression, Frate vs. FF (including
            % both pre and post switch)
            [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
            hsplots1 = [hsplots1 hsplot];
            ylabel('Frate vs. Pitch');
            title(['ch' num2str(cc) '-sw' num2str(i) '-' motif '[' CondAll{2} '(r)-' CondAll{1} '(k)]']);
            hold on;
            indstmp = condmat==1;
            plotcol = 'k';
            plot(PitchAllTrials(indstmp), FrateAllTrials(indstmp), 'o', 'Color', plotcol);
            indstmp = condmat==2;
            plotcol = 'r';
            plot(PitchAllTrials(indstmp), FrateAllTrials(indstmp), 'o', 'Color', plotcol);
            hold on;
            lt_regress(FrateAllTrials, PitchAllTrials, 0, 0, 1, 1, 'b', 1)
            axis tight
            
            
            % =================== 2) cross correaltion Frate and FF
            [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
            hsplots2 = [hsplots2 hsplot];
            title('xcov, left is frate leads');
            xlabel('frate <--> pitch');
            windowmax = 10;
            binsize=1;
            [xx, lags] = xcov(FrateAllTrials, PitchAllTrials, ceil(windowmax/binsize), 'coeff');
            plot(lags*binsize, xx, '-k');
            lt_plot_zeroline;
        end
        
        % ======== across all switches
        % ------------- 1) regression
        [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
        hsplots1 = [hsplots1 hsplot];
        ylabel('Frate vs. Pitch');
        title('ALL SWITCHES');
        lt_regress(FrateAllAll, PitchAllAll, 1, 0, 1, 1, 'b', 1)
        axis tight
        
        % --------------- 2) xcov
        [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
        hsplots2 = [hsplots2 hsplot];
        title('ALL TRIALS');
        xlabel('frate <--> pitch');
        windowmax = 10;
        binsize=1;
        [xx, lags] = xcov(FrateAllAll, PitchAllAll, ceil(windowmax/binsize), 'coeff');
        plot(lags*binsize, xx, '-k', 'LineWidth', 2);
        lt_plot_zeroline;
        
        linkaxes(hsplots1, 'xy');
        linkaxes(hsplots2, 'xy');
        
    end
    
end


%% ======================== CALCULATE CROSS COV BETWEEN BRAIN REGIONS
close all;
motifstoplot = {'ab', 'jb', 'g'};
motifstoplot = {'a(b)'};
windowmax = 0.04;
binsize = 0.002;
premotorwind = [-0.035 0.025]; % use for ch14-21 on 11/12, morning.
fs = 30000;
plotRawDatOnly = 0;

numswitches = length(DATAllSwitches.switch);

% --------- gaussian for smothing
if (0)
    windowsize=0.005; % from -2sd to +2sd
    sigma=(windowsize/4)*fs; %
    numsamps=4*sigma; % (get 2 std on each side)
    if mod(numsamps,2)==1
        numsamps = numsamps-1;
    end
    
    alpha= numsamps/(2*sigma); % N/2sigma
    gaussFilter = gausswin(numsamps, alpha);
    gaussFilter = gaussFilter / sum(gaussFilter); % Normalize.
end

for k = 1:length(chanstoplot)
    chan1 = chanstoplot(k);
    
    for kk=k+1:length(chanstoplot)
        
        chan2 = chanstoplot(kk);
        
        for mm = 1:nummotifs
            
            motif = DATAllSwitches.switch(1).motif(mm).batchinorder(1).motifname;
            if ~isempty(motifstoplot)
                if ~any(ismember(motifstoplot, motif))
                    continue
                end
            end
            
            % ====================== on figure for each motif
            figcount=1;
            if plotRawDatOnly==1
                subplotrows=5;
                subplotcols=3;
            else
                subplotrows=3;
                subplotcols=5;
            end
            fignums_alreadyused=[];
            hfigs=[];
            hsplots1 = [];
            hsplots2 = [];
            hsplots3 = [];
            
            for i=1:numswitches
                
                for bb = 1:length(DATAllSwitches.switch(i).motif(mm).batchinorder)
                    
                    % ================= for this channel pair, motif, and
                    % switch, get xcov in block preceding and following
                    % switch
                    cond = DATAllSwitches.switch(i).motif(mm).batchinorder(bb).condition;
%                     datmat1 = DATAllSwitches.switch(i).motif(mm).batchinorder(bb).DatAllRaw{chan1};
%                     datmat2 = DATAllSwitches.switch(i).motif(mm).batchinorder(bb).DatAllRaw{chan2};
                    datmat1 = DATAllSwitches.switch(i).motif(mm).batchinorder(bb).DatAll{chan1};
                    datmat2 = DATAllSwitches.switch(i).motif(mm).batchinorder(bb).DatAll{chan2};
                    t =  DATAllSwitches.switch(i).motif(mm).batchinorder(bb).t;
                    
                    
                    
                    % ================= PLOT RAW DAT TO DETERMINE
                    % APPROPRIATE WINDOW TO TAKE TO AVOID NOISE
                    if plotRawDatOnly ==1
                        
                        numtrials = size(datmat1,1);
                        for tt=1:numtrials
                            
                            tTMP = (1/fs)*(1:size(datmat1,2));
                            [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
                            hsplots3 = [hsplots3 hsplot];
                            title(['ch' num2str(chan1) '(k)vs' num2str(chan2) '(r), ' ...
                                motif ',sw' num2str(i) '[' cond ']']);
                            plot(tTMP, datmat1(tt,:), 'r');
                            plot(tTMP, datmat2(tt,:)+200, 'k');
                            axis tight
                        end
                        
                    else
                        
                        % ========== smooth rectify with small window
                        if (0)
                            datmat1 = abs(datmat1);
                            for nn =1:size(datmat1,1)
                                tmp = conv(datmat1(nn,:), gaussFilter);
                                tmp = tmp(:,numsamps/2:end-numsamps/2);
                                datmat1(nn,:) = tmp;
                                
                            end
                            %                         % -- clip off edges
                            %                         datmat1 = datmat1(:,numsamps/2:end-numsamps/2);
                            %
                            datmat2 = abs(datmat2);
                            for nn =1:size(datmat1,1)
                                tmp = conv(datmat2(nn,:), gaussFilter);
                                tmp = tmp(:,numsamps/2:end-numsamps/2);
                                datmat2(nn,:) = tmp;
                            end
                            
                        else
                            datmat1 = abs(datmat1);
                            datmat2 = abs(datmat2);
                        end
                        
                        
                        
                        
                        % =================== cut off to premotor window
                        t = DATAllSwitches.switch(i).motif(mm).batchinorder(bb).t;
                        try
                            pretime = DATAllSwitches.switch(i).params.pretime;
                            pretime = pretime/fs;
                        catch err
                            disp('NOTE!!! making pretime 0.1');
                            pretime = 0.1;
                        end
                        
                        % --------- 
                        tmp = pretime+premotorwind;
                        indstmp = t>=tmp(1) & t<=tmp(2);
                        datmat1 = datmat1(:, indstmp);
                        datmat2 = datmat2(:, indstmp);
                        t = t(indstmp);
                        assert(all(size(datmat1)==size(datmat2)), 'asdfasd');
                        
                        
                        % ---------------- bin activity
                        TrimDown = 1;
                        
                        [datmat1, xtimes] = lt_neural_v2_QUICK_binFR(datmat1, t, binsize, TrimDown);
                        [datmat2, xtimes] = lt_neural_v2_QUICK_binFR(datmat2, t, binsize, TrimDown);
                        
                        
                        % =================== calculate xcov
                        CCall = [];
                        numtrials = size(datmat2,1);
                        for tt=1:numtrials
                            [cc, lags] = xcov(datmat1(tt,:), datmat2(tt,:), ceil(windowmax/binsize), 'coeff');
                            CCall = [CCall; cc];
                        end
                        
                        % ================= calcualte xcov (shifted)
                        CCallSHUFFLE = [];
                        for tt=1:numtrials
                            
                            d1 = datmat1(tt,:);
                            if tt==numtrials
                                d2 = datmat2(1,:);
                            else
                                d2 = datmat2(tt+1,:);
                            end
                            
                            [cc, lags] = xcov(d1, d2, ceil(windowmax/binsize), 'coeff');
                            CCallSHUFFLE = [CCallSHUFFLE; cc];
                        end
                        
                        
                        % ===================== calculate noise correlation
                        frate1 = mean(datmat1,2);
                        frate2 = mean(datmat2,2);
                        windfrate = 10; % num trials
                        binfrate = 1; % trials shift
                        
                        [ccfrate, lagfrate] = xcov(frate1, frate2, ceil(windfrate/binfrate), 'coeff');
                        
                        
                        
                        % ========================= PLOT ALL TRIALS [activity
                        % xcov]
                        [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
                        hsplots1 = [hsplots1 hsplot];
                        title(['ch' num2str(chan1) 'vs' num2str(chan2) ', ' motif ',sw' num2str(i) '[' cond ']']);
                        plot(lags*binsize, CCall, 'Color', [0.7 0.7 0.7]);
                        lt_plot(lags*binsize, mean(CCall,1), {'Errors', lt_sem(CCall)});
                        lt_plot_zeroline;
                        
                        % --- overlay shifted
                        shadedErrorBar(lags*binsize, mean(CCallSHUFFLE,1), lt_sem(CCallSHUFFLE), ...
                            {'Color', [0.9 0.6 0.6]},1);
                        
                        
                        % ========================= PLOT ALL TRIALS [noise corr]
                        [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
                        hsplots2 = [hsplots2 hsplot];
                        title('FRATE OVER TRIALS');
                        plot(lagfrate*binfrate, ccfrate, '-r');
                        lt_plot_zeroline;
                    end
                end
            end
            if plotRawDatOnly==1
                linkaxes(hsplots3, 'xy');
            end
            linkaxes(hsplots1, 'xy');
            linkaxes(hsplots2, 'xy');
            pause;
            close all;
        end
        
    end
end


if (0)
    % FOR PLOTTING DIAGNOSIS - comparing differeing smoothing and binning
        lt_figure; hold on;
    binsize = 0.001
    windowsize=0.005; % from -2sd to +2sd
    sigma=(windowsize/4)*fs; %
    numsamps=4*sigma; % (get 2 std on each side)
    if mod(numsamps,2)==1
        numsamps = numsamps-1;
    end
    
    alpha= numsamps/(2*sigma); % N/2sigma
    gaussFilter = gausswin(numsamps, alpha);
    gaussFilter = gaussFilter / sum(gaussFilter); % Normalize.

DATMAT = datmat2;

                            datmat1 = abs(DATMAT);
                            for nn =1:size(datmat1,1)
                                tmp = conv(datmat1(nn,:), gaussFilter);
                                tmp = tmp(:,numsamps/2:end-numsamps/2);
                                datmat1(nn,:) = tmp;
                                
                            end

                          % ---------------- bin activity
                        TrimDown = 1;
                        [X, xtimes] = lt_neural_v2_QUICK_binFR(datmat1, t, binsize, TrimDown);
                        
plot(t, abs(DATMAT(1,:)));
plot(t, datmat1(1,:), 'k', 'LineWidth', 2);
plot(xtimes, X(1,:), 'o-r', 'LineWidth', 2);
end