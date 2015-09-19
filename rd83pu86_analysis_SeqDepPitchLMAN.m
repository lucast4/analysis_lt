%% 1) Gather raw data for this day
% NOTE: THESE PARAMETERS WORK FOR DAYS USING SHORT PROBES AND LONG PROBES

clear all; close all;

Params.DayRawDat.fs=32000;
Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
Params.DayRawDat.batch='batch.labeled.all';
% Params.DayRawDat.syllables={'a','b','c'};
% Params.DayRawDat.frequency_range={[1300 2200], [2800 3950],[2150 3150]};
% Params.DayRawDat.pc_dur=[0.12,0.11,0.10];
% % Params.DayRawDat.pc_time_window={[375 525],[60 220],[55 320]};
% Params.DayRawDat.pc_time_window={[375 525],[30 50],[55 320]}; % WN over b
Params.DayRawDat.syllables={'a','b', 'q', 'w','e','r'};
Params.DayRawDat.frequency_range={[1100 2000], [2800 3950],[1100 2000], [2800 3950],[2800 3950],[2800 3950]};
Params.DayRawDat.pc_dur=[0.13,0.115,0.13, 0.115,0.115,0.115];
Params.DayRawDat.pc_time_window={[375 475],[80 220],[400 520],[80 220], [80 260], [80 260]};

Params.DayRawDat.pc_sigma=1;

% --- trying to get all syllables - look at code to check
% Params.DayRawDat.syllables={'a','ab','cb','bb','cc','bc','dc'};
% Params.DayRawDat.frequency_range={[1300 2200], [2800 3950],[2800 3950],[2800 3950],[2150 3150],[2150 3150],[2150 3150]};
% Params.DayRawDat.pc_dur=[0.12,0.09,0.09,0.09,0.11,0.11,0.11];
% Params.DayRawDat.pc_time_window={[375 525],[60 220],[60 220],[60 220],[55 320],[55 320],[55 320]};

% plot and save?
plotON=1;
saveON=0;

% Related to LMAN inactivation
plotLMANinact=1;
Params.DayRawDat.Musc_On_Time='1416'; % time given muscimol - will plot data with temporal lag after this.
Params.DayRawDat.Musc_Off_Time='1852';

[Params, RawDatStruct]=lt_seq_dep_pitch_DayRawDat(Params,1,1,'',plotLMANinact);





%% Script to change name of all song files in a day to stick "PBS" or "MUSC" right after bird name

StringToAdd='PBS';

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
