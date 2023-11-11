clc;
clear all;
close all;
% Load CSV dataset
dataset = readtable('filter_experiment.csv');
% Extract time and amplitude data
time = dataset.Time;
amplitude = dataset.Amplitude;
% Define filter specifications
Fs = 10000;         % Sampling frequency in Hz
Fc1 = 150;           % Cutoff frequency in Hz for low-pass filter
Fc2 = 300;          % Cutoff frequency in Hz for high-pass filter
N = 80;           % Filter order (adjust as needed)
% Design FIR low-pass filter using fir1
w=(Fc1/(Fs/2));
b = fir1(N, Fc1/(Fs/2), 'low');
s= fir1(N, Fc2/(Fs/2), 'high');
figure(1);
[h,w]=freqz(b,1,128,1000);
plot(w,abs(h));
figure(2);
[h,w]=freqz(s,1,128,1000);
plot(w,abs(h));
% Apply the FIR filter to the input signal
filtered_amplitude = filter(b, 1, amplitude);
filtered_amplitudeH=filter(s,1,amplitude);
% Plot original and filtered signals
figure;
subplot(3,1,1);
plot(time, amplitude);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3,1,2);
plot(time, filtered_amplitude);
title('Filtered Signal (Low-Pass)');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(3,1,3);
plot(time, filtered_amplitudeH);
title('Filtered Signal (High-Pass)');
xlabel('Time (s)');
ylabel('Amplitude');
sgtitle('Original and filted signals');
% Frequency response plot
figure;
freqz(b, 1, 1024, Fs);
title('Frequency Response of FIR Low-Pass Filter');
figure;
freqz(s, 1, 1024, Fs);
title('Frequency Response of FIR High-Pass Filter');

