% function result = is_inside_cone(vectors)
% 功能：将给定的向量集生成凸锥，并判断制定的向量是否在凸锥之内
% 原理：根据凸锥的定义，v = Sum(lambda_i *
% v_i)仍然在凸锥内，要求lambda_i>0，则v可以由所有的v_i线性组合得到，包含lambda_i>0的约束条件，则lambda_i可以通过线性规划求解，目标函数是Sum(lambda_i)最小。
% author：Zachary Liang
% Date：2024-4-2
% 输入1：构成凸锥的向量集，每一列表示一个向量
% 输入2：要判断的向量集，每一列表示一个向量
% 输出：1表示在凸锥内，0表示不在凸锥内。


function result = is_inside_cone(vectors,v)
m = size(vectors, 2); % 凸锥向量数量
n = size(v, 2); % 需要判断的向量数量

% 构建线性规划问题
f = ones(m, 1); % 目标函数系数
A = diag(-ones(m,1)); % 不等式约束矩阵
b = zeros(m, 1); % 不等式约束右端向量
Aeq = vectors(:,1:m);

for i = 1:n
    beq = -v(:,i);
    % 求解线性规划问题
    options = optimoptions('linprog', 'Display', 'off');
    [x(:,i), ~, exitflag(i)] = linprog(f, A, b, Aeq, beq, [], [], options);
end
% 判断结果
result = (all(exitflag) && min(min(x)) >= 0);
