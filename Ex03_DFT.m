clc;
clear all;
close all;
N = input('Enter N: ');
x = input('Enter the Sequence x(n) = ');
disp('Input Sequence');
disp(x);
subplot(4,1,1);
stem(0:length(x)-1, x, "k");
xlabel('n');
ylabel('X(n)');
title('Input Signal');
grid on;
if N > length(x)
    x = [x, zeros(1, N - length(x))];
end
y = zeros(1, N);
for k = 0:N-1
    for n = 0:N-1
        y(k+1) = y(k+1) + x(n+1) * exp((-1i*2*pi*k*n)/N);
    end
end
disp('DFT of the Sequence:');
disp(y);
subplot(4,1,2);
stem(0:N-1, abs(y), "k");
xlabel('k');
ylabel('|X(k)|');
title('Magnitude of DFT Signal');
grid on;
disp('Magnitude of the Sequence:');
disp(abs(y));

subplot(4,1,3);
stem(0:N-1, angle(y), "k");
xlabel('k');
ylabel('arg(X(k))');
title('Phase of DFT Signal');
grid on;
disp('Phase of the Sequence:');
disp(angle(y));
M = length(y);
m = zeros(1, M);
for n = 0:M-1
    for k = 0:M-1
        m(n+1) = m(n+1) + (1/M) * y(k+1) * exp((1i*2*pi*k*n)/M);
    end
end
disp('IDFT of the Sequence:');
disp(m);
subplot(4,1,4);
stem(0:length(x)-1, real(m), "k");
xlabel('n');
ylabel('Y(n)');
title('IDFT Signal (Real Part)');
grid on;
sgtitle('DFT and IDFT of given sequences.')
