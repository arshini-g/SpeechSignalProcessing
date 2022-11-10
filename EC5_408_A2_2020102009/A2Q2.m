%% Q2

%% (a)

clc;
clear;
info = audioinfo("chunk1.wav");
[y,Fs] = audioread('chunk1.wav');
sound(y,Fs);
t = 0:(1/Fs):(info.Duration);
t = t(1:end-1);

figure(1);
grid on
plot(t,y);
title('chunk1.wav');
xlabel('Time');
ylabel('Signal');

%% (b)

f0 = pitch(y, Fs);
figure(2)
subplot(2,1,1);
plot(f0);
title('pitch contour');

subplot(2,1,2);
plot(y);
title('chunk1.wav');
%% (c)

% Number of Zero Crossings is the number of times the signal changes signs
ZC = 0;
for k = 1:length(y)-1
        if ((y(k) < 0) && (y(k + 1) > 0 ))
            ZC = ZC + 1;
        elseif ((y(k) > 0) && (y(k + 1) < 0))
            ZC = ZC + 1;
        end
end

% Zero Crossing Rate is the number of times a signal crosses zero in one
% second

% Here ZCR = ZC/length

disp(ZC); % = 311
 
framelen = 0.02;
framesamples = Fs*framelen; % 
frameno = ceil(length(y)/framesamples); %
frame_no = buffer(y,framesamples);
% number of zero crossing per frame plot

ZCr(frameno) = 0;
for i=1:frameno
    for j=1:framesamples-1    
        if (frame_no(j,i) < 0 && frame_no(j+1,i) > 0)
            ZCr(i) = ZCr(i) + 1;
        elseif (frame_no(j,i) > 0  && frame_no(j+1,i) < 0)
            ZCr(i) = ZCr(i) + 1;
        end
    end
end
ZCr1 = ZCr / framesamples;

figure(3);
plot(ZCr1);
title('Zero Crossing Rate');
xlabel('Frame');
ylabel('Zero Crossing Rate');
%% (d)

STE(frameno) = 0;

for i=1:frameno
    for j=1:framesamples
        STE(i) = STE(i) + (frame_no(j,i).*frame_no(j,i));
        t=t+1;
    end
end

figure(4);
plot(STE);
title('Short-Time Energy');
xlabel('Frame');
ylabel('Energy');
