%% SVD平面拟合
% 输入三维点坐标矩阵，每一列是一个点的xyz坐标
% 输出第一个元素是拟合平面的位置p0(所有点的均值)
% 输出第二个元素是拟合平面的法向量n0

% Revision
% Date 2021-6-20
% 修改作图，采用fill的方式填充所有点构成的平面
%%
function [varargout] = PlaneFittingSVD(varargin)
if isempty(varargin)
    fprintf("    There's no input;\n");
    return
end
pl_store = varargin{1}';
if size(pl_store,2) ~= 3
    fprintf("    Wrong input;\n");
    return
end
% %%%%%%%%%%%% SVD分解求拟合平面法向 %%%%%%%%%%%%%
% 协方差矩阵的SVD变换中，最小奇异值对应的奇异向量就是平面的方向
p0_fit=mean(pl_store,1);
centeredPlane=bsxfun(@minus,pl_store,p0_fit);
[U,S,V]=svd(centeredPlane);
n0_fit = [V(1,3) V(2,3) V(3,3)]';
d=-dot(n0_fit,p0_fit);

% 图形绘制
% xfit = min(pl_store(:,1)):(max(pl_store(:,1))-min(pl_store(:,1)))/20:max(pl_store(:,1));
% yfit = min(pl_store(:,2)):(max(pl_store(:,2))-min(pl_store(:,2)))/20:max(pl_store(:,2));
% [XFIT,YFIT]= meshgrid (xfit,yfit);
% d = -dot(n0_fit,p0_fit);
% ZFIT = -(d + n0_fit(1) * XFIT + n0_fit(2) * YFIT)/n0_fit(3);
% mesh(XFIT,YFIT,ZFIT); % 使用mesh的方法作图，在平面本身接近平行于坐标系平面时，可能平面会非常大
m = size(pl_store,1);
n = 10;
while m/n>100
    n = n*2;
end
p_new = pl_store([1:n:m],1:3); % 降采样
fill3(p_new(:,1),p_new(:,2),p_new(:,3),1); % 平面作图，采用fill的方式填充所有点构成的平面

% %%%%%%%%%%%% SVDn分解求拟合平面法向 %%%%%%%%%%%%%

varargout{1} = p0_fit;
varargout{2} = n0_fit;