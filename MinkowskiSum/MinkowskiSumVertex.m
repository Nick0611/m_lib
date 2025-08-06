% 闵可夫斯基和 暴力算法，时间复杂度O(n^2)
% https://zhuanlan.zhihu.com/p/621941782
% given a convex hull X, each row of X represents a vertex
% given a convex hull Y, each row of Y represents a vertex
% obtain the Minkowski sum of X and Y
% Revision 20230901
% 为了修正边界推进算法，Z = [X;Y];要逐点推进，之前的凸包的点都要保留，通过removeRedundantVertex去除冗余点。
% Revision 20230902
% 不用通过removeRedundantVertex去除冗余点了，直接在本函数里判断（去除冗余，保留凸包边界点）
function [Z] = MinkowskiSumVertex(X,Y)
Z = [X;Y];

for i = 1:size(X,1)
    for j = 1:size(Y,1)
        Z = [Z; X(i,:)+Y(j,:)];
    end
end
Z = uniquetol(Z,'ByRows',true);
if size(Z,1)>size(Z,2)
    for iter_line = 1:size(Z,1)-2
        if abs(normS((Z(1,:)-Z(2,:)))*normS(Z(iter_line+2,:)-Z(2,:))') ~= 1
            n = normS(cross(Z(1,:)-Z(2,:),Z(iter_line+2,:)-Z(2,:)))'; % 找到不共线的三个点
            for i = 1:size(Z,1)-3
                dis(i) = n'*(Z(i+3,:)-Z(2,:))'; % 判断是否共面
                if abs(dis(i))>eps
                    K = convhulln(Z);
                    Z = Z(K);
                    break;
                end
            end
            break;
        end
    end 
end
% Z = removeRedundantVertex(Z);

end