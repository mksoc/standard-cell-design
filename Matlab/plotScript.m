clearvars
close all
clc

%% Read .csv simulation files
t_F = csvread('t_F.csv', 1, 0);
t_R = csvread('t_R.csv', 1, 0);
tp_L = csvread('tp_L.csv', 1, 0);
tp_H = csvread('tp_H.csv', 1, 0);

%% Plot graphs
figure(1)
clf
for i = 1:7
    plot(t_F(:, (2*i-1)).*1e15, t_F(:, 2*i).*1e12,'-*');
    hold on
end
grid on
ylabel('Output 70%-30% falling time [ps]')
xlabel('Load Capacitance [fF]')
exportPdf(gcf,'t_F.pdf')

figure(2)
clf
for i = 1:7
    plot(t_R(:, (2*i-1)).*1e15, t_R(:, 2*i).*1e12,'-*');
    hold on
end
grid on
ylabel('Output 30%-70% rising time [ps]')
xlabel('Load Capacitance [fF]')
exportPdf(gcf,'t_R.pdf')

figure(3)
clf
for i = 1:7
    plot(tp_L(:, (2*i-1)).*1e15, tp_L(:, 2*i).*1e12,'-*');
    hold on
end
grid on
ylabel('Output falling 50%-50% propagation delay [ps]')
xlabel('Load Capacitance [fF]')
exportPdf(gcf,'tp_L.pdf')

figure(4)
clf
for i = 1:7
    plot(tp_H(:, (2*i-1)).*1e15, tp_H(:, 2*i).*1e12,'-*');
    hold on
end
grid on
ylabel('Output rising 50%-50% propagation delay [ps]')
xlabel('Load Capacitance [fF]')
exportPdf(gcf,'tp_H.pdf')