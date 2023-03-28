% ECE 3323 Problem 30 - FM Bandwidth
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
fm = 2;
x = cos(2*pi*fm*t);
fftx = abs(fftshift(fft(x)))/s;
 
%plot the example message
plot(t,x,'k','LineWidth',2);
title('Message Signal');
xlabel('Time (S)');
ylabel('Magnitude');
axis([0,.5,-1,1]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
 
%plot message spectrum
plot(f,fftx,'k','LineWidth',2);
title('Message Signal Spectrum');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
axis([-80, 80, 0, .6]);
set(gca,'XTick',[-80,-40,0,40,80]);
set(gca, 'FontName','Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
 
%carrier signal
fc = 40;   %carrier frequency
c = cos(2*pi*fc*t);
fftc = abs(fftshift(fft(c)))/s;
 
%plot the carrier
plot(t,c,'k','LineWidth',2);
title('Carrier Signal');
xlabel('Time (S)', 'FontName','Arial');
ylabel('Magnitude', 'FontName','Arial');
axis([0,.5,-1,1]);
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
axis([-80, 80, 0, .6]);
set(gca,'YTick',[0,0.5]);
set(gca,'XTick',[-80,-40,0,40,80]);
set(gca, 'FontSize', 20);
grid on;
pause;
 
%Create the FM Signal 
beta = 0.5;
fd = beta*fm;
phi = cos(2*pi*fc.*t + beta*sin(2*pi*fm*t));
fftphi = abs(fftshift(fft(phi)))/s;
 
%plot the FM
plot(t,phi,'k','LineWidth',2);
hold on;
plot(t, x,'c','LineWidth',1);
hold off;
title(['FM Signal, beta = ',num2str(beta),', Frequency Deviation = ', num2str(fd)]);
xlabel('Time (S)');
ylabel('Magnitude');
axis([0,.5,-1,1]);
set(gca, 'FontName', 'Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
 
%plot spectrum
plot(f,fftphi,'k','LineWidth',2);
title(['FM Spectrum, beta = ',num2str(beta),', Frequency Deviation = ', num2str(fd)]);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
axis([-80, 80, 0, .6]);
set(gca,'XTick',[-80,-40,0,40,80]);
set(gca, 'FontName','Arial');
set(gca, 'FontSize', 20);
grid on;
pause;
close all;
