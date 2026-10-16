clear;
clc;
close all;

Fs = 8000;
Ap = 1;
As = 40;

% Low Pass Filter
fp1 = 1000;
fs1 = 1500;

wp1 = fp1/(Fs/2);
ws1 = fs1/(Fs/2);

[N1,Wn1] = buttord(wp1,ws1,Ap,As);
[b1,a1] = butter(N1,Wn1,'low');

% High Pass Filter
fp2 = 2500;
fs2 = 1800;

wp2 = fp2/(Fs/2);
ws2 = fs2/(Fs/2);

[N2,Wn2] = buttord(wp2,ws2,Ap,As);
[b2,a2] = butter(N2,Wn2,'high');

% Display Results
disp('LOW PASS FILTER');
disp('Filter Order:');
disp(N1);
disp('Cutoff Frequency in Hz:');
disp(Wn1*(Fs/2));
disp('Numerator Coefficients:');
disp(b1);
disp('Denominator Coefficients:');
disp(a1);

disp('HIGH PASS FILTER');
disp('Filter Order:');
disp(N2);
disp('Cutoff Frequency in Hz:');
disp(Wn2*(Fs/2));
disp('Numerator Coefficients:');
disp(b2);
disp('Denominator Coefficients:');
disp(a2);

% Frequency Response
[H1,f1] = freqz(b1,a1,1024,Fs);
[H2,f2] = freqz(b2,a2,1024,Fs);

% Plot 1: LPF Magnitude
figure('Name','Butterworth IIR Filters');

subplot(2,2,1);
plot(f1,20*log10(abs(H1)+1e-12),'b');
grid on;
title('Butterworth LPF Magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
ylim([-80 5]);

% Plot 2: LPF Phase
subplot(2,2,2);
plot(f1,angle(H1)*180/pi,'r');
grid on;
title('Butterworth LPF Phase Response');
xlabel('Frequency (Hz)');
ylabel('Phase (degrees)');

% Plot 3: HPF Magnitude
subplot(2,2,3);
plot(f2,20*log10(abs(H2)+1e-12),'b');
grid on;
title('Butterworth HPF Magnitude');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
ylim([-80 5]);

% Plot 4: HPF Phase
subplot(2,2,4);
plot(f2,angle(H2)*180/pi,'r');
grid on;
title('Butterworth HPF Phase Response');
xlabel('Frequency (Hz)');
ylabel('Phase (degrees)');
