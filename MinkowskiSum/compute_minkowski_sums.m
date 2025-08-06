% function result = compute_minkowski_sums(A)
% 功能：计算n个向量（m维度）的闵可夫斯基和，穷举的办法
% 原理：n个向量按照二项式系数的顺序选择求和
% 输入：A，m by n
% 输出1：闵可夫斯基和顶点矩阵
% 输出2：矩阵的元胞形式，例如第一个元胞是n个选1个，第二个元胞是n个选2个相加
% 时间：2024-5-16
% 作者：Zachary Liang


% % 示例矩阵
% A = [1 2 3; 4 5 6; 7 8 9];  % 3 x 3 矩阵
%
% % 计算结果
% result = compute_minkowski_sums(A);
%
% % 显示结果
% for k = 1:length(result)
%     fprintf('子矩阵 %d:\n', k);
%     disp(result{k});
% end

function varargout = compute_minkowski_sums(A)
% 获取向量的数量和维度
[d, n] = size(A);
output_A = [];

% 初始化结果
result = {};

% 遍历所有组合
for k = 1:n
    combs = nchoosek(1:n, k);  % 生成k个元素的所有组合
    sum_vectors = zeros(d, size(combs, 1));

    for i = 1:size(combs, 1)
        sum_vector = sum(A(:, combs(i, :)), 2);  % 计算每个组合的和
        sum_vectors(:, i) = sum_vector;
    end

    result{k} = sum_vectors;
    output_A = [output_A,sum_vectors];
end
output_A = unique(output_A', 'rows')';
varargout{1} = output_A;
varargout{2} = result;

