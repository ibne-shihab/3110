clc;
clear all;
close all;
% Load CSV dataset
dataset = readtable('filter_experiment.csv');
% Extract time and amplitude data
time = dataset.Time;
amplitude = dataset.Amplitude;
% Define filter specifications
Fs = 1000;         % Sampling frequency in Hz
Fc_low = 50;       % Cutoff frequency in Hz for low-pass filter
Fc_high = 150;     % Cutoff frequency in Hz for high-pass filter
Fpass1 = 50;       % First passband edge in Hz for band-pass filter
Fpass2 = 200;      % Second passband edge in Hz for band-pass filter
Fstop1 = 100;      % First stopband edge in Hz for band-stop filter
Fstop2 = 150;      % Second stopband edge in Hz for band-stop filter
N = 4;             % Filter order (adjust as needed)
% Design IIR filters using butter
[b_low, a_low] = butter(N, Fc_low/(Fs/2), 'low');
[b_high, a_high] = butter(N, Fc_high/(Fs/2), 'high');
[b_bandpass, a_bandpass] = butter(N, [Fpass1 Fpass2]/(Fs/2), 'bandpass');
[b_bandstop, a_bandstop] = butter(N, [Fstop1 Fstop2]/(Fs/2), 'stop');
wp=(Fc_low/(Fs/2));
figure(1);

[h,wp]=freqz(([b_low, a_low]),1,128,1000);
plot(wp,abs(h));
ws=(Fc_high/(Fs/2));
title('Low Pass IIR');
figure(2);

[h,ws]=freqz(([b_high, a_high]),1,128,1000);
plot(ws,abs(h));
wbp=(Fc_high/(Fs/2));
title('High Pass IIR');
figure(3);

[h,wbp]=freqz(([b_bandpass, a_bandpass]),1,128,1000);
plot(wbp,abs(h));
wbs=(Fc_high/(Fs/2));
title('Band Pass IIR');
figure(4);

[h,wbs]=freqz(([b_bandstop, a_bandstop]),1,128,1000);
plot(wbs,abs(h));
title('Band Stop IIR');
% Apply the IIR filters to the input signal
filtered_low = filter(b_low, a_low, amplitude);
filtered_high = filter(b_high, a_high, amplitude);
filtered_bandpass = filter(b_bandpass, a_bandpass, amplitude);
filtered_bandstop = filter(b_bandstop, a_bandstop, amplitude);
% Plot original and filtered signals for different IIR filters
figure;
% Original Signal
subplot(5,1,1);
plot(time, amplitude);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% IIR Low-Pass Filtered Signal
subplot(5,1,2);
plot(time, filtered_low);
title('Filtered Signal (IIR Low-Pass)');
xlabel('Time (s)');
ylabel('Amplitude');
% IIR High-Pass Filtered Signal
subplot(5,1,3);
plot(time, filtered_high);
title('Filtered Signal (IIR High-Pass)');
xlabel('Time (s)');
ylabel('Amplitude');
% IIR Band-Pass Filtered Signal
subplot(5,1,4);
plot(time, filtered_bandpass);
title('Filtered Signal (IIR Band-Pass)');
xlabel('Time (s)');
ylabel('Amplitude');

% IIR Band-Stop Filtered Signal
subplot(5,1,5);
plot(time, filtered_bandstop);
title('Filtered Signal (IIR Band-Stop)');
xlabel('Time (s)');
ylabel('Amplitude');
sgtitle('Original and IIR filted signals');
figure;
freqz(filtered_bandstop, 1, 1024, Fs);
title('Frequency Response of FIR Band-Stop Filter');
figure;
freqz(filtered_bandpass, 1, 1024, Fs);
title('Frequency Response of pass Filter');
figure;
freqz(filtered_high, 1, 1024, Fs);
title('Frequency Response of high Filter');
figure;
freqz(filtered_low, 1, 1024, Fs);
title('Frequency Response of low Filter');
