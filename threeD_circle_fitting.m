%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project: 3D circle fitting
% 功能：空间拟合圆demo，最小二乘
% Author: jiangjp
%         1034378054@qq.com
%         Wuhan University of Technology
% Date:   25/10/2019
% revised: 6/1/2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
clear all;
clc;
close all;
 
%%%   无误差空间圆拟合点  %%%
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

% fid1=fopen('C:\Users\Tang\Desktop\对接调试\步进精度测试\inverse_data.txt');
% formatSpec1='%d,%lf,%lf,%lf,%lf,%lf,%lf';
% A=fscanf(fid1,formatSpec1,[7,inf]);
% A=A';
% fclose(fid1);

% fid1=fopen('C:\Users\Tang\Desktop\对接调试\步进精度测试\test.txt');
% formatspec='%f,%f,%f,%f';
% A=fscanf(fid1,formatspec,[4,inf]);
% fclose(fid1);
%%%   含误差空间圆拟合点  %%%
% load('alpha');
% M=alpha(1:3:end,:);
 
 
[num,dim]=size(M);
 
L1=ones(num,1);
A=(M'*M)\M'*L1;       % 求解平面法向量
 
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
 
C=(D')\(L3);  % 求解空间圆圆心坐标
 
C=C(1:3);
 
radius=0;
for i=1:num
    tmp=M(i,:)-C';
    radius=radius+sqrt(tmp(1)^2+tmp(2)^2+tmp(3)^2);
end
r=radius/num;            %  空间圆拟合半径
 
figure
h1=plot3(M(:,1),M(:,2),M(:,3),'*');
%set(gca,'xlim',[11.4 11.7]);
 
 
%%%%   绘制空间圆  %%%%
n=A;
c=C;
 
theta=(0:2*pi/100:2*pi)';    %  theta角从0到2*pi
a=cross(n,[1 0 0]);          %  n与i叉乘，求取a向量
if ~any(a)                   %  如果a为零向量，将n与j叉乘
    a=cross(n,[0 1 0]);
end
b=cross(n,a);      % 求取b向量
a=a/norm(a);       % 单位化a向量
b=b/norm(b);       % 单位化b向量
 
c1=c(1)*ones(size(theta,1),1);
c2=c(2)*ones(size(theta,1),1);
c3=c(3)*ones(size(theta,1),1);
 
x=c1+r*a(1)*cos(theta)+r*b(1)*sin(theta);  % 圆上各点的x坐标
y=c2+r*a(2)*cos(theta)+r*b(2)*sin(theta);  % 圆上各点的y坐标
z=c3+r*a(3)*cos(theta)+r*b(3)*sin(theta);  % 圆上各点的z坐标
 
hold on;
h2=plot3(x,y,z,'-r');
xlabel('x轴')
ylabel('y轴')
zlabel('z轴')
legend([h1 h2],'控制点','拟合圆');
grid on