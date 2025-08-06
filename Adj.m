% Revision-2023-11-11
% 作者：Zachary Liang
% 增加输入判断6*1旋量的adj伴随变换功能
function Adg=Adj(g)
%both for se(3) and SE(3)
if size(g,1) == 6 && size(g,2) == 1
    Adg = [Wed(g(1:3)),zeros(3,3);Wed(g(4:6)),Wed(g(1:3))];
else
    jud=g(4,4);
    if abs(jud-1)<1e-3 %Lie group
        Rot=g(1:3,1:3);
        tra=g(1:3,4);
        Tra=Wed(tra);
        Adg=blkdiag(Rot,Rot);
        Adg(4:6,1:3)=Tra*Rot;
    else
        w=g(1:3,1:3);%lie group
        v=Wed(g(1:3,4));
        Adg=blkdiag(w,w);
        Adg(4:6,1:3)=v;
    end
end