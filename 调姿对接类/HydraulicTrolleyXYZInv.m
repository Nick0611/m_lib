%%% function P = HydraulicTrolleyXYZInv(g0,g)
% 功能： 计算赫曼液压车的运动学逆解
% 输入1： g0，零位位姿，相对于车身坐标系{C}
% 输入2： g，目标位姿，相对于车身坐标系{C}
% 输出： P，3 by 1，为xyz三个方向的油缸的运动量
% 作者： Zachary Liang
% 时间： 2023-5-28
function P = HydraulicTrolleyXYZInv(g0,g)
dg = Vee(logm(pinv(g0)*g));
P = dg(4:6);
