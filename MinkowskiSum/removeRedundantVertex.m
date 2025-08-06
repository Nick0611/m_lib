% È¥³ýÈßÓà¶¥µã
% https://zhuanlan.zhihu.com/p/621941782
function [X] = removeRedundantVertex(X)

try
    [k,vol] = convhulln(X);  % get the number of vertex forming the new convex hull
    k = unique(k);
    X = X(k,:);
end

end