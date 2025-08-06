%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project: 3D circle fitting
% ���ܣ��ռ����Բdemo����С����
% Author: jiangjp
%         1034378054@qq.com
%         Wuhan University of Technology
% Date:   25/10/2019
% revised: 6/1/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
clear all;
clc;
close all;
 
%%%   �����ռ�Բ��ϵ�  %%%
M=[-0.3 0.46 0.83;...
    -0.2 0.254 0.946;...
    -0.1 0.111 0.989;...
    0 0 1;...
    0.1 -0.0910 0.991;...
    0.2 -0.166 0.966;...
    0.3 -0.227 0.927;...
    0.4 -0.275 0.874;...
    0.5 -0.309 0.809;...
    0.6 -0.329 0.729;...
    0.7 -0.332 0.632;...
    0.8 -0.312 0.512;...
    0.9 -0.254 0.354;...
    0.8 0.512 -0.312;...
    0.7 0.632 -0.332;...
    0.6 0.729 -0.329;...
    0.5 0.809 -0.309;...
    0.4 0.874 -0.274;...
    0.3 0.927 -0.227;...
    0.2 0.966 -0.166;...
    0.1 0.991 -0.091;...
    0 1 0;...
    -0.1 0.989 0.111;...
    -0.2 0.946 0.254;...
    -0.3 0.83 0.45];

% fid1=fopen('C:\Users\Tang\Desktop\�Խӵ���\�������Ȳ���\inverse_data.txt');
% formatSpec1='%d,%lf,%lf,%lf,%lf,%lf,%lf';
% A=fscanf(fid1,formatSpec1,[7,inf]);
% A=A';
% fclose(fid1);

% fid1=fopen('C:\Users\Tang\Desktop\�Խӵ���\�������Ȳ���\test.txt');
% formatspec='%f,%f,%f,%f';
% A=fscanf(fid1,formatspec,[4,inf]);
% fclose(fid1);
%%%   �����ռ�Բ��ϵ�  %%%
% load('alpha');
% M=alpha(1:3:end,:);
 
 
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
 
figure
h1=plot3(M(:,1),M(:,2),M(:,3),'*');
%set(gca,'xlim',[11.4 11.7]);
 
 
%%%%   ���ƿռ�Բ  %%%%
n=A;
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