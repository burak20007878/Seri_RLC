clear;  % Tüm değişkenleri temizler
clc;    % Komut penceresini temizler
close all;  % Tüm figür pencerelerini kapatır
% Parametrelerin tanımlanması
R = 2.925;    % Direnç (Ohm)
L = 0.00009312;   % Endüktans (H)
C = 0.000000680;  % Kapasitans (F)
V_in = 100; % DC Gerilim kaynağı (Volt)
% Başlangıç koşulları
i0 = 0; % Akım başlangıçta sıfır

% Zaman aralığı
tspan = [0 0.0003]; % 0 ile 5 saniye arasında analiz yapılacak

% Diferansiyel denklem fonksiyonu
% di/dt = (V_in - R*i - 1/C*q) / L
% dq/dt = i
% i = akım, q = yük
odefun = @(t, x) [x(2); (V_in - R*x(2) - x(1)/C)/L];

% Başlangıç koşulları: q(0) = 0, i(0) = i0
x0 = [0; i0];

% Diferansiyel denklemi çözme
[t, x] = ode45(odefun, tspan, x0);

% Kondansatör üzerindeki gerilimin hesaplanması
V_C = x(:,1) / C; % V_C(t) = q(t) / C

% Rezonans frekansını hesaplama
f0 = 1 / (2 * pi * sqrt(L * C));

% Kalite faktörünü hesaplama
Q = (1/R) * sqrt(L / C);

% Sonuçların çizimi
figure;
subplot(1,1,1);
plot(t, V_C);
title('Seri RLC Devresi - Kondansatör Gerilimi (V_C)');
xlabel('Zaman (s)');
ylabel('Gerilim (V)');
text(tspan(end) * 0.7, max(V_C) * 0.9, ['f_0 = ', num2str(f0), ' Hz']);
text(tspan(end) * 0.7, max(V_C) * 0.87, ['Q = ', num2str(Q)]);
