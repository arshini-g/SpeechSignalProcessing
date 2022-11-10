%% Q4

[y,Fs] = audioread("q3_voiced.wav");

Y = transpose(Y);
%% additive noise model
 
speech = Y;
noise = 0.25*randn(1,length(speech));
l = length(Y);
W = hanning(l); 
W = W';
s = speech.*W; % windowed speech
n = noise.*W; % windowed noise 
x =  s + n; % noise corrupted signal

avg_n = mean(n);
avg_s = mean(s);
SNR = sum(avg_s/avg_n);

%% spectral subtraction 

X = stft(x);
N = stft(n);
enhanced_spectrum = X-N;
enhanced_signal = istft(enhanced_spectrum);
avg = mean(enhanced_signal);

%% SNR after spectral subtraction 

SNR_spectral = avg/avg_n;