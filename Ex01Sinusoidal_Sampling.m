clc;
clear all;
close all;
frequency = 10; 
freq_sample = 200; % Sampling rate Hz
time = 0:1/freq_sample:1; 
Signal = sin(2*pi*frequency*time); % Generate the sinusoidal signal
subplot(3,1,1);
plot(time,Signal,'k'); % Plot the original signal
xlabel('Time (s)');
ylabel('Amplitude');
title('Sinusoidal Signal');
grid on;
Ts = 1/freq_sample; % Sampling interval 
n = 0:Ts:1; 
sampled_signal = sin(2*pi*frequency*time); % Sampled signal
subplot(3,1,2);
stem(n,sampled_signal,'k');
xlabel('Time (s)');
ylabel('Amplitude');
title('Sampled Signal');
grid on;
reconstructed = zeros(size(time)); % Initialize the reconstructed signal
for i = 1:length(n)
    reconstructed = reconstructed + sampled_signal(i)*sinc((time-(i-1)*Ts)/Ts);
end
subplot(3,1,3);
plot(time,reconstructed,'k');
xlabel('Time (s)');
ylabel('Amplitude');
title('Reconstructed Signal');
grid on;
%sgtitle('Sampling of a sinusoidal signal and reconstruction of analog signal');