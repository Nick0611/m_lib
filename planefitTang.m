function [u,ro] = planefitTang (data,c,n)
% 由同一靶标球点簇拟合平面，目标函数距离项改为平方,法向量表示改为球坐标
% 2020.7.15

% 输入 data--导入数据
%      c--截取数据长度
%      n--法向量猜测值
% 输出 u--拟合平面法向量
%% 导入点簇数据
P=data(1:c,:);
% 末端点
dA=P(:,34:36)';
dB=P(:,37:39)';
dC=P(:,40:42)';
% 中间点
mA=P(:,25:27)';
mB=P(:,28:30)';
mC=P(:,31:33)';
planedata=[dA,dB,dC,mA,mB,mC]';

figure('color','w')

hold on
axis equal

%% 拟合待定参数猜测值     
u=n;
u=u/norm(u);
r=norm(u);
theta=acos(u(3)/r);
phi=atan(u(2)/u(1));
ro=transpose(mean(planedata,1));      % 拟合平面上某点
d=[10;10;10;10;10;10];                % 点簇到拟合平面的距离
%% 目标函数和雅可比矩阵
MM=30;
num=0;
for i=1:MM
    [f,J]=grad_obj(dA,dB,dC,mA,mB,mC,theta,phi,ro,d);
    disp(['迭代次数：',num2str(i),'    当前无穷范数：',num2str(sqrt(max(abs(f))))]);%'        条件数',num2str(cond(J))]);
    if max(abs(f))<1e-3
        break;
    end
    delta=-pinv(J)*f;
    theta=theta+delta(7,:);
    phi=phi+delta(8,:);
    d=d+delta(1:6,:);
    num=num+1;
end
disp(['迭代总次数：',num2str(num),'    当前无穷范数：',num2str(sqrt(max(abs(f))))]);
u=[sin(theta)*cos(phi);sin(theta)*sin(phi);cos(theta)];
%%
xfitr = min(dC(1,:))-90:5:max(dC(1,:))+90;
yfitr = min(dC(2,:))-80:5:max(dC(2,:))+140;
[XFITR,YFITR]= meshgrid (xfitr,yfitr);
ZFITR = -(-u'*ro + u(1) * XFITR + u(2) * YFITR)/u(3);
mesh(XFITR,YFITR,ZFITR);
alpha(0.5);

%% 构造 目标函数 和 雅可比矩阵
end

function [obj,Jacobi] = grad_obj (A,B,C,MA,MB,MC,theta,phi,ro,d)
    c=size(A,2);
    obj=zeros(6*c,1);
    Jacobi=zeros(6*c,8);
    u=[sin(theta)*cos(phi);sin(theta)*sin(phi);cos(theta)];
    u_t=[cos(theta)*cos(phi);cos(theta)*sin(phi);-sin(theta)];
    u_p=[-sin(theta)*sin(phi);sin(theta)*cos(phi);0];
    for i=1:c
        v1=A(:,i)-ro;
        obj(i,:)=(u'*v1)'*(u'*v1)-(d(1,:))^2;
        Jacobi(i,:)=[-2*d(1,:),0,0,0,0,0,2*(u'*v1)*v1'*u_t,2*(u'*v1)*v1'*u_p];
        
        v2=B(:,i)-ro;
        obj(c+i,:)=(u'*v2)'*(u'*v2)-(d(2,:))^2;
        Jacobi(c+i,:)=[0,-2*d(2,:),0,0,0,0,2*(u'*v2)*v2'*u_t,2*(u'*v2)*v2'*u_p];
        
        v3=C(:,i)-ro;
        obj(2*c+i,:)=(u'*v3)'*(u'*v3)-(d(3,:))^2;
        Jacobi(2*c+i,:)=[0,0,-2*d(3,:),0,0,0,2*(u'*v3)*v3'*u_t,2*(u'*v3)*v3'*u_p];
        
        v4=MA(:,i)-ro;
        obj(3*c+i,:)=(u'*v4)'*(u'*v4)-(d(4,:))^2;
        Jacobi(3*c+i,:)=[0,0,0,-2*d(4,:),0,0,2*(u'*v4)*v4'*u_t,2*(u'*v4)*v4'*u_p];
        
        v5=MB(:,i)-ro;
        obj(4*c+i,:)=(u'*v5)'*(u'*v5)-(d(5,:))^2;
        Jacobi(4*c+i,:)=[0,0,0,0,-2*d(5,:),0,2*(u'*v5)*v5'*u_t,2*(u'*v5)*v5'*u_p];
        
        v6=MC(:,i)-ro;
        obj(5*c+i,:)=(u'*v6)'*(u'*v6)-(d(6,:))^2;
        Jacobi(5*c+i,:)=[0,0,0,0,0,-2*d(6,:),2*(u'*v6)*v6'*u_t,2*(u'*v6)*v6'*u_p];
    end
end
