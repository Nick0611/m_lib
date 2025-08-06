function [result,T]=transform_svd(target,source)
%输出刚体变换矩阵，可以讲source点所在坐标系转换到target点所在的坐标系中。
%即target~ result=T*source;
% Date 2021-07-06
% 来源 陈坤勇
% 输入 target Nby3
% 输入 source Nby3
ptm=mean(target);targetm=target-ptm;
psm=mean(source);sourcem=source-psm;
w=sourcem'*targetm;
[u,d,v]=svd(w);
R=v*u';
if det(R)<0
    v(:,3)=-v(:,3);
    R=v*u';
end
t=ptm-(R*psm')';
T=[R,t';0,0,0,1];
result=transform(T,source);