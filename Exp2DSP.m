clear;
clc;
close all;

Fs = 8000;
Ap = 1;
As = 40;

% Low Pass Filter
fp1 = 1000;
fs1 = 1500;

[N1,Wn1] = buttord(fp1/(Fs/2),fs1/(Fs/2),Ap,As);
[b1,a1] = butter(N1,Wn1,'low');

% High Pass Filter
fp2 = 2500;
fs2 = 1800;

[N2,Wn2] = buttord(fp2/(Fs/2),fs2/(Fs/2),Ap,As);
[b2,a2] = butter(N2,Wn2,'high');

% Display Results
disp('LOW PASS FILTER');
disp(N1);
disp(Wn1*Fs/2);
disp(b1);
disp(a1);

disp('HIGH PASS FILTER');
disp(N2);
disp(Wn2*Fs/2);
disp(b2);
disp(a2);

% Frequency Response
[H1,f1] = freqz(b1,a1,1024,Fs);
[H2,f2] = freqz(b2,a2,1024,Fs);

% Plotting
figure;

subplot(2,2,1);
plot(f1,20*log10(abs(H1)+1e-12),'b');
grid on;
title('LPF Magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
ylim([-80 5]);

subplot(2,2,2);
plot(f1,angle(H1)*180/pi,'r');
grid on;
title('LPF Phase');
xlabel('Frequency (Hz)');
ylabel('Phase (degrees)');

subplot(2,2,3);
plot(f2,20*log10(abs(H2)+1e-12),'b');
grid on;
title('HPF Magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
ylim([-80 5]);

subplot(2,2,4);
plot(f2,angle(H2)*180/pi,'r');
grid on;
title('HPF Phase');
xlabel('Frequency (Hz)');
ylabel('Phase (degrees)');
