%%% function varargout = RodriguezTrans(varargin)
% 功能：罗德利斯旋转和旋转矩阵之间相互转化，输入1个参数旋转矩阵，则输出旋转轴u和转角the；
% 输入两个参数旋转轴方向和旋转角，则输出旋转矩阵
% 作者：梁振鹍
% 日期：2022-3-15
% 来源：https://blog.csdn.net/qq_31806429/article/details/87920597
function varargout = RodriguezTrans(varargin)
if nargin == 1
    R = varargin{1};
    the = acos((trace(R)-1)/2);
    x = (R-R')/2/sin(the);
    u = [x(3,2);x(1,3);x(2,1)];
    varargout{1} = u;
    varargout{2} = the;
else
    n = varargin{1};n = n/norm(n);
    the = varargin{2};
    R = cos(the)*eye(3)+(1-cos(the))*n*n'+sin(the)*Wed(n);
    varargout{1} = R;
end