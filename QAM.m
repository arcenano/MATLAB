% ECE 3323 Problem 29 - Quadrature AM
clear variables;
clc;
close all;
SetFigSize;
% Parameters for the signals
s = 16384; %number of samples in the signal
fs = 1024; %number of samples per second
% Time scale for the time functions
t = (0:s-1)/fs;
% Frequency scale for the fourier transform
f = (-(s/2)+1:s/2)*fs/s;
% Create Message signal #1
x1 = sin(2*pi*4*t) + sin(2*pi*6*t);
x1 = x1./max(abs(x1)); %normalize the signal
% Find the spectrum of message signal #1
fftx1 = abs(fftshift(fft(x1)))/s;
% Plot the message signal #1
plot(t,x1,'k','LineWidth',2);
title('Message Signal 1');
xlabel('Time (S)');
ylabel('Magnitude');
axis([0,1,-1,1]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
% Plot message signal #1 spectrum
plot(f,fftx1,'k','LineWidth',2);
title('Message Signal 1 Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
axis([-120, 120, 0, .3]);
set(gca,'XTick',[-120,-80,-40,0,40,80,120]);
set(gca, 'FontName','Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
% Create message signal #2
x2 = sin(2*pi*3*t) + sin(2*pi*5*t);
x2 = x2./max(abs(x2)); %normalize the signal
% Find the spectrum
fftx2 = abs(fftshift(fft(x2)))/s;
% Plot message signal #2
plot(t,x2,'k','LineWidth',2);
title('Message Signal 2');
xlabel('Time (S)');
ylabel('Magnitude');
axis([0,1,-1,1]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
% Plot the spectrum of message signal #2
plot(f,fftx2,'k','LineWidth',2);
title('Message Signal 2 Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
axis([-120, 120, 0, .3]);
set(gca,'XTick',[-120,-80,-40,0,40,80,120]);
set(gca, 'FontName','Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
% Create carrier signal 1
fc = 40; %carrier frequency
c1 = cos(2*pi*fc*t);

% Find the spectrum
fftc1 = abs(fftshift(fft(c1)))/s;
% Plot the carrier
plot(t,c1,'k','LineWidth',2);
title('Carrier Signal');
xlabel('Time (S)', 'FontName','Arial');
ylabel('Magnitude', 'FontName','Arial');
axis([0,1,-1,1]);
set(gca, 'FontName','Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
% Plot carrier spectrum
plot(f,fftc1,'k','LineWidth',2);
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
% Create the phase shifted carrier signal
c2 = cos(2*pi*fc*t - pi/2);
% Create the QAM Signal
phi = x1.*c1 + x2.*c2;
phi = phi./max(abs(phi)); %normalize the signal
% Find the spectrum
fftphi = abs(fftshift(fft(phi)))/s;
% Plot the QAM signal
plot(t,phi,'k','LineWidth',2);
hold on;
plot(t, x1,'c','LineWidth',1);
plot(t, x2,'c','LineWidth',1);
hold off;
title('QAM Signal');
xlabel('Time (S)');
ylabel('Magnitude');
axis([0,1,-1,1]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 20);
grid on;
pause;

% Plot the spectrum of the QAM signal
plot(f,fftphi,'k','LineWidth',2);
title('QAM Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
axis([-120, 120, 0, .2]);
set(gca,'XTick',[-120,-80,-40,0,40,80,120]);
set(gca, 'FontName','Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
% Create received signal #1
r1 = phi.*c1;
r1 = r1./max(abs(r1)); %normalize the signal
% Find the spectrum
fftr1 = abs(fftshift(fft(r1)))/s;
%plot the received signal 1
plot(t,r1,'k','LineWidth',2);
hold on;
plot(t, x1,'c','LineWidth',1);
hold off;
title('Recieved Signal 1');
xlabel('Time (S)');
ylabel('Magnitude');
axis([0,1,-1,1]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
% Plot the spectrum of received signal #1
plot(f,fftr1,'k','LineWidth',2);
title('Received Signal 1 Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
axis([-120, 120, 0, .2]);
set(gca,'XTick',[-120,-80,-40,0,40,80,120]);
set(gca, 'FontName','Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
%Set up the low pass filter
FilterOrder = 8; %Enter the filter order (1, 2, 4 or 8)
CutOffFrequency = 20; %Enter the cut off frequency
[b,a] = butter(FilterOrder,CutOffFrequency/(0.5*fs));
%Creates the filter coefficients for a low-pass


%Butterworth filter
% Create output signal #1
y1 = filter(b,a,r1); %The filter operation operates on signal x and
%assigns the values to signal y
y1 = y1/max(abs(y1)); %normalize y
% Plot output signal #1
plot(t,y1,'k','LineWidth',2);
hold on;
plot(t, x1,'c','LineWidth',1);
hold off;
title('Demodulated Signal 1');
xlabel('Time (S)');
ylabel('Magnitude');
axis([0,1,-1,1]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
% Create received signal #2
r2 = phi.*c2;
r2 = r2./max(abs(r2)); %normalize the signal
% Find the spectrum
fftr2 = abs(fftshift(fft(r2)))/s;
% Plot the received signal #2
plot(t,r2,'k','LineWidth',2);
hold on;
plot(t, x2,'c','LineWidth',1);
hold off;
title('Recieved Signal 2');
xlabel('Time (S)');
ylabel('Magnitude');
axis([0,1,-1,1]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
% Plot the spectrum of received signal #2
plot(f,fftr2,'k','LineWidth',2);
title('Received Signal 2 Spectrum');    
xlabel('Frequency (Hz)');
ylabel('Magnitude');
axis([-120, 120, 0, .2]);
set(gca,'XTick',[-120,-80,-40,0,40,80,120]);
set(gca, 'FontName','Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
% Create the output signal
y2 = filter(b,a,r2); %The filter operation operates on signal 
% x and
%assigns the values to signal y
y2 = y2/max(abs(y2)); %normalize y
%plot the output signal #2
plot(t,y2,'k','LineWidth',2);
hold on;
plot(t, x2,'c','LineWidth',1);
hold off;
title('Demodulated Signal 2');
xlabel('Time (S)');
ylabel('Magnitude');
axis([0,1,-1,1]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
close all;