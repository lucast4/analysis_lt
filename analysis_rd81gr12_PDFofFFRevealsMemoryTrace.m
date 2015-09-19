%% does the PDF of post learning FF reveal the original pre-learning FF? i.e. multimodality of FF PDF?

% notes - conversion values for days:
% total dur 10nov to 11jan, 63 days (ends on post day 39)
% 12/05 was 1st post day
% 12/11-12/17 was what I called post stable days (post days 7-13), day 32-38.

% new ff: 3360
% old ff: 3400

%% combining raw values for last 6 days
% go to all_days_pitch... and load the data structure that ends in
% "..._data.mat"

% Then compile raw val;ues over many days and plot.

compiled_FF_values=[];
clear dummy
for n=58:63;
    dummy=FF.b.time_and_FF{n}(:,2);
    compiled_FF_values=[compiled_FF_values; dummy];
    clear dummy
end

figure(1); hist(compiled_FF_values,60); 
figure(2);  hist(compiled_FF_values,30);
figure(12); probplot('normal', compiled_FF_values)
gmdistribution.fit(compiled_FF_values,2)


%might be an extra peak at the old FF, 3400.  

%% now try with post-learning, right after stabilize FF.

% from post day 7 to 13, stable mean.

compiled_FF_values_postlearning=[];
clear dummy
for n=32:38;
    dummy=FF.b.time_and_FF{n}(:,2);
    compiled_FF_values_postlearning=[compiled_FF_values_postlearning; dummy];
    clear dummy
end

figure(3); hist(compiled_FF_values_postlearning,60); 
figure(4);  hist(compiled_FF_values_postlearning,30);
figure(13); probplot('normal', compiled_FF_values)
gmdistribution.fit(compiled_FF_values_postlearning,2)


%% try as control pre-learning

compiled_FF_values_prelearning=[];
clear dummy
for n=1:4;
    dummy=FF.b.time_and_FF{n}(:,2);
    compiled_FF_values_prelearning=[compiled_FF_values_prelearning; dummy];
    clear dummy
end

figure(5); hist(compiled_FF_values_prelearning,60); 
figure(6);  hist(compiled_FF_values_prelearning,30);
figure(13); probplot('normal', compiled_FF_values)
gmdistribution.fit(compiled_FF_values_prelearning,2)



%% can look at runnign average for post day 7 to see if bird transitions between states (sing low or high pitch)
% not obvious



%%
figure; hist(FF.b.time_and_FF{60}(:,2),70)