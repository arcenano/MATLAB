% Close figures, clear variables and cmd window
close all;
clear;
clc;

SetFigSize;
    

n = -20:1:20;

Xn = 0.8*sinc(n*0.2);

subplot(2,1,1)
stem(n, Xn,'b','LineWidth',2);

title('Amplitude Line Spectrum');
axis([-20,20,-0.5,1]);
xlabel('N');
ylabel('Magnitude');

phase = angle(Xn)*180/pi;

subplot(2,1,2)
stem(n, phase ,'b','LineWidth',2);

title('Phase Spectrum');
axis([-20,20,-10,180]);
xlabel('N');
ylabel('Angle (radians)');

dt = 0.001;
t = -6:dt:6;

amp = 5;
x = amp*rectangularPulse((t-3)/2);
y = x + 4*rectangularPulse((t+0)/0.4);
z = x + 4*rectangularPulse((t-2)/0.4);

fseries = 0.8*ones(1,length(t));
N = 8;

for n=1:N;
fseries = fseries + 1.6*sinc(0.2*n)*cos(pi*n*t);
end

figure
plot(t,z,'LineWidth',1);
hold;
plot(t,fseries,'b','LineWidth',2);

title('Fourier Series With 8 Terms');
axis([-3,3,-1,5]);
xlabel('Time (s)');
ylabel('Magnitude');




