%% does the PDF of post learning FF reveal the original pre-learning FF? i.e. multimodality of FF PDF?

% notes - conversion values for days:
% pre1 10/30/12
% post1 11/23/12
% 79 = 1st WN day


% new FF: 3280
% old FF: 3160

% conclusion - some days, those with overlap with previous FF, are bimodal
% (either sentered at old FF, or lower), while those without overlap, and
% pre-learning days, are unimodal.


%% combining raw values for last 4 stable days before 2nd driving of WN down
% go to all_days_pitch... and load the data structure that ends in
% "..._data.mat"

% Then compile raw val;ues over many days and plot.

compiled_FF_values=[];
clear dummy
for n=69:72;
    dummy=FF.a.time_and_FF{n}(:,2);
    compiled_FF_values=[compiled_FF_values; dummy];
    clear dummy
end

figure(1); hist(compiled_FF_values,60); 
figure(2);  hist(compiled_FF_values,30);

% Dont see tendency to sing at lower freq of baseline (3160).  possibly
% indicate that variation needs to overlap to see bimodality?

%% few days after the previous stable days were FF goes down and see overlap of bvariability.  now do be see bimodality?

% all days after above before WN start again on day 79
compiled_FF_values=[];
clear dummy
for n=73:78; 
    dummy=FF.a.time_and_FF{n}(:,2);
    compiled_FF_values=[compiled_FF_values; dummy];
    clear dummy
end

figure(3); hist(compiled_FF_values,60); 
figure(4);  hist(compiled_FF_values,30);
figure(12); probplot('normal', compiled_FF_values)


% only these days that seemed top have highest variability within this period
compiled_FF_values=[];
clear dummy
for n=74:76; 
    dummy=FF.a.time_and_FF{n}(:,2);
    compiled_FF_values=[compiled_FF_values; dummy];
    clear dummy
end

figure(5); hist(compiled_FF_values,60); 
figure(6);  hist(compiled_FF_values,30);
figure(12); probplot('normal', compiled_FF_values)

%% plot only individual days in the above period.
for day_num= 73:80;
    figure(day_num);  hist(FF.a.time_and_FF{day_num}(:,2),15);
end


%% compile values over the 10 days before the first big gap (i.e. post learning, stable) (day 40-49)
compiled_FF_values=[];
clear dummy
for n=50:68; 
    dummy=FF.a.time_and_FF{n}(:,2);
    compiled_FF_values=[compiled_FF_values; dummy];
    clear dummy
end

figure(7); hist(compiled_FF_values,60); 
figure(8);  hist(compiled_FF_values,30);
%% take the two days in the big gap as stable days

compiled_FF_values=[];
clear dummy
for n=50:68; 
    try
    dummy=FF.a.time_and_FF{n}(:,2);
    catch
        n=n+1;
        continue
    end
    compiled_FF_values=[compiled_FF_values; dummy];
    clear dummy
end

figure(9); hist(compiled_FF_values,15); 
figure(10);  hist(compiled_FF_values,30);

%% as control do pre-learning

compiled_FF_values=[];
clear dummy
for n=1:3; 
    dummy=FF.a.time_and_FF{n}(:,2);
    compiled_FF_values=[compiled_FF_values; dummy];
    clear dummy
end

figure(11); hist(compiled_FF_values,20); 
figure(13);  hist(compiled_FF_values,40);
figure(14); probplot('normal', compiled_FF_values)

