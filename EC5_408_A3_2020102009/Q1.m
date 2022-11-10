%% Q1

%% (i)

clc;
clear;
info = audioinfo("q1.wav");
[y,Fs] = audioread('q1.wav');

figure();
grid on
plot(y);
title('Q1.wav');
xlabel('Time');
ylabel('Signal');

w = hamming(512);

frames = buffer(y, 512, 256, 'nodelay');

winframe = frames .* w;

figure();
subplot(2,2,1);
plot(frames(:,51));
hold on
title('Frame 51');
xlabel('Samples');
ylabel('Amplitude');

subplot(2,2,2);
plot(frames(:,52));
hold on
title('Frame 52');
xlabel('Samples');
ylabel('Amplitude');

subplot(2,2,3);
plot(frames(:,53));
hold on
title('Frame 53');
xlabel('Samples');
ylabel('Amplitude');

subplot(2,2,4);
plot(frames(:,54));
hold on
title('Frame 54');
xlabel('Samples');
ylabel('Amplitude');

figure();
subplot(2,2,1);
plot(winframe(:,51));
grid on
title('Windowed Frame 51');
xlabel('Samples');
ylabel('Amplitude');

subplot(2,2,2);
plot(winframe(:,52));
grid on
title('Windowed Frame 52');
xlabel('Samples');
ylabel('Amplitude');

subplot(2,2,3);
plot(winframe(:,53));
grid on
title('Windowed Frame 53');
xlabel('Samples');
ylabel('Amplitude');

subplot(2,2,4);
plot(winframe(:,54));
grid on
title('Windowed Frame 54');
xlabel('Samples');
ylabel('Amplitude');


[auto1, lag1] = xcorr(winframe(:,51));

[auto2, lag2] = xcorr(winframe(:,52));

[auto3, lag3] = xcorr(winframe(:,53));

[auto4, lag4] = xcorr(winframe(:,54));

[autof1, lagf1] = xcorr(frames(:,51));

[autof2, lagf2] = xcorr(frames(:,52));

[autof3, lagf3] = xcorr(frames(:,53));

[autof4, lagf4] = xcorr(frames(:,54));

figure();
subplot(2,2,1);
plot(lagf1,autof1);
title('Autocorrelation 51');
xlabel('Samples');
ylabel('Amplitude');

subplot(2,2,2);
plot(lagf2,autof2);
title('Autocorrelation 52');
xlabel('Samples');
ylabel('Amplitude');

subplot(2,2,3);
plot(lagf3,autof3);
title('Autocorrelation 53');
xlabel('Samples');
ylabel('Amplitude');

subplot(2,2,4);
plot(lagf4,autof4);
title('Autocorrelation 54');
xlabel('Samples');
ylabel('Amplitude');

figure();
subplot(2,2,1);
plot(lag1,auto1);
title('Windowed Autocorrelation 51');
xlabel('Samples');
ylabel('Amplitude');

subplot(2,2,2);
plot(lag2,auto2);
title('Windowed Autocorrelation 52');
xlabel('Samples');
ylabel('Amplitude');

subplot(2,2,3);
plot(lag3,auto3);
title('Windowed Autocorrelation 53');
xlabel('Samples');
ylabel('Amplitude');

subplot(2,2,4);
plot(lag4,auto4);
title('Windowed Autocorrelation 54');
xlabel('Samples');
ylabel('Amplitude');



%% (ii)

[stft1,freq1] = stft(y,Fs,'Window', hamming(512,"periodic"),'OverlapLength',256,'FFTLength',512, 'Centered',false);
figure();
plot(freq1,abs(stft1(:,50)));
title('Magnitude Spectrum using Hamming Window');


[stft2,freq2] = stft(y,Fs,'Window', rectwin(512),'OverlapLength',256,'FFTLength',512);
figure();
plot(freq2,abs(stft2(:,50)));
title('Magnitude Spectrum using Rectangular Window');

%% (iv)

f1 = pitch(y,Fs);
[y,Fs] = audioread('q1.wav');

figure();
subplot(2,1,1);
t = (0:length(y)-1)/Fs;
plot(t,y)
title('Pitch Contour of q1.wav');
xlabel("Time")
ylabel("Amplitude")
grid minor

subplot(2,1,2);
plot(f1, '.')
title('Pitch Contour');
xlabel('frames');
ylabel('Frequency');


