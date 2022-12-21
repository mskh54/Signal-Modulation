%AM Modulator, 1 Dec 2022
clc;  %clear command window
clear all;  %clear our workspace
close all;  %closes all other workable windows

%% Generating message signal signal
mu = 1;   %Modulation Index
Am = 1;   % Amplitude of modulating signal
fm = 10;   % Frequency of modulating (message) signal (we take 10 Hz)
fs = 100*fm;  % Sampling frequency we take 100 times the frequency of message signal 
                   % (to have it properly sampled.)
Tm = 1/fm;    % Time period of modulating signal which will be inverse of its frequency.
t = 0:1/fs:5*Tm;    % We stimulate 5 periods of modulating signal with interval of sampling time 
                           %which is 1/(sampling frequency)
ym = Am*cos(2*pi*fm*t);  % The generated message signal.

%% Generating the carrier signal
Ac = 1;    % Amplitude of carrier signal is minimum magnitude of message signal(Am) / modulation index(m).
fc = 20*fm;   % Frequency of carrier signal (we assume it to be 20 times the frequency of message signal.)
yc = Ac*cos(2*pi*fc*t);    %The generated Carrier signal



%% Modulating message signal to carrier signal 
AM = Ac*cos(2*pi*fc*t).*(1+mu*cos(2*pi*fm*t)); 
DSB=Ac*cos(2*pi*fc*t).*cos(2*pi*fm*t); 
LSSB=(Ac/2)*cos(2*pi*fc*t).*cos(2*pi*fm*t)-(Ac/2)*sin(2*pi*fc*t).*sin(2*pi*fm*t);


%% Time Domain
figure;
subplot(511);    %We will be plotting the time domain message signal, carrier signal and the modulated signal in same plot
plot(t,ym);  %Plotting the message signal
hold on;
xlabel('time (secs) -->');
ylabel(' m(t)(Volts) ');
title ('Time domain Message Signal');

subplot(512); 
hold on;
plot(t,yc); 
ylabel ('ycarrier(Volts)');
xlabel('time (secs) -->');
title ('Time Domain Carrier Signal');

subplot(513);
plot(t,AM,'r');
hold off;
xlabel ('time (secs) -->');
ylabel('AM(Volts)');
title ('time domain AM Signal');

subplot(514);
plot(t,DSB,'g');
hold off;
xlabel ('time (secs) -->');
ylabel('DSB(Volts)');
title ('time domain DSB Signal');

subplot(515);
plot(t,LSSB,'b');
hold off;
xlabel ('time (secs) -->');
ylabel('SSB(Volts)');
title ('time domain LSSB Signal');

%% Frequency Domain
figure;
subplot(511);
f_ym =linspace(-fm,fm,length(ym));
plot(f_ym,abs(fft(ym)))
title ('Frequency domain Message Signal');
xlabel ('Frequency (Hz) -->');

hold on
subplot(512);
f_yc=linspace(-fc,fc,length(yc));
plot(f_yc,abs(fft(yc)))
title ('Frequency domain Carrier Signal');
xlabel ('Frequency (Hz) -->');
hold off

subplot(513);
f_AM=linspace(-fc,fc,length(AM));
plot(f_AM,abs(fft(AM)))
title ('Frequency domain AM Signal');
xlabel ('Frequency (Hz) -->');
hold off

subplot(514);
f_DSB=linspace(-fc,fc,length(DSB));
plot(f_DSB,abs(fft(DSB)))
title ('Frequency domain DSB Signal');
xlabel ('Frequency (Hz) -->');
hold off

subplot(515);
f_SSB=linspace(-fc,fc,length(LSSB));
plot(f_SSB,abs(fft(LSSB)))
title ('Frequency domain LSSB Signal');
xlabel ('Frequency (Hz) -->');




% Demodulating the AM signal ucosg Coherent Detection
% Step 1: Synchronous Demodulation ucosg carrier
Vc = 2*AM.*cos(2*pi*fc*t);
% %Step 2: Low Pass RC Filter we use Butterworth filter for that
[b,a] = butter(3,fc*2/fs);
ym_rec = filter(b,a,Vc); % filtering the demodulated signal
ym_rec=ym_rec- mean(ym_rec); %To get zero mean and low error in demodulation by subtracting mean from each of the terms
% 
figure;
plot(t, ym_rec,'LineWidth',2);  %Plotting the demodulated message signal
hold on;
plot(t,ym,'r');   %plotting the origional message signal in the same plot 
title('demodulated AM signal with origional message signal');
legend('Demodulated AM signal','message signal');
xlabel('Time (s)');
ylabel('Amplitude (Volts)');