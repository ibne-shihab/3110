clc;
clear all;
close all;
syms z n
a=2^n+2^n*(n-1); %x(n) = [2^n+2^n*(n-1)]u(n)
ZTrans=ztrans(a);
disp('The Z-Transfrom of the given is: ');%Z transform
disp(ZTrans);
InvrZ=iztrans(ZTrans);
disp('The inverse Z-Transfrom of the given is: ');%InverseZtransform
disp(InvrZ);
B=[0 2 0];
A=[1 -4 4];
pl = roots(A); % To display pole value
disp('The poles of Z-Transfrom are: ')
disp(pl);
zr= roots(B); % To display zero value
disp('The zeros of Z-Transfrom are: ')
disp(zr);
figure(1);
zplane(B,A,'k');
figure(2);
freqz(B,A);% Compute and display pole-zero diagram
sgtitle('Zeros and Poles of Z-Transform');