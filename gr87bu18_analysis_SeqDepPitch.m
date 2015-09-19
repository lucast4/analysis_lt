%% CHECKING TEMPLATE MATCHING (ab[b]);

% === GETTING aB
clear all; close all;
batchf='batch.labeled.all';
config='/bluejay4/lucas/birds/gr87bu18/config.evconfig2'; % using new a
syl='b';
syl_pre='ab';
syl_post='';
get_WN_hits=1;
get_offline_match=1;
get_FF=1;
NoteNum=0;

check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);



%% AUTOLABEL - 
% 
% batch = 'batch.keep';
% config = '/bluejay3/lucas/birds/pu11wh87/051815_SeqDepPitchLMAN_durWN_MUSC_day7/config.evconfig2';
% syl.targ='b';
% syl.pre='bcc';
% syl.post='';
% 
% NoteNum=1;
% ampThresh=17000;
% min_dur=30;
% min_int=5;
% overwrite_notmat=1;
% 
% 
% lt_autolabel_EvTAFv4(batch, config, syl, NoteNum, ampThresh, min_dur, min_int, overwrite_notmat)


%% 1) Gather raw data for this day
% clear all; close all;
% 
% Params.DayRawDat.fs=32000;
% Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
% Params.DayRawDat.batch='batch.labeled.all';
% % Params.DayRawDat.syllables={'a','b','c'};
% % Params.DayRawDat.frequency_range={[1300 2200], [2800 3950],[2150 3150]};
% % Params.DayRawDat.pc_dur=[0.12,0.11,0.10];
% % % Params.DayRawDat.pc_time_window={[375 525],[60 220],[55 320]};
% % Params.DayRawDat.pc_time_window={[375 525],[30 50],[55 320]}; % WN over b
% Params.DayRawDat.syllables={'a','b','c', 'd'};
% Params.DayRawDat.frequency_range={[1300 2200], [2800 3950],[2150 3150], [1100 2700]};
% Params.DayRawDat.pc_dur=[0.13,0.115,0.115, 0.11];
% Params.DayRawDat.pc_time_window={[375 475],[50 170],[55 320],[10 180]};
% 
% Params.DayRawDat.pc_sigma=1;
% 
% % --- trying to get all syllables - look at code to check
% % Params.DayRawDat.syllables={'a','ab','cb','bb','cc','bc','dc'};
% % Params.DayRawDat.frequency_range={[1300 2200], [2800 3950],[2800 3950],[2800 3950],[2150 3150],[2150 3150],[2150 3150]};
% % Params.DayRawDat.pc_dur=[0.12,0.09,0.09,0.09,0.11,0.11,0.11];
% % Params.DayRawDat.pc_time_window={[375 525],[60 220],[60 220],[60 220],[55 320],[55 320],[55 320]};
% 
% % plot and save?
% plotON=1;
% saveON=0;
% 
% % Related to LMAN inactivation
% plotLMANinact=1;
% Params.DayRawDat.Musc_On_Time='1352'; % time given muscimol - will plot data with temporal lag after this.
% Params.DayRawDat.Musc_Off_Time='1754';
% 
% [Params, RawDatStruct]=lt_seq_dep_pitch_DayRawDat(Params,1,1,'',plotLMANinact);
% 


%% Script to change name of all song files in a day to stick "PBS" or "MUSC" right after bird name

% StringToAdd='PBS';
% 
% FilesInFolder=dir('*'); % get all cbins, cbinnotmat, and rec
% 
% % copy all stuff to backup folder
% mkdir OldSongFiles
% !cp * OldSongFiles;
% 
% % continue
% for i=1:length(FilesInFolder);
%     fn=FilesInFolder(i).name;
%     
%     if any(strfind(fn,'.cbin')) || any(strfind(fn,'.rec')) || any(strfind(fn,'.not.mat'));
%     
%         fn_new=[fn(1:9) StringToAdd '_' fn(10:end)];
%         
%         eval(['!mv ' fn ' ' fn_new]);
%         
%     end
% end



%% ANALYSIS ACROSS DAYS ============================================================
%% 1) GATHER RAW DATA ACROSS DAYS

% clear all; close all
% phrase = 'SeqDepPitchLMAN5';
% first_day= '12Sep2015';
% last_day= '12Sep2015';
% Params.DayRawDat.batch='batch.labeled.all';
% 
% save_results=0;
% 
% % functions to run (SAME FOR ALL MOTIFS)
% FcnAll={'seq_dep_pitch_2'};
% 
% % Parameters for functions within
% Params.DayRawDat.fs=32000;
% Params.DayRawDat.pc_harms=1; % harmonics to take weighted avg over. 1 or 2 is good.
% Params.DayRawDat.syllables={'a','b','c', 'd'};
% Params.DayRawDat.frequency_range={[1300 2200], [2800 3950],[2150 3150], [1100 2700]};
% Params.DayRawDat.pc_dur=[0.135,0.125,0.125, 0.115];
% Params.DayRawDat.pc_time_window={[365 485],[50 165],[48 310],[10 180]};
% 
% Params.DayRawDat.pc_sigma=1;
% 
% plotON=0;
% saveON=1;
% 
% WithinParams={'ParamsSDP',Params,'plotON_SDP',plotON,'saveON_SDP',saveON};
% 
% [filename_save all_days_various]=lt_all_days_various_calculations_FUNCTION(phrase,first_day,last_day,FcnAll,WithinParams,save_results);
% 
% 
% 
% %% 2) Seq filter, remove outliers, and compile raw data, and enter experiment info into params
% cd seq_dep_pitch_SeqDepPitchLMAN5/
% clear all; close all;
% 
% % 0) keep?
% Params.SeqFilter.AmplThr=19000;
% 
% % 1) Seq filter and remove outliers and compile into one struct
% Params.SeqFilter.all_daysON=1; % If 1, then doesn't matter what I enter for days argumemtns.
% Params.SeqFilter.FirstDay='';
% Params.SeqFilter.LastDay='';
% 
% Params.SeqFilter.SeqPreList={'a','ab','bcc','bccb','dcc','dccb','b','bc','d','dc'};
% Params.SeqFilter.SylTargList={'b','b','b','b','b','b','c','c','c','c'};
% Params.SeqFilter.SeqPostList={'','','','','','','','','',''};
% 
% 
% % 2) experiment info
% Params.SeqFilter.WNTimeON='17Sep2015-0000'; % Time WN turned on (1st WN day)
% Params.SeqFilter.WNTimeOFF= '17Sep2015-2400'; % Time WN turned off (last WN day) ( use 0000 and 2400 if only plotting days)
% Params.SeqFilter.BaselineDays=1:5;
% 
% Params.SeqFilter.SylLists.FieldsToPlot{1}={'aB','abB','bccB','bccbB','dccB','dccbB'};
% Params.SeqFilter.SylLists.FieldsToPlot{2}={'d','bC','bcC','dC','dcC'};
% 
% Params.SeqFilter.SylLists.FieldsInOrder{1}={'a','aB','abB','bC','bcC','bccB','bccbB'};
% Params.SeqFilter.SylLists.FieldsInOrder{2}={'d','dC','dcC','dccB','dccbB'};
% 
% Params.SeqFilter.SylLists.TargetSyls={'aB'};
% Params.SeqFilter.SylLists.SylsSame={'abB','bccB','bccbB','dccB','dccbB'};
% Params.SeqFilter.SylLists.SylsDifferent={'a','d','bC','bcC','dC','dcC'};
% 
% % Params.SeqFilter.DaysForSnapshot{1}={'06Jun2015','08Jun2015'};
% % Params.SeqFilter.DaysToMark= {'08Jun2015-2400', '16Jun2015-2400', '18Jun2015-2400'}; % will mark all plots with lines here;
% 
% % 3) RUN
% plotON=0;
% [Params, AllDays_RawDatStruct]=lt_seq_dep_pitch_SeqFilterCompile(Params,plotON);
% 
% 

%% Recalculate FF using new time windows
% % 
% % Params.RecalculateFF.pc_time_window_list=Params.SeqFilter.pc_time_window_list{1}; % list is the same as specified for seq filter, except one change:
% % Params.RecalculateFF.pc_time_window_list(:,6)=[27 47]; % bccb should have different time window.
% % % Params.RecalculateFF.pc_time_window_list(:,9)=[30 50]; % dccb should have different time window.
% % plotON=0;
% % 
% % [Params, AllDays_RawDatStruct] = lt_seq_dep_pitch_RecalculateFF(Params, AllDays_RawDatStruct, plotON);
% % 
% 
%% 3) Perform various analyses on that data structure
% close all; 
% 
% Params.PlotLearning.MuscimolSchedule={...
%     {'14Sep2015', '1404', '1825'}, ...
%     {'16Sep2015', '1407', '1826'}};
%     
% 
% % Params.PlotLearning.MuscimolDaysToThrowout={'06Jul2015'};
% 
% Params.PlotLearning.plotWNdays=1; % if 1, then plots WN lines, if 0, then no.
% Params.PlotLearning.DayBinSize=3; % 3 day running avg.
% saveON=1;
% 
% 
% [Params, AllDays_PlotLearning, AllDays_RawDatStruct]=lt_seq_dep_pitch_PlotLearning(Params, AllDays_RawDatStruct,saveON);
% 
% 
% %% 4) PLOT - looking at effects of LMAN inactivation
% close all;
% Params.PlotLearning.Lag_time=2;
% Params.PlotLearning.PBS_window=[-6.5 0];
% 
% % Params.PlotLearning.timeline.consolid_start='17Aug2015';
% % Params.PlotLearning.timeline.consolid_end='14Jul2015';
% % Params.PlotLearning.timeline.bidir_start='15Jul2015';
% % Params.PlotLearning.timeline.bidir_end='25Jul2015';
% 
% [Params, AllDays_PlotLearning]= lt_seq_dep_pitch_PlotLearning_Musc(Params, AllDays_PlotLearning);
% 
% 
% %% ========================== Use regular expressions to sort data from Raw data
% % close all; 
% % Params.RegExpr.expressions={'abbccbb', 'dccbb'};
% % DoLMAN=1;
% % saveON=1;
% % [Params, AllDays_RegExpr] = lt_seq_dep_pitch_RegExpr(Params, AllDays_RawDatStruct, saveON, DoLMAN, AllDays_PlotLearning);
% % 
% % 
% % % ========================== PLOT REG EXPR DATA
% % Params.PlotRegExpr.plotWNdays=1;
% % saveON=1;
% % LMANon=1;
% % [Params, AllDays_RegExpr]=lt_seq_dep_pitch_PlotRegExpr(Params, AllDays_RegExpr ,saveON, LMANon);
% % 
% % %% ==========================
% % % %% TEMPORARY - PLOTTING BASELINE PITCH ALL DAYS, after seq compile =============
% % % 
% % % NumDays=length(AllDays_RawDatStruct);
% % % 
% % % syllist=Params.SeqFilter.SylLists.FieldsToPlot{1};
% % % 
% % % % str_to_plot='PBS';
% % % 
% % % firstday='06May2015';
% % % 
% % % for j=1:length(syllist);
% % %     syl=syllist{j};
% % %     lt_figure; hold on;
% % %     title(syl);
% % %     
% % %     for i=1:NumDays;
% % % 
% % %         if isempty(AllDays_RawDatStruct{i});
% % % continue
% % % end
% % % 
% % %         NumRends=size(AllDays_RawDatStruct{i}.data.(syl),1);
% % %         
% % %         Ytot_PBS=[];
% % %         Ytot_MUSC=[];
% % %         for ii=1:NumRends
% % %             
% % %                 tval=lt_convert_EventTimes_to_RelTimes(firstday,AllDays_RawDatStruct{i}.data.(syl){ii,6});
% % %                 tval=tval.FinalValue;
% % %                 yval=AllDays_RawDatStruct{i}.data.(syl){ii,1};
% % % 
% % %                
% % %                 if any(strfind(AllDays_RawDatStruct{i}.data.(syl){ii,5},'PBS'));
% % %                 
% % %                 
% % %                 plot(tval,yval,'ob');
% % %                  
% % %                 Ytot_PBS=[Ytot_PBS yval];
% % %                 
% % %                 elseif any(strfind(AllDays_RawDatStruct{i}.data.(syl){ii,5},'MUSC'))
% % %                     
% % %                 plot(tval,yval,'or');
% % %                 Ytot_MUSC=[Ytot_MUSC yval];
% % %                 grid on
% % %             end
% % %             
% % %             
% % %         end
% % %              plot(tval,mean(Ytot_PBS),'sb','MarkerFaceColor','b');
% % %              plot(tval,mean(Ytot_MUSC),'sr','MarkerFaceColor','r');
% % %        
% % %         
% % %     end
% % % end
% % % 
% % 
% % %% Script to change name of all song files in a day to stick "PBS" or "MUSC" right after bird name
% % 
% % StringToAdd='PBS';
% % 
% % FilesInFolder=dir('*'); % get all cbins, cbinnotmat, and rec
% % 
% % % copy all stuff to backup folder
% % mkdir OldSongFiles
% % !cp * OldSongFiles;
% % 
% % % continue
% % for i=1:length(FilesInFolder);
% %     fn=FilesInFolder(i).name;
% %     
% %     if any(strfind(fn,'.cbin')) || any(strfind(fn,'.rec')) || any(strfind(fn,'.not.mat'));
% %     
% %         fn_new=[fn(1:9) StringToAdd '_' fn(10:end)];
% %         
% %         eval(['!mv ' fn ' ' fn_new]);
% %         
% %     end
% % end
% % 
% %% Script to replace PBS with MUSC (or vice versa) in file names of all songs in day
% StringToRemove='MUSC';
% StringToAdd='PBS';
% 
% FilesInFolder=dir('*'); % get all cbins, cbinnotmat, and rec
% 
% % copy all stuff to backup folder
% mkdir OldSongFiles
% !cp * OldSongFiles;
% 
% % continue
% for i=1:length(FilesInFolder);
%     fn=FilesInFolder(i).name;
%     
%     if any(strfind(fn,'.cbin')) || any(strfind(fn,'.rec')) || any(strfind(fn,'.not.mat'));
%     
%         length_remove=length(StringToRemove);
%         
%         fn_new=[fn(1:9) StringToAdd fn(10+length_remove:end)];
% 
%         eval(['!mv ' fn ' ' fn_new]);
%     end
% end
