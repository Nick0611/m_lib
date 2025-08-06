%%% function P = HydraulicTrolleyXYZFor(g0,Drive)
% 功能： 计算赫曼液压车的运动学逆解
% 输入1： g0，零位位姿
% 输入2： Drive，3 by 1，三个油缸的驱动量
% 输出： P，3 by 1，为球头相对车身坐标系{C}的位置
% 作者： Zachary Liang
% 时间： 2023-5-28
function P = HydraulicTrolleyXYZFor(g0,Drive)
P = g0(1:3,4)+Drive;
