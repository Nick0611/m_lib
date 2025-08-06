%%% sigma3filter
% 功能 对实验数据采回来的点进行任意倍数的sigma滤波
% Data 2021-07-06
% 作者 梁振鹍
% 输入1 理想位置点 3byN OR 2byN
% 输入2 实际位置点 3byN OR 2byN
% 输入3 sigma倍数，例如 1; 默认3
% 输出1 滤波后的数据
% 输出2 滤波后的点矩阵逻辑索引
% 输出3 滤波后的点数量
function varargout = sigma3filter(varargin)
n = 3;
p_ideal = varargin{1};
p_given = varargin{2};
if nargin == 3
    n = varargin{3};
end
num = size(p_given,2);
d = diag(dist(p_ideal',p_given));
UpperBound = mean(d)+n*std(d);
LowerBound = mean(d)-n*std(d);
for i = 1:num
    if dist(p_ideal(:,i)',p_given(:,i)) <= UpperBound & dist(p_ideal(:,i)',p_given(:,i)) >= LowerBound
        emp_prob(i)=1;
    else
        emp_prob(i)=0;
    end
end
emp_prob = logical(emp_prob);
varargout{1} = p_given(:,emp_prob);
varargout{2} = emp_prob;
varargout{3} = size(varargout{1},2);