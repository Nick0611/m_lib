function [u,ro] = planefitTang (data,c,n)
% ��ͬһ�б��������ƽ�棬Ŀ�꺯���������Ϊƽ��,��������ʾ��Ϊ������
% 2020.7.15

% ���� data--��������
%      c--��ȡ���ݳ���
%      n--�������²�ֵ
% ��� u--���ƽ�淨����
%% ����������
P=data(1:c,:);
% ĩ�˵�
dA=P(:,34:36)';
dB=P(:,37:39)';
dC=P(:,40:42)';
% �м��
mA=P(:,25:27)';
mB=P(:,28:30)';
mC=P(:,31:33)';
planedata=[dA,dB,dC,mA,mB,mC]';

figure('color','w')

hold on
axis equal

%% ��ϴ��������²�ֵ     
u=n;
u=u/norm(u);
r=norm(u);
theta=acos(u(3)/r);
phi=atan(u(2)/u(1));
ro=transpose(mean(planedata,1));      % ���ƽ����ĳ��
d=[10;10;10;10;10;10];                % ��ص����ƽ��ľ���
%% Ŀ�꺯�����ſɱȾ���
MM=30;
num=0;
for i=1:MM
    [f,J]=grad_obj(dA,dB,dC,mA,mB,mC,theta,phi,ro,d);
    disp(['����������',num2str(i),'    ��ǰ�������',num2str(sqrt(max(abs(f))))]);%'        ������',num2str(cond(J))]);
    if max(abs(f))<1e-3
        break;
    end
    delta=-pinv(J)*f;
    theta=theta+delta(7,:);
    phi=phi+delta(8,:);
    d=d+delta(1:6,:);
    num=num+1;
end
disp(['�����ܴ�����',num2str(num),'    ��ǰ�������',num2str(sqrt(max(abs(f))))]);
u=[sin(theta)*cos(phi);sin(theta)*sin(phi);cos(theta)];
%%
xfitr = min(dC(1,:))-90:5:max(dC(1,:))+90;
yfitr = min(dC(2,:))-80:5:max(dC(2,:))+140;
[XFITR,YFITR]= meshgrid (xfitr,yfitr);
ZFITR = -(-u'*ro + u(1) * XFITR + u(2) * YFITR)/u(3);
mesh(XFITR,YFITR,ZFITR);
alpha(0.5);

%% ���� Ŀ�꺯�� �� �ſɱȾ���
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
