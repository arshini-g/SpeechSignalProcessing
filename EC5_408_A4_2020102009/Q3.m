clc;
clear;

% Read audio file
% y is the signal amplitudes and has 16808 samples
% Fs is the sampling rate that is 16000
[y1,Fs1] = audioread('Q3a.wav');
info = audioinfo("Q3a.wav");
disp(info.Duration)

% Defining the parameters of the frames
framelen = 0.02;
framesamples = Fs1*framelen; 
frameno = ceil(length(y1)/framesamples);
frame_no = buffer(y1,framesamples);


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
k=0;

% aligning errors of each frame in one array to use in mfcc calculation
for i=1:frameno
    for j= 1:framesamples
        k = k+1;
        e(k) = err(j,i);
    end
end

% Pitch contour
winLength = framesamples;
overlapLength = 0;
[f01] = pitch(y1,Fs1,Method="SRH",WindowLength=winLength,OverlapLength=overlapLength);

% Hilbert envelope of LP Residual
[up1, lo] = envelope(e, 1,"analytic");

% Smoothing of HE of LP Residual
w = hamming(256);
win = conv(up1,w);

% VOP evidence plot
vop_evidence1 = conv(gausswin(1600),win);

% VOP
vop1 = islocalmax(vop_evidence1);
scale = 10;
figure()
subplot(4,1,1)
plot(y1)
title('Original Signal')
xlabel('Time')
ylabel('Amplitude')

subplot(4,1,2)
plot(e)
title('LP Residual')
xlabel('Time')
ylabel('Amplitude')

subplot(4,1,3)
plot(up1)
title('Hilbert Envelope of LP Residual')
xlabel('Time')

subplot(4,1,4)
plot(vop_evidence1)
title('VOP Evidence Plot')
xlabel('Time')

%f0 = smoothdata(f0);
t1 = 0:1/Fs1:length(y1)/Fs1;

figure();
plot(vop1);

figure();
plot(f01,'r--');
title('Pitch Contour of mad.wav');
xlabel("Time")
ylabel("Amplitude")
grid minor

figure()
pitch(y1,Fs1,'Method','SRH');
title('F_0 Contour')
hold on
plot(t1,vop1(1:45898)*400)

% Change in F0 = 347-81 = 266Hz
% F0 peak = 347.52Hz

F0_mean1 = sum(pitch(y1,Fs1))/length(pitch(y1,Fs1));
% f0 mean = 121.76 Hz

logenergy1 = mfcc(y1,Fs1,"NumCoeffs",13,"LogEnergy","append");
figure()
plot(logenergy1);
title('Change in Log Energy(Tamil)')
xlabel('Frames')
ylabel('Amplitude')

%%

% Read audio file
% y is the signal amplitudes and has 16808 samples
% Fs is the sampling rate that is 16000
[y2,Fs2] = audioread('Q3b.wav');
info = audioinfo("Q3b.wav");
disp(info.Duration)

% Defining the parameters of the frames
framelen2 = 0.02;
framesamples2 = Fs2*framelen2; 
frameno2 = ceil(length(y2)/framesamples2);
frame_no2 = buffer(y2,framesamples2);


% The matrices to store the filter values and the error values
prediction2 = zeros(framesamples2,frameno2);
err2 = zeros(framesamples2,frameno2);
x2 = zeros(1,framesamples2);

% To find the filter values and errors in each frame
for i=1:frameno2    
    x2 = frame_no2(:,i);
    a2 = lpc(x2,10);
    est_y2 = filter([0 -a2(2:end)],1,x2);
    prediction2(:,i) = est_y2;
    err2(:,i) = x2 - est_y2;
end
k=0;

% aligning errors of each frame in one array to use in mfcc calculation
for i=1:frameno2
    for j= 1:framesamples2
        k = k+1;
        e2(k) = err2(j,i);
    end
end

% Pitch contour
winLength = framesamples2;
overlapLength = 0;
[f02] = pitch(y2,Fs2,Method="SRH",WindowLength=winLength,OverlapLength=overlapLength);

% Hilbert envelope of LP Residual
[up2, lo] = envelope(e2, 1,"analytic");

% Smoothing of HE of LP Residual
w2 = hamming(1024);
win2 = conv(up2,w2);

% VOP evidence plot
vop_evidence2 = conv(gausswin(1600),win2);

% VOP
vop2 = islocalmax(vop_evidence2);
scale = 10;
figure()
subplot(4,1,1)
plot(y2)
title('Original Signal')
xlabel('Time')
ylabel('Amplitude')

subplot(4,1,2)
plot(e2)
title('LP Residual')
xlabel('Time')
ylabel('Amplitude')

subplot(4,1,3)
plot(win2)
title('Hilbert Envelope of LP Residual')
xlabel('Time')

subplot(4,1,4)
plot(vop_evidence2)
title('VOP Evidence Plot')
xlabel('Time')

%f0 = smoothdata(f0);
t2 = 0:1/Fs2:length(y2)/Fs2;

figure();
plot(vop2);

figure();
plot(f02,'r--');
title('Pitch Contour of mad.wav');
xlabel("Time")
ylabel("Amplitude")
grid minor

figure()
pitch(y2,Fs2,'Method','SRH');
title('F_0 Contour')
hold on
plot(t2,vop2(1:110620)*400)


% Change in F0 = 382 - 72 = 310Hz
% F0 peak = 382Hz
F0_mean2 = sum(pitch(y2,Fs2))/length(pitch(y2,Fs2));

% f0 mean 159.27Hz
logenergy2 = mfcc(y2,Fs2,"NumCoeffs",13,"LogEnergy","append");
figure()
plot(logenergy2);
title('Change in Log Energy(Telugu)')

%%

% Read audio file
% y is the signal amplitudes and has 16808 samples
% Fs is the sampling rate that is 16000
[y3,Fs3] = audioread('Q3c.wav');
info = audioinfo("Q3c.wav");
disp(info.Duration)

% Defining the parameters of the frames
framelen3 = 0.02;
framesamples3 = Fs3*framelen3; 
frameno3 = ceil(length(y3)/framesamples3);
frame_no3 = buffer(y3,framesamples3);


% The matrices to store the filter values and the error values
prediction3 = zeros(framesamples3,frameno3);
err3 = zeros(framesamples3,frameno3);
x3 = zeros(1,framesamples3);

% To find the filter values and errors in each frame
for i=1:frameno3    
    x3 = frame_no3(:,i);
    a3 = lpc(x3,10);
    est_y3 = filter([0 -a3(2:end)],1,x3);
    prediction3(:,i) = est_y3;
    err3(:,i) = x3 - est_y3;
end
k=0;

% aligning errors of each frame in one array to use in mfcc calculation
for i=1:frameno3
    for j= 1:framesamples3
        k = k+1;
        e3(k) = err3(j,i);
    end
end

% Pitch contour
winLength = framesamples3;
overlapLength = 0;
[f03] = pitch(y3,Fs3,Method="SRH",WindowLength=winLength,OverlapLength=overlapLength);

% Hilbert envelope of LP Residual
[up3, lo] = envelope(e3, 1,"analytic");

% Smoothing of HE of LP Residual
w3 = hamming(256);
win3 = conv(up3,w3);

% VOP evidence plot
vop_evidence3 = conv(gausswin(1600),win3);

% VOP
vop3 = islocalmax(vop_evidence3);
scale = 10;
figure()
subplot(4,1,1)
plot(y3)
title('Original Signal')
xlabel('Time')
ylabel('Amplitude')

subplot(4,1,2)
plot(e3)
title('LP Residual')
xlabel('Time')
ylabel('Amplitude')

subplot(4,1,3)
plot(up3)
title('Hilbert Envelope of LP Residual')
xlabel('Time')

subplot(4,1,4)
plot(vop_evidence3)
title('VOP Evidence Plot')
xlabel('Time')

%f0 = smoothdata(f0);
t3 = 0:1/Fs3:length(y3)/Fs3;

figure();
plot(vop3);

figure();
plot(f03,'r--');
title('Pitch Contour of mad.wav');
xlabel("Time")
ylabel("Amplitude")
grid minor

figure()
pitch(y3,Fs3,'Method','SRH');
title('F_0 Contour')
hold on
plot(t3,vop3(1:101377)*400)


% Change in F0 = 397-126 = 271Hz
% F0 peak = 397Hz
F0_mean3 = sum(pitch(y3,Fs3))/length(pitch(y3,Fs3));

% f0 mean = 205.5Hz 

logenergy3 = mfcc(y3,Fs3,"NumCoeffs",13,"LogEnergy","append");
figure()
plot(logenergy3);
title('Change in Log Energy(Malayalam)')

%%

% Read audio file
% y is the signal amplitudes and has 16808 samples
% Fs is the sampling rate that is 16000
[y4,Fs4] = audioread('Q3d.wav');
info = audioinfo("Q3d.wav");
disp(info.Duration)

% Defining the parameters of the frames
framelen4 = 0.02;
framesamples4 = Fs4*framelen4; 
frameno4 = ceil(length(y4)/framesamples4);
frame_no4= buffer(y4,framesamples4);


% The matrices to store the filter values and the error values
prediction4 = zeros(framesamples4,frameno4);
err4 = zeros(framesamples4,frameno4);
x4 = zeros(1,framesamples4);

% To find the filter values and errors in each frame
for i=1:frameno4    
    x4 = frame_no4(:,i);
    a4 = lpc(x4,10);
    est_y4 = filter([0 -a4(2:end)],1,x4);
    prediction4(:,i) = est_y4;
    err4(:,i) = x4 - est_y4;
end
k=0;

% aligning errors of each frame in one array to use in mfcc calculation
for i=1:frameno4
    for j= 1:framesamples4
        k = k+1;
        e4(k) = err4(j,i);
    end
end

% Pitch contour
winLength = framesamples4;
overlapLength = 0;
[f04] = pitch(y4,Fs4,Method="SRH",WindowLength=winLength,OverlapLength=overlapLength);

% Hilbert envelope of LP Residual
[up4, lo] = envelope(e4, 1,"analytic");

% Smoothing of HE of LP Residual
w4 = hamming(256);
win4 = conv(up4,w4);

% VOP evidence plot
vop_evidence4 = conv(gausswin(1600),win4);

% VOP
vop4 = islocalmax(vop_evidence4);
scale = 10;
figure()
subplot(4,1,1)
plot(y4)
title('Original Signal')
xlabel('Time')
ylabel('Amplitude')

subplot(4,1,2)
plot(e4)
title('LP Residual')
xlabel('Time')
ylabel('Amplitude')

subplot(4,1,3)
plot(up4)
title('Hilbert Envelope of LP Residual')
xlabel('Time')

subplot(4,1,4)
plot(vop_evidence4)
title('VOP Evidence Plot')
xlabel('Time')

%f0 = smoothdata(f0);
t4 = 0:1/Fs4:length(y4)/Fs4;

figure();
plot(vop4);

figure();
plot(f04,'r--');
title('Pitch Contour of mad.wav');
xlabel("Time")
ylabel("Amplitude")
grid minor

figure()
pitch(y4,Fs4,'Method','SRH');
title('F_0 Contour')
hold on
plot(t4,vop4(1:55257)*400)

% Change in F0 = 400-65 = 335Hz
% F0 peak = 400Hz
F0_mean4 = sum(pitch(y4,Fs4))/length(pitch(y4,Fs4));
% f0 mean = 126.47Hz
logenergy4 = mfcc(y4,Fs4,"NumCoeffs",13,"LogEnergy","append");
figure()
plot(logenergy4);
title('Change in Log Energy(Hindi)')

%% Analysis

figure()
title('Original Speech Signals')
subplot(2,2,1)
plot(y1)
title('Tamil Native Speaker')

subplot(2,2,2)
plot(y2)
title('Telugu Native Speaker')

subplot(2,2,3)
plot(y3)
title('Malayalam Native Speaker')

subplot(2,2,4)
plot(y4)
title('Hindi Native Speaker')

figure()
title('VOP Evidence Plots')
subplot(2,2,1)
plot(vop_evidence1)
title('Tamil Native Speaker')

subplot(2,2,2)
plot(vop_evidence2)
title('Telugu Native Speaker')

subplot(2,2,3)
plot(vop_evidence3)
title('Malayalam Native Speaker')

subplot(2,2,4)
plot(vop_evidence4)
title('Hindi Native Speaker')

figure()
title('VOP')
subplot(2,2,1)
plot(vop1)
title('Tamil Native Speaker')

subplot(2,2,2)
plot(vop2)
title('Telugu Native Speaker')

subplot(2,2,3)
plot(vop3)
title('Malayalam Native Speaker')

subplot(2,2,4)
plot(vop4)
title('Hindi Native Speaker')

figure()
title('F_0 Contour')
subplot(2,2,1)
pitch(y1,Fs1)
title('Tamil Native Speaker')

subplot(2,2,2)
pitch(y2,Fs2)
title('Telugu Native Speaker')

subplot(2,2,3)
pitch(y3,Fs3)
title('Malayalam Native Speaker')

subplot(2,2,4)
pitch(y4,Fs4)
title('Hindi Native Speaker')
