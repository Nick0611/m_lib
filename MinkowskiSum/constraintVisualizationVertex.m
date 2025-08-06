% 顶点表示的多面体可视化
% https://zhuanlan.zhihu.com/p/621941782
%   given a convex hull X, each row of X represents a vertex
%   draw this convex hull
function [figP,figL,C,V] = constraintVisualizationVertex(X,varargin)

DT = delaunayTriangulation(X);
[C,V]  = convexHull(DT); % V是体积

figP = plot3S(DT.Points','.','MarkerSize',10);
hold on
if size(X,2) == 3
    figL = trisurf(C,DT.Points(:,1),DT.Points(:,2),DT.Points(:,3), varargin{1:end});
end
if size(X,2) == 2
    if nargin == 1
        figL = patch(DT.Points(C,1),DT.Points(C,2),'r');
    else
        figL = patch(DT.Points(C,1),DT.Points(C,2),varargin{1:end});
    end
end
end