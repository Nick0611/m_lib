%%% 5阶旋量系零空间代数余子式法
% 来源：戴建生机构学与机器人学几何基础与旋量代数推论8.4
% 日期：2021-11-27
syms t g d real
J = [0 0 1 0 0 0;
    0 0 0 0 0 1;
    0 0 0 cos(t) sin(t) 0;
    cos(t) sin(t) 0 0 0 0;
    -cos(g)*sin(t) cos(g)*cos(t) sin(g) d*sin(g)*sin(t) -d*sin(g)*cos(t) d*cos(g)];
for i = 1:6
    ind = logical([ones(5,i-1),zeros(5,1),ones(5,6-i)]);
    s(i,1) = (-1)^(i+1)*det(reshape(J(ind),5,5)); % s即为互易旋量
end


%%% 2by5矩阵零空间代数余子式法
% 来源：戴建生机构学与机器人学几何基础与旋量代数例8.4
% 日期：2021-11-27
J = [1 1 0 -1 1;
    1 0 -1 0 1];
for j = 1:3
    for i = 1:3        
        ind = logical([zeros(2,j-1),ones(2,3),zeros(2,5-j-2)]);
        ind(:,i+j-1) = 0;
        s(i,j) = (-1)^(i+1)*det(reshape(J(ind),2,2));
    end
end
b = [[s(:,1);0;0],[0;s(:,2);0],[0;0;s(:,3)]]; % b的每一列都是一个解


%%% 矩阵零空间代数余子式法 通用方法
% 来源：戴建生机构学与机器人学几何基础与旋量代数
% 日期：2021-11-28
syms l2 m2 p2 q2 l3 m3 n3 p3 q3 r3 real
J = [0 0 1 0 0 0;
    l2 m2 0 p2 q2 0;
    l3 m3 n3 p3 q3 r3];
Order = rank(J);
BlkMoveNum = size(J,2)-Order;
for j = 1:BlkMoveNum    
    for i = 1:Order+1
        ind = logical([zeros(Order,j-1),ones(Order,Order+1),zeros(Order,size(J,2)-j-1-Order)]);
        ind(:,i+j-1) = 0
        x = reshape(J(ind),Order,Order);
%         if rank(x) == size(x)
            s(i,j) = (-1)^(i+1)*det(x); % s即为互易旋量
%         else
%             disp('分块不满秩！');
%         end
    end
    b(:,j) = [zeros(j-1,1);s(:,j);zeros(size(J,2)-Order-j,1)];
end
