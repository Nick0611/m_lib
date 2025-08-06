function [x,yk]=LN_TLS(Jacp,dely,alp)
% 最小范数（Least Norm）的TLS方法，有效位数选择使用范数比方法
B=[-dely,Jacp];
[Ak,yk]=signi_rank(B,alp);
[U,S,V]=svd(Ak);
[rowV,colV]=size(V);
for i=1:(colV-yk)
    V1=V(:,(yk+1):colV);
    v1=V1(1,:);
    a=v1*v1';
    x=V1(2:rowV,:)*v1'/(v1*v1');
    if a<0.1
       yk=yk-1;
    else
        break;
    end
end