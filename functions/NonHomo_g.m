%%% function y = NonHomo_g(g,x,param1)
% Author: Zachary Leung
% Date: 2023-3-30
% 功能：使用4*4刚性变换矩阵对3*1非齐次坐标变换，得到变换后的非齐次坐标，可以指定是点变换还是向量变换
% input1: g 4 by 4
% input2: x 3 by 3 非齐次的坐标
% input3: 1，为点；0，为向量
% output: y 3 by 1 变换后的非齐次坐标
% revision-2024-3-18
% 允许输入的x是一个矩阵，每一列表示一个元素，对应的输出也为矩阵
function y = NonHomo_g(g,x,param1)
if param1 == 1
    xx = [x;ones(1,size(x,2))];
end
if param1 == 0
    xx = [x;zeros(1,size(x,2))];
end
y = [eye(3) zeros(3,1)]*g*xx;