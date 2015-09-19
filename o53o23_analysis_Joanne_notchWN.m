clear all;close all;
batch='batch.catch.keep';
syl_target='a';
syl_pre={''};
phrase='test';
freq_range={[2200 4000]};
pc_time_window={[10 110]};
plot_result=1;
pc_window=3000;

lt_calc_day_pitch_v2_FUNCTION(syl_target, syl_pre, phrase, ...
    freq_range, pc_time_window, plot_result,pc_window,batch)