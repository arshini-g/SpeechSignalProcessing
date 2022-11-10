%% Q3

[y1,Fs1] = audioread('q3_voiced.wav');

[y2,Fs2] = audioread('q3_unvoiced.wav');

Windowlen = Fs1 * 0.02; %=882

%% Voiced speech /b/

figure(1)
spectrogram(y1(:,1),882,[],[],Fs1,"yaxis");
title('Voiced Speech Spectrogram');

%% Unvoiced speech /k/

figure(2)
spectrogram(y2(:,1),882,[],[],Fs2,"yaxis");
title('Unvoiced Speech Spectrogram');
