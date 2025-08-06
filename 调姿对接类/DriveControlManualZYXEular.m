%%% function [Drive,gG] = DriveControlManualZYXEular(ax,ay,az,x,y,z,g_OC,g0,g_now,gb)
% 输入1： ZYX顺规表征的绕x轴转角，弧度制
% 输入2： ZYX顺规表征的绕y轴转角，弧度制
% 输入3： ZYX顺规表征的绕z轴转角，弧度制
% 输入4： 目标x
% 输入5： 目标y
% 输入6： 目标z
% 输入7： g_OC，每个小车坐标系相对于全局坐标系坐标系,1 by num_trolley的元胞，每个元胞元素是4 by 4
% 输入8： g0，每个球头坐标系的初始位置相对于小车坐标系,1 by num_trolley的元胞，每个元胞元素是4 by 4
% 输入9： g_now，小车球头坐标系当前位置相对小车坐标系，1 by num_trolley的元胞，每个元胞元素是4 by 4
% 输入10： gb，每个球头坐标系相对于活动段自身坐标系,1 by num_trolley的元胞，每个元胞元素是4 by 4
% 输出1： Drive 每台车在每个路径点下的各个油缸的驱动量
% 输出2： gG 每台车的球头在全局坐标系下的每个路径点上对应的位置
% 作者： Zachary Liang
% 时间： 2023-6-5
function [Drive,gG] = DriveControlManualZYXEular(ax,ay,az,x,y,z,g_OC,g0,g_now,gb)
[R,g] = T_Matrix(ax,ay,az,x,y,z);
    
num_trolley = size(g_OC,2);
num_Interpolation = 100;
ControlPointRatio = 0.2;
gB = {};

% 路径插值
gg = IntrplBezier(ControlPointRatio,num_Interpolation,eye(4),g); % 李群轨迹插值函数，默认两个关键点之间插值120个，包括首尾关键点
gB = [gg{1}];

% 驱动量计算
for i = 1:num_Interpolation
    for j = 1:num_trolley
        gG{i}{j} = gB{i}*gb{j}; % 计算得到的小车球头在全局坐标系中的位姿
        Drive{i}{j} = HydraulicTrolleyXYZInv(g0{j},pinv(g_OC{j})*gG{i}{j}); % 第j个车的第i个轨迹点的运动学逆解
    end
%     DrawCoor(gcf,gB{i},1);
end

% 各车各液压缸在编码器原点坐标系中的绝对值
for j = 1:num_trolley
    for i = 1:100
        Drive{i}{j} = Drive{i}{j}+g_now{j}(1:3,4); % 加上此时的编码器的数值
    end
end
1;