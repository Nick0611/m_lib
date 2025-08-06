%%% planefit
% 散点拟合平面，作图
% 输入1 数据点矩阵，每一列是一个点
% 输入2 法向量初始猜测值
% 输出1 平面法向量
% 输出2 平面位置（所有点的平均值）
% 输出3 平面度误差（所有点到平面的误差和dis）
% 作者 梁振鹍
% Date 2021-07-23

function [u,ro,dis] = planefit (data,n)
% 由同一靶标球点簇拟合平面，目标函数距离项改为平方,法向量表示改为球坐标
% 2020.7.15

% 输入 data--导入数据
%      c--截取数据长度
%      n--法向量猜测值
% 输出 u--拟合平面法向量

planedata = data;
Pnum = size(planedata,2);
figure('color','w')

%% 拟合待定参数猜测值     
u=n;
u=u/norm(u);
r=norm(u);
theta=acos(u(3)/r);
if u(1)==0
    if u(2)>0
        phi = pi/2;
    elseif u(2)<0
        phi = -pi/2;
    else
        phi = 0;
    end
else
    phi=atan(u(2)/u(1));
end
ro=mean(planedata,2);      % 拟合平面上某点
d=10;                % 点簇到拟合平面的距离
%% 目标函数和雅可比矩阵
MM=30;
num=0;
for i=1:MM
    [f,J]=grad_obj(planedata,theta,phi,ro,d);
    disp(['迭代次数：',num2str(i),'    当前无穷范数：',num2str(sqrt(max(abs(f))))]);%'        条件数',num2str(cond(J))]);
    if max(abs(f))<1e-3
        break;
    end
    delta=-pinv(J)*f;
    theta=theta+delta(2,:);
    phi=phi+delta(3,:);
    d=d+delta(1,:);
    num=num+1;
end
disp(['迭代总次数：',num2str(num),'    当前无穷范数：',num2str(sqrt(max(abs(f))))]);
u=[sin(theta)*cos(phi);sin(theta)*sin(phi);cos(theta)];
%%
xfitr = linspace(min(planedata(1,:)),max(planedata(1,:)),10);
yfitr = linspace(min(planedata(2,:)),max(planedata(2,:)),10);
[XFITR,YFITR]= meshgrid (xfitr,yfitr);
ZFITR = -(-u'*ro + u(1) * XFITR + u(2) * YFITR)/u(3);
mesh(XFITR,YFITR,ZFITR);
alpha(0.5);
hold on
axis equal
scatter3(planedata(1,:),planedata(2,:),planedata(3,:),'filled');

dis = norm((planedata-repmat(ro,1,Pnum))'*u,2);
%% 构造 目标函数 和 雅可比矩阵
end

function [obj,Jacobi] = grad_obj (A,theta,phi,ro,d)
    c=size(A,2);
    obj=zeros(c,1);
    Jacobi=zeros(c,3);
    u=[sin(theta)*cos(phi);sin(theta)*sin(phi);cos(theta)];
    u_t=[cos(theta)*cos(phi);cos(theta)*sin(phi);-sin(theta)];
    u_p=[-sin(theta)*sin(phi);sin(theta)*cos(phi);0];
    for i=1:c
        v1=A(:,i)-ro;
        obj(i,:)=(u'*v1)'*(u'*v1)-(d(1,:))^2;
        Jacobi(i,:)=[-2*d,2*(u'*v1)*v1'*u_t,2*(u'*v1)*v1'*u_p];
    end
end
