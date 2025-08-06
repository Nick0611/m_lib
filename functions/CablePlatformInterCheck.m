% function y = CablePlatformInterCheck(u,varargin)
% 功能：判断绳索与动平台是否发生干涉
% 输入1：绳索的方向向量，从动平台锚点指向机架出绳点
% 输入2~num：锚点周围相邻的动平台的边界面的指向外部的方向向量
% 输出：0：绳索与动平台干涉；正值：不干涉，且值为绳索与最近面的夹角弧度制
% 作者：Zachary Liang
% 时间：2024-6-9
function y = CablePlatformInterCheck(u,varargin)
num = nargin-1;
for i = 1:num
    n(:,i) = varargin{i};
    tmp(i) = u'*n(:,i);
end
if all(tmp<=0)
    y = 0;
else
    A = tmp;
    A(tmp<=0) = 100;
    [M,I] = min(A);
    y = pi/2-acos(M); % 离面最近的夹角评价指标
end
