%%% circle_fit
% ���ܣ���С���˾���ⷨ��Ͽռ�ɢ��Բ
% ���룺ɢ�����꣬ÿһ��Ϊһ��������
% ���1��ƽ�淨����
% ���2��Բ������
% ���3��Բ�뾶
% Note��������Դ https://blog.csdn.net/jiangjjp2812/article/details/106937333

% Revision �����d
% Data 2021-6-20
% ȡ��figure
% ���ӵ�һ�����ƽ�淨����

function [n,C,r]=circle_fit(M)
M = M';
[num,dim]=size(M);
 
L1=ones(num,1);
A=(M'*M)\M'*L1;       % ���ƽ�淨����
 
B=zeros((num-1)*num/2,3);
 
count=0;
for i=1:num-1
    for j=i+1:num   
        count=count+1;
        B(count,:)=M(j,:)-M(i,:);
    end    
end
 
L2=zeros((num-1)*num/2,1);
count=0;
for i=1:num-1
    for j=i+1:num
        count=count+1;
        L2(count)=(M(j,1)^2+M(j,2)^2+M(j,3)^2-M(i,1)^2-M(i,2)^2-M(i,3)^2)/2;
    end
end
 
D=zeros(4,4);
D(1:3,1:3)=(B'*B);
D(4,1:3)=A';
D(1:3,4)=A;
 
L3=[B'*L2;1];
 
C=(D')\(L3);  % ���ռ�ԲԲ������
 
C=C(1:3);
 
radius=0;
for i=1:num
    tmp=M(i,:)-C';
    radius=radius+sqrt(tmp(1)^2+tmp(2)^2+tmp(3)^2);
end
r=radius/num;            %  �ռ�Բ��ϰ뾶
 
% figure
h1=plot3(M(:,1),M(:,2),M(:,3),'*');
%set(gca,'xlim',[11.4 11.7]);
 
 
%%%%   ���ƿռ�Բ  %%%%
n=A/norm(A);
c=C;
 
theta=(0:2*pi/100:2*pi)';    %  theta�Ǵ�0��2*pi
a=cross(n,[1 0 0]);          %  n��i��ˣ���ȡa����
if ~any(a)                   %  ���aΪ����������n��j���
    a=cross(n,[0 1 0]);
end
b=cross(n,a);      % ��ȡb����
a=a/norm(a);       % ��λ��a����
b=b/norm(b);       % ��λ��b����
 
c1=c(1)*ones(size(theta,1),1);
c2=c(2)*ones(size(theta,1),1);
c3=c(3)*ones(size(theta,1),1);
 
x=c1+r*a(1)*cos(theta)+r*b(1)*sin(theta);  % Բ�ϸ����x����
y=c2+r*a(2)*cos(theta)+r*b(2)*sin(theta);  % Բ�ϸ����y����
z=c3+r*a(3)*cos(theta)+r*b(3)*sin(theta);  % Բ�ϸ����z����
 
hold on;
h2=plot3(x,y,z,'-r');
xlabel('x��')
ylabel('y��')
zlabel('z��')
legend([h1 h2],'���Ƶ�','���Բ');
grid on
end