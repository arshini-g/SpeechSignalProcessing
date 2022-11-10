%% Q2

clc;
clear;
info = audioinfo("q2.wav");
[y,Fs] = audioread('q2.wav');


winLength = 512;
overlapLength = 256;
[coeffs,delta,deltadelta,loc] = mfcc(y,Fs,'WindowLength',winLength,'OverlapLength',overlapLength,'NumCoeffs',13','LogEnergy','Ignore');


figure();
mfcc(y, Fs);

figure();
plot(coeffs);
title('Coefficients Plot');
xlabel('Frames');
ylabel('Coefficients');

