% ECE 3323 Problem 25 - Conventional AM
% Both sychronous detection and peak detection
clear variables;
clc;
close all;

SetFigSize;
s = 16384; %number of samples in the signal
fs = 1024; %number of samples per second
%time scale for the time functions
t = (0:s-1)/fs;
%Frequency scale for the fourier transform
f = (-(s/2)+1:s/2)*fs/s;
%message signal
x = sin(2*pi*4*t) + sin(2*pi*6*t);
x = x./max(abs(x)); %normalize the signal
fftx = abs(fftshift(fft(x)))/s;
%plot the example message
plot(t,x,'k','LineWidth',2);
title('Message Signal');
xlabel('Time (S)');
ylabel('Magnitude');
axis([0,1,-1,1]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
%plot message spectrum
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
%carrier signal
fc = 40; %carrier frequency
c = cos(2*pi*fc*t);
fftc = abs(fftshift(fft(c)))/s;
%plot the carrier
plot(t,c,'k','LineWidth',2);
title('Carrier Signal');
xlabel('Time (S)', 'FontName','Arial');
ylabel('Magnitude', 'FontName','Arial');
axis([0,1,-1,1]);
set(gca, 'FontName','Arial');

set(gca, 'FontSize', 20);
grid on;
pause;
%plot carrier spectrum
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
%Create the AM Signal
m = 1;
phi = (1+m*x).*c;
fftphi = abs(fftshift(fft(phi)))/s;
%plot the AM
plot(t,phi,'k','LineWidth',2);
hold on;
plot(t,1+m*x,'c','LineWidth',1);
plot(t,-(1+m*x),'c','LineWidth',1);
hold off;
title('DSBLC Conventional AM Signal');
xlabel('Time (S)');
ylabel('Magnitude');
axis([0,1,-2,2]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
%plot spectrum
plot(f,fftphi,'k','LineWidth',2);
title('DSBLC Conventional AM Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
axis([-120, 120, 0, .6]);
set(gca,'XTick',[-120,-80,-40,0,40,80,120]);
set(gca, 'FontName','Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
% Synchronous Detection

r = phi.*c;
fftr = abs(fftshift(fft(r)))/s;
%plot the received signal
plot(t,r,'k','LineWidth',2);
hold on;
plot(t, x,'c','LineWidth',1);
hold off;
title('Recieved Signal - Synchronous Detection');
xlabel('Time (S)');
ylabel('Magnitude');
axis([0,1,-2,2]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
%plot spectrum
plot(f,fftr,'k','LineWidth',2);
title('Received Signal Spectrum - Synchronous Detection');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
axis([-120, 120, 0, .6]);
set(gca,'XTick',[-120,-80,-40,0,40,80,120]);
set(gca, 'FontName','Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
FilterOrder = 8; %Enter the filter order (1, 2, 4 or 8)
CutOffFrequency = 20; %Enter the cut off frequency
[b,a] = butter(FilterOrder,CutOffFrequency/(0.5*fs));
%Creates the filter coefficients for a low-pass
%Butterworth filter
y = filter(b,a,r); %The filter operation operates on signal x and
%assigns the values to signal y
y = y - mean(y);
y = y/max(abs(y)); %normalize y
%plot the signal
plot(t,y,'k','LineWidth',2);
hold on;
plot(t, x,'c','LineWidth',1);
hold off;
title('Demodulated Signal - Synchronous Detection');
xlabel('Time (S)');
ylabel('Magnitude');
axis([0,1,-1,1]);

set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
% Peak Detection
r1 = abs(phi);
fftr1 = abs(fftshift(fft(r1)))/s;
%plot the received signal
plot(t,r1,'k','LineWidth',2);
hold on;
plot(t, x,'c','LineWidth',1);
hold off;
title('Recieved Signal - Peak Detection');
xlabel('Time (S)');
ylabel('Magnitude');
axis([0,1,-2,2]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
%plot spectrum
plot(f,fftr1,'k','LineWidth',2);
title('Received Signal Spectrum - Peak Detection');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
axis([-240, 240, 0, 0.6]);
set(gca,'XTick',[-240,-200,-160,-120,-80,-40,0,40,80,120,160,200,240]);
set(gca, 'FontName','Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
y1 = filter(b,a,r1); %The filter operation operates on signal x and
%assigns the values to signal y
y1 = y1 - mean(y1);
y1 = y1/max(abs(y1)); %normalize y
%plot the signal
plot(t,y1,'k','LineWidth',2);
hold on;
plot(t, x,'c','LineWidth',1);
hold off;
title('Demodulated Signal - Peak Detection');
xlabel('Time (S)');
ylabel('Magnitude');

axis([0,1,-1,1]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 20);
grid on;
