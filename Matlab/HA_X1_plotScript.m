clearvars
close all
clc 

currDir = "../HA_X1/simulations/";
reportPicDir = "../report/Images/HA/";
xRange = [0 65];
yRange = [0 150];
yRange_diff = [1 1.8];

%% w/ parasitics

% CO OUTPUT

% Read .csv simulation files
tp_CO_falling_schematic = csvread(currDir + "schematic/25deg/CO/CO_A_B_tp_L.csv", 1, 0);
tp_CO_falling_parasitics = csvread(currDir + "wParasitics/25deg/CO/CO_A_B_tp_L.csv", 1, 0);
tf_CO_schematic = csvread(currDir + "schematic/25deg/CO/CO_A_B_t_F.csv", 1, 0);
tf_CO_parasitics = csvread(currDir + "wParasitics/25deg/CO/CO_A_B_t_F.csv", 1, 0);

inTime = 4; % input falling time to be plotted when comparing schematic and parasitics

input_tr = 1e-9*[0.00117378,0.00472397,0.0171859,0.0409838,0.0780596,0.130081,0.198535];
input_tr_str = ['input t_f = 1.173'; 'input t_f = 4.723'; 'input t_f = 17.19'; 'input t_f = 40.98'; 'input t_f = 78.06'; 'input t_f = 130.1'; 'input t_f = 198.5'];
C_load = tp_CO_falling_schematic(:, 1)';

% Output falling propagation delay with parasitics
figure(1)
clf
subplot(1, 2, 1)
for i = 1:7
    plot(tp_CO_falling_parasitics(:, (2*i-1)).*1e15, tp_CO_falling_parasitics(:, 2*i).*1e12, '-*');
    hold on
end
grid on
title('CO falling 50%-50% propagation delay')
xlabel('Load Capacitance [fF]')
ylabel('tp [ps]')
legend(input_tr_str, 'Location', 'southeast');
xlim(xRange)
ylim(yRange)
% exportPdf(gcf, reportPicDir + "CO_tp_L.pdf")

% Fall transition time with parasitics
figure(2)
clf
subplot(1, 2, 1)
for i = 1:7
    plot(tf_CO_parasitics(:, (2*i-1)).*1e15, tf_CO_parasitics(:, 2*i).*1e12, '-*');
    hold on
end
grid on
title('CO 70%-30% falling time')
xlabel('Load Capacitance [fF]')
ylabel('tf [ps]')
legend(input_tr_str, 'Location', 'northwest');
xlim(xRange)
ylim([0 120])
% exportPdf(gcf, reportPicDir + "CO_t_F.pdf")


% S OUTPUT

% Read .csv simulation files
tp_S_falling_schematic = csvread(currDir + "schematic/25deg/S/S_A-rising_B_tp_L.csv", 1, 0);
tp_S_falling_parasitics = csvread(currDir + "wParasitics/25deg/S/S_A-rising_B_tp_L.csv", 1, 0);
tf_S_schematic = csvread(currDir + "schematic/25deg/S/S_A-rising_B_t_F.csv", 1, 0);
tf_S_parasitics = csvread(currDir + "wParasitics/25deg/S/S_A-rising_B_t_F.csv", 1, 0);

% Output falling propagation delay with parasitics
figure(1)
subplot(1, 2, 2)

for i = 1:7
    plot(tp_S_falling_parasitics(:, (2*i-1)).*1e15, tp_S_falling_parasitics(:, 2*i).*1e12, '-*');
    hold on
end
grid on
title('S falling 50%-50% propagation delay')
xlabel('Load Capacitance [fF]')
ylabel('tp [ps]')
legend(input_tr_str, 'Location', 'southeast');
xlim(xRange)
ylim(yRange)
exportPdf(gcf, reportPicDir + "tp_L.pdf")

% Fall transition time with parasitics
figure(2)
subplot(1, 2, 2)
for i = 1:7
    plot(tf_S_parasitics(:, (2*i-1)).*1e15, tf_S_parasitics(:, 2*i).*1e12, '-*');
    hold on
end
grid on
title('S 70%-30% falling time')
xlabel('Load Capacitance [fF]')
ylabel('tf [ps]')
legend(input_tr_str, 'Location', 'southeast');
xlim(xRange)
ylim([0 120])
exportPdf(gcf, reportPicDir + "t_F.pdf")

%% Compute differences

tf_CO_parasitics = tf_CO_parasitics(:, [2, 4, 6, 8, 10,12, 14]);
tf_CO_schematic = tf_CO_schematic(:, [2, 4, 6, 8, 10,12, 14]);
tf_S_parasitics = tf_S_parasitics(:, [2, 4, 6, 8, 10,12, 14]);
tf_S_schematic = tf_S_schematic(:, [2, 4, 6, 8, 10,12, 14]);
tp_CO_falling_parasitics = tp_CO_falling_parasitics(:, [2, 4, 6, 8, 10,12, 14]);
tp_CO_falling_schematic = tp_CO_falling_schematic(:, [2, 4, 6, 8, 10,12, 14]);
tp_S_falling_parasitics = tp_S_falling_parasitics(:, [2, 4, 6, 8, 10,12, 14]);
tp_S_falling_schematic = tp_S_falling_schematic(:, [2, 4, 6, 8, 10,12, 14]);

CO_t_F_diff = tf_CO_parasitics./tf_CO_schematic;
S_t_F_diff = tf_S_parasitics./tf_S_schematic;
CO_tp_L_diff = tp_CO_falling_parasitics./tp_CO_falling_schematic;
S_tp_L_diff = tp_S_falling_parasitics./tp_S_falling_schematic;

figure(3)
clf
subplot(1, 2, 1)
surf(input_tr.*1e12, C_load.*1e15, CO_t_F_diff)
xlabel('Input transition time [ps]')
ylabel('Load Capacitance [fF]')
zlabel('tf_{lumped}/tf_{schematic}')
title('Normalized CO 70%-30% falling time')
set(gca, 'View', [140 18], 'ZLim', [0.9 1.7])

subplot(1, 2, 2)
surf(input_tr.*1e12, C_load.*1e15, S_t_F_diff)
xlabel('Input transition time [ps]')
ylabel('Load Capacitance [fF]')
zlabel('tf_{lumped}/tf_{schematic}')
title('Normalized S 70%-30% falling time')
set(gca, 'View', [140 18], 'ZLim', [0.9 1.7])

exportPdf(gcf, reportPicDir + "t_F_diff.pdf")

figure(4)
clf 
subplot(1, 2, 1)
surf(input_tr.*1e12, C_load.*1e15, CO_tp_L_diff)
xlabel('Input transition time [ps]')
ylabel('Load Capacitance [fF]')
zlabel('tp_{lumped}/tp_{schematic}')
title('Normalized CO falling 50%-50% propagation delay')
set(gca, 'View', [140 18], 'ZLim', [0.9 1.7])

subplot(1, 2, 2)
surf(input_tr.*1e12, C_load.*1e15, S_tp_L_diff)
xlabel('Input transition time [ps]')
ylabel('Load Capacitance [fF]')
zlabel('tp_{lumped}/tp_{schematic}')
title('Normalized S falling 50%-50% propagation delay')
set(gca, 'View', [140 18], 'ZLim', [0.9 1.7])

exportPdf(gcf, reportPicDir + "tp_L_diff.pdf")

% [1.3854 1.8125 14.6771 6.2188]

% CO_t_F_diff = tf_CO_parasitics(:,2*inTime)./tf_CO_schematic(:,2*inTime);
% S_t_F_diff = tf_S_parasitics(:,2*inTime)./tf_S_schematic(:,2*inTime);
% CO_tp_L_diff = tp_CO_falling_parasitics(:,2*inTime)./tp_CO_falling_schematic(:,2*inTime);
% S_tp_L_diff = tp_S_falling_parasitics(:,2*inTime)./tp_S_falling_schematic(:,2*inTime);
% 
% figure(3)
% subplot(1, 2, 1)
% plot(tf_CO_parasitics(:,2*inTime-1).*1e15,CO_t_F_diff,'-*')
% grid on
% xlabel('Load Capacitance [fF]')
% ylabel('Normalized CO 70%-30% falling time')
% xlim(xRange)
% ylim(yRange_diff)
% %exportPdf(gcf, currDir + "t_F_diff")
% 
% figure(3)
% subplot(1, 2, 2)
% plot(tf_S_parasitics(:,2*inTime-1).*1e15,S_t_F_diff,'-*')
% grid on
% xlabel('Load Capacitance [fF]')
% ylabel('Normalized S 70%-30% falling time')
% xlim(xRange)
% ylim(yRange_diff)
% %exportPdf(gcf, currDir + "t_R_diff")
% 
% figure(4)
% subplot(1, 2, 1)
% plot(tp_CO_falling_parasitics(:,2*inTime-1).*1e15,CO_tp_L_diff,'-*')
% grid on
% xlabel('Load Capacitance [fF]')
% ylabel('Normalized CO falling 50%-50% propagation delay')
% xlim(xRange)
% ylim(yRange_diff)
% %exportPdf(gcf, currDir + "tp_L_diff")
% 
% figure(4)
% subplot(1, 2, 2)
% plot(tp_S_falling_parasitics(:,2*inTime-1).*1e15,S_tp_L_diff,'-*')
% grid on
% xlabel('Load Capacitance [fF]')
% ylabel('Normalized S falling 50%-50% propagation delay')
% xlim(xRange)
% ylim(yRange_diff)
% %exportPdf(gcf, currDir + "tp_H_diff")