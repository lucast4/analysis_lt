%% does the PDF of post learning FF reveal the original pre-learning FF? i.e. multimodality of FF PDF?

% notes - conversion values for days:

% a
% new FF: 5020
% old FF: 4950

% b
% new ff: 5045
% old ff: 5000

% conclusion - not clear, maybe slight increase in extremem valules which
% might look like two gaussians.

%% combining raw values over many stable days post 1st learning after 2nd gap
% go to all_days_pitch... and load the data structure that ends in
% "..._data.mat"

% Then compile raw val;ues over many days and plot.

compiled_FF_values=[];
clear dummy
for n=69:77;
    dummy=FF.a.time_and_FF{n}(:,2);
    compiled_FF_values=[compiled_FF_values; dummy];
    clear dummy
end

figure(1); hist(compiled_FF_values,60); 
figure(2);  hist(compiled_FF_values,30);
figure(3); probplot('normal',compiled_FF_values)
gmdistribution.fit(compiled_FF_values,2)

% seems consistend with there being two gaussians, and the old FF one being
% larger.

%% do the same thing, but for syllable b, which was not targetted

compiled_FF_values=[];
clear dummy
for n=69:77;
    dummy=FF.b.time_and_FF{n}(:,2);
    compiled_FF_values=[compiled_FF_values; dummy];
    clear dummy
end

figure(4); hist(compiled_FF_values,60); 
figure(5);  hist(compiled_FF_values,30);
figure(6); probplot('normal',compiled_FF_values)

% seems consistend with there being two gaussians, and the old FF one being
% larger.

%% do same, but for last days, after return from 2nd WN learning

compiled_FF_values=[];
clear dummy
for n=96:102;
    dummy=FF.a.time_and_FF{n}(:,2);
    compiled_FF_values=[compiled_FF_values; dummy];
    clear dummy
end

figure(13); hist(compiled_FF_values,60); 
figure(14);  hist(compiled_FF_values,30);
figure(15); probplot('normal',compiled_FF_values)

% try to fit gaussian mixture model
gmdistribution.fit(compiled_FF_values,2)



%% do pre-learning as controls for a and b.

% syllable a
compiled_FF_values=[];
clear dummy
for n=1:3;
    dummy=FF.a.time_and_FF{n}(:,2);
    compiled_FF_values=[compiled_FF_values; dummy];
    clear dummy
end

figure(7); hist(compiled_FF_values,60); 
figure(8);  hist(compiled_FF_values,30);
figure(9); probplot('normal',compiled_FF_values)
gmdistribution.fit(compiled_FF_values,2)


% syllable b
compiled_FF_values=[];
clear dummy
for n=1:3;
    dummy=FF.b.time_and_FF{n}(:,2);
    compiled_FF_values=[compiled_FF_values; dummy];
    clear dummy
end

figure(10); hist(compiled_FF_values,60); 
figure(11);  hist(compiled_FF_values,30);
figure(12); probplot('normal',compiled_FF_values)
gmdistribution.fit(compiled_FF_values,2)


