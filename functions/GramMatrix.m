% function Gram = GramMatrix(X)
% 计算X的Gram矩阵，Gram矩阵是将X的每一列看作一个向量，G(i,j)就是第i列和第j列向量的内积
% 输入1：X， m by n，n个列向量
% 输出1：Gram，n by n
% 作者：Zachary Liang
% 日期：2023-10-10
function Gram = GramMatrix(X)
% % 方法1
% for i = 1:size(X,2)
%     for j = 1:size(X,2)
%         % 计算第i列和第j列向量的内积，得到Gram矩阵的元素
%         Gram(i, j) = dot(X(:, i), X(:, j));
%     end
% end
% 方法2
Gram = X'*X;