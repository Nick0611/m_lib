% function [line_n,line_p0] = PlnIntxnPln(n1,p1,n2,p2)
% 计算两个平面的交线方程，用向量形式表征
% 输入1~4：平面1的法向量、上面一点，平面2的法向量、上面一点,3 by 1
% 输出1：交线法向量
% 输出2：交线上一点
% 作者：Zachary Liang
% 日期：2023-10-10
function [line_n,line_p0] = PlnIntxnPln(n1,p10,n2,p20)
line_n = cross(n1,n2);
N = [line_n,n1,n2]';
N0 = [line_n'*p10;n1'*p10;n2'*p20];
line_p0 = N\N0;