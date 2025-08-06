% 股票走势模拟，本金1元，不定投，计算最终收益
% 2025-2-10
% Zachary Liang
% 发现即使初始价格和最终价格一致，但是中间过程的震荡也会导致收益是负的

% 参数设置
n_days = 365; % 365 天
initial_value = 600; % 第一天价值
final_value = 1000; % 最后一天价值

% 生成随机游走数据
daily_returns = randn(1, n_days-1) * 0.02; % 每日收益率，标准差为 2%
stock_values = cumprod([initial_value, 1 + daily_returns]);

% 线性调整以确保第一天和最后一天的值
x = 1:n_days;
desired_final_value = final_value;
adjustment = (desired_final_value - stock_values(1)) / (stock_values(end) - stock_values(1));
adjusted_stock_values = stock_values(1) + (stock_values - stock_values(1)) * adjustment;

% 绘制股票价值曲线
figure;
plot(x, adjusted_stock_values, 'b', 'LineWidth', 1.5);
xlabel('天数');
ylabel('股票价值');
title('365 天股票价值模拟');
grid on;

% 显示第一天和最后一天的值
fprintf('第一天价值: %.2f\n', adjusted_stock_values(1));
fprintf('最后一天价值: %.2f\n', adjusted_stock_values(end));

df = diff(stock_values);
df=df./stock_values(1:end-1);
money=1;
for i = 1:364
money = money*(1+df(i));
end
money