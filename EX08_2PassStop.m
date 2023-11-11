clc;
clear all;
close all;
dataset = readtable('filter_experiment.csv');

% Extract time and amplitude data
time = dataset.Time;
amplitude = dataset.Amplitude;

% Define filter specifications
Fs = 1000;         % Sampling frequency in Hz
Fpass1 = 60;       % First passband edge in Hz
Fpass2 = 100;      % Second passband edge in Hz
Fstop1 = 10;      % First stopband edge in Hz
Fstop2 = 90;      % Second stopband edge in Hz
N = 100;           % Filter order (adjust as needed)

% Design FIR band-pass filter using fir1
b_bandpass = fir1(N, [Fpass1 Fpass2]/(Fs/2), 'bandpass');

% Design FIR band-stop filter using fir1
b_bandstop = fir1(N, [Fstop1 Fstop2]/(Fs/2), 'stop');
w=([Fpass1 Fpass2]/(Fs/2));
figure(1);
[h,w]=freqz(b_bandpass,1,128,1000);
plot(w,abs(h));
figure(2);
[h,w]=freqz(b_bandstop,1,128,1000);
plot(w,abs(h));
% Apply the band-pass filter to the input signal
filtered_bandpass = filter(b_bandpass, 1, amplitude);

% Apply the band-stop filter to the input signal
filtered_bandstop = filter(b_bandstop, 1, amplitude);

% Plot original and filtered signals for both band-pass and band-stop filters
figure;

% Original Signal
subplot(3,1,1);
plot(time, amplitude);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Band-Pass Filtered Signal
subplot(3,1,2);
plot(time, filtered_bandpass);
title('Filtered Signal (Band-Pass)');
xlabel('Time (s)');
ylabel('Amplitude');

% Band-Stop Filtered Signal
subplot(3,1,3);
plot(time, filtered_bandstop);
title('Filtered Signal (Band-Stop)');
xlabel('Time (s)');
ylabel('Amplitude');
sgtitle('Original and filted signals');
% Band-Pass Filter Frequency Response
figure;
freqz(b_bandpass, 1, 1024, Fs);
title('Frequency Response of FIR Band-Pass Filter');

% Band-Stop Filter Frequency Response
figure;
freqz(b_bandstop, 1, 1024, Fs);
title('Frequency Response of FIR Band-Stop Filter');
