% 输入lineData n*3点阵
% 输出1 u0 直线方向
% 输出2 p0 点集的平均
function [u0,p0] = LineFittingSVD(lineData)
% 拟合的直线必过所有坐标的算数平均值
p0 = mean(lineData,1);

% 协方差矩阵奇异变换，与拟合平面不同的是
% 所得直线的方向实际上与最大奇异值对应的奇异向量相同
centeredLine=bsxfun(@minus,lineData,p0);
[U,S,V]=svd(centeredLine);
u0=V(:,1);

% % 画图
% t=-8:0.1:8;
% xx=p0(1)+u0(1)*t;
% yy=p0(2)+u0(2)*t;
% zz=p0(3)+u0(3)*t;
% plot3(xx,yy,zz)