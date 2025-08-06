%%% function y = ColNorm(x)
% 对矩阵的每一列求二范数
% 输入：x， 3 by N
% 输出：y， 1 by N
function y = ColNorm(x)
[row,col] = size(x);
for i = 1:col
    y(i) = norm(x(:,i));
end