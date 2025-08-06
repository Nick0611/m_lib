%%% x = NumGradP(f,x0,prc)
% 只计算数值梯度
% 时间：2022-8-16
% 输入1：函数值计算函数的句柄 用 @+函数名输入 m by 1
% 输入2：自变量初值 n by 1
% 输入3：精度，0.00001
% 输出1：雅克比矩阵
% revision 2023-8-19
% function varargout = NumGradP(f,varargin)
% 增加varargin，原来的f只能处理x0一个形参，现在可以无限输入，但是最后一个参数默认是prc
% author： Zachary Liang

function varargout = NumGradP(f,x0,varargin)
x = x0;
dimx = size(x,1);
prc = varargin{end};
d1 = f(x0,varargin{1:end-1});
for i = 1:dimx
    N = zeros(dimx,1);
    N(i) = prc;
    tmp =  f(x+N,varargin{1:end-1});
    d2(:,i) = tmp-d1;
end
J = d2/prc; %输出行元素对自变量元素的偏导

varargout{1} = J;
end
