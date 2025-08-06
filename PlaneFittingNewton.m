%% 牛顿迭代平面拟合
% 输入三维点坐标矩阵，每一列是一个点的xyz坐标
% 输出第一个元素是拟合平面的位置p0
% 输出第二个元素是拟合平面的法向量n0
% 不好用，20241220
%%
function [varargout] = PlaneFittingNewton(varargin)
if isempty(varargin)
    fprintf("    There's no input;\n");
    return
end
p = varargin{1};
n = varargin{2};
if size(p,1) ~= 3
    fprintf("    Wrong input;\n");
    return
end
scatter3(p(1,:),p(2,:),p(3,:));
P=p(:,1);
for i=1:10
    for j=1:length(p)
        bj=[n',(p(:,j)-P)'];
        B(j,1:6)=(bj);
        d(j,1)=n'*(p(:,j)-P);
    end
    B=pinv(B);
    c=B*d;
    P=P-c(1:3,1);
    n=n-c(4:6,1);
    n=n/norm(n);
end
varargout{1} = P;
varargout{2} = n;
