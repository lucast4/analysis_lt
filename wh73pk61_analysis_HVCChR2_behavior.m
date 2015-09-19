%% 1/11/15 - To analyze acute stim, and learning, effects of stim

% Simulated data
cd /bluejay3/lucas/birds/wh73pk61/010515_HVCChR2_NoLaser_TwoTemplTest

%             target - c(1) (laser)
%             catch trial - 0.5
%             trig refr - 0.15
%             output chan - 1
%         Note 1 - 
%             target b(1) (wn)
%             CATCH TR: 0.3
%             trig ref - 0.1
%             out chan - 0
%         Catch song - 0.06

lt_Opto_Stim_analy

%% TO SIMPLY LOOK AT WN TARGETTING
%% TO CHECK c1 (laser)
    clear all; close all;
    batchf='batch.labeled.all';
%     config='/bluejay3/lucas/birds/wh73pk61/011915_HVCChR2_StimAndLearn_noStimdurLearn/config_011915.evconfig2';
    config='/bluejay3/lucas/birds/wh73pk61/012915_HVCChR2_StimAndLearn_StimON_WNON_day1/config_012915_startWN.evconfig2';

    syl='c';
    syl_pre='';
    syl_post='c';
    get_WN_hits=1;
    get_offline_match=1;
    get_FF=0;
    NoteNum=0;

    check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


    %% ANOTHER METHOD
    clear all; close all;
    batchf='batch.labeled.all';
    syl='c';
    syl_pre='';
    syl_post='c';
    syl_refract=0.15;
    freq_range=[2800 3800];
    evtaf_ver='v4';
    get_WN_hits=1;
    get_offline_match=1;
    get_FF=0;


%     template_name='wh73pk61_c1_v1_3';
%     cntrng_values{1}={[3 4 2] 'or' 'n' 'n'};
%     cntrng_values{2}={[3 4 2] 'or' 'n' 'n'};
%     cntrng_values{3}={[3 4 2] 'and' 'n' 'n'};
%     col_logic='(a+b+c)';
    template_name='wh73pk61_c1_v1_5';
    cntrng_values{1}={[3 4 2] 'or' 'n' 'n'};
    cntrng_values{2}={[3 4 2] 'or' 'n' 'n'};
    cntrng_values{3}={[3 4 2] 'or' 'n' 'n'};
    cntrng_values{4}={[3 4 2] 'or' 'n' 'n'};
    cntrng_values{5}={[3 4 2] 'or' 'n' 'n'};

    col_logic='(a+b+c+d+e)';
    check_stuff=lt_check_hit_templ_freq_FUNCTION(batchf, syl, syl_pre, syl_post, syl_refract, freq_range, ...
        evtaf_ver,get_WN_hits,get_offline_match,get_FF,template_name,cntrng_values,col_logic);


    
%% TO CHECK b1 - WN target
    clear all; close all;
    batchf='batch.labeled.all';
%     config='/bluejay3/lucas/birds/wh73pk61/011215_HVCChR2_Stim_250msConst_knob75/config_011215_StartStim.evconfig2';
    config='/bluejay3/lucas/birds/wh73pk61/012915_HVCChR2_StimAndLearn_StimON_WNON_day1/config_012915_startWN.evconfig2';

    syl='b';
    syl_pre='c';
    syl_post='';
    get_WN_hits=1;
    get_offline_match=1;
    get_FF=1;
    NoteNum=1;

    check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

%% ANOTHER WAY
    clear all; close all;
    batchf='batch.labeled.all';
    syl='b';
    syl_pre='c';
    syl_post='';
    syl_refract=0.20;
    freq_range=[2800 3800];
    evtaf_ver='v4';
    get_WN_hits=1;
    get_offline_match=1;
    get_FF=0;


%     template_name='wh73pk61_b1_v1_3';
%     cntrng_values{1}={[1 10 2] 'and' 'n' 'y'};
%     cntrng_values{2}={[2 4 1.7] 'or' 'n' 'n'};
%     cntrng_values{3}={[2 4 1.7] 'and' 'n' 'n'};
%     col_logic='(a)*(b+c)';
% 
    template_name='wh73pk61_b1_v1_5';
    cntrng_values{1}={[1 10 1.7] 'and' 'n' 'y'};
    cntrng_values{2}={[1 4 2.2] 'or' 'n' 'n'};
    cntrng_values{3}={[1 4 2.2] 'or' 'n' 'n'};
    cntrng_values{4}={[1 4 2.2] 'or' 'n' 'n'};
    cntrng_values{5}={[1 4 2.2] 'or' 'n' 'n'};
    col_logic='(a)*(b+c+d+e)';


    check_stuff=lt_check_hit_templ_freq_FUNCTION(batchf, syl, syl_pre, syl_post, syl_refract, freq_range, ...
        evtaf_ver,get_WN_hits,get_offline_match,get_FF,template_name,cntrng_values,col_logic);




    
%% TO CHECK C2 targetting (3/6/15)

    clear all; close all;
    batchf='batch.test';
config='/bluejay3/lucas/birds/wh73pk61/config_3templ.evconfig2';

    syl='C';
    syl_pre='';
    syl_post='';
    get_WN_hits=1;
    get_offline_match=1;
    get_FF=1;
    NoteNum=2;

    check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

%% TO CHECK B2 targetting (3/6/15)

%     clear all; close all;
%     batchf='batch.test';
% config='/bluejay3/lucas/birds/wh73pk61/031015_HVCChR2_XStimOFF_PitchShiftON_day2/config_newbtempl.evconfig2';
% 
%     syl='B';
%     syl_pre='';
%     syl_post='';
%     get_WN_hits=1;
%     get_offline_match=1;
%     get_FF=1;
%     NoteNum=1;
% 
%     check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


%% TO CHECK B2 targetting (3/27/15)

    clear all; close all;
    batchf='batch.NoteGroup_0.LABELED';
config='/bluejay3/lucas/birds/wh73pk61/032715_HVCChR2_NoteGroups_StimOFFWnON_Targb2only_day1/config.evconfig2';

    syl='b';
    syl_pre='ccb';
    syl_post='';
    get_WN_hits=1;
    get_offline_match=1;
    get_FF=1;
    NoteNum=1;

    check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

%% TO CHECK B2 targetting (3/27/15), using v1_8

    clear all; close all;
    batchf='batch.NoteGroup_0.LABELED';
config='/bluejay3/lucas/birds/wh73pk61/config_b2_new.evconfig2';

    syl='b';
    syl_pre='ccb';
    syl_post='';
    get_WN_hits=1;
    get_offline_match=1;
    get_FF=1;
    NoteNum=1;

    check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);

    
    
%% TO CHECK TARGETING (4/9/15) - currently doing association bidir experiment (only labeling -cb-


    clear all; close all;
    batchf='batch.keep.AutoLabeled.rand';
%     config='/bluejay3/lucas/birds/wh73pk61/040915_HVCChR2_NoteGroups_StimONWnON_association_StimupNostimdn_day3/config.evconfig2';
    config='/bluejay3/lucas/birds/wh73pk61/042215_HVCChR2_StimOFFWnON_reversion_day3/config.evconfig2'; % starting 4/22 3:20pm

    % laser
    syl='c';
    syl_pre='';
    syl_post='c';
    get_WN_hits=0;
    get_offline_match=1;
    get_FF=0;
    NoteNum=0;
    
    % wn targ
    syl='b';
    syl_pre='b';
    syl_post='';
    get_WN_hits=1;
    get_offline_match=1;
    get_FF=1;
    NoteNum=1;
    
    % below: should be same as note 1
    syl='b';
    syl_pre='ccb';
    syl_post='';
    get_WN_hits=1;
    get_offline_match=1;
    get_FF=1;
    NoteNum=3;
    


    check_stuff=lt_check_hit_templ_freq_v2_EvTAFv4Sim(batchf, syl, syl_pre, syl_post, get_WN_hits,get_offline_match,get_FF,config,NoteNum);


%% DEBUGGING
% test1=readrecf('wh73pk61_120115_165010.409.rec')
% test2=readrecf('wh73pk61_120115_165010.409X.rec')


%% PREPARING FOR WN LEARNING EXPERIMENT
% Target: b1



%% PLOTTING LEARNING EXPERIMENT - simple summary all days
% Note: below is script to compile day by day by hand. Then it plots using
% that structure. It is saved.

% Look at 1/11 to 1/26 (before start constant stim).


wh67pk20_analysis_HVCopto_neuralData_PLOTSUMMARY



%% PLOTTING LEARNING EXPERIMENT - good experiments where I was sure laser power coming out was good.
clear all; close all;

% ===================== EXPERIMENT 1- turning off WN during stim epoch
% note: things to mark on plot: 3/17 - lacking data of nostim before epoch
% 1, 2) directed song mark

% 1) Data directories
BirdDir='/bluejay3/lucas/birds/wh73pk61/';

ListOfDirs=...
    {'031215_HVCChR2_XStimON_PitchShiftOFF_day4/lt_Opto_Stim_analy_batch.labeled.all_13Mar2015_1208X/PLOT_StimCatch_StimNotCatch_13Mar2015_1210/TimeWindow_13Mar2015_1213/OverTime_13Mar2015_1217',...
    '030815_HVCChR2_XStim_StimOFF/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2009/PLOT_All_12Mar2015_2010/TimeWindow_12Mar2015_2010/OverTime_12Mar2015_2010',...
    '030815_HVCChR2_XStim_StimON_pulse/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2010/PLOT_StimCatch_StimNotCatch_12Mar2015_2012/TimeWindow_12Mar2015_2012/OverTime_12Mar2015_2012',...
    '030915_HVCChR2_XStimOFF_PitchShiftON_day1/lt_Opto_Stim_analy_batch.labeled.catch_12Mar2015_2012/PLOT_All_12Mar2015_2014/TimeWindow_12Mar2015_2014/OverTime_12Mar2015_2014',...
    '031015_HVCChR2_XStimOFF_PitchShiftON_day2/lt_Opto_Stim_analy_batch.labeled.catch_12Mar2015_2014/PLOT_All_12Mar2015_2015/TimeWindow_12Mar2015_2015/OverTime_12Mar2015_2015',...
    '030715_HVCChR2_XStim_StimOFF/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2015/PLOT_All_12Mar2015_2016/TimeWindow_12Mar2015_2016/OverTime_12Mar2015_2016',...
    '031115_HVCChR2_XStimOFF_PitchShiftON_day3/lt_Opto_Stim_analy_batch.labeled.catch_12Mar2015_2016/PLOT_All_12Mar2015_2016/TimeWindow_12Mar2015_2016/OverTime_12Mar2015_2016',...
    '030715_HVCChR2_XStim_StimON_pulse/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2016/PLOT_StimCatch_StimNotCatch_12Mar2015_2018/TimeWindow_12Mar2015_2018/OverTime_12Mar2015_2018',...
    '031115_HVCChR2_XStimON_PitchShiftOFF_day3_actuallyoff/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2018/PLOT_StimCatch_StimNotCatch_12Mar2015_2021/TimeWindow_12Mar2015_2022/OverTime_12Mar2015_2022',...
    '030615_HVCChR2_XStim_StimON_pulse/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2022/PLOT_StimCatch_StimNotCatch_12Mar2015_2025/TimeWindow_12Mar2015_2025/OverTime_12Mar2015_2025',...
    '031215_HVCChR2_XStimOFF_PitchShiftON_day4/lt_Opto_Stim_analy_batch.labeled.all_13Mar2015_1222X/PLOT_All_13Mar2015_1231/TimeWindow_13Mar2015_1232/OverTime_13Mar2015_1232',...
    '031415_HVCChR2_XStimON_PitchShiftOFF_day6/lt_Opto_Stim_analy_batch.labeled.all_15Mar2015_1139X/PLOT_StimCatch_StimNotCatch_15Mar2015_1143/TimeWindow_15Mar2015_1146/OverTime_15Mar2015_1146',...
    '031315_HVCChR2_XStimON_PitchShiftOFF_day5/lt_Opto_Stim_analy_batch.labeled.all_29Mar2015_1715X/PLOT_StimCatch_StimNotCatch_29Mar2015_1718/TimeWindow_29Mar2015_1720/OverTime_29Mar2015_1721/',...
    '031315_HVCChR2_XStimOFF_PitchShiftON_day5/lt_Opto_Stim_analy_batch.labeled.all_14Mar2015_1511X/PLOT_All_14Mar2015_1512/TimeWindow_14Mar2015_1512/OverTime_14Mar2015_1513',...
    '031415_HVCChR2_XStimOFF_PitchShiftON_day6/lt_Opto_Stim_analy_batch.labeled.all_14Mar2015_1517X/PLOT_All_14Mar2015_1518/TimeWindow_14Mar2015_1518/OverTime_14Mar2015_1518',...
    '031515_HVCChR2_XStimON_PitchShiftOFF_day7/lt_Opto_Stim_analy_batch.labeled.all_17Mar2015_1215X/PLOT_StimCatch_StimNotCatch_17Mar2015_1217/TimeWindow_17Mar2015_1218/OverTime_17Mar2015_1218',...
    '031515_HVCChR2_XStimOFF_PitchShiftON_day7/lt_Opto_Stim_analy_batch.labeled.all_17Mar2015_1057X/PLOT_All_17Mar2015_1059/TimeWindow_17Mar2015_1059/OverTime_17Mar2015_1100',...
    '031615_HVCChR2_XStimON_PitchShiftOFF_day8/lt_Opto_Stim_analy_batch.labeled.all_29Mar2015_1727X/PLOT_StimCatch_StimNotCatch_29Mar2015_1731/TimeWindow_29Mar2015_1733/OverTime_29Mar2015_1733',...
    '031615_HVCChR2_XStimOFF_PitchShiftON_day8/lt_Opto_Stim_analy_batch.labeled.all_17Mar2015_1128X/PLOT_All_17Mar2015_1130/TimeWindow_17Mar2015_1130/OverTime_17Mar2015_1130',...
    '031715_HVCChR2_XStimON_PitchShiftOFF_day9/lt_Opto_Stim_analy_batch.labeled.all_17Mar2015_1137X/PLOT_StimCatch_StimNotCatch_17Mar2015_1138/TimeWindow_17Mar2015_1139/OverTime_17Mar2015_1140',...
    '031415_HVCChR2_XStimOFF_PitchShiftON_day6/lt_Opto_Stim_analy_batch.labeled.all_17Mar2015_1152X/PLOT_All_17Mar2015_1154/TimeWindow_17Mar2015_1156/OverTime_17Mar2015_1156',...
    '031715_HVCChR2_XStimOFF_PitchShiftON_day9/lt_Opto_Stim_analy_batch.labeled.all_17Mar2015_1623X/PLOT_All_17Mar2015_1624/TimeWindow_17Mar2015_1627/OverTime_17Mar2015_1627',...
    '031715_HVCChR2_XStimON_PitchShiftOFF_day9/lt_Opto_Stim_analy_batch.labeled.all_18Mar2015_1024X/PLOT_StimCatch_StimNotCatch_18Mar2015_1027/TimeWindow_18Mar2015_1030/OverTime_18Mar2015_1032',...
    '031715_HVCChR2_XStimOFF_PitchShiftON_day9/lt_Opto_Stim_analy_batch.labeled.all_18Mar2015_1039X/PLOT_All_18Mar2015_1040/TimeWindow_18Mar2015_1040/OverTime_18Mar2015_1040',...
    '031815_HVCChR2_XStimOFF_PitchShiftON_day10/lt_Opto_Stim_analy_batch.labeled.all_18Mar2015_1439X/PLOT_All_18Mar2015_1440/TimeWindow_18Mar2015_1443/OverTime_18Mar2015_1443',...
    '031815_HVCChR2_XStimOFF_PitchShiftON_day10/lt_Opto_Stim_analy_batch.labeled.all_19Mar2015_1257X/PLOT_All_19Mar2015_1259/TimeWindow_19Mar2015_1301/OverTime_19Mar2015_1301',...
    '031815_HVCChR2_XStimON_PitchShiftOFF_day10/lt_Opto_Stim_analy_batch.labeled.all_19Mar2015_1244X/PLOT_StimCatch_StimNotCatch_19Mar2015_1245/TimeWindow_19Mar2015_1249/OverTime_19Mar2015_1250',...
    '031815_HVCChR2_DIRECTED/lt_Opto_Stim_analy_batch.labeled.all_19Mar2015_1419X/PLOT_All_19Mar2015_1419/TimeWindow_19Mar2015_1439/OverTime_19Mar2015_1442',...
    '031915_HVCChR2_XStimOFF_PitchShiftON_day11/lt_Opto_Stim_analy_batch.labeled.all_29Mar2015_1740X/PLOT_All_29Mar2015_1741/TimeWindow_29Mar2015_1742/OverTime_29Mar2015_1742',...
    '031915_HVCChR2_DIRECTED/lt_Opto_Stim_analy_batch.labeled.all_19Mar2015_1714X/PLOT_All_19Mar2015_1714/TimeWindow_19Mar2015_1715/OverTime_19Mar2015_1715',...
    '031915_HVCChR2_XStimON_PitchShiftOFF_day11/lt_Opto_Stim_analy_batch.labeled.all_29Mar2015_1747X/PLOT_StimCatch_StimNotCatch_29Mar2015_1750/TimeWindow_29Mar2015_1801/OverTime_29Mar2015_1801',...
    '032015_HVCChR2_XStimON_PitchShiftOFF_day12/lt_Opto_Stim_analy_batch.labeled.all_29Mar2015_1811X/PLOT_StimCatch_StimNotCatch_29Mar2015_1813/TimeWindow_29Mar2015_1816/OverTime_29Mar2015_1816',...
    '032315_HVCChR2_NoteGroups_StimWnON_day3/lt_Opto_Stim_analy_batch.labeled.all_23Mar2015_1224X/PLOT_StimCatch_StimNotCatch_23Mar2015_1225/TimeWindow_23Mar2015_1225/OverTime_23Mar2015_1225',...
    '032215_HVCChR2_NoteGroups_StimWnON_day2/lt_Opto_Stim_analy_batch.labeled.all_22Mar2015_1419X/PLOT_StimCatch_StimNotCatch_22Mar2015_1420/TimeWindow_22Mar2015_1421/OverTime_22Mar2015_1422',...
    '032115_HVCChR2_NoteGroups_StimWnON_day1/lt_Opto_Stim_analy_batch.labeled.all_21Mar2015_2222X/PLOT_StimCatch_StimNotCatch_21Mar2015_2224/TimeWindow_21Mar2015_2226/OverTime_21Mar2015_2226',...
    '032615_HVCChR2_NoteGroups_StimONWnON_day6/lt_Opto_Stim_analy_batch.labeled.all_28Mar2015_1809X/PLOT_StimCatch_StimNotCatch_28Mar2015_1811/TimeWindow_28Mar2015_1813/OverTime_28Mar2015_1814/',...
    '032615_HVCChR2_NoteGroups_StimONWnOFF_day6/lt_Opto_Stim_analy_batch.labeled.all_28Mar2015_1828X/PLOT_StimCatch_StimNotCatch_28Mar2015_1830/TimeWindow_28Mar2015_1833/OverTime_28Mar2015_1833/'};

TimeFieldsOfInterest = 1:4;
statfield='ffvals';
BaselineDays=1:3;

lt_Opto_Stim_analy_SUMMARY_PlotOverTime(BirdDir,ListOfDirs,TimeFieldsOfInterest,statfield,BaselineDays)


% ======================= EXPERIMENT 2 - keeping WN on and quantifying pitch in early part of syl
BirdDir='/bluejay3/lucas/birds/wh73pk61/';

ListOfDirs=...
    {'030815_HVCChR2_XStim_StimOFF/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2009/PLOT_All_12Mar2015_2010/TimeWindow_12Mar2015_2010/OverTime_12Mar2015_2010',...
    '030815_HVCChR2_XStim_StimON_pulse/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2010/PLOT_StimCatch_StimNotCatch_12Mar2015_2012/TimeWindow_12Mar2015_2012/OverTime_12Mar2015_2012',...
    '030715_HVCChR2_XStim_StimOFF/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2015/PLOT_All_12Mar2015_2016/TimeWindow_12Mar2015_2016/OverTime_12Mar2015_2016',...
    '030715_HVCChR2_XStim_StimON_pulse/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2016/PLOT_StimCatch_StimNotCatch_12Mar2015_2018/TimeWindow_12Mar2015_2018/OverTime_12Mar2015_2018',...
    '030615_HVCChR2_XStim_StimON_pulse/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2022/PLOT_StimCatch_StimNotCatch_12Mar2015_2025/TimeWindow_12Mar2015_2025/OverTime_12Mar2015_2025',...
    '032715_HVCChR2_NoteGroups_StimOFFWnON_Targb2only_day1/lt_Opto_Stim_analy_batch.labeled.all_28Mar2015_1625X/PLOT_All_28Mar2015_1628/TimeWindow_28Mar2015_1638/OverTime_28Mar2015_1639',...
    '032715_HVCChR2_NoteGroups_StimONWnON_Targb2only_day1/lt_Opto_Stim_analy_batch.labeled.all_27Mar2015_1811X/PLOT_StimCatch_StimNotCatch_27Mar2015_1812/TimeWindow_27Mar2015_1819/OverTime_27Mar2015_1819',...
    '032715_HVCChR2_NoteGroups_StimONWnON_Targb2only_day1/lt_Opto_Stim_analy_batch.rec_FB.constk63_27Mar2015_2147X/PLOT_StimCatch_StimNotCatch_27Mar2015_2148/TimeWindow_28Mar2015_1545/OverTime_28Mar2015_1545',...
    '032715_HVCChR2_NoteGroups_StimONWnON_Targb2only_day1/lt_Opto_Stim_analy_batch.rec_FB.pulsek65_27Mar2015_2231X/PLOT_StimCatch_StimNotCatch_27Mar2015_2232/TimeWindow_28Mar2015_1542/OverTime_28Mar2015_1543',...
    '032815_HVCChR2_NoteGroups_StimONWnON_Targb2only_day2/lt_Opto_Stim_analy_batch.labeled.all_28Mar2015_1718X/PLOT_StimCatch_StimNotCatch_28Mar2015_1719/TimeWindow_30Mar2015_1232/OverTime_30Mar2015_1232',...
    '032815_HVCChR2_NoteGroups_StimOFFWnON_Targb2only_day2/lt_Opto_Stim_analy_batch.labeled.all_29Mar2015_1849X/PLOT_All_29Mar2015_1852/TimeWindow_30Mar2015_1230/OverTime_30Mar2015_1230',...    
    '032815_HVCChR2_NoteGroups_StimONWnON_Targb2only_day_stim2/lt_Opto_Stim_analy_batch.labeled.all_29Mar2015_1832X/PLOT_StimCatch_StimNotCatch_29Mar2015_1833/TimeWindow_30Mar2015_1234/OverTime_30Mar2015_1234',...
    '032915_HVCChR2_NoteGroups_StimONWnON_Targb2only_day3/lt_Opto_Stim_analy_batch.labeled.all_29Mar2015_1910X/PLOT_StimCatch_StimNotCatch_29Mar2015_1913/TimeWindow_30Mar2015_1238/OverTime_30Mar2015_1238',...
    '032915_HVCChR2_NoteGroups_StimOFFWnON_Targb2only_day3/lt_Opto_Stim_analy_batch.labeled.all_30Mar2015_1214X/PLOT_All_30Mar2015_1217/TimeWindow_30Mar2015_1236/OverTime_30Mar2015_1236',...
    '033015_HVCChR2_NoteGroups_StimOFFWnON_Targb2only_day4/lt_Opto_Stim_analy_v2/All',...
    '033015_HVCChR2_NoteGroups_StimONWnON_Targb2only_day4/lt_Opto_Stim_analy_batch.labeled.all_30Mar2015_1853X/PLOT_StimCatch_StimNotCatch_30Mar2015_1856/TimeWindow_30Mar2015_1857/OverTime_30Mar2015_1858/',...
    '033115_HVCChR2_NoteGroups_StimOFFWnON_Targb2only_day5/lt_Opto_Stim_analy_batch.labeled.all_01Apr2015_1306X/PLOT_All_01Apr2015_1311/TimeWindow_01Apr2015_1313/OverTime_01Apr2015_1314',...
    '033115_HVCChR2_NoteGroups_StimONWnON_Targb2only_day5/lt_Opto_Stim_analy_batch.labeled.all_01Apr2015_1315X/PLOT_StimCatch_StimNotCatch_01Apr2015_1316/TimeWindow_01Apr2015_1335/OverTime_01Apr2015_1335',...
    '040115_HVCChR2_NoteGroups_StimONWnON_Targb2only_day6/lt_Opto_Stim_analy_v2/Stim',...
    '040115_HVCChR2_NoteGroups_StimOffWnON_Targb2only_day6/lt_Opto_Stim_analy_v2/All'};
    
    
    
TimeFieldsOfInterest = 1:4;
statfield='ffvals';
BaselineDays=1:3;
plotStimEpochs=1;

lt_Opto_Stim_analy_SUMMARY_PlotOverTime(BirdDir,ListOfDirs,TimeFieldsOfInterest,statfield,BaselineDays,plotStimEpochs)


% ================== COMBINING EXPTS 1 and 2 (REVERSION, EARLY TURNED OFF WN, LATER DAYS DID NOT) - 
BirdDir='/bluejay3/lucas/birds/wh73pk61/';

ListOfDirs=...
    {'031215_HVCChR2_XStimON_PitchShiftOFF_day4/lt_Opto_Stim_analy_batch.labeled.all_13Mar2015_1208X/PLOT_StimCatch_StimNotCatch_13Mar2015_1210/TimeWindow_13Mar2015_1213/OverTime_13Mar2015_1217',...
    '030815_HVCChR2_XStim_StimOFF/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2009/PLOT_All_12Mar2015_2010/TimeWindow_12Mar2015_2010/OverTime_12Mar2015_2010',...
    '030815_HVCChR2_XStim_StimON_pulse/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2010/PLOT_StimCatch_StimNotCatch_12Mar2015_2012/TimeWindow_12Mar2015_2012/OverTime_12Mar2015_2012',...
    '030915_HVCChR2_XStimOFF_PitchShiftON_day1/lt_Opto_Stim_analy_batch.labeled.catch_12Mar2015_2012/PLOT_All_12Mar2015_2014/TimeWindow_12Mar2015_2014/OverTime_12Mar2015_2014',...
    '031015_HVCChR2_XStimOFF_PitchShiftON_day2/lt_Opto_Stim_analy_batch.labeled.catch_12Mar2015_2014/PLOT_All_12Mar2015_2015/TimeWindow_12Mar2015_2015/OverTime_12Mar2015_2015',...
    '030715_HVCChR2_XStim_StimOFF/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2015/PLOT_All_12Mar2015_2016/TimeWindow_12Mar2015_2016/OverTime_12Mar2015_2016',...
    '031115_HVCChR2_XStimOFF_PitchShiftON_day3/lt_Opto_Stim_analy_batch.labeled.catch_12Mar2015_2016/PLOT_All_12Mar2015_2016/TimeWindow_12Mar2015_2016/OverTime_12Mar2015_2016',...
    '030715_HVCChR2_XStim_StimON_pulse/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2016/PLOT_StimCatch_StimNotCatch_12Mar2015_2018/TimeWindow_12Mar2015_2018/OverTime_12Mar2015_2018',...
    '031115_HVCChR2_XStimON_PitchShiftOFF_day3_actuallyoff/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2018/PLOT_StimCatch_StimNotCatch_12Mar2015_2021/TimeWindow_12Mar2015_2022/OverTime_12Mar2015_2022',...
    '030615_HVCChR2_XStim_StimON_pulse/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2022/PLOT_StimCatch_StimNotCatch_12Mar2015_2025/TimeWindow_12Mar2015_2025/OverTime_12Mar2015_2025',...
    '031215_HVCChR2_XStimOFF_PitchShiftON_day4/lt_Opto_Stim_analy_batch.labeled.all_13Mar2015_1222X/PLOT_All_13Mar2015_1231/TimeWindow_13Mar2015_1232/OverTime_13Mar2015_1232',...
    '031415_HVCChR2_XStimON_PitchShiftOFF_day6/lt_Opto_Stim_analy_batch.labeled.all_15Mar2015_1139X/PLOT_StimCatch_StimNotCatch_15Mar2015_1143/TimeWindow_15Mar2015_1146/OverTime_15Mar2015_1146',...
    '031315_HVCChR2_XStimON_PitchShiftOFF_day5/lt_Opto_Stim_analy_batch.labeled.all_29Mar2015_1715X/PLOT_StimCatch_StimNotCatch_29Mar2015_1718/TimeWindow_29Mar2015_1720/OverTime_29Mar2015_1721/',...
    '031315_HVCChR2_XStimOFF_PitchShiftON_day5/lt_Opto_Stim_analy_batch.labeled.all_14Mar2015_1511X/PLOT_All_14Mar2015_1512/TimeWindow_14Mar2015_1512/OverTime_14Mar2015_1513',...
    '031415_HVCChR2_XStimOFF_PitchShiftON_day6/lt_Opto_Stim_analy_batch.labeled.all_14Mar2015_1517X/PLOT_All_14Mar2015_1518/TimeWindow_14Mar2015_1518/OverTime_14Mar2015_1518',...
    '031515_HVCChR2_XStimON_PitchShiftOFF_day7/lt_Opto_Stim_analy_batch.labeled.all_17Mar2015_1215X/PLOT_StimCatch_StimNotCatch_17Mar2015_1217/TimeWindow_17Mar2015_1218/OverTime_17Mar2015_1218',...
    '031515_HVCChR2_XStimOFF_PitchShiftON_day7/lt_Opto_Stim_analy_batch.labeled.all_17Mar2015_1057X/PLOT_All_17Mar2015_1059/TimeWindow_17Mar2015_1059/OverTime_17Mar2015_1100',...
    '031615_HVCChR2_XStimON_PitchShiftOFF_day8/lt_Opto_Stim_analy_batch.labeled.all_29Mar2015_1727X/PLOT_StimCatch_StimNotCatch_29Mar2015_1731/TimeWindow_29Mar2015_1733/OverTime_29Mar2015_1733',...
    '031615_HVCChR2_XStimOFF_PitchShiftON_day8/lt_Opto_Stim_analy_batch.labeled.all_17Mar2015_1128X/PLOT_All_17Mar2015_1130/TimeWindow_17Mar2015_1130/OverTime_17Mar2015_1130',...
    '031715_HVCChR2_XStimON_PitchShiftOFF_day9/lt_Opto_Stim_analy_batch.labeled.all_17Mar2015_1137X/PLOT_StimCatch_StimNotCatch_17Mar2015_1138/TimeWindow_17Mar2015_1139/OverTime_17Mar2015_1140',...
    '031415_HVCChR2_XStimOFF_PitchShiftON_day6/lt_Opto_Stim_analy_batch.labeled.all_17Mar2015_1152X/PLOT_All_17Mar2015_1154/TimeWindow_17Mar2015_1156/OverTime_17Mar2015_1156',...
    '031715_HVCChR2_XStimOFF_PitchShiftON_day9/lt_Opto_Stim_analy_batch.labeled.all_17Mar2015_1623X/PLOT_All_17Mar2015_1624/TimeWindow_17Mar2015_1627/OverTime_17Mar2015_1627',...
    '031715_HVCChR2_XStimON_PitchShiftOFF_day9/lt_Opto_Stim_analy_batch.labeled.all_18Mar2015_1024X/PLOT_StimCatch_StimNotCatch_18Mar2015_1027/TimeWindow_18Mar2015_1030/OverTime_18Mar2015_1032',...
    '031715_HVCChR2_XStimOFF_PitchShiftON_day9/lt_Opto_Stim_analy_batch.labeled.all_18Mar2015_1039X/PLOT_All_18Mar2015_1040/TimeWindow_18Mar2015_1040/OverTime_18Mar2015_1040',...
    '031815_HVCChR2_XStimOFF_PitchShiftON_day10/lt_Opto_Stim_analy_batch.labeled.all_18Mar2015_1439X/PLOT_All_18Mar2015_1440/TimeWindow_18Mar2015_1443/OverTime_18Mar2015_1443',...
    '031815_HVCChR2_XStimOFF_PitchShiftON_day10/lt_Opto_Stim_analy_batch.labeled.all_19Mar2015_1257X/PLOT_All_19Mar2015_1259/TimeWindow_19Mar2015_1301/OverTime_19Mar2015_1301',...
    '031815_HVCChR2_XStimON_PitchShiftOFF_day10/lt_Opto_Stim_analy_batch.labeled.all_19Mar2015_1244X/PLOT_StimCatch_StimNotCatch_19Mar2015_1245/TimeWindow_19Mar2015_1249/OverTime_19Mar2015_1250',...
    '031815_HVCChR2_DIRECTED/lt_Opto_Stim_analy_batch.labeled.all_19Mar2015_1419X/PLOT_All_19Mar2015_1419/TimeWindow_19Mar2015_1439/OverTime_19Mar2015_1442',...
    '031915_HVCChR2_XStimOFF_PitchShiftON_day11/lt_Opto_Stim_analy_batch.labeled.all_29Mar2015_1740X/PLOT_All_29Mar2015_1741/TimeWindow_29Mar2015_1742/OverTime_29Mar2015_1742',...
    '031915_HVCChR2_DIRECTED/lt_Opto_Stim_analy_batch.labeled.all_19Mar2015_1714X/PLOT_All_19Mar2015_1714/TimeWindow_19Mar2015_1715/OverTime_19Mar2015_1715',...
    '031915_HVCChR2_XStimON_PitchShiftOFF_day11/lt_Opto_Stim_analy_batch.labeled.all_29Mar2015_1747X/PLOT_StimCatch_StimNotCatch_29Mar2015_1750/TimeWindow_29Mar2015_1801/OverTime_29Mar2015_1801',...
    '032015_HVCChR2_XStimON_PitchShiftOFF_day12/lt_Opto_Stim_analy_batch.labeled.all_29Mar2015_1811X/PLOT_StimCatch_StimNotCatch_29Mar2015_1813/TimeWindow_29Mar2015_1816/OverTime_29Mar2015_1816',...
    '032315_HVCChR2_NoteGroups_StimWnON_day3/lt_Opto_Stim_analy_batch.labeled.all_23Mar2015_1224X/PLOT_StimCatch_StimNotCatch_23Mar2015_1225/TimeWindow_23Mar2015_1225/OverTime_23Mar2015_1225',...
    '032215_HVCChR2_NoteGroups_StimWnON_day2/lt_Opto_Stim_analy_batch.labeled.all_22Mar2015_1419X/PLOT_StimCatch_StimNotCatch_22Mar2015_1420/TimeWindow_22Mar2015_1421/OverTime_22Mar2015_1422',...
    '032115_HVCChR2_NoteGroups_StimWnON_day1/lt_Opto_Stim_analy_batch.labeled.all_21Mar2015_2222X/PLOT_StimCatch_StimNotCatch_21Mar2015_2224/TimeWindow_21Mar2015_2226/OverTime_21Mar2015_2226',...
    '032615_HVCChR2_NoteGroups_StimONWnON_day6/lt_Opto_Stim_analy_batch.labeled.all_28Mar2015_1809X/PLOT_StimCatch_StimNotCatch_28Mar2015_1811/TimeWindow_28Mar2015_1813/OverTime_28Mar2015_1814/',...
    '032615_HVCChR2_NoteGroups_StimONWnOFF_day6/lt_Opto_Stim_analy_batch.labeled.all_28Mar2015_1828X/PLOT_StimCatch_StimNotCatch_28Mar2015_1830/TimeWindow_28Mar2015_1833/OverTime_28Mar2015_1833/',...
    '030815_HVCChR2_XStim_StimOFF/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2009/PLOT_All_12Mar2015_2010/TimeWindow_12Mar2015_2010/OverTime_12Mar2015_2010',...
    '030815_HVCChR2_XStim_StimON_pulse/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2010/PLOT_StimCatch_StimNotCatch_12Mar2015_2012/TimeWindow_12Mar2015_2012/OverTime_12Mar2015_2012',...
    '030715_HVCChR2_XStim_StimOFF/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2015/PLOT_All_12Mar2015_2016/TimeWindow_12Mar2015_2016/OverTime_12Mar2015_2016',...
    '030715_HVCChR2_XStim_StimON_pulse/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2016/PLOT_StimCatch_StimNotCatch_12Mar2015_2018/TimeWindow_12Mar2015_2018/OverTime_12Mar2015_2018',...
    '030615_HVCChR2_XStim_StimON_pulse/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2022/PLOT_StimCatch_StimNotCatch_12Mar2015_2025/TimeWindow_12Mar2015_2025/OverTime_12Mar2015_2025',...
    '032715_HVCChR2_NoteGroups_StimOFFWnON_Targb2only_day1/lt_Opto_Stim_analy_batch.labeled.all_28Mar2015_1625X/PLOT_All_28Mar2015_1628/TimeWindow_28Mar2015_1638/OverTime_28Mar2015_1639',...
    '032715_HVCChR2_NoteGroups_StimONWnON_Targb2only_day1/lt_Opto_Stim_analy_v2/Stim',...
    '032715_HVCChR2_NoteGroups_StimONWnON_Targb2only_day1/lt_Opto_Stim_analy_batch.rec_FB.constk63_27Mar2015_2147X/PLOT_StimCatch_StimNotCatch_27Mar2015_2148/TimeWindow_28Mar2015_1545/OverTime_28Mar2015_1545',...
    '032715_HVCChR2_NoteGroups_StimONWnON_Targb2only_day1/lt_Opto_Stim_analy_batch.rec_FB.pulsek65_27Mar2015_2231X/PLOT_StimCatch_StimNotCatch_27Mar2015_2232/TimeWindow_28Mar2015_1542/OverTime_28Mar2015_1543',...
    '032815_HVCChR2_NoteGroups_StimONWnON_Targb2only_day2/lt_Opto_Stim_analy_batch.labeled.all_28Mar2015_1718X/PLOT_StimCatch_StimNotCatch_28Mar2015_1719/TimeWindow_30Mar2015_1232/OverTime_30Mar2015_1232',...
    '032815_HVCChR2_NoteGroups_StimOFFWnON_Targb2only_day2/lt_Opto_Stim_analy_batch.labeled.all_29Mar2015_1849X/PLOT_All_29Mar2015_1852/TimeWindow_30Mar2015_1230/OverTime_30Mar2015_1230',...    
    '032815_HVCChR2_NoteGroups_StimONWnON_Targb2only_day_stim2/lt_Opto_Stim_analy_batch.labeled.all_29Mar2015_1832X/PLOT_StimCatch_StimNotCatch_29Mar2015_1833/TimeWindow_30Mar2015_1234/OverTime_30Mar2015_1234',...
    '032915_HVCChR2_NoteGroups_StimONWnON_Targb2only_day3/lt_Opto_Stim_analy_batch.labeled.all_29Mar2015_1910X/PLOT_StimCatch_StimNotCatch_29Mar2015_1913/TimeWindow_30Mar2015_1238/OverTime_30Mar2015_1238',...
    '032915_HVCChR2_NoteGroups_StimOFFWnON_Targb2only_day3/lt_Opto_Stim_analy_batch.labeled.all_30Mar2015_1214X/PLOT_All_30Mar2015_1217/TimeWindow_30Mar2015_1236/OverTime_30Mar2015_1236',...
    '033015_HVCChR2_NoteGroups_StimOFFWnON_Targb2only_day4/lt_Opto_Stim_analy_v2/All',...
    '033015_HVCChR2_NoteGroups_StimONWnON_Targb2only_day4/lt_Opto_Stim_analy_batch.labeled.all_30Mar2015_1853X/PLOT_StimCatch_StimNotCatch_30Mar2015_1856/TimeWindow_30Mar2015_1857/OverTime_30Mar2015_1858/',...
    '033115_HVCChR2_NoteGroups_StimOFFWnON_Targb2only_day5/lt_Opto_Stim_analy_batch.labeled.all_01Apr2015_1306X/PLOT_All_01Apr2015_1311/TimeWindow_01Apr2015_1313/OverTime_01Apr2015_1314',...
    '033115_HVCChR2_NoteGroups_StimONWnON_Targb2only_day5/lt_Opto_Stim_analy_batch.labeled.all_01Apr2015_1315X/PLOT_StimCatch_StimNotCatch_01Apr2015_1316/TimeWindow_01Apr2015_1335/OverTime_01Apr2015_1335',...
    '040115_HVCChR2_NoteGroups_StimONWnON_Targb2only_day6/lt_Opto_Stim_analy_v2/Stim',...
    '040115_HVCChR2_NoteGroups_StimOffWnON_Targb2only_day6/lt_Opto_Stim_analy_v2/All'};

TimeFieldsOfInterest = 1:4;
statfield='ffvals';
BaselineDays=1:3;
plotStimEpochs=1;

lt_Opto_Stim_analy_SUMMARY_PlotOverTime(BirdDir,ListOfDirs,TimeFieldsOfInterest,statfield,BaselineDays,plotStimEpochs)


% ========================= EXPERIMENT 3 - ASSOCIATION (ALL UP TO DATE
% DATA)
BirdDir='/bluejay3/lucas/birds/wh73pk61/';

ListOfDirs=...
    {'030815_HVCChR2_XStim_StimOFF/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2009/PLOT_All_12Mar2015_2010/TimeWindow_12Mar2015_2010/OverTime_12Mar2015_2010',...
    '030815_HVCChR2_XStim_StimON_pulse/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2010/PLOT_StimCatch_StimNotCatch_12Mar2015_2012/TimeWindow_12Mar2015_2012/OverTime_12Mar2015_2012',...
    '030715_HVCChR2_XStim_StimOFF/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2015/PLOT_All_12Mar2015_2016/TimeWindow_12Mar2015_2016/OverTime_12Mar2015_2016',...
    '030715_HVCChR2_XStim_StimON_pulse/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2016/PLOT_StimCatch_StimNotCatch_12Mar2015_2018/TimeWindow_12Mar2015_2018/OverTime_12Mar2015_2018',...
    '030615_HVCChR2_XStim_StimON_pulse/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2022/PLOT_StimCatch_StimNotCatch_12Mar2015_2025/TimeWindow_12Mar2015_2025/OverTime_12Mar2015_2025',...
    '040215_HVCChR2_NoteGroups_StimONWnON_association_day1/lt_Opto_Stim_analy_v2/All/',...
    '040315_HVCChR2_NoteGroups_StimONWnON_association_day2/lt_Opto_Stim_analy_v2/All',...
    '040415_HVCChR2_NoteGroups_StimONWnON_association_day3/lt_Opto_Stim_analy_v2/All/',...
    '040515_HVCChR2_NoteGroups_StimONWnON_association_day4/lt_Opto_Stim_analy_v2/All/',...
    '040615_HVCChR2_NoteGroups_StimONWnON_association_day5/lt_Opto_Stim_analy_v2/Stim',...
    '040715_HVCChR2_NoteGroups_StimONWnON_association_StimupNostimdn_day1/lt_Opto_Stim_analy_v2/All/',...
    '040915_HVCChR2_NoteGroups_StimONWnON_association_StimupNostimdn_day3/lt_Opto_Stim_analy_v2/All/',...
    '041015_HVCChR2_NoteGroups_StimONWnON_association_StimupNostimdn_day4/lt_Opto_Stim_analy_v2/All/',...
    '041115_HVCChR2_NoteGroups_StimOFFWnON_association_day5/lt_Opto_Stim_analy_v2/All',...
    '041215_HVCChR2_NoteGroups_StimOFFWnON_association_day6/lt_Opto_Stim_analy_v2/All',...
    '041315_HVCChR2_StimONWnON_assoc_StimWNupNoStimWNDn_LaserCatch_day1/lt_Opto_Stim_analy_v2/Probe_post12',...
    '041415_HVCChR2_StimONWnON_assoc_StimWNupNoStimWNDn_LaserCatch_day2/lt_Opto_Stim_analy_v2/Probe/',...
    '041515_HVCChR2_StimONWnON_assoc_StimWNUpNoStimWNDn_LaserCatch_day1/lt_Opto_Stim_analy_v2/Probe/'};

TimeFieldsOfInterest = 1:4;
statfield='ffvals';
BaselineDays=1:3;
plotStimEpochs=0;

% ASSOC EXP: Params telling what days are stim + UP vs stim + DN, etc.
MetaParams.AssocExpt.Timeline.Stim_WNup_UniDir={'02Apr2015','03Apr2015','06Apr2015'};
MetaParams.AssocExpt.Timeline.Stim_WNdn_UniDir={'04Apr2015','05Apr2015'};
MetaParams.AssocExpt.Timeline.Stim_WNup_BiDir={'07Apr2015','08Apr2015','09Apr2015','10Apr2015'};
MetaParams.AssocExpt.Timeline.noStim_WNup={'11Apr2015'};
MetaParams.AssocExpt.Timeline.noStim_WNdn={'12Apr2015'};
MetaParams.AssocExpt.Timeline.Stim_WNup_probe={'15Apr2015'};
MetaParams.AssocExpt.Timeline.Stim_WNdn_probe={'13Apr2015','14Apr2015'};

lt_Opto_Stim_analy_SUMMARY_PlotOverTime(BirdDir,ListOfDirs,TimeFieldsOfInterest,statfield,BaselineDays,plotStimEpochs,MetaParams)


% =================== EXPERIMENT - CONCURRENT STIM + WN REVERSION DAYS
% 3/21 to 3/26
% 1/21 to 1/26 (power might be bad, earliest video check came after this)



% ===================== EXPERIMENT - REVERSION (ALL DAYS WITH WN ON WHILE
% STIM)
% Combining experiments:
% 1) 3/26 to 4/1
% 2) 4/20 to 5/24
% (6/1/15) - UP TO DATE.


% -- Get directories of interest

BirdDir='/bluejay3/lucas/birds/wh73pk61/';

ListOfDirs1=...
    {'030815_HVCChR2_XStim_StimOFF/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2009/PLOT_All_12Mar2015_2010/TimeWindow_12Mar2015_2010/OverTime_12Mar2015_2010',...
    '030815_HVCChR2_XStim_StimON_pulse/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2010/PLOT_StimCatch_StimNotCatch_12Mar2015_2012/TimeWindow_12Mar2015_2012/OverTime_12Mar2015_2012',...
    '030715_HVCChR2_XStim_StimOFF/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2015/PLOT_All_12Mar2015_2016/TimeWindow_12Mar2015_2016/OverTime_12Mar2015_2016',...
    '030715_HVCChR2_XStim_StimON_pulse/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2016/PLOT_StimCatch_StimNotCatch_12Mar2015_2018/TimeWindow_12Mar2015_2018/OverTime_12Mar2015_2018',...
    '030615_HVCChR2_XStim_StimON_pulse/lt_Opto_Stim_analy_batch.labeled.all_12Mar2015_2022/PLOT_StimCatch_StimNotCatch_12Mar2015_2025/TimeWindow_12Mar2015_2025/OverTime_12Mar2015_2025',...
    '032615_HVCChR2_NoteGroups_StimONWnON_day6/lt_Opto_Stim_analy_batch.labeled.all_28Mar2015_1809X/PLOT_StimCatch_StimNotCatch_28Mar2015_1811/TimeWindow_28Mar2015_1813/OverTime_28Mar2015_1814/',...
    '032615_HVCChR2_NoteGroups_StimONWnOFF_day6/lt_Opto_Stim_analy_batch.labeled.all_28Mar2015_1828X/PLOT_StimCatch_StimNotCatch_28Mar2015_1830/TimeWindow_28Mar2015_1833/OverTime_28Mar2015_1833/',...
    '032715_HVCChR2_NoteGroups_StimOFFWnON_Targb2only_day1/lt_Opto_Stim_analy_v2/All',...
    '032715_HVCChR2_NoteGroups_StimONWnON_Targb2only_day1/lt_Opto_Stim_analy_v2/Stim',...
    '032815_HVCChR2_NoteGroups_StimONWnON_Targb2only_day2/lt_Opto_Stim_analy_batch.labeled.all_28Mar2015_1718X/PLOT_StimCatch_StimNotCatch_28Mar2015_1719/TimeWindow_30Mar2015_1232/OverTime_30Mar2015_1232',...
    '032815_HVCChR2_NoteGroups_StimOFFWnON_Targb2only_day2/lt_Opto_Stim_analy_v2/All',...    
    '032815_HVCChR2_NoteGroups_StimONWnON_Targb2only_day_stim2/lt_Opto_Stim_analy_batch.labeled.all_29Mar2015_1832X/PLOT_StimCatch_StimNotCatch_29Mar2015_1833/TimeWindow_30Mar2015_1234/OverTime_30Mar2015_1234',...
    '032915_HVCChR2_NoteGroups_StimONWnON_Targb2only_day3/lt_Opto_Stim_analy_batch.labeled.all_29Mar2015_1910X/PLOT_StimCatch_StimNotCatch_29Mar2015_1913/TimeWindow_30Mar2015_1238/OverTime_30Mar2015_1238',...
    '032915_HVCChR2_NoteGroups_StimOFFWnON_Targb2only_day3/lt_Opto_Stim_analy_v2/All',...
    '033015_HVCChR2_NoteGroups_StimOFFWnON_Targb2only_day4/lt_Opto_Stim_analy_v2/All',...
    '033015_HVCChR2_NoteGroups_StimONWnON_Targb2only_day4/lt_Opto_Stim_analy_batch.labeled.all_30Mar2015_1853X/PLOT_StimCatch_StimNotCatch_30Mar2015_1856/TimeWindow_30Mar2015_1857/OverTime_30Mar2015_1858/',...
    '033115_HVCChR2_NoteGroups_StimOFFWnON_Targb2only_day5/lt_Opto_Stim_analy_batch.labeled.all_01Apr2015_1306X/PLOT_All_01Apr2015_1311/TimeWindow_01Apr2015_1313/OverTime_01Apr2015_1314',...
    '033115_HVCChR2_NoteGroups_StimONWnON_Targb2only_day5/lt_Opto_Stim_analy_batch.labeled.all_01Apr2015_1315X/PLOT_StimCatch_StimNotCatch_01Apr2015_1316/TimeWindow_01Apr2015_1335/OverTime_01Apr2015_1335',...
    '040115_HVCChR2_NoteGroups_StimONWnON_Targb2only_day6/lt_Opto_Stim_analy_v2/Stim',...
    '040115_HVCChR2_NoteGroups_StimOffWnON_Targb2only_day6/lt_Opto_Stim_analy_v2/All'};
    

MetadataStruct=lt_metadata_collect;

experiment = '';
condition='';
notes='';
date_range={'20Apr2015','20May2015'};
only_labeled_dirs=1;

ListOfDirs2=lt_metadata_find_dirs(MetadataStruct, experiment, condition, notes, date_range, only_labeled_dirs);

% get the correct subdir that contains opto stats
c=1;
for i=1:length(ListOfDirs2);
    cd(ListOfDirs2{i});
    
    tmp=[];
    try
        cd lt_Opto_Stim_analy_v2
        try cd 'All';
            tmp='All';
        catch err
            try cd 'Stim';
                tmp='Stim';
            end
        end
    catch err
        disp(['error - no lt_Opto_Stim_analy_v2 data on: ' ListOfDirs2{i} ' - throwing day out']);
    cd(BirdDir);        
        continue
    end
    
    % go back up to main dir
    cd(BirdDir);
    
    % modify name to add opto analysis name
    ListOfDirs2_modified{c}=[ListOfDirs2{i} '/lt_Opto_Stim_analy_v2/' tmp];
    c=c+1;
end

ListOfDirs_all=[ListOfDirs1 ListOfDirs2_modified];

% Params for analysis
TimeFieldsOfInterest = 1:4;
statfield='ffvals';
BaselineDays=1:3;
plotStimEpochs=1;


lt_Opto_Stim_analy_SUMMARY_PlotOverTime(BirdDir, ListOfDirs_all,TimeFieldsOfInterest,statfield,BaselineDays,plotStimEpochs)



%% AUTOLABELING
Params.batch='batch.rec_FB.rand';

Params.ampThresh=21000;
Params.min_dur=13;
Params.min_int=1;

Params.syl.pre='';
Params.syl.post='';
Params.syl.targ='b';

Params.overwrite_notmat=1;


% TEMPLATE SETTINGS
Params.TEMPLATE.templatefile = 'autolabel_templ_b1_v2.dat';
Params.TEMPLATE.cntrng(1).MIN=1;
Params.TEMPLATE.cntrng(1).MAX=3;
Params.TEMPLATE.cntrng(1).NOT=0;
Params.TEMPLATE.cntrng(1).MODE=1;
Params.TEMPLATE.cntrng(1).TH=1;
Params.TEMPLATE.cntrng(1).AND=0;
Params.TEMPLATE.cntrng(1).BTMIN=0;

Params.TEMPLATE.cntrng(2).MIN=1;
Params.TEMPLATE.cntrng(2).MAX=3;
Params.TEMPLATE.cntrng(2).NOT=0;
Params.TEMPLATE.cntrng(2).MODE=1;
Params.TEMPLATE.cntrng(2).TH=2.2;
Params.TEMPLATE.cntrng(2).AND=0;
Params.TEMPLATE.cntrng(2).BTMIN=0;

Params.TEMPLATE.cntrng(3).MIN=1;
Params.TEMPLATE.cntrng(3).MAX=3;
Params.TEMPLATE.cntrng(3).NOT=0;
Params.TEMPLATE.cntrng(3).MODE=1;
Params.TEMPLATE.cntrng(3).TH=2.2;
Params.TEMPLATE.cntrng(3).AND=1;
Params.TEMPLATE.cntrng(3).BTMIN=0;

Params.TEMPLATE.cntrng(4).MIN=0;
Params.TEMPLATE.cntrng(4).MAX=10;
Params.TEMPLATE.cntrng(4).NOT=0;
Params.TEMPLATE.cntrng(4).MODE=0;
Params.TEMPLATE.cntrng(4).TH=3;
Params.TEMPLATE.cntrng(4).AND=0;
Params.TEMPLATE.cntrng(4).BTMIN=0;

Params.TEMPLATE.refract=0.2;



% RUN
[fnames, sylnum, vlsorfn, vlsorind]=lt_autolabel_function(Params);


%% 2) TO CHECK ACCURACY - isolates all syls labeled and saves to .wav -
% open and check by eye. -----------------
[fnames, sylnum]=lt_jc_chcklbl(Params.batch, Params.syl.targ, 0.025,0.025,'','','');
[vlsorfn vlsorind]=jc_vlsorfn(Params.batch, Params.syl.targ, '', '');

% Troubleshooting, enter syl name you want to find song of.
% [fnames, sylnum]=lt_jc_chcklbl(batch,'x', 0.025,0.025,'','','');
% [vlsorfn vlsorind]=jc_vlsorfn(batch,'x','','');
   
disp('DONE!');


%% After using evsonganaly, run below to replace with corrected things

%     X1=load('syllwv1.wav.not.mat');
%     X2=load('syllwv2.wav.not.mat');
%     XcatLabels=strcat(X1.labels, X2.labels);
%     [Inds, NewSyl]=regexp(XcatLabels,'\w','start','match');
% %     newsyl=strjoin(NewSyl,'\0');
% 
%     lt_jc_fndlbl(vlsorind, vlsorfn, Inds, NewSyl,1)

% collect all labels
labels_all=[];
for i=1:length(fnames);
    load([fnames{i} '.not.mat']);
    labels_all=[labels_all labels];
end

% Any thing not '-' will be replaced by the entered label.
Inds=find(labels_all~='-');
sylnum_handlabeled=length(labels_all);

if sylnum~=sylnum_handlabeled;
    disp('WARNING - hand labeled # of syl does not match actual number, can cause autolabeling frameshift error - check evsonganaly thresholding');
else
disp('GOOD - hand labeled num of syl is correct');
end

lt_jc_fndlbl(vlsorind,vlsorfn,Inds,labels_all,1)



%% AUTOLABELING ACROSS DAYS
clear all; close all;

DirList={'/bluejay3/lucas/birds/wh73pk61/032715_HVCChR2_NoteGroups_StimOFFWnON_Targb2only_day1', ...
    '/bluejay3/lucas/birds/wh73pk61/032815_HVCChR2_NoteGroups_StimOFFWnON_Targb2only_day2',...
    '/bluejay3/lucas/birds/wh73pk61/032915_HVCChR2_NoteGroups_StimOFFWnON_Targb2only_day3',...
    '/bluejay3/lucas/birds/wh73pk61/051315_ReversionWNup_StimOFFWnON',...
    '/bluejay3/lucas/birds/wh73pk61/051415_ReversionWNup_StimONWnON',...
    '/bluejay3/lucas/birds/wh73pk61/051415_ReversionWNup_StimOFFWnON', ...
    '/bluejay3/lucas/birds/wh73pk61/051515_ReversionWNup_StimOFFWnON', ...
    '/bluejay3/lucas/birds/wh73pk61/051615_ReversionWNup_StimOFFWnON',...
    '/bluejay3/lucas/birds/wh73pk61/051615_ReversionWNup_StimONWnON', ...
    '/bluejay3/lucas/birds/wh73pk61/051715_ReversionWNup_StimOFFWnOFF', ...
    '/bluejay3/lucas/birds/wh73pk61/051815_ReversionWNup_StimOFFWnOFF',...
    '/bluejay3/lucas/birds/wh73pk61/051915_ReversionWNup_StimOFFWnOFF', ...
    '/bluejay3/lucas/birds/wh73pk61/052015_ReversionWNup_StimONWnOFF',...
    '/bluejay3/lucas/birds/wh73pk61/052015_ReversionWNup_StimOFFWnOFF'};

curdir=pwd;

for i=1:length(DirList);
    cd(curdir);
    cd(DirList{i});
% Collect all songs
% lt_make_batch(1)

% Autolabel
Params.batch='batch.rec_FB.rand';

Params.ampThresh=21000;
Params.min_dur=13;
Params.min_int=1;

Params.syl.pre='';
Params.syl.post='';
Params.syl.targ='b';

Params.overwrite_notmat=1;


% TEMPLATE SETTINGS
Params.TEMPLATE.templatefile = 'autolabel_templ_b1_v2.dat';
Params.TEMPLATE.cntrng(1).MIN=1;
Params.TEMPLATE.cntrng(1).MAX=3;
Params.TEMPLATE.cntrng(1).NOT=0;
Params.TEMPLATE.cntrng(1).MODE=1;
Params.TEMPLATE.cntrng(1).TH=1;
Params.TEMPLATE.cntrng(1).AND=0;
Params.TEMPLATE.cntrng(1).BTMIN=0;

Params.TEMPLATE.cntrng(2).MIN=1;
Params.TEMPLATE.cntrng(2).MAX=3;
Params.TEMPLATE.cntrng(2).NOT=0;
Params.TEMPLATE.cntrng(2).MODE=1;
Params.TEMPLATE.cntrng(2).TH=2.2;
Params.TEMPLATE.cntrng(2).AND=0;
Params.TEMPLATE.cntrng(2).BTMIN=0;

Params.TEMPLATE.cntrng(3).MIN=1;
Params.TEMPLATE.cntrng(3).MAX=3;
Params.TEMPLATE.cntrng(3).NOT=0;
Params.TEMPLATE.cntrng(3).MODE=1;
Params.TEMPLATE.cntrng(3).TH=2.2;
Params.TEMPLATE.cntrng(3).AND=1;
Params.TEMPLATE.cntrng(3).BTMIN=0;

Params.TEMPLATE.cntrng(4).MIN=0;
Params.TEMPLATE.cntrng(4).MAX=10;
Params.TEMPLATE.cntrng(4).NOT=0;
Params.TEMPLATE.cntrng(4).MODE=0;
Params.TEMPLATE.cntrng(4).TH=3;
Params.TEMPLATE.cntrng(4).AND=0;
Params.TEMPLATE.cntrng(4).BTMIN=0;

Params.TEMPLATE.refract=0.2;



% RUN
[fnames, sylnum, vlsorfn, vlsorind]=lt_autolabel_function(Params);

end



%% ============= USING CONTEXT ANALYSIS TO ANALYZE ASSOCIATION EXPERIMENT

% 4/2 to 4/6, one-dir association, used catch song, so will have to modify
% context code to analyze that.


% 4/7 to 4/10 - 
% NG0 = laser + WNup
% NG1 = WNdn
lt_make_batch(1);
Params.batch='batch.keep';
Params.config='/bluejay3/lucas/birds/wh73pk61/042215_HVCChR2_StimOFFWnON_reversion_day3/config.evconfig2'; % starting 4/22 3:20pm
Params.expt_phrase='Association';

Params.dataID='All'; % e.g. id of data (e.g. 'All' for all data in data). if blank, uses batch name.

% -- Run evtafsim and save information
AllData=lt_context_ExtractDayData(Params);


% ======================= COLLECT AllData Structures from multiple days
clear all; close all;

% Params
Params_alldays.CollectAllData=1; % if 1, then collects all data starting from first day
Params_alldays.firstday='';
Params_alldays.lastday='';

Params_alldays.NoteToPlot=1; % this is the note whose detects we will analyze (i.e. this note should get all renditions of the syl)
Params_alldays.RunBin=10;

Params_alldays.BoundaryTimes={'09Apr2015-1802', '10Apr2015-1837', '14Apr2015-2400', '15Apr2015-2400', ...
    '18Apr2015-1555'}; % in format of e.g. 05May2014-1423, these are times of switching in experiment (e.g. turning WN off and on, changing pitch contingency, etc)

% NOTE TO SELF:
% Phase 1 = 4/7 to 4/9 (bidir)
% Phase 2 = 4/9 to 4/10 (bidir, problem, then continued)
% Phase 3 = 4/13 to 4/14 (4 song classes - laser + dn)
% Phase 4 = 4/14 to 4/15 (4 song classes - laser + up) 
% Phase 5 = 4/15 to 4/18 (broke association, 6 classes)
% Phase 6 = nothing

lt_context_CompileAndPlot(Params_alldays);



