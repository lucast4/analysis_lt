% clear all; close all;
% UNDIRfilename='/bluejay3/lucas/birds/pu53wh88/all_days_various_calculations/all_days_various_MOTIF_COMPILED_06Nov2014_2014';
% DIRfilename='bluejay3/lucas/birds/pu53wh88/all_days_various_calculations/all_days_various_MOTIF_COMPILED_06Nov2014_2042';

% LOAD DATA
    ADVcompiledUNDIR=load(UNDIRfilename);
    ADVcompiledDIR=load(DIRfilename);

% SD
day1_undir=ADVcompiledUNDIR.all_days_various_COMPILED.parameters_COMPILATION.first_day;
day1_dir=ADVcompiledDIR.all_days_various_COMPILED.parameters_COMPILATION.first_day;

% auto parameters
motif_table=ADVcompiledUNDIR.all_days_various_COMPILED.parameters_COMPILATION.motif_table;
syllables=ADVcompiledUNDIR.all_days_various_COMPILED.parameters_COMPILATION.syllables_COMPILED(:,2);
syllables_COMPILED=ADVcompiledUNDIR.all_days_various_COMPILED.parameters_COMPILATION.syllables_COMPILED;
num_syl=size(syllables,1);
plot_colors=lt_make_plot_colors(num_syl,0);


num_days=size(ADVcompiledUNDIR.all_days_various_COMPILED.all_days_various(1).lt_calc_day_pitch,2);

% plot (First, UNDIR);
if (0)
    hfig_allpitch=figure; hold on;
end

% FIRST, compile all syllables into an easy to use structure
for j=1:num_syl;
    syl=(syllables{j});
    ADV_undir.(syl)=ADVcompiledUNDIR.all_days_various_COMPILED.all_days_various(syllables_COMPILED{j,1}).lt_calc_day_pitch; % extract relevant structure from compiled structures
    ADV_dir.(syl)=ADVcompiledDIR.all_days_various_COMPILED.all_days_various(syllables_COMPILED{j,1}).lt_calc_day_pitch;
end


% plot (First, UNDIR);
for j=1:num_syl;
    syl=(syllables{j});
    
    Xmean_UNDIR.(syl)=nan(num_days,1);
    Xstd_UNDIR.(syl)=nan(num_days,1);
    Xn_UNDIR.(syl)=nan(num_days,1);
    Xse_UNDIR.(syl)=nan(num_days,1);
    
    all_days_various=ADVcompiledUNDIR.all_days_various_COMPILED.all_days_various(syllables_COMPILED{j,1}); % extract relevant structure from compiled structures
    
    for i=1:num_days; % number of days
        try
            Xmean_UNDIR.(syl)(i)=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).mean_FF;
            Xstd_UNDIR.(syl)(i)=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).sd_FF;
            Xn_UNDIR.(syl)(i)=size(all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF,1); % sample size
        catch err
            continue
        end
    end
    Xse_UNDIR.(syl)=Xstd_UNDIR.(syl)./sqrt(Xn_UNDIR.(syl));
    %     errorbar(X,Xstd,'o','Color',plot_colors{j});
    %     H(j)=plot(X,'o-','Color',plot_colors{j},'MarkerFaceColor',plot_colors{j},'MarkerSize',7);
    if (0) % plot median (below) instead
        h=errorbar(Xmean_UNDIR.(syl),Xse_UNDIR.(syl),'o-','Color',plot_colors{j},'MarkerFaceColor',plot_colors{j},'MarkerSize',12);
        errorbar_tick(h,200);
    end
end
% try
%     legend(H, motif_table(:,1));
% catch err
%     legend(H, motif_table(:,2));
% end


num_days=size(ADVcompiledUNDIR.all_days_various_COMPILED.all_days_various(1).lt_calc_day_pitch,2);
days_to_add=datenum(day1_dir,'ddmmmyyyy')-datenum(day1_undir,'ddmmmyyyy');

for j=1:num_syl;
    syl=syllables{j};
    
    Xmean_DIR.(syl)=nan(num_days+days_to_add,1);
    Xstd_DIR.(syl)=nan(num_days+days_to_add,1);
    Xn_DIR.(syl)=nan(num_days+days_to_add,1);
    Xse_DIR.(syl)=nan(num_days+days_to_add,1);
    all_days_various=ADVcompiledDIR.all_days_various_COMPILED.all_days_various(syllables_COMPILED{j,1}); % extract relevant structure from compiled structures
    for i=1:num_days; % number of days
        ii=i+days_to_add;
        try
            Xmean_DIR.(syl)(ii)=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).mean_FF;
            Xstd_DIR.(syl)(ii)=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).sd_FF;
            Xn_DIR.(syl)(ii)=size(all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).time_and_FF,1); % sample size
            Xse_DIR.(syl)(ii)=Xstd(i)/sqrt(Xn(i));
        catch err
            %             X(ii)=nan;
            %             Xstd(ii)=nan;
            %             Xn(ii)=nan;
            %             Xse(ii)=nan;
            continue
        end
    end
    Xse_DIR.(syl)=Xstd_DIR.(syl)./sqrt(Xn_DIR.(syl));
    if (0) % plot median (below), not means
        h=errorbar(Xmean_DIR.(syl),Xse_DIR.(syl),'s--','Color',plot_colors{j},'MarkerSize',12);
    end
end

% title('Pitch over days for all analyzed motifs: UNDIR (circle) and _DIR (square)');
% xlabel('days');
% ylabel('Pitch (hz)');

%% PLOT _DIR SONG value taking into account baseline differences

% First, get average baseline difference (average over days), then subtract
% that average from all days.

for j=1:num_syl;
    syl=syllables{j};
    Baseline_Compare_Inds=~isnan(Xmean_UNDIR.(syl)(baseline_days)).*~isnan(Xmean_DIR.(syl)(baseline_days)); % days where have both dir and undir song
    Baseline_Compare_Inds=logical(Baseline_Compare_Inds);
    
    DirBaseMean=mean(Xmean_DIR.(syl)(Baseline_Compare_Inds)); % mean of baseline days
    UndirBaseMean=mean(Xmean_UNDIR.(syl)(Baseline_Compare_Inds));
    
    DirMinusUndir_base.(syl)=DirBaseMean-UndirBaseMean;
    
end


if (0) % plot median (below) instead of this (mean)
    % Now replot as above, but subtract Baseline difference from dir data
    % points.
    
    % PLOT UNDIR
    figure; hold on;
    H=[];
    for j=1:num_syl;
        syl=(syllables{j});
        h=errorbar(Xmean_UNDIR.(syl),Xse_UNDIR.(syl),'o-','Color',plot_colors{j},'MarkerFaceColor',plot_colors{j},'MarkerSize',12);
        errorbar_tick(h,200);
    end
    try
        legend(H, motif_table(:,1));
    catch err
        legend(H, motif_table(:,2));
    end
    
    % PLOT DIR (subtracting baseline diff)
    for j=1:num_syl;
        syl=(syllables{j});
        MeanVal_subtracted=Xmean_DIR.(syl)-DirMinusUndir_base.(syl);
        h=errorbar([1:num_days+days_to_add]+0.2, MeanVal_subtracted,Xse_DIR.(syl),'s--','Color',plot_colors{j},'MarkerSize',9);
    end
    
    title('Pitch over days *WITH baseline diff subtracted from DIR datapoints*: UNDIR (circle) and DIR (square)');
    xlabel('days');
    ylabel('Pitch (hz)');
end


%% PLOT DAY VALUES, BUT PLOT MEDIAN (account for outliers?);
figure; hold on;
for j=1:num_syl;
    syl=(syllables{j});
    
    Xmedian_UNDIR.(syl)=nan(num_days,1);
    all_days_various=ADVcompiledUNDIR.all_days_various_COMPILED.all_days_various(syllables_COMPILED{j,1}); % extract relevant structure from compiled structures
    for i=1:num_days; % number of days
        try
            Xmedian_UNDIR.(syl)(i)=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).median_FF;
        catch err
            continue
        end
    end
    
    h=errorbar(Xmedian_UNDIR.(syl),Xse_UNDIR.(syl),'o-','Color',plot_colors{j},'MarkerFaceColor',plot_colors{j},'MarkerSize',12);
    errorbar_tick(h,200);
end
try
    legend(motif_table(:,1));
catch err
    legend(motif_table(:,2));
end
title('UNDIR: Median pitch over days');
xlabel('days');
ylabel('Pitch (hz)');
xlim([1 num_days]);
ylimits=ylim;
ylim([ylimits(1) ylimits(2)+100]);

figure; hold on;
% plot (First, UNDIR);
for j=1:num_syl;
    syl=syllables{j};
    
    Xmedian_DIR.(syl)=nan(num_days+days_to_add,1);
    all_days_various=ADVcompiledDIR.all_days_various_COMPILED.all_days_various(syllables_COMPILED{j,1}); % extract relevant structure from compiled structures
    for i=1:num_days; % number of days
        ii=i+days_to_add;
        try
            Xmedian_DIR.(syl)(ii)=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).median_FF;
        catch err
            continue
        end
    end
    h=errorbar(Xmean_DIR.(syl),Xse_DIR.(syl),'o-','Color',plot_colors{j},'MarkerFaceColor',plot_colors{j},'MarkerSize',12);
end
xlim([1 num_days]);
ylim([ylimits(1) ylimits(2)+100]);
try
    legend(motif_table(:,1));
catch err
    legend(motif_table(:,2));
end

title('DIR: Median pitch over days');
xlabel('days');
ylabel('Pitch (hz)');

%% PLOT MEDIAN, TAKING INTO ACCOUNT BASELINE DIFFERENCE (in mean)

% First, get average baseline difference (average over days), then subtract
% that average from all days.

for j=1:num_syl;
    syl=syllables{j};
    Baseline_Compare_Inds=~isnan(Xmean_UNDIR.(syl)(baseline_days)).*~isnan(Xmean_DIR.(syl)(baseline_days)); % days where have both dir and undir song
    Baseline_Compare_Inds=logical(Baseline_Compare_Inds);
    
    DirBaseMedian=mean(Xmedian_DIR.(syl)(Baseline_Compare_Inds)); % mean of baseline days
    UndirBaseMedian=mean(Xmedian_UNDIR.(syl)(Baseline_Compare_Inds));
    
    DirMinusUndir_baseMedian.(syl)=DirBaseMedian-UndirBaseMedian;
    
end


% PLOT UNDIR
figure; hold on;
H=[];
for j=1:num_syl;
    syl=(syllables{j});
    h=errorbar(Xmedian_UNDIR.(syl),Xse_UNDIR.(syl),'o-','Color',plot_colors{j},'MarkerFaceColor',plot_colors{j},'MarkerSize',12);
    errorbar_tick(h,200);
end
try
    legend(H, motif_table(:,1));
catch err
    legend(H, motif_table(:,2));
end

% PLOT DIR (subtracting baseline diff)
for j=1:num_syl;
    syl=(syllables{j});
    MedianVal_subtracted=Xmedian_DIR.(syl)-DirMinusUndir_baseMedian.(syl);
    h=errorbar([1:num_days+days_to_add]+0.3, MedianVal_subtracted,Xse_DIR.(syl),'s--','Color','k','MarkerSize',7,'MarkerFaceColor',plot_colors{j});
end

title('MEDIAN Pitch over days *WITH baseline diff subtracted from DIR datapoints*: UNDIR (circle) and DIR (square)');
xlabel('days');
ylabel('Pitch (hz)');


%% PLOT z-score relative to baseline (and using within day STD)
% baseline mean is mean of medians (across days), baeline std is mean
% within-day std.

% get baseline mean and average STD
baseline_days_dir=baseline_days-days_to_add; % e.g. if dir data starts one day ahead, then indices are one day smaller.
baseline_days_dir=baseline_days_dir(baseline_days_dir>0); % only positive are days


for j=1:num_syl;
    syl=(syllables{j});
    
    % collect baseline days
    BaselineMeansDir.(syl)=[];
    BaselineSTDDir.(syl)=[];
    BaselineMeansUndir.(syl)=[];
    BaselineSTDUndir.(syl)=[];
    
    for ii=baseline_days
        try
            BaselineMeansUndir.(syl)=[BaselineMeansUndir.(syl) ADV_undir.(syl){ii}.FF.(syl).median_FF];
            BaselineSTDUndir.(syl)=[BaselineSTDUndir.(syl) ADV_undir.(syl){ii}.FF.(syl).sd_FF];
        catch err
        end
    end
    for ii=baseline_days_dir;
        try
            BaselineMeansDir.(syl)=[BaselineMeansDir.(syl) ADV_dir.(syl){ii}.FF.(syl).median_FF]; % get mean of medians
            BaselineSTDDir.(syl)=[BaselineSTDDir.(syl) ADV_dir.(syl){ii}.FF.(syl).sd_FF];
        catch err
        end
    end
    
    BaselineTotalMeanDir.(syl)=mean(BaselineMeansDir.(syl));
    BaselineTotalSTDDir.(syl)=mean(BaselineSTDDir.(syl));
    BaselineTotalMeanUndir.(syl)=mean(BaselineMeansUndir.(syl));
    BaselineTotalSTDUndir.(syl)=mean(BaselineSTDUndir.(syl));
end

% Calculate z-scores for each day.
for j=1:num_syl;
    syl=(syllables{j});
    Zscore_Undir.(syl)=nan(num_days,1);
    Zscore_Dir.(syl)=nan(num_days-days_to_add,1);
    for ii=1:num_days;
        % undir
        try % some days no data
            XDIFF=ADV_undir.(syl){ii}.FF.(syl).median_FF-BaselineTotalMeanUndir.(syl);
            Zscore_Undir.(syl)(ii)=XDIFF/BaselineTotalSTDUndir.(syl);
        catch err
        end
        
        
        % dir (add days)
        try % since if days don't match some days here might not work.
            XDIFF=ADV_dir.(syl){ii}.FF.(syl).median_FF-BaselineTotalMeanDir.(syl);
            Zscore_Dir.(syl)(ii)=XDIFF/BaselineTotalSTDDir.(syl);
        catch err
        end
        
    end
    
end


% PLOT UNDIR
figure; hold on;
H=[];
for j=1:num_syl;
    syl=(syllables{j});
    plot(Zscore_Undir.(syl),'o-','Color',plot_colors{j},'MarkerFaceColor',plot_colors{j},'MarkerSize',12);
end
try
    legend(H, motif_table(:,1));
catch err
    legend(H, motif_table(:,2));
end
title('UNDIR: Z-scored day medians (relative to baseline median (mean across days), and day SDs (mean across days)');
ylabel('z-score');
xlabel('days');

% PLOT DIR (subtracting baseline diff)
figure; hold on;
H=[];
for j=1:num_syl;
    syl=(syllables{j});
    plot((1+days_to_add):length(Zscore_Dir.(syl))+days_to_add,Zscore_Dir.(syl),'o-','Color',plot_colors{j},'MarkerFaceColor',plot_colors{j},'MarkerSize',12)
end
try
    legend(H, motif_table(:,1));
catch err
    legend(H, motif_table(:,2));
end

title('DIR: Z-scored day medians (relative to baseline median (mean across days), and day SDs (mean across days)');
ylabel('z-score');
xlabel('days');



%% PLOT DAY BY DAY DIFF IN DIR VS. UNDIR

% first get the day-by-day dir minus undir difference.
for j=1:num_syl;
    syl=(syllables{j});
    DIRminusUNDIR.(syl)=nan(num_days,1);
    for ii=1:num_days;
        try
            DIRminusUNDIR.(syl)(ii)=Xmedian_DIR.(syl)(ii)-Xmedian_UNDIR.(syl)(ii);;
        catch err
        end
    end
end

% PLOT DAY VALUES, BUT PLOT MEDIAN (account for outliers?);
for j=1:num_syl;
    syl=(syllables{j});
    figure; hold on; subplot(3,1,1); hold on;
    Xmedian_UNDIR.(syl)=nan(num_days,1);
    all_days_various=ADVcompiledUNDIR.all_days_various_COMPILED.all_days_various(syllables_COMPILED{j,1}); % extract relevant structure from compiled structures
    for i=1:num_days; % number of days
        try
            Xmedian_UNDIR.(syl)(i)=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).median_FF;
        catch err
            continue
        end
    end
    
    h=errorbar(Xmedian_UNDIR.(syl),Xse_UNDIR.(syl),'o-','Color',plot_colors{j},'MarkerFaceColor',plot_colors{j},'MarkerSize',12);
    errorbar_tick(h,200);
    try
        legend(H, motif_table(j,1));
    catch err
        legend(H, motif_table(j,2));
    end
    
    % plot (First, UNDIR);
    
    Xmedian_DIR.(syl)=nan(num_days+days_to_add,1);
    all_days_various=ADVcompiledDIR.all_days_various_COMPILED.all_days_various(syllables_COMPILED{j,1}); % extract relevant structure from compiled structures
    for i=1:num_days; % number of days
        ii=i+days_to_add;
        try
            Xmedian_DIR.(syl)(ii)=all_days_various.lt_calc_day_pitch{i}.FF.(syllables{j}).median_FF;
        catch err
            continue
        end
    end
    h=errorbar(Xmean_DIR.(syl),Xse_DIR.(syl),'s--','Color',plot_colors{j},'MarkerSize',12);
    
    title('Median pitch over days: UNDIR (circle) and _DIR (square)');
    xlabel('days');
    ylabel('Pitch (hz)');
    xlim([1 num_days]);
    
    % plot, in subplot, the difference between dir and undir
    subplot(3,1,2);
    plot(-DIRminusUNDIR.(syl)); % use just to get ylim values
    ylimits=ylim;
    bar([1:num_days], -DIRminusUNDIR.(syl)); % subtracting baseline diff between dir and undir.
    ylim(ylimits);
    xlim([1 num_days]);
    title('UNDIR minus DIR pitch (not baseline-normalized)');
    ylabel('hz')
    
    % plot differences, but subtracting the baseline diff.
    subplot(3,1,3); hold on;
    plot(-(DIRminusUNDIR.(syl)-DirMinusUndir_baseMedian.(syl)),'o-','Color',plot_colors{j},'MarkerFaceColor',plot_colors{j},'MarkerSize',12); % use just to get ylim values
    line(xlim,[0 0],'Color','k','LineStyle','--')
    xlim([1 num_days]);
    title('Putative AFP component: (UNDIR minus DIR)');
    ylabel('UNDIR minus DIR pitch (hz)');
end

