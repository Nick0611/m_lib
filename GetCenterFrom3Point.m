%%% GetCenterFrom3Point
% 作者：唐术杰
function [center,radius] = GetCenterFrom3Point(P1,P2,P3)
%%根据给定的3个点，求出园的圆心坐标(x0,y0)和半径(r0)。
    if length(P1)==2
        kab=(P2(1)-P1(1))/(P1(2)-P2(2));
        kbc=(P3(1)-P2(1))/(P2(2)-P3(2));
        a=(P1+P2)/2;
        b=(P2+P3)/2;
        x0=(kab*a(1)-a(2)-kbc*b(1)+b(2))/(kab-kbc);
        y0=kab*(x0-a(1))+a(2);
        r0=norm([x0,y0]-P1);
        center=[x0;y0];
        radius=r0;
    elseif length(P1)==3
        x1=P1(1);x2=P2(1);x3=P3(1);
        y1=P1(2);y2=P2(2);y3=P3(2);
        z1=P1(3);z2=P2(3);z3=P3(3);

        a1 = (y1*z2 - y2*z1 - y1*z3 + y3*z1 + y2*z3 - y3*z2);
        b1 = -(x1*z2 - x2*z1 - x1*z3 + x3*z1 + x2*z3 - x3*z2);
        c1 = (x1*y2 - x2*y1 - x1*y3 + x3*y1 + x2*y3 - x3*y2);
        d1 = -(x1*y2*z3 - x1*y3*z2 - x2*y1*z3 + x2*y3*z1 + x3*y1*z2 - x3*y2*z1);

        a2 = 2 * (x2 - x1);
        b2 = 2 * (y2 - y1);
        c2 = 2 * (z2 - z1);
        d2 = x1 * x1 + y1 * y1 + z1 * z1 - x2 * x2 - y2 * y2 - z2 * z2;

        a3 = 2 * (x3 - x1);
        b3 = 2 * (y3 - y1);
        c3 = 2 * (z3 - z1);
        d3 = x1 * x1 + y1 * y1 + z1 * z1 - x3 * x3 - y3 * y3 - z3 * z3;

        x = -(b1*c2*d3 - b1*c3*d2 - b2*c1*d3 + b2*c3*d1 + b3*c1*d2 - b3*c2*d1)...
            /(a1*b2*c3 - a1*b3*c2 - a2*b1*c3 + a2*b3*c1 + a3*b1*c2 - a3*b2*c1);
        y = (a1*c2*d3 - a1*c3*d2 - a2*c1*d3 + a2*c3*d1 + a3*c1*d2 - a3*c2*d1)...
            /(a1*b2*c3 - a1*b3*c2 - a2*b1*c3 + a2*b3*c1 + a3*b1*c2 - a3*b2*c1);
        z = -(a1*b2*d3 - a1*b3*d2 - a2*b1*d3 + a2*b3*d1 + a3*b1*d2 - a3*b2*d1)...
            /(a1*b2*c3 - a1*b3*c2 - a2*b1*c3 + a2*b3*c1 + a3*b1*c2 - a3*b2*c1);

        r = sqrt((x1 - x)*(x1 - x) + (y1 - y)*(y1 - y) + (z1 - z)*(z1 - z));

        center=[x;y;z];

        radius=r;
    end
end