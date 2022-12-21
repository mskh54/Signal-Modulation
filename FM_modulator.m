%Mohammad sadegh Khodadadi AliAbadi
%Number Student :983110283
clear all;
clc;
close all;

t = 0:0.0001:0.1;
%% Generating massage signal
Am = 1;
fm = 30;
m_t = Am*cos(2*pi*fm*t);
subplot(4,1,1);
plot(t,m_t);
hold on;
xlabel('time (sec)');
ylabel(' m(t)(Volts) ');
title ('Time domain Message Signal');
%% Generating the carrier signal
Ac = 1; 
fc = 500; 
Carrier= Ac*cos(2*pi*fc*t);
subplot(4,1,2);
plot(t,Carrier);
hold on;
xlabel('time (sec)');
ylabel(' Carrier(t)(Volts) ');
title ('Time domain Carrier Signal');
%% Modulating message signal to carrier signal
beta = 15;
kf = beta*fm/Am;
integral_m_t = 1/(2*pi*fm)*sin(2*pi*fm*t);;
FM_mudolation = Ac*cos((2*pi*fc*t)+2*pi*kf*integral_m_t);
subplot(4,1,3);
plot(t,FM_mudolation,'g');
hold on;
xlabel('time (sec)');
ylabel(' FM(Volts) ');
title ('Time domain FMSignal');
%% Frequency domain signal FM_mudolation 
Frequency_FM = fft(FM_mudolation);
f_FM=linspace(-fc,fc,length(Frequency_FM));
subplot(4,1,4);
plot(f_FM,abs(Frequency_FM),'r');
hold on;
xlabel('Frequency (Hz)');
title ('Frequency domain FM Signal');