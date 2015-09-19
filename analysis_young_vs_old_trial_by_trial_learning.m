%% LT 10/2013 - here I ask whether young birds learn quicker than old birds.  

% The important poitn is that looking at the day to day learning is not
% very informative, since a high learning reate would be "buffered" down by
% the bird eascaping threshold earlier in the day.  

% Times when DB changed threshold frequencies: (they were not 1/day, but
% maybe quite variable?  Not sure, will look at his notebook). (All are set
% at 70%-ile unless otherwise noted).

bk42bk46 - 
8/21/12 - 12:09pm (3367), 5:08 (3406)
8/22 - 1:06 (3512), 6:05 (3564)
8/23 - 12:37 (3570), ?/afternoon (3623)
8/24 - 12:46 (3628), ? (3634)
8/25 - 12:37 (3610), ? (3608) 

%% analysis

% plotting just the first n renditions of syllable

% for bk42bk46
load bk42bk46_CP_young_pitch_FF_data.mat
FF.a.time_and_FF % contains FF data for each rendition.

% plot a running average of the learning trajctory for each day. 

for i=4;
    for window=[1 5 10 20 40 60];
        running_average{i}{window}=runningaverage(FF.a.time_and_FF{i}(:,2),window);
        figure; plot(running_average{i}{window}) 
    end
end
    
figure; hold on;    
for i=4;
    plot(FF.a.time_and_FF{i}(1:100,:)) % day 4 to 8 are WN days ( only 5 days)
end

%3310 to 3370 in 20 trials (window 20)
% 3300 to 3370 in 15 trials (window 10)

%% do the same as above for other birds

% bk51bk59 - young.

day1-
2/14/13 - 2:09 (5134), 

% start day 5
load bk51bk59.mat

for i=5;
    for window=[1 5 10 20 40 60];
        running_average{i}{window}=runningaverage(multiple_pitch.FF.a.time_and_FF{i}(:,2),window);
        figure; plot(running_average{i}{window}) 
    end
end

% from 5050 to 5350 in 70 trials (window of 20)

%% bk59bk42 - 88dph
%  day 6 is first WN day
% target is syl a
clear all
close all
load bk59bk42_CP_young_pitch_FF_data.mat

for i=7;
    for window=[1 5 10 20 40 60];
        running_average{i}{window}=runningaverage(FF.a.time_and_FF{i}(:,2),window);
        figure; plot(running_average{i}{window}) 
    end
end

%  about 60 triasl for 2580 to 2640 (window 10 or 20), almost no flat to
%  start

%% bk27bk66

% start day 5 (WN), hit 2/day, target was "a"

load bk27bk66_CP_pitch_FF_data.mat

for i=5;
    for window=[1 5 10 20 40 60];
        running_average{i}{window}=runningaverage(FF.a.time_and_FF{i}(:,2),window);
        figure; plot(running_average{i}{window}) 
    end
end

% about 80 renditions to get from ~5110 to 5190. (window 20)
% similar in window 10

%% rd81gr12

load rd81gr12_CP_young_pitch_FF_data.mat

% start WN day 5
% syllable b

for i=5;
    for window=[1 5 10 20 40];
        running_average{i}{window}=runningaverage(FF.b.time_and_FF{i}(:,2),window);
        figure; plot(running_average{i}{window}) 
    end
end

% about 23 trials to get from 3335 to 3390 (note there are few trials
% labeled over the day, so possibly that is underestimating the slowness of
% learning. (window 20)

%% 

% WN day 1 is day 13
% target is syl b.

load pu70bk66_CP_young_pitch_FF_data.mat

for i=13;
    for window=[1 5 10 20 40 60];
        running_average{i}{window}=runningaverage(FF.b.time_and_FF{i}(:,2),window);
        figure; plot(running_average{i}{window}) 
    end
end

% took 130 trials to get from 3460 to 3540 (window 20).  flat until about
% trial 110.

%% bk90bk46

% WN starts day 5
% target is a (?)

clear all
close all
load bk90bk46_CP_old_pitch_FF_data.mat

for i=5;
    for window=[1 5 10 20 40 60];
        running_average{i}{window}=runningaverage(FF.a.time_and_FF{i}(:,2),window);
        figure; plot(running_average{i}{window}) 
    end
end


%  takes about 200 trials to get from 4990 to 5070 (window 20). flat until
%  about trial 40.