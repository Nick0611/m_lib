%%% function g = InterpolationLinear(g1,g2,t)
% 功能： 两个SE(3)关键点之间在t位置的插值点
% 输入1： 位姿关键点1 4 by 4
% 输入2： 位姿关键点2 4 by 4
% 输入3： 插值位置 0~1之间
% 输出1： 插值点上的g 4 by 4 属于SE(3)
% 作者： Zachary Liang
% 时间： 2023-5-22
function g = InterpolationLinear(g1,g2,t) % 两个关键点之间在t位置的插值点
g = g1*expm(t*logm(pinv(g1)*g2));
