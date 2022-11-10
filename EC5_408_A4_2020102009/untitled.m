%%

% Read audio file
% y is the signal amplitudes and has 16808 samples
% Fs is the sampling rate that is 16000
[y4,Fs4] = audioread('Q3c.wav');
info = audioinfo("Q3c.wav");
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
plot(t4,vop4(1:101377)*400)


% Change in F0 = 382-72 = 310Hz
% F0 peak = 382Hz
F0_mean4 = sum(pitch(y4,Fs4))/length(pitch(y4,Fs4));

logenergy4 = mfcc(y4,Fs4,"NumCoeffs",13,"LogEnergy","append");
figure()
plot(logenergy4);
title('Change in Log Energy')
