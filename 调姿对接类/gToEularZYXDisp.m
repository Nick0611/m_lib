%%% function [ang,pos] = gToEularZYXDisp(g)
% 功能： 将4 by 4的位姿矩阵转换为ZYX顺规的欧拉角表征，弧度制
% 输入1： g 4 by 4，位姿变换矩阵
% 输出1： 欧拉角[绕x;绕y;绕z]
% 输出2： 位置[x;y;z]
% 作者： Zachary Liang
% 时间： 2023-6-4
function [ang,pos] = gToEularZYXDisp(g)
the = -asin(g(3,1)); %y
pu = atan2(g(3,2)/cos(the),g(3,3)/cos(the)); %x
fai = atan2(g(2,1)/cos(the),g(1,1)/cos(the)); %z
ang = [pu;the;fai];
pos = g(1:3,4);