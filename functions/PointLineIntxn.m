%%% PointLineIntxn
% 作者 梁振鹍
% Date 2022-07-21
% 计算点p0到直线簇的距离
% 输入1：固定点p 3 by 1
% 输入2: 线簇，6 by n，前三行是方向，后三行是位置
function dis = PointLineIntxn(p0,ksi)
n = ksi(1:3,:); p = ksi(4:6,:); num = size(ksi,2);
lambda = diag((n'*(p0-p)))./diag((n'*n));
pout = p+lambda'.*n;
for i = 1:num
    dis(i,1) = norm(pout(:,i)-p0);
end