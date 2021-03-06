%% 读取数据文件
clear;clc;
M = readmatrix('2022-05-20 18：13.txt');
Time = M(:,1); % 提取时间
Displacement = M(:, 2); % 提取位移
Torque_2 = M(:, end-2); % 提取2#通道扭矩
clear M
%% 提取扭矩峰值和谷值
% 峰值提取
isPlus = (Torque_2 > 0);
plusTime = Time(isPlus); plusTorque_2 = Torque_2(isPlus);
[peaks, maxIdx] = findpeaks(plusTorque_2,'MinPeakProminence',max(Torque_2)/2);
% 谷值提取
isMinus = (Torque_2 < 0);
minusTime = Time(isMinus); minusTorque_2 = Torque_2(isMinus);
[valleys, minIdx] = findpeaks(-minusTorque_2,'MinPeakProminence',-min(Torque_2)/2);
%% 绘图
subplot(1,2,1);
plot(Time, Torque_2);
title('Time v.s. Torque2#');
xlabel('Time (s)')
ylabel('Torque2# (N*m)')
subplot(1,2,2);
plot(plusTime(maxIdx), peaks);
hold on;
plot(minusTime(minIdx), -valleys);
hold off;
title('Time v.s. Torque2#Peaks');
xlabel('Time (s)')
ylabel('Torque2# (N*m)')