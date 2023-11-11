clc;
clear all;
close all;
% Define filter specifications
Fs = 1000;         % Sampling frequency in Hz
Fc = 50;          % Cutoff frequency in Hz for high-pass filter
Fc = 50;          % Cutoff frequency in Hz for high-pass filter
N = 100;           % Filter order (adjust as needed)
Fpass1 = 60;       % First passband edge in Hz
Fpass2 = 100;      % Second passband edge in Hz
Fstop1 = 10;      % First stopband edge in Hz
Fstop2 = 90;      % Second stopband edge in Hz

% Design FIR high-pass filter using fir1
b = fir1(N, Fc/(Fs/2), 'low');
h = fir1(N, Fc/(Fs/2), 'high');
b_bandpass = fir1(N, [Fpass1 Fpass2]/(Fs/2), 'bandpass');
% Design FIR band-stop filter using fir1
b_bandstop = fir1(N, [Fstop1 Fstop2]/(Fs/2), 'stop');
% Generate a test signal

t = 0:1/Fs:1;      % Time vector
x =  0.25 + 2 * sin(2 * pi * 500 * t) + sin(2 * pi * 120.5 *t) + 1.5 * sin(2 * pi * 200 * t)+ 0.5 * sin(2 * pi * 1500 *t)+ 0.5 * sin(2 * pi * 2500 *t) + 0.5 * sin(2 * pi * 3500 *t);  % Example signal with low and high frequencies
w=(Fc/(Fs/2));
% Apply the FIR filter to the input signal
y = filter(b, 1, x);
highpass=filter(h, 1, x);
bandpass=filter(b_bandpass, 1, x);
bandstop=filter(b_bandstop, 1, x);
figure(1);
[h,w]=freqz(b,1,128,1000);
plot(w,abs(h));
figure(2);
[h,w]=freqz(highpass,1,128,1000);
plot(w,abs(h));
wp=[Fpass1 Fpass2]/(Fs/2);
figure(3);
[h,wp]=freqz(bandpass,1,128,1000);
plot(wp,abs(h));
ws=[Fstop1 Fstop2]/(Fs/2);
figure(4);
[h,ws]=freqz(bandstop,1,128,1000);
plot(ws,abs(h));

% Plot original and filtered signals
figure;
subplot(4,1,1);
plot(t, x);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4,1,2);
plot(t, y);
title('Filtered Signal (Low-Pass)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4,1,3);
plot(t, bandpass);
title('Filtered Signal (Band-Pass)');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(4,1,4);
plot(t, bandstop);
title('Filtered Signal (Band-Stop)');
xlabel('Time (s)');
ylabel('Amplitude');

% Frequency response plot
figure;
freqz(b, 1, 1024, Fs);
title('Frequency Response of FIR Low-Pass Filter');
figure;
freqz(h, 1, 1024, Fs);
title('Frequency Response of FIR High-Pass Filter');
figure;
freqz(bandpass, 1, 1024, Fs);
title('Frequency Response of FIR Band-Pass Filter');
figure;
freqz(bandstop, 1, 1024, Fs);
title('Frequency Response of FIR Band-stop Filter');
