
% ECE 3323 Problem 33 - FM
clear variables;
clc;
close all;
SetFigSize;
 
% Signal parameters
s = 4*16384; %number of samples in the signal
fs = 4*1024; %number of samples per second
% Time scale for the time functions
t = (0:s-1)/fs;
% Frequency scale for the fourier transform
f = (-(s/2)+1:s/2)*fs/s;
 
% Message signal
f1 = 4;
f2 = 6;
x = sin(2*pi*f1*t) + sin(2*pi*f2*t);
x = x./max(abs(x)); %normalize the signal
% Find the spectrum
fftx = abs(fftshift(fft(x)))/s;
 
% Plot the message signal
plot(t,x,'k','LineWidth',2);
title('Message Signal');
xlabel('Time (S)');
ylabel('Magnitude');
axis([0,1,-1,1]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
 
% Plot the message spectrum
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
 
% Create the carrier signal
fc = 40;   %carrier frequency
c = cos(2*pi*fc*t);
% Finf the spectrum
fftc = abs(fftshift(fft(c)))/s;
 
% Plot the carrier
plot(t,c,'k','LineWidth',2);
title('Carrier Signal');
xlabel('Time (S)', 'FontName','Arial');
ylabel('Magnitude', 'FontName','Arial');
axis([0,1,-1,1]);
set(gca, 'FontName','Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
 
% Plot carrier spectrum
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
 
% Create the FM Signal 
k = 50;
phi = cos(2*pi*fc*t ...
    -k*cos(2*pi*f1*t)/(2*pi*f1) ...
    -k*cos(2*pi*f2*t)/(2*pi*f2));
% Find the spectrum
fftphi = abs(fftshift(fft(phi)))/s;
 
% Plot the FM signal
plot(t,phi,'k','LineWidth',2);
hold on;
plot(t,x,'c','LineWidth',1);
hold off;
title('FM Signal');
xlabel('Time (S)');
ylabel('Magnitude');
axis([0,1,-1,1]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
 
% Plot the spectrum
plot(f,fftphi,'k','LineWidth',2);
title('FM Signal Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
axis([-120, 120, 0, .6]);
set(gca,'XTick',[-120,-80,-40,0,40,80,120]);
set(gca, 'FontName','Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
 
% Create the received signal
r = diff(phi);         % Take the derivative
r = [r, r(length(r))]; % Correct the array length
r = r/max(abs(r));     % Normalize the signal

% Find the spectrum
fftr = abs(fftshift(fft(r)))/s;
 
% Plot the received signal
plot(t,r,'k','LineWidth',2);
hold on;
plot(t, x,'c','LineWidth',1);
hold off;
title('Recieved Signal - Frequency Discrimination');
xlabel('Time (S)');
ylabel('Magnitude');
axis([0,1,-1,1]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
 
% Plot the spectrum
plot(f,fftr,'k','LineWidth',2);
title('Received Signal Spectrum - Frequency Discrimination');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
axis([-120, 120, 0, .6]);
set(gca,'XTick',[-120,-80,-40,0,40,80,120]);
set(gca, 'FontName','Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
 
% Peak detection
r = abs(r);  % Full wave rectifier
% Find the spectrum
fftr = abs(fftshift(fft(r)))/s;
 
% plot the rectified signal
plot(t,r,'k','LineWidth',2);
hold on;
plot(t, x,'c','LineWidth',1);
hold off;
title('Recieved Signal - Rectified');
xlabel('Time (S)');
ylabel('Magnitude');
axis([0,1,-1,1]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
 
%plot the spectrum
plot(f,fftr,'k','LineWidth',2);
title('Received Signal Spectrum - Rectified');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
axis([-120, 120, 0, .6]);
set(gca,'XTick',[-120,-80,-40,0,40,80,120]);
set(gca, 'FontName','Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
 
% Set up low pass filter
FilterOrder = 8;
CutOffFrequency = 20;
[b,a] = butter(FilterOrder,CutOffFrequency/(0.5*fs));
 
%Create the output signal
y = filter(b,a,r);
y = y - mean(y);    % Remove the DC offset
y = y/max(abs(y));  % Normalize the signal
gain = 2.0;
y = y*gain;
 
% Plot the signal
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

