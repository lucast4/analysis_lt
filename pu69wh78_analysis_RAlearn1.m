%% calc FF for all syls, save next to song file
clear all; close all;

ListOfDirs_ALL = {...
    '/bluejay5/lucas/birds/pu69wh78/NEURAL/103017_RAlearn1'};

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

%% plot ff
close all;
TrainON = '30Oct2017-1430';
SwitchTimes = {};
subtractMean = 1;
dozscore =1 ;

lt_batchsong_plotFF(DATSTRUCT, MotifsToExtract, TrainON, SwitchTimes, subtractMean, ...
    dozscore);

%% ============== PLOT
% close all;
% TrainON = '30Oct2017-1430';
% SwitchTimes = {}; % will places lines in plot at these times
% subtractMean = 1;
% 
% TrainON_dnum = datenum(TrainON, 'ddmmmyyyy-HHMM');
% 
% figcount=1;
% subplotrows=4;
% subplotcols=1;
% fignums_alreadyused=[];
% hfigs=[];
% hsplots = [];
% 
% for i = 1:length(MotifsToExtract);
%     [fignums_alreadyused, hfigs, figcount, hsplot]=lt_plot_MultSubplotsFigs('', subplotrows, subplotcols, fignums_alreadyused, hfigs, figcount);
%     hsplots = [hsplots hsplot];
%     title(MotifsToExtract{i});
%     
%     % ####################################### UNDIR
%     inds = [DATSTRUCT.motif(i).rendnum.isDIR]==0;
%     plotcol = 'k';
%     
%     % ----------------- RUN
%     ffvals = [DATSTRUCT.motif(i).rendnum(inds).ff];
%     tvals = [DATSTRUCT.motif(i).rendnum(inds).datenum_song_SecRes];
%     
%     % ------- subtract baseline FF
%     if subtractMean==1
%     baseinds = tvals < TrainON_dnum;
%     ffvals = ffvals - mean(ffvals(baseinds));
%     end
%     
%     % -- convert tvals to days from start
%     firstday = datestr(floor(min(tvals)), 'ddmmmyyyy');
%     tvals = lt_convert_EventTimes_to_RelTimes(firstday, tvals);
%     tvals = tvals.FinalValue;
%     
%     % ----- plot
%     plot(tvals, ffvals, 'o', 'Color', plotcol);
%   
%     % ----- plot day means
%     numdays = floor(max(tvals));
%     for j=1:numdays
%        
%         indstmp = floor(tvals)==j;
%         tt = tvals(indstmp);
%         ff = ffvals(indstmp);
%         
%         if isempty(ff)
%             continue
%         end
%             
%         lt_plot(max(tt)+0.1, mean(ff), {'Errors', lt_sem(ff), 'Color', plotcol});
%     end
%     
%         % ######################### lines
%     % --- train onset
%     tmp = lt_convert_EventTimes_to_RelTimes(firstday, TrainON_dnum);
%     line([tmp.FinalValue tmp.FinalValue], ylim, 'Color', 'r');
%     
%     for j=1:length(SwitchTimes)
%         tmp = lt_convert_EventTimes_to_RelTimes(firstday, datenum(SwitchTimes{j}, 'ddmmmyyyy-HHMM'));
%         line([tmp.FinalValue tmp.FinalValue], ylim, 'Color', 'm');
%     end
%     lt_plot_zeroline;
% 
%     
%     % ####################################### DIR
%     inds = [DATSTRUCT.motif(i).rendnum.isDIR]==1;
%     if ~any(inds)
%         continue
%     end
%     plotcol = 'b';
%     
%     % ----------------- RUN
%     ffvals = [DATSTRUCT.motif(i).rendnum(inds).ff];
%     tvals = [DATSTRUCT.motif(i).rendnum(inds).datenum_song_SecRes];
%     
%     % ------- subtract baseline FF
%     if subtractMean==1
%     baseinds = tvals < TrainON_dnum;
%     ffvals = ffvals - mean(ffvals(baseinds));
%     end
%     
%     % -- convert tvals to days from start
%     tvals = lt_convert_EventTimes_to_RelTimes(firstday, tvals);
%     tvals = tvals.FinalValue;
%     
%     % ----- plot
%     lt_plot(tvals, ffvals, {'Color', plotcol});
% %      plot(tvals, ffvals, 'o', 'Color', plotcol);
% 
%         % ----- plot day means
%     numdays = floor(max(tvals));
%     for j=1:numdays
%        
%         indstmp = floor(tvals)==j;
%         tt = tvals(indstmp);
%         ff = ffvals(indstmp);
%         
%         if isempty(ff)
%             continue
%         end
%             
%         lt_plot(max(tt)+0.15, mean(ff), {'Errors', lt_sem(ff), 'Color', plotcol});
%     end
% 
%     
% end
% linkaxes(hsplots, 'xy');
    

%% ############################# 
%% #############################  PLOT NEURAL CHANGES AT SWITCHES
%% ====================== SWITCH ONE (WN on)
clear all; close all;
% ----- different datasets, each with different batch/dir combination
basedir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/103017_RAlearn1/';
subdirs = {'', ''}; % these must be dirs within basedir. they will be used as fieldnames in extracted structure
Batchfiles = {'BatchSw1Pre', 'BatchSw1Post'}; % must be one for each subdir;
Conditions = {'base', 'WNon'};

% ------ params for all subdirs
chanstoplot = [17 18 21]; % chip channels. leave empty to get all
motifstoplot = {'(a)ab', 'a(a)b', 'a(b)', '(j)jb', 'j(j)b', 'jj(b)', 'abhh(g)', 'jbhh(g)'}; % cell arary of motifs, strings
pretime = 0.1; % sec, from onset
posttime = 0.15; % sec, from offset
plotRaw = 0; % plot each extracted trial (raw, smoothed, and spec)


DATSTRUCT = lt_neural_BatchSmthEXTRACT(basedir, subdirs, Batchfiles, chanstoplot, motifstoplot, ...
    '', pretime, posttime, plotRaw, Conditions);


%% ##################################### 2) COMBINE MULTIPLE SWITCHES BY HAND
clear all; close all;

basedir = '/bluejay5/lucas/birds/pu69wh78/NEURAL/103017_RAlearn1/';
ListOfDatstructs = {...
    'DATSTRUCT_BatchSm_18Nov2017_1503.mat'};


DATAllSwitches = lt_neural_BatchSmthCOMPILE(basedir, ListOfDatstructs);


%% ==== 1) PLOT, each channel, plot each trial + mean, comparing conditions
close all;
plotRaw = 1; % if 1, then plots all trials and blocks overlaied. if 0 then goes straight to cross corr summary.
motifstoplot = {}; % if empty, plots all
premotor_wind = [-0.03 0.02]; % for cross correlation (rel syl onset);

lt_neural_BatchSmth_Premotor(DATAllSwitches, motifstoplot, premotor_wind, plotRaw)

