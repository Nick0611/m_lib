%%% function [fai,the] = Cartes2Spher(n)
% 将笛卡尔坐标系转换为球坐标系
% 输入：n    3 by n
% 输出1：fai  与z轴夹角，1 by n 弧度
% 输出2：the  xy平面上的投影和x轴夹角，1 by n 弧度
% 输出3：r  长度，1 by n 弧度
function [fai,the,r] = Cartes2Spher(n)
for i = 1:size(n,2)
    r(i) = norm(n(:,i));
    n(:,i) = n(:,i)/r(i);
    fai(i) = acos(n(3,i));
    the(i) = atan2(n(2,i),n(1,i));
end