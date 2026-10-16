
clear;
clc;
close all;

% EXPERIMENT 3: IMPULSE INVARIANCE VS BILINEAR TRANSFORMATION

% INPUT PARAMETERS
Fs = 1000;          % Sampling frequency in Hz
T = 1/Fs;           % Sampling period

Omega_p = 200;      % Passband edge in rad/s
Omega_s = 300;      % Stopband edge in rad/s
Ap = 1;             % Passband attenuation in dB
As = 40;            % Stopband attenuation in dB

% Convert analog angular frequencies to Hz
Fp = Omega_p/(2*pi);
Fstop = Omega_s/(2*pi);

fprintf('EXPERIMENT 3: FILTER DESIGN COMPARISON\n\n');
fprintf('Sampling Frequency = %.2f Hz\n', Fs);
fprintf('Passband Edge = %.2f rad/s\n', Omega_p);
fprintf('Stopband Edge = %.2f rad/s\n', Omega_s);
fprintf('Passband Attenuation = %.2f dB\n', Ap);
fprintf('Stopband Attenuation = %.2f dB\n\n', As);

% ------------------------------------------------
% 1. IMPULSE INVARIANCE METHOD
% ------------------------------------------------

[N1, Wn1] = buttord(Omega_p, Omega_s, Ap, As, 's');
[b_a1, a_a1] = butter(N1, Wn1, 's');

[b_imp, a_imp] = impinvar(b_a1, a_a1, Fs);

fprintf('IMPULSE INVARIANCE METHOD\n');
fprintf('Filter Order = %d\n', N1);
fprintf('Analog Cutoff = %.4f rad/s\n', Wn1);
fprintf('Numerator Coefficients:\n');
disp(b_imp);
fprintf('Denominator Coefficients:\n');
disp(a_imp);

% ------------------------------------------------
% 2. BILINEAR TRANSFORMATION WITH PREWARPING
% ------------------------------------------------

Omega_pw = 2*Fs*tan(pi*Fp/Fs);
Omega_sw = 2*Fs*tan(pi*Fstop/Fs);

[N2, Wn2] = buttord(Omega_pw, Omega_sw, Ap, As, 's');
[b_a2, a_a2] = butter(N2, Wn2, 's');

[b_blt, a_blt] = bilinear(b_a2, a_a2, Fs);

fprintf('\nBILINEAR TRANSFORMATION METHOD\n');
fprintf('Filter Order = %d\n', N2);
fprintf('Prewarped Passband Edge = %.4f rad/s\n', Omega_pw);
fprintf('Prewarped Stopband Edge = %.4f rad/s\n', Omega_sw);
fprintf('Analog Cutoff = %.4f rad/s\n', Wn2);
fprintf('Numerator Coefficients:\n');
disp(b_blt);
fprintf('Denominator Coefficients:\n');
disp(a_blt);

% ------------------------------------------------
% 3. FREQUENCY RESPONSE
% ------------------------------------------------

[H_imp, f] = freqz(b_imp, a_imp, 2048, Fs);
[H_blt, ~] = freqz(b_blt, a_blt, 2048, Fs);

% Magnitude response in dB
figure('Name', 'Filter Comparison');

subplot(2,1,1);
plot(f, 20*log10(abs(H_imp) + eps), 'b', 'LineWidth', 1.5);
hold on;
plot(f, 20*log10(abs(H_blt) + eps), 'r--', 'LineWidth', 1.5);
grid on;
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Magnitude Response Comparison');
legend('Impulse Invariance', 'Bilinear Transformation');
xlim([0 150]);
ylim([-100 5]);

% Phase response
subplot(2,1,2);
plot(f, unwrap(angle(H_imp))*180/pi, 'b', 'LineWidth', 1.5);
hold on;
plot(f, unwrap(angle(H_blt))*180/pi, 'r--', 'LineWidth', 1.5);
grid on;
xlabel('Frequency (Hz)');
ylabel('Phase (degrees)');
title('Phase Response Comparison');
legend('Impulse Invariance', 'Bilinear Transformation');
xlim([0 150]);

fprintf('\nFilter comparison plot generated successfully.\n');
