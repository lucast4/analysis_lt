%% 2/14/14 - take song times and plot intervals.  (i used rd66gr93 2/12 as has transitions, so rec hits might be more reliable).
% related to joanne's bird showing around 50s periodicity for intersyllable
% intervals.


DateNum_songs_with_FB_MoreThanOne
shifted=DateNum_songs_with_FB_MoreThanOne;

shifted(1:end-1)=shifted(2:end);

interval=shifted(1:end-1)-DateNum_songs_with_FB_MoreThanOne(1:end-1);

[interval_hours]=lt_convert_datenum_to_hour(interval);

interval_sec=interval_hours*3600;

figure; hist(interval_sec,360)


%% plot scatter of one interval versus subsequent

interval_sec_plus1=interval_sec;
interval_sec_plus1(1:end-1)=interval_sec_plus1(2:end);
figure; 
scatter(interval_sec(1:end-1),interval_sec_plus1(1:end-1))