%% Q4

%% (a)

clc;
clear;
info = audioinfo("lataji_nrm.wav");
[y,Fs] = audioread('lataji_nrm.wav');
sound(y,Fs);
t = 0:(1/Fs):(info.Duration);
t = t(1:end-1);

figure(1);
grid on
plot(t,y);
title('lataji\_nrm.wav');
xlabel('Time');
ylabel('Signal');

info = audioinfo("lataji_sng.wav");
[y,Fs] = audioread('lataji_sng.wav');
sound(y,Fs);
t = 0:(1/Fs):(info.Duration);
t = t(1:end-1);

figure(2);
grid on
plot(t,y);
title('lataji\_sng.wav');
xlabel('Time');
ylabel('Signal');

%% (b)

f1 = pitch(y,Fs);
[y,Fs] = audioread('lataji_nrm.wav');

figure(3);
subplot(2,1,1);
t = (0:length(y)-1)/Fs;
plot(t,y);
title('Pitch Contour of lataji\_nrm.wav');
xlabel("Time")
ylabel("Amplitude")
grid minor

subplot(2,1,2);
plot(f1,'.');

f2 = pitch(y,Fs);
[y,Fs] = audioread('lataji_sng.wav');

figure(4);
subplot(2,1,1);
t = (0:length(y)-1)/Fs;
plot(t,y)
title('Pitch Contour of lataji\_sng.wav');
xlabel("Time")
ylabel("Amplitude")
grid minor

subplot(2,1,2);
plot(f2, '.')
