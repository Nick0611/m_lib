%%% planefit
% ɢ�����ƽ�棬��ͼ
% ����1 ���ݵ����ÿһ����һ����
% ����2 ��������ʼ�²�ֵ
% ���1 ƽ�淨����
% ���2 ƽ��λ�ã����е��ƽ��ֵ��
% ���3 ƽ��������е㵽ƽ�������dis��
% ���� �����d
% Date 2021-07-23

function [u,ro,dis] = planefit (data,n)
% ��ͬһ�б��������ƽ�棬Ŀ�꺯���������Ϊƽ��,��������ʾ��Ϊ������
% 2020.7.15

% ���� data--��������
%      c--��ȡ���ݳ���
%      n--�������²�ֵ
% ��� u--���ƽ�淨����

planedata = data;
Pnum = size(planedata,2);
figure('color','w')

%% ��ϴ��������²�ֵ     
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
ro=mean(planedata,2);      % ���ƽ����ĳ��
d=10;                % ��ص����ƽ��ľ���
%% Ŀ�꺯�����ſɱȾ���
MM=30;
num=0;
for i=1:MM
    [f,J]=grad_obj(planedata,theta,phi,ro,d);
    disp(['����������',num2str(i),'    ��ǰ�������',num2str(sqrt(max(abs(f))))]);%'        ������',num2str(cond(J))]);
    if max(abs(f))<1e-3
        break;
    end
    delta=-pinv(J)*f;
    theta=theta+delta(2,:);
    phi=phi+delta(3,:);
    d=d+delta(1,:);
    num=num+1;
end
disp(['�����ܴ�����',num2str(num),'    ��ǰ�������',num2str(sqrt(max(abs(f))))]);
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
%% ���� Ŀ�꺯�� �� �ſɱȾ���
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
