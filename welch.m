clc
clear all
close all

load EEGrestingState.mat
N=length(eegdata);

%time vector
time=(0:N-1)/srate;

plot(time,eegdata)
xlabel('Time (s)')
ylabel('Voltage (\muV)')
title('EEG data')

%% FFT

eegpow=abs(fft(eegdata)/N).^2;
hz=linspace(0,srate/2,floor(N/2)+1);

figure
stem(hz,eegpow(1:length(hz)))
set(gca,'xlim',[0 40])
xlabel('Frequency (Hz)')
title('Spectrum of EEG data')

%% Applying Welch method

%create hanning window
winsize=2*srate; %2 second window
hanning=0.5-cos(2*pi*linspace(0,1,winsize))./2;

% number of fft points (frequency resolution)
nfft=srate*10;

figure
pwelch(eegdata,hanning,round(winsize/4),nfft,srate);

set(gca,'xlim',[0 40])
