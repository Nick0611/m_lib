%%% function xi = LieBkt(xi1,xi2)
% Author: Zachary Leung
% Date: 2023-3-16
% 功能：李括号
% 输入两个旋量（李代数），如果是6*1形式，则将xi1转换为4*4形式并做伴随，左作用到xi2上
% 如果是4*1形式，则xi1*xi2-xi2*xi1。
function xi = LieBkt(xi1,xi2)
if size(xi1,1) == 6
    xi = Adj(Wed(xi1))*xi2;
end
if size(xi1,1) == 4
    xi = xi1*xi2-xi2*xi1;
end