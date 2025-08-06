%%% function y = normD(X)
% 输入1：X，矩阵
% 输出：y，X每列向量二范数构成的列向量
% 作者：Zachary Liang
% 实践：2023-11-7
function y = normD(X)
for i = 1:size(X,2)
    y(i,1) = norm(X(:,i));
end
