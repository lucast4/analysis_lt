%% 1) Gather raw data for this day
clear all; close all;

Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.all';
% Params.DayRawDat.syllables={'a','b','c'};
% Params.DayRawDat.frequency_range={[1300 2200], [2800 3950],[2150 3150]};
% Params.DayRawDat.pc_dur=[0.12,0.11,0.10];
% % Params.DayRawDat.pc_time_window={[375 525],[60 220],[55 320]};
% Params.DayRawDat.pc_time_window={[375 525],[30 50],[55 320]}; % WN over b
Params.DayRawDat.syllables={'a','b','e', 'f','g', 'h'};
Params.DayRawDat.frequency_range={[1200 2400], [1200 2400], [1400 2400], [3000 4000], [3000 3800], ...
    [3000 3800]};
Params.DayRawDat.pc_dur=[0.11, 0.11, 0.13, 0.1, 0.1, 0.1];
Params.DayRawDat.pc_time_window={[90 300], [80 270], [395 490], [15 60], [20 140], [100 160]};

Params.DayRawDat.pc_sigma=1;


% plot and save?
plotON=1;
saveON=1;


% Related to LMAN inactivation
plotLMANinact=1;
Params.DayRawDat.Musc_On_Time='1134'; % time given muscimol - will plot data with temporal lag after this.
Params.DayRawDat.Musc_Off_Time='1650';
MinutesLag = 0;

[Params, RawDatStruct]=lt_seq_dep_pitch_DayRawDat(Params,1,1,'',plotLMANinact, ...
    MinutesLag);



%% Script to change name of all song files in a day to stick "PBS" or "MUSC" right after bird name

StringToAdd='MUSC';

FilesInFolder=dir('*'); % get all cbins, cbinnotmat, and rec

% copy all stuff to backup folder
mkdir OldSongFiles
!cp * OldSongFiles;

% continue
for i=1:length(FilesInFolder);
    fn=FilesInFolder(i).name;
    
    if any(strfind(fn,'.cbin')) || any(strfind(fn,'.rec')) || any(strfind(fn,'.not.mat'));
    
        fn_new=[fn(1:9) StringToAdd '_' fn(10:end)];
        
        eval(['!mv ' fn ' ' fn_new]);
        
    end
end

