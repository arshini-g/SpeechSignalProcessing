clc;
close all;
clear all;

%calculating various parameters of the audio input
[b, Fs]=audioread('ded.wav'); %Audio File, Fs is sampling rate
sound(b,Fs);
len=length(b)/Fs; %We get time of audio in seconds
sam_len = floor(((len*1000)- 10)/(10));
max = zeros(10);
getans=zeros(sam_len,1);

%calculating the spectral peaks corresponding to a signal with interval of
%20 ms.
for i=2:sam_len
      b_test=b(Fs*(i-1)*0.01 : Fs*(i+1)*0.01);
      b_test_fft = fft(b_test,256);
      b_test_fft2=b_test_fft(1:128);
      [sortedX,sortingIndices] = sort(b_test_fft2,'descend');
      maxValues = sortedX(1:10);
      for temp=1:10
        getans(i,1)=getans(i)+abs(maxValues(temp));
      end
end


% Further smoothing of the signal by convulution with that of the gaussian
% window
f_new = smoothdata(getans);
windowWidth = 10;
halfWidth = windowWidth / 2;
gaussFilter = gausswin(1);
gaussFilter = gaussFilter / sum(gaussFilter);
y = conv(gaussFilter,f_new);

%Axis Alignment
x_axis=0:1/Fs:len;
if(length(x_axis)~=length(b))
    q=length(x_axis)-length(b);
    if(q>0)
        x_axis=0:1/Fs:len-q/Fs;
    else
        x_axis=0:1/Fs:len+q/Fs;
    end
end

x_axis2=0:len/length(f_new):len;
if(length(x_axis2)~=length(f_new))
    q=length(x_axis2)-length(f_new);
    if(q>0)
        x_axis2=0:len/length(f_new):len-(q*len/length(f_new));
    else
        x_axis2=0:len/length(f_new):len+(q*len/length(f_new));
    end
end

x_axis3=0:len/length(y):len;
if(length(x_axis3)~=length(y))
    q=length(x_axis3)-length(y);
    if(q>0)
        x_axis3=0:len/length(y):len-(q*len/length(y));
    else
        x_axis3=0:len/length(y):len+(q*len/length(y));
    end
end

f1=smoothdata(getans);

%Plots-

subplot(4,1,1);
plot(x_axis,b);
title('Time Domain Signal');
subplot(4,1,2);
plot(x_axis2, f1);
title('Sum of 10 lagest peaks in DFT Spectrum');
subplot(4,1,3);
plot(x_axis2,f_new);

title('Normalized Waveform');
subplot(4,1,4);
plot(x_axis3,y);
title('VOP Evidence Plot');