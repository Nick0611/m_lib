% 多面体坐标变换
% https://zhuanlan.zhihu.com/p/621941782
function [Y] = constraintTransVertex(X,T)
% given a convex hull X, each row of X represents a vertex
% obtain the set of y=Tx, x in X

Y = T*X';   % get the vertex after transformation
Y = Y';

end