%SetFigSize.m
%Code to set up the figure dimensions
%may be used as a function
FigureWidth = 10;
FigureHeight = 4.5;
set(gcf, 'Units', 'Inches');
set(gcf, 'Position', [2.5,2.5,FigureWidth, FigureHeight]);
FigureLeftMargin = 1;
FigureBottomMargin = 1;
FigureMargin = .75;
set(gca, 'Units', 'Inches');
set(gca, 'Position',[FigureLeftMargin,...
FigureBottomMargin,...
FigureWidth-FigureMargin-FigureLeftMargin,...
FigureHeight-FigureMargin-FigureBottomMargin]);
% ECE 3323 Problem 22 - Double Side Band (Suppressed Carrier)
clear variables;
clc;
close all;
SetFigSize;
% These parameters are chosen to give good results for the FFT
s = 16384; %number of samples in the signal
fs = 1024; %number of samples per second
%time scale for the time functions
t = (0:s-1)/fs;
%Frequency scale for the fourier transform
f = (-(s/2)+1:s/2)*fs/s;
% Message Signal - the sum of two sinusoids, frequency 4 and 6 Hz
x = sin(2*pi*4*t) + sin(2*pi*6*t);
x = x./max(abs(x)); %normalize the signal to -1 to +1
% Spectrum Magnitude of the Message Signal found with the FFT
fftx = abs(fftshift(fft(x)))/s;
% Plot the Message Signal
plot(t,x,'k','LineWidth',2);
title('Message Signal');
xlabel('Time (S)');
ylabel('Magnitude');
axis([0,1,-1,1]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
% Plot Message Signal Spectrum Magnitude
plot(f,fftx,'k','LineWidth',2);
title('Message Signal Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
axis([-120, 120, 0, .3]);
set(gca,'XTick',[-120,-80,-40,0,40,80,120]);
set(gca, 'FontName','Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
% Carrier signal with a frequency of 40 Hz
fc = 40; %carrier frequency
c = cos(2*pi*fc*t);
% Spectrum Magnitude of the Carrier Signal found with the FFT
fftc = abs(fftshift(fft(c)))/s;
% Plot the Carrier Signal
plot(t,c,'k','LineWidth',2);
title('Carrier Signal');
xlabel('Time (S)', 'FontName','Arial');
ylabel('Magnitude', 'FontName','Arial');
axis([0,1,-1,1]);
set(gca, 'FontName','Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
% Plot Carrier Signal Spectrum Magnitude
plot(f,fftc,'k','LineWidth',2);
title('Carrier Signal Spectrum');
xlabel('Frequency (Hz)', 'FontName','Arial');

ylabel('Magnitude', 'FontName','Arial');
set(gca, 'FontName','Arial');
axis([-120, 120, 0, .6]);
set(gca,'YTick',[0,0.5]);
set(gca,'XTick',[-120,-80,-40,0,40,80,120]);
set(gca, 'FontSize', 20);
grid on;
pause;
% Create the DSBSC Signal
phi = x.*c;
% Spectrum Magnitude of the DSB Signal found with the FFT
fftphi = abs(fftshift(fft(phi)))/s;
% Plot the DSB Signal
plot(t,phi,'k','LineWidth',2);
hold on;
plot(t, x,'c','LineWidth',1);
plot(t,-x,'c','LineWidth',1);
hold off;
title('DSBSC Signal');
xlabel('Time (S)');
ylabel('Magnitude');
axis([0,1,-1,1]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
% Plot the DSB spectrum
plot(f,fftphi,'k','LineWidth',2);
title('DSBSC Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
axis([-120, 120, 0, .2]);
set(gca,'XTick',[-120,-80,-40,0,40,80,120]);
set(gca, 'FontName','Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
% Create the received signal
r = phi.*c;
% Find the Spectrum of the received signal with the FFT
fftr = abs(fftshift(fft(r)))/s;
% Plot the received signal
plot(t,r,'k','LineWidth',2);
hold on;
plot(t, x,'c','LineWidth',1);
hold off;
title('Recieved Signal');
xlabel('Time (S)');
ylabel('Magnitude');
axis([0,1,-1,1]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
% Plot The spectrum of the received signal
plot(f,fftr,'k','LineWidth',2);
title('Received Signal Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
axis([-120, 120, 0, .2]);
set(gca,'XTick',[-120,-80,-40,0,40,80,120]);
set(gca, 'FontName','Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
% Set up the low pass filter
FilterOrder = 8; %Enter the filter order (1, 2, 4 or 8)
CutOffFrequency = 20; %Enter the cut off frequency
[b,a] = butter(FilterOrder,CutOffFrequency/(0.5*fs));
%Creates the filter coefficients for a low-pass
%Butterworth filter
y = filter(b,a,r); %The filter operation operates on signal x and
%assigns the values to signal y
y = y/max(abs(y)); %normalize y
% Plot the output signal
plot(t,y,'k','LineWidth',2);
hold on;
plot(t, x,'c','LineWidth',1);
hold off;
title('Demodulated Signal');
xlabel('Time (S)');
ylabel('Magnitude');
axis([0,1,-1,1]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
close all;