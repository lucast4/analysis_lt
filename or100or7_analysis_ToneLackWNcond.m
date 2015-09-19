%% MAKING TONES and WN

        %% Make tone-WN, but using SYS WN file for my WN
        % clear all
        % file='/bluejay3/lucas/birds/sounds/WN/WN_SYS/wn60length200.wav';
        % [white Fs]=wavread(file);
        %
        % tone_pitch=500; %in hz
        % dur_pretone_silent=1;
        % dur_tone=0.1;
        % dur_interval=0.1;
        % % dur_WN=0.065;
        % rel_ampl_tone_vs_WN=0.1;
        % sample_rate=44100;
        % upsweep=[5000 8000]; % if do upsweep [startFreq endFreq]
        %
        % %make WN
        % % white=rand(ceil(sample_rate*dur_WN),1)*2-1;
        %
        % if (0)
        %     % make the pure tone
        %     tone=rel_ampl_tone_vs_WN*sin(linspace(0, dur_tone*tone_pitch*2*pi, round(dur_tone*sample_rate)));
        % end
        %
        % % make the tone dirty
        % if (0)
        %     length_tone=size(tone,2);
        %     scaling_vector = 0.8 + (1.2-0.8).*rand(length_tone,1);
        %     tone_dirty=rel_ampl_tone_vs_WN*tone.*scaling_vector';
        % end
        %
        % % make an upsweep
        % if (1)
        %     t=0:1/sample_rate:dur_tone;
        %     tone_UpSweep=rel_ampl_tone_vs_WN*chirp(t,upsweep(1),1,upsweep(2));
        % end
        %
        % % final sound file
        % try
        %     final_sound=[zeros(sample_rate*dur_pretone_silent,1); tone'; zeros(dur_interval*sample_rate,1); white];
        % catch
        %     try
        %         final_sound=[zeros(sample_rate*dur_pretone_silent,1); tone_dirty'; zeros(dur_interval*sample_rate,1); white]; % for dirty tone
        %     catch
        %         final_sound=[zeros(sample_rate*dur_pretone_silent,1); tone_UpSweep'; zeros(dur_interval*sample_rate,1); white]; % for dirty tone
        %     end
        % end
        %
        %
        % figure; plot(final_sound)
        % file_name='/bluejay3/lucas/birds/sounds/test3_sysWN_Up.wav';
        % audiowrite(file_name,final_sound,sample_rate);
        %
        % % to listen
        % % clear all
        % % file='test2_sysWN.wav';
        % [y Fs]=wavread(file_name);
        % player=audioplayer(y,Fs);
        % %%
        % play(player)

        %% To make WN by self (delay-WN)

        clear all
        file='/bluejay3/lucas/birds/sounds/WN/WN_SYS/wn60length200.wav';
        [white Fs]=wavread(file);

        tone_pitch=500; %in hz
        dur_pretone_silent=1;
        dur_tone=0.1;
        dur_interval=0.1;
        % dur_WN=0.065;
        rel_ampl_tone_vs_WN=0.1;
        sample_rate=44100;
        upsweep=[5000 8000]; % if do upsweep [startFreq endFreq]

        %make WN
        % white=rand(ceil(sample_rate*dur_WN),1)*2-1;

        if (0)
            % make the pure tone
            tone=rel_ampl_tone_vs_WN*sin(linspace(0, dur_tone*tone_pitch*2*pi, round(dur_tone*sample_rate)));
        end

        % make the tone dirty
        if (0)
            length_tone=size(tone,2);
            scaling_vector = 0.8 + (1.2-0.8).*rand(length_tone,1);
            tone_dirty=rel_ampl_tone_vs_WN*tone.*scaling_vector';
        end

        % make an upsweep
        if (1)
            t=0:1/sample_rate:dur_tone;
            tone_UpSweep=rel_ampl_tone_vs_WN*chirp(t,upsweep(1),1,upsweep(2));
        end

        % final sound file
        try
            final_sound=[zeros(dur_interval*sample_rate,1); white];
        catch
            try
                final_sound=[zeros(sample_rate*dur_pretone_silent,1); tone_dirty'; zeros(dur_interval*sample_rate,1); white]; % for dirty tone
            catch
                final_sound=[zeros(sample_rate*dur_pretone_silent,1); tone_UpSweep'; zeros(dur_interval*sample_rate,1); white]; % for dirty tone
            end
        end


        figure; plot(final_sound)
        file_name='/bluejay3/lucas/birds/sounds/delay100_WN60.wav';
        audiowrite(file_name,final_sound,sample_rate);

        % to listen
        % clear all
        % file='test2_sysWN.wav';
        [y Fs]=wavread(file_name);
        player=audioplayer(y,Fs);

        play(player)


        %% Make tone by itself (no WN)
        clear all
        file='/bluejay3/lucas/birds/sounds/WN/WN_SYS/wn60length200.wav';
        [white Fs]=wavread(file);

        tone_pitch=500; %in hz
        dur_pretone_silent=1;
        dur_tone=0.1;
        dur_interval=0.1;
        % dur_WN=0.065;
        rel_ampl_tone_vs_WN=1;
        sample_rate=44100;
        upsweep=[5000 8000]; % if do upsweep [startFreq endFreq]

        %make WN
        % white=rand(ceil(sample_rate*dur_WN),1)*2-1;

        if (0)
            % make the pure tone
            tone=rel_ampl_tone_vs_WN*sin(linspace(0, dur_tone*tone_pitch*2*pi, round(dur_tone*sample_rate)));
        end

        % make the tone dirty
        if (0)
            length_tone=size(tone,2);
            scaling_vector = 0.8 + (1.2-0.8).*rand(length_tone,1);
            tone_dirty=rel_ampl_tone_vs_WN*tone.*scaling_vector';
        end

        % make an upsweep
        if (1)
            t=0:1/sample_rate:dur_tone;
            tone_UpSweep=rel_ampl_tone_vs_WN*chirp(t,upsweep(1),1,upsweep(2));
        end

        % final sound file
        try
            final_sound=[zeros(sample_rate*dur_pretone_silent,1); tone'; zeros(dur_interval*sample_rate,1); white];
        catch
            try
                final_sound=[zeros(sample_rate*dur_pretone_silent,1); tone_dirty'; zeros(dur_interval*sample_rate,1); white]; % for dirty tone
            catch
                final_sound=tone_UpSweep'; % for tone
            end
        end


        figure; plot(final_sound)
        file_name='/bluejay3/lucas/birds/sounds/upsweep100_5to8.wav';
        audiowrite(file_name,final_sound,sample_rate);

        % to listen
        % clear all
        % file='test2_sysWN.wav';
        [y Fs]=wavread(file_name);
        player=audioplayer(y,Fs);

        play(player)



        %% To listen to something else

        clear all
        file='wn60length200.wav';
        [y Fs]=wavread(file);
        player=audioplayer(y,Fs);
        play(player)


%% Calc pitch for day
evtaf_freq('batch.catch.keep',[2000 4000],'c',


%% ANALYSIS
    % 1) Pitch
    %     for all r
    %     
    % 2) pitch contour
    %       compare delayWN vs tone
    % 3) hit rate

    %% Pitch 
    % do with box2 (WN) becuase that has HIT marks for all tones, and so
    % easier analysis
    
    % First, label all "r"
    
    DO: 1) sd latency, 2) check where pitch was calcualted using uievtaf 3) alter lt_check code to tell latency.
            measure pitch right before the hit bin (worrya botu contamination)

% Second, use uievtafsim

%% 

batch = 'batch.catch.keep';
syllables = lt_db_check_template_timing_and_hit_rate_BIRDTAF_FUNCTION(batch,1,{'r'},{'c'},{''},'y')


%% Looking at pitch contours.
clear all; close all

lt_calc_day_pitch
percentiles_306090=prctile(day_pitch.FF.r.time_and_FF(:,2),[30 50 70]);

% plot contours
close all;
pc_escapes=[];
pc_hits=[];
figure(1); hold on; title('blue = escapes; red = WN hit')
for i=1:size(day_pitch.pc_all.r,2);
    if day_pitch.fvalsstr_forpc_all.r(i).TRIG==0; % escapes
        plot(day_pitch.pc_all.r(:,i),'b');
        pc_escapes=[pc_escapes day_pitch.pc_all.r(:,i)];
    else % hits
        plot(day_pitch.pc_all.r(:,i),'r');
        pc_hits=[pc_hits day_pitch.pc_all.r(:,i)];
    end
end

% get mean and sd of contours

pc_escapes_mean=mean(pc_escapes,2);
pc_escapes_SD=std(pc_escapes,0,2);
pc_hits_mean=mean(pc_hits,2);
pc_hits_SD=std(pc_hits,0,2);

% plot
figure; hold on;
plot(pc_escapes_mean,'b')
plot(pc_escapes_mean+pc_escapes_SD,'b');
plot(pc_escapes_mean-pc_escapes_SD,'b');
plot(pc_hits_mean,'r');
plot(pc_hits_mean-pc_hits_SD,'r');
plot(pc_hits_mean+pc_hits_SD,'r');



    
%% hit rates


%% To look at pitch contours of hits vs. misses

% First look at spectrograms

% save .not.mat files in case something messes up below
% try cd('old_not_mat')
%     cd ..
% catch err
%     mkdir old_not_mat
% end
% !cp *not.mat* old_not_mat

% get spectrograms
batch='batch.catch.keep.early';

db_change_syllable_in_batchfile(batch,'r','x') % change all r to x. then below change missed x to r (so hits are x, escapes are r)
db_change_miss_label(batch,'x','r');

%
db_make_template

%% change syllables back
db_change_syllable_in_batchfile(batch,'x','r') % change all r to x. then below change missed x to r (so hits are x, escapes are r)

