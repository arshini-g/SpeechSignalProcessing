%% Q1

%% (a)
clc;
clear;
info = audioinfo("H_MKB.wav");
[y,Fs] = audioread('H_MKB.wav');
% sound(y,Fs);
t = 0:(1/Fs):(info.Duration);
t = t(1:end-1);

figure(1);
grid on
plot(t,y);
title('H\_MKB.wav');
xlabel('Time');
ylabel('Signal');

%% (b)

[y, Fs] = audioread('H_MKB.wav');

framelen = 0.02;
framesamples = Fs*framelen; % 882
frameno = ceil(length(y)/framesamples); % 590

% each frame has 882 samples and there are 590 frames with the last one
% having less than 882 samples.

frame_no = buffer(y,framesamples);
STE = zeros(frameno,1);
for i=1:frameno
    for j=1:framesamples
        STE(i) = STE(i) + (frame_no(j,i).*frame_no(j,i));
        t=t+1;
    end
end

t1 = 0:0.02:info.Duration;

figure(2);
plot(t1, STE, 'r', LineWidth=1);
title('Short-time Energy');
xlabel('Time');
ylabel('Energy');

%% (c)

% Analyzing the STE, we find that the 29th frame has the highest energy so
% it is certainly voiced.

max = 0;

for i= 1 : frameno
 if (max < STE(i))
    max = STE(i);
    index = i; % index = 29
end  
end

voiced = frame_no(:,index);
figure(3);
plot(voiced);
title('Voiced Frame');
xlabel('Time');
ylabel('Audio Signal');

%% (d)

frame_ft = fft(voiced);
figure(4);
plot(abs(frame_ft));
title('FT of the voiced frame');
%% (e)

logar = log(abs(frame_ft));

figure(5);
plot(logar);
title('Logarithm of the FT of the voiced frame');
%% (f)

expon = exp(logar);

figure(6)
plot(expon);
title('Exponential Operation on Logarithm of FT of voiced frame');
%% (g)

inverse = abs(ifft(expon));

figure(7)
plot((inverse));
hold on
title('Inverse FT of the voiced frame');
xlabel("frequency");
plot(voiced);

% The blue line represents the recovered signal after all the previous steps
% The red line represents the original unmodified frame that we selected
%% (h)
