% Close figures, clear variables and cmd window
close all;
clear;
clc;

SetFigSize;

dt = 0.001;
t = 0:dt:2;

x = zeros(1,length(t));

for n = 1:length(t)
    if t(n) <= 0.25
        x(n) = 4;
    elseif t(n) <= 0.5
        x(n) = -16*(t(n)-0.5);
    elseif t(n) <= 1.5
        x(n) = 0;
    elseif t(n) <= 1.75
        x(n) = 16*(t(n)-1.5);
    else 
        x(n) = 4;
    end
end


plot(t,x,'k','LineWidth',2);
title('x(t)');
axis([0,2,-5,5]);
xlabel('Time (s)');
ylabel('Magnitude');

a0 = mean(x);
fseries = a0*ones(1,length(t));

figure

plot(t,x,'k','LineWidth',1);
hold;
plot(t,fseries,'b','LineWidth',2);
title('Fourier Series With 1 Term (Only A0)');

axis([0,2,-1,5]);
xlabel('Time (s)'); 
ylabel('Magnitude');

fseries = a0*ones(1,length(t));

for n = 1:3

a(n) = 2*mean(x.*cos(2*pi*n*t/2));
b(n) = 2*mean(x.*sin(2*pi*n*t/2));
fseries = fseries + a(n)*cos(2*pi*n*t/2) + b(n)*sin(2*pi*n*t/2);

figure

plot(t,x,'k','LineWidth',1);
hold;
plot(t,fseries,'b','LineWidth',2);

tit = ['Fourier Series With ',num2str(n+1),' Terms'];
title(tit);

axis([0,2,-1,5]);
xlabel('Time (s)');
ylabel('Magnitude');

end
