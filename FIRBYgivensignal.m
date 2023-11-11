clc;
clear all;
close all;

% Define filter specifications
Fs = 1000;        % Sampling frequency in Hz
N = 100;          % Filter order (adjust as needed)

% High-pass filter specifications
Fhp = 50;         % Cutoff frequency in Hz for high-pass filter
Fstop_hp = 10;    % Stopband edge in Hz for high-pass filter
b_hp = fir1(N, Fhp/(Fs/2), 'high', kaiser(N+1, 3), 'noscale');

% Low-pass filter specifications
Flp = 200;        % Cutoff frequency in Hz for low-pass filter
Fstop_lp = 250;   % Stopband edge in Hz for low-pass filter
b_lp = fir1(N, Flp/(Fs/2), 'low', kaiser(N+1, 3), 'noscale');

% Band-pass filter specifications
Fbp1 = 50;        % First passband edge in Hz for band-pass filter
Fbp2 = 200;       % Second passband edge in Hz for band-pass filter
Fstop_bp1 = 10;   % First stopband edge in Hz for band-pass filter
Fstop_bp2 = 250;  % Second stopband edge in Hz for band-pass filter
b_bp = fir1(N, [Fbp1 Fbp2]/(Fs/2), 'bandpass', kaiser(N+1, 3), 'noscale');

% Band-stop filter specifications
Fbs1 = 80;        % First stopband edge in Hz for band-stop filter
Fbs2 = 150;       % Second stopband edge in Hz for band-stop filter
Fpass_bs1 = 70;   % First passband edge in Hz for band-stop filter
Fpass_bs2 = 160;  % Second passband edge in Hz for band-stop filter
b_bs = fir1(N, [Fbs1 Fbs2]/(Fs/2), 'stop', kaiser(N+1, 3), 'noscale');

% Generate a test signal
t = 0:1/Fs:1;      % Time vector
x = 0.25 + 2*sin(2*pi*500*t) + sin(2*pi*120.5*t) + 1.5*sin(2*pi*200*t) + ...
    0.5*sin(2*pi*1500*t) + 0.5*sin(2*pi*2500*t) + 0.5*sin(2*pi*3500*t); 

% Apply the filters to the input signal
y_hp = filter(b_hp, 1, x);
y_lp = filter(b_lp, 1, x);
y_bp = filter(b_bp, 1, x);
y_bs = filter(b_bs, 1, x);

% Plot original and filtered signals for each filter type
figure;

subplot(5,1,1);
plot(t, x);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(5,1,2);
plot(t, y_hp);
title('Filtered Signal (High-Pass)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(5,1,3);
plot(t, y_lp);
title('Filtered Signal (Low-Pass)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(5,1,4);
plot(t, y_bp);
title('Filtered Signal (Band-Pass)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(5,1,5);
plot(t, y_bs);
title('Filtered Signal (Band-Stop)');
xlabel('Time (s)');
ylabel('Amplitude');

% Frequency response plots
figure;

subplot(2,2,1);
freqz(b_hp, 1, 1024, Fs);
title('Frequency Response of High-Pass Filter');

subplot(2,2,2);
freqz(b_lp, 1, 1024, Fs);
title('Frequency Response of Low-Pass Filter');

subplot(2,2,3);
freqz(b_bp, 1, 1024, Fs);
title('Frequency Response of Band-Pass Filter');

subplot(2,2,4);
freqz(b_bs, 1, 1024, Fs);
title('Frequency Response of Band-Stop Filter');
