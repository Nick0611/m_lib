%%% function f = CylinderFit(x,p)
% 功能：迭代法将散点拟合圆柱的目标函数
% 输入1：x，初始值，3 by 1，[圆柱半径，轴线方向向量的x分量，轴线方向向量的y分量]，z分量通过单位约束求得
% 输入2：p，3 by n，散点坐标矩阵
% 输出：f，n by 1，每个点离拟合圆柱面的距离（半径差）
% 作者：Zachary Liang
% 时间：2023-11-7
% x = [p0x,p0y,p0z,r0,ux,uy]'
% revision 2024-4-16，u用球坐标表示，否则没法保证单位约束
function f = CylinderFit(x,p)
p0 = mean(p,2);
r0 = x(1);
% u = [x(2:3);sqrt(1-x(end)^2-x(end-1)^2)];;
u = [sin(x(2))*cos(x(3));sin(x(2))*sin(x(3));cos(x(2))];
for i = 1:size(p,2)
    f(i,1) = norm((eye(3)-u*u')*(p(:,i)-p0))-r0;
end