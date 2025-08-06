function coAdg=coAdj(g)
%both for se(3) and SE(3)
jud=g(4,4);
if abs(jud-1)<1e-3 %Lie group
    Rot=g(1:3,1:3);
    tra=g(1:3,4);
    Tra=Wed(tra);
    coAdg=blkdiag(Rot,Rot);
    coAdg(1:3,4:6)=Tra*Rot;
else
    w=g(1:3,1:3);%lie group
    v=Wed(g(1:3,4));
    coAdg=blkdiag(w,w);
    coAdg(1:3,4:6)=v;
end