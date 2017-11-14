%% ==== 11/10/17 -quick comparison of units 
% over sleep (night 1), awake (singing) and sleep (night 2)
clear all; close all;
fname_BOSnight1 = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/BOS_110917Night/pu69wh78_171109_233141.rhd';
fname_BOSnight2 = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/BOS_111017Night/pu69wh78_171111_010625.rhd';
fname_SONGmorning = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/pu69wh78_171110_092648.rhd';
fname_SONGevening = '/bluejay5/lucas/birds/pu69wh78/NEURAL/110917_RALMANOvernightLearn1/pu69wh78_171110_210810.rhd';
% pu69wh78_171110_210340.rhd
% pu69wh78_171110_210522.rhd
% pu69wh78_171110_210810.rhd
chanstoplot = [9 14 21];

fnames = {fname_BOSnight1, fname_BOSnight2, fname_SONGmorning, fname_SONGevening};

for i=1:length(fnames)

filename=fnames{i};
ChansToPlot.DigChans_zero=[0]; % make string "all" to plot all that exist. empty array to ignore
ChansToPlot.AnalogChans_zero=[0]; % assumes that this is audio
% ChansToPlot.AmpChans_zero=[9 14 19];
ChansToPlot.AmpChans_zero=[9 11 12 14 1 18];
% ChansToPlot.AmpChans_zero=[8 9 11 16 17 20 21];
ChansToPlot.AmpChans_zero=[9 14 21];

% neuralFiltLow=500;
neuralFiltLow=300;

PlotWhat.raw=0;
PlotWhat.filt=1;
PlotWhat.rect_sm=1;
PlotWhat.raster=0;
PlotWhat.digital=0;

Rect_sm.windowsize=0.03; % in sec, size of window, equals -2 to +2 sd.
Raster.ThrXNoise=4; % threshold for units, used for all channels, uses absolute data for peak detection
Raster.PosOrNeg=-1; % -1 or +1, for crossings.

        numsubplots = length(chanstoplot);

lt_neural_alignRawDat(filename, ChansToPlot, neuralFiltLow, PlotWhat, Rect_sm, Raster, ...
            numsubplots)

end