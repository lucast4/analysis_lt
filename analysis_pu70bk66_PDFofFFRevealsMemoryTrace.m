%% does the PDF of post learning FF reveal the original pre-learning FF? i.e. multimodality of FF PDF?

% notes - conversion values for days:


% new FF: 3500 (decreasing)
% old FF: 3420

% conclusion - 

%% combining raw values over many stable days post 1st learning before 2nd learning
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
figure(6); probplot('normal',compiled_FF_values)

% seems consistend with there being two gaussians, and the old FF one being
% larger.

%% same but for period right before the gap, that was still stable. 

compiled_FF_values=[];
clear dummy
for n=45:50;
    dummy=FF.b.time_and_FF{n}(:,2);
    compiled_FF_values=[compiled_FF_values; dummy];
    clear dummy
end

figure(3); hist(compiled_FF_values,60); 
figure(4);  hist(compiled_FF_values,30);
figure(5); cdfplot(compiled_FF_values)

%% make Cumulative probabilty function


