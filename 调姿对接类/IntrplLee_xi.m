%%% function g = IntrplLee(num,varargin)
% 功能： 给定两个位姿，在SE(3)中进行轨迹插值
% 注意： 自适应插值次数，给定2个g就线性插值，给定3个g就2次插值
% 输入1： 插值后的轨迹点数量 包括首尾控制点
% 输入2： 起始位姿g1 4 by 4, 目标位姿g2,g3,...,gn 4 by 4，依次写出即可
% 输出1： 插值得到的每个插值点上的SE(3)，1 by num 的元胞
% 作者： Zachary Liang
% 时间： 2023-5-22

function xi = IntrplLee_xi(num,varargin)
i = linspace(0,1,num);
n = nargin-1;
xi_K = cell(1,n-1);
coder.varsize('xi_K');
for j = 1:n-1
    xi_K{j} = coder.nullcopy(cell(1,num));
    for iter = 1:num
        xi_K{j}{iter} = InterpolationLinear_xi(varargin{j},varargin{j+1},i(iter));
    end
end
while(n-2)
    for k = 1:(n-2)
        for iter = 1:num
            xi_K{k}{iter} = InterpolationLinear_xi(xi_K{k}{iter},xi_K{k+1}{iter},i(iter));
        end
    end
    n = n-1;
    xi_K(end) = [];
end
xi = xi_K{1};

    