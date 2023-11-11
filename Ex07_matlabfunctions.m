clc;
clear all;
close all;
zero=roots([1,0,2])
pole=roots([1,2,-1,1])
numerator=[1,0,2];
denominator=[1,2,-1,1];
systf=tf(numerator,denominator);
pzmap(systf)
sgtitle('Zeros and Poles with MATLAB functions');