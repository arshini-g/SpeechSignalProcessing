clc;
clear;

% Read audio file
info = audioinfo("ded.wav");
disp(info.Duration)

% y is the signal amplitudes and has 16808 samples
% Fs is the sampling rate that is 16000
[y,Fs] = audioread('ded.wav');

% Framing assuming frame length as 20ms
framelen = 0.02;
framesamples = Fs*framelen; %320 samples
frameno = ceil(length(y)/framesamples); %53 frames

% The matrix of frames where the samples in each frame are along the
% columns i.e. frame_no(:,1) gives a column of samples in frame 1.
frame_no = buffer(y,framesamples);


% The matrices to store the filter values and the error values
prediction = zeros(framesamples,frameno);
err = zeros(framesamples,frameno);
x = zeros(1,framesamples);

% To find the filter values and errors in each frame
for i=1:frameno    
    x = frame_no(:,i);
    a = lpc(x,10);
    est_y = filter([0 -a(2:end)],1,x);
    prediction(:,i) = est_y;
    err(:,i) = x - est_y;
end

% Plot the orignal frame and the LPC estimate 
figure()
subplot(2,1,1)
plot(frame_no(:,23))
hold on
plot(prediction(:,23))
hold on
title('Frame 23')
xlabel('Samples')
ylabel('Amplitude')
legend('Original signal','LPC estimate')

subplot(2,1,2)
plot(frame_no(:,34))
hold on
plot(prediction(:,34))
hold on
title('Frame 34')
xlabel('Samples')
ylabel('Amplitude')
legend('Original signal','LPC estimate')

% Plot the LP Residual
figure()
subplot(2,1,1)
plot(err(:,23))
title('Error in Frame 23')
xlabel('Samples')
ylabel('Error')

subplot(2,1,2)
plot(err(:,34))
title('Error in Frame 34')
xlabel('Samples')
ylabel('Error')

% Array to store errors
e = zeros(length(y),1);
k=0;

% Aligning errors of each frame in one array to use in mfcc calculation
for i=1:frameno
    for j= 1:framesamples
        k = k+1;
        e(k) = err(j,i);
    end
end

% To apply mfcc take overlap of 0 or 160 as done above accordingly
winLength = 320;
overlapLength = 160;
[coeffs] = mfcc(e,Fs,'WindowLength',winLength,'OverlapLength',overlapLength,'NumCoeffs',13','LogEnergy','Ignore');

% MFCC of signal
[coeffs1] = mfcc(y,Fs,'WindowLength',winLength,'OverlapLength',overlapLength,'NumCoeffs',13','LogEnergy','Ignore');

% Plot the MFCC spectrum of LP Residual
figure();
mfcc(e, Fs);

% Plot MFCC of signal
figure()
mfcc(y,Fs);

% Plot coefficients
figure();
subplot(2,1,1)
plot(coeffs1);
title('Coefficients of Original Signal');
xlabel('Frames');
ylabel('Coefficients');

subplot(2,1,2)
plot(coeffs(1:350,:));
title('Coefficients of LP Residual');
xlabel('Frames');
ylabel('Coefficients');
