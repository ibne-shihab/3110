clc;
clear all;
close all;
samples = 256;
t = 1/128;
k = 0:samples-1;
time = k * t;
signal = 0.25 + 2 * sin(2 * pi * 5 * time) + sin(2 * pi * 12.5 * time) + 1.5 * sin(2 * pi * 20 * time) + 0.5 * sin(2 * pi * 35 * time);
subplot(3, 1, 1);
plot(time, signal, 'k');
title('Original Signal');
xlabel('Time (s)');
ylabel('Magnitude');
grid on;
F = fft(signal);
magF = abs([F(1) / samples, F(2:samples/2) / (samples/2)]);
hertZ = k(1:samples/2) * (1 /( samples * t));
subplot(3, 1, 2);
stem(hertZ, magF, 'k');
title('Frequency Spectrum');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
grid on;
n = 1;
Fourier = zeros(1, length(0:0.05:40));
for f = 0:0.05:40
    Fourier(n) = trapz(time, signal .* exp(-1j * 2 * pi * f * time));
    n = n + 1;
end
frequencies = 0:0.05:40;
subplot(3, 1, 3);
stem(frequencies, abs(Fourier), 'k');
title('Amplitude Spectrum');
xlabel('Frequency (Hz)');
ylabel('Phase Angle');
grid on;
sgtitle('Frequency and Amplitude spectrums of two signals.')
