ls ~/MATLAB/matlab_pj/
%%
clear all;close all

filename = 'wh67pk20_HVCL_site2_1100_knob8_140729_170756.rhd';


pj_readIntanNoGui(filename);
%%
% read_Intan_RHD2000_file

figure; hold on;
plot(amplifier_data(2,:),'b');
plot(board_dig_in_data,'g');
plot(aux_input_data(1,:),'b')


%% NOTE: stopped at editing lt_pj_PSTH_Intan_temp.  can use lt_pj_PSTH_Intan which works fine, but I am editing to add rasters, etc.

datChannels=[17 21 26 30];
digChan=1;
fs=frequency_parameters.amplifier_sample_rate;
trialLength=1000; % start of stim to start of next stim. (ms)
stimLength=500; 
binSize=20; % ms, for PSTH
xNoise=3; % threshold for calling something spike, in RMS above baseline noise.
saveFigs=0;
plotRaw=0;
plotdig=1;
plotPSTH=1;
plotRaster=1;


% datChannels=[1:32];
lt_pj_PSTH_Intan_temp(amplifier_data,board_dig_in_data,datChannels,digChan,fs,...
    stimLength,trialLength,binSize,xNoise,saveFigs,plotRaw,plotdig,plotPSTH,plotRaster)



% 
% for i=1:length(datChannels);
%     datchan=datChannels(i);
% 
% pj_PSTH_Intan(amplifier_data,board_dig_in_data,datchan,1,30000,500,1000,50,3,0,1,1,1)
% end


%% NOTES:

% wh67pk20_HVCL_site2_1100_knob8_140729_170756 interesting