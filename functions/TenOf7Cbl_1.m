% function v_fea = TenOf7Cbl_1(N,tp,tmin,tmax)
% 功能：求7绳索并联机构的力分布
% 输入1：结构矩阵的零空间
% 输入2：力平衡方程对应的伪逆特解
% 输入3：最小允许力向量
% 输入4：最大允许力向量
% 输出：如果有解，则输出通解的取值范围，如果没解，则输出空
% 作者：Zachary Liang
% 时间：2024-6-13
function v_fea = TenOf7Cbl_1(N,tp,tmin,tmax)
% 初始化x的上下限
x_min = -Inf;
x_max = Inf;

% 逐元素计算x的范围
for i = 1:length(N)
    if N(i) > 0
        x_min = max(x_min, (tmin(i)-tp(i)) / N(i));
        x_max = min(x_max, (tmax(i)-tp(i)) / N(i));
    elseif N(i) < 0
        x_min = max(x_min, (tmax(i)-tp(i)) / N(i));
        x_max = min(x_max, (tmin(i)-tp(i)) / N(i));
    else
        if ~(tmax(i)>=0 && tmin(i)<=0)
            v_fea = [];
            return;
        end
    end
end

% 检查是否有解
if x_min <= x_max
    v_fea = [x_min;x_max];
else
    v_fea = [];
end