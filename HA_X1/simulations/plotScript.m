% CO OUTPUT

%% Read .csv simulation files
tp_CO_falling_schematic = csvread('./schematic/25deg/CO/CO_A_B_tp_L.csv', 1, 0);
tp_CO_falling_parasitics = csvread('./wParasitics/25deg/CO/CO_A_B_tp_L.csv', 1, 0);
tf_CO_schematic = csvread('./schematic/25deg/CO/CO_A_B_t_F.csv', 1, 0);
tf_CO_parasitics = csvread('./wParasitics/25deg/CO/CO_A_B_t_F.csv', 1, 0);

idx = 7; % input falling time to be plotted when comparing schematic and parasitics

input_tr = ['input t_f = 1.173'; 'input t_f = 4.723'; 'input t_f = 17.19'; 'input t_f = 40.98'; 'input t_f = 78.06'; 'input t_f = 130.1'; 'input t_f = 198.5'];

%% Output falling propagation delay with parasitics
figure(1)
clf
subplot(1, 2, 1)
% Schematic
for i = 1:7
    plot(tp_CO_falling_parasitics(:, (2*i-1)).*1e15, tp_CO_falling_parasitics(:, 2*i).*1e12);
    hold on
end
grid on
title('CO falling 50%-50% propagation delay')
xlabel('Load Capacitance [fF]')
ylabel('tp [ps]')
legend(input_tr, 'Location', 'southeast');

%% Fall transition time with parasitics
figure(1)
subplot(1, 2, 2)
for i = 1:7
    plot(tf_CO_parasitics(:, (2*i-1)).*1e15, tf_CO_parasitics(:, 2*i).*1e12);
    hold on
end
grid on
title('CO 70%-30% falling time')
xlabel('Load Capacitance [fF]')
ylabel('tf [ps]')
legend(input_tr, 'Location', 'southeast');

%% Output falling propagation delay schematic vs parasitics
figure(2)
clf
subplot(1, 2, 1)

plot(tp_CO_falling_schematic(:, 2*idx-1).*1e15, tp_CO_falling_schematic(:, 2*idx).*1e12);
hold on
plot(tp_CO_falling_parasitics(:, 2*idx-1).*1e15, tp_CO_falling_parasitics(:, 2*idx).*1e12);
grid on
title('CO falling 50%-50% propagation delay')
xlabel('Load Capacitance [fF]')
ylabel('tp [ps]')
legend('schematic', 'parasitics', 'Location', 'southeast')

%% Output fall transition time schematic vs parasitics
figure(2)
subplot(1, 2, 2)
plot(tf_CO_schematic(:, 2*idx-1).*1e15, tf_CO_schematic(:, 2*idx).*1e12);
hold on
plot(tf_CO_parasitics(:, 2*idx-1).*1e15, tf_CO_parasitics(:, 2*idx).*1e12);
grid on
title('CO 70%-30% falling time')
xlabel('Load Capacitance [fF]')
ylabel('tf [ps]')
legend('schematic', 'parasitics', 'Location', 'southeast')


% S OUTPUT

%% Read .csv simulation files
tp_S_falling_schematic = csvread('./schematic/25deg/S/S_A-rising_B_tp_L.csv', 1, 0);
tp_S_falling_parasitics = csvread('./wParasitics/25deg/S/S_A-rising_B_tp_L.csv', 1, 0);
tf_S_schematic = csvread('./schematic/25deg/S/S_A-rising_B_t_F.csv', 1, 0);
tf_S_parasitics = csvread('./wParasitics/25deg/S/S_A-rising_B_t_F.csv', 1, 0);

%% Output falling propagation delay with parasitics
figure(3)
clf
subplot(1, 2, 1)
% Schematic
for i = 1:7
    plot(tp_S_falling_parasitics(:, (2*i-1)).*1e15, tp_S_falling_parasitics(:, 2*i).*1e12);
    hold on
end
grid on
title('S falling 50%-50% propagation delay')
xlabel('Load Capacitance [fF]')
ylabel('tp [ps]')
legend(input_tr, 'Location', 'southeast');

%% Fall transition time with parasitics
figure(3)
subplot(1, 2, 2)
for i = 1:7
    plot(tf_S_parasitics(:, (2*i-1)).*1e15, tf_S_parasitics(:, 2*i).*1e12);
    hold on
end
grid on
title('S 70%-30% falling time')
xlabel('Load Capacitance [fF]')
ylabel('tf [ps]')
legend(input_tr, 'Location', 'southeast');

%% Output falling propagation delay schematic vs parasitics
figure(4)
clf
subplot(1, 2, 1)

plot(tp_S_falling_schematic(:, 2*idx-1).*1e15, tp_S_falling_schematic(:, 2*idx).*1e12);
hold on
plot(tp_S_falling_parasitics(:, 2*idx-1).*1e15, tp_S_falling_parasitics(:, 2*idx).*1e12);
grid on
title('S falling 50%-50% propagation delay')
xlabel('Load Capacitance [fF]')
ylabel('tp [ps]')
legend('schematic', 'parasitics', 'Location', 'southeast')

%% Output fall transition time schematic vs parasitics
figure(4)
subplot(1, 2, 2)
plot(tf_S_schematic(:, 2*idx-1).*1e15, tf_S_schematic(:, 2*idx).*1e12);
hold on
plot(tf_S_parasitics(:, 2*idx-1).*1e15, tf_S_parasitics(:, 2*idx).*1e12);
grid on
title('S 70%-30% falling time')
xlabel('Load Capacitance [fF]')
ylabel('tf [ps]')
legend('schematic', 'parasitics', 'Location', 'southeast')