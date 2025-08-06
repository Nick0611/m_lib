%%% function v_fea = TenOf8Cbl_Exhaustion(N,tau_g,tmin,tmax)
% author: Zahcary Liung
% Date: 2024-3-19
% 穷举计算可行多边形
% Note: 不等式判断部分等号的取法和文献不同
% input1: 结构矩阵的零空间矩阵 n by (m-n)
% input2: 力平衡方程的通解 n by 1
% input3: 绳索的最小拉力矢量 m by 1
% input4: 绳索的最大拉力矢量 m by 1
% output1: 可行多边形的顶点 2 by 不确定
% revision-2024-3-20
% 修改小数位数decimal为1，原先是6，放宽一些误差。要不然算直线交点很容易误差太大，但是好像会误操作啊
% revision-2024-5-21：使用linecross2D_2来判断两个直线的交点而不是linecross2D，linecross2D不能处理斜率无穷大
% revision 2024-5-22:还是得用round啊，要不然有的点判断≥的时候会被丢掉
% 还得再把散点变得有序，因为计算多边形重心的算法PolygonCentroid需要有序。
% revision 2024-6-9：增加了v_fea的非空判断，要不然计算凸包会报错
% revision 2024-7-6
% 把~isempty(v_fea)换成size(v_fea,2)>2，因为有可能计算出来只有两个点，convhull会报错
function v_fea = TenOf8Cbl_Exhaustion(N,tau_g,tmin,tmax)
dim = size(N,1);
decimal = 6;
v_fea = []; % 记录可行多边形的顶点集合
NN(1:2:2*dim,:) = N; NN(2:2:2*dim,:) = N;
t(1:2:2*dim) = tmin-tau_g; t(2:2:2*dim) = tmax-tau_g;
for i = 1:2*dim-1
    for j = i+1:2*dim
        %     vij = linecross2D(-NN(i,1)/NN(i,2),t(i)/NN(i,2),-NN(j,1)/NN(j,2),t(j)/NN(j,2));
        vij = linecross2D_2(NN(i,1),NN(i,2),-t(i),NN(j,1),NN(j,2),-t(j));
        if ~isempty(vij)
            if round(N*vij,decimal)>=round(tmin-tau_g,decimal) & round(N*vij,decimal)<=round(tmax-tau_g,decimal) % 验证这个交点是否满足所有不等式约束。round的原因：将浮点数四舍五入到特定的精度，以消除小的数值误差。
%             if N*vij>=tmin-tau_g & N*vij<=tmax-tau_g
                v_fea(:,end+1) = vij;
            end
        end
    end
end
if size(v_fea,2)>2
    v_fea = uniquetol(v_fea','ByRows',true)'; % 存在多条直线分别重合的情况，算出的交点是重复的，同时也是存在数值误差的，使用uniquetol找到唯一行，将处于容差范围内的行视为相等
    % 计算凸包
    k = convhull(v_fea(1,:), v_fea(2,:));
    % 获取凸包顶点（有序）
    v_fea = v_fea(:,k(1:end-1));
end
