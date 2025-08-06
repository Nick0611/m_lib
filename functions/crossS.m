%%% function y = crossS(A,B)
% 功能：cross函数的拓展，用来实现两个矩阵列向量的对应叉乘
% 输入1：A 3 by n
% 输入2：B 3 by n
function y = crossS(A,B)
for i = 1:size(A,2)
    y(:,i) = cross(A(:,i),B(:,i));
end