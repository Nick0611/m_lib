function [] = FindCommonTangentofTwoEllipse(ellipse1, ellipse2)
% Function: find common tangent line for two separate ellipses
% Author: Yang Yang
% Date: 2019-02-18
% Usage: input two ellipses paramters, [halfMajor, halfMinor, centerX, centerY, theta(deg)]
% 来源： https://blog.csdn.net/weixin_36444883/article/details/87826299
% 时间： 2023-6-1
% 功能： 找到两个椭圆的公切线，存在以下情况：
% 两个椭圆重合，无数条公切线，这个不做讨论
% 其中一个椭圆被另一个椭圆完全包含，不存在公切线
% 两个椭圆内切，只有一个切点，存在1条公切线
% 两个椭圆内切，只有两个切点，存在2条公切线
% 两个椭圆相交，只有两个交点，存在2条公切线
% 两个椭圆相交，只有三个交点，存在3条公切线
% 两个椭圆相交，只有四个交点，存在4条公切线
% 两个椭圆外切，存在3条公切线
% 两个椭圆相离，存在4条公切线

% Description: test code for FindCommonTangentofTwoEllipse.m
% Author: Yang Yang
% Date: 2019-02-20

% % test case 1, infinity slope
% ep1 = [30, 10, 0, 50, 45];
% ep2 = [30, 10, 0, -50, 45];
% FindCommonTangentofTwoEllipse(ep1, ep2);
% 
% % test case 2, zero slope
% ep1 = [50, 20, 70, 0, -10];
% ep2 = [50, 20, -70, 0, -10];
% FindCommonTangentofTwoEllipse(ep1, ep2);
% 
% % test case 3, common case
% ep1 = [30, 20, 50, 10, -10];
% ep2 = [45, 20, -50, 20, 30];
% FindCommonTangentofTwoEllipse(ep1, ep2);
% 
% % test case 4, random case
% a=10+(50-10)*rand(1);
% b=10+(50-10)*rand(1);
% xc =  60+(100-60)*rand(1);
% yc =  60+(100-60)*rand(1);
% theta = 180*rand(1);
% ep1 = [a, b, xc, yc, theta];
% 
% a=10+(50-10)*rand(1);
% b=10+(50-10)*rand(1);
% xc =  -(60+(100-60)*rand(1));
% yc =  60+(100-60)*rand(1);
% theta = 180*rand(1);
% ep2 = [a, b, xc, yc, theta];
% 
% save ep1-sep.mat ep1; % save data for debug
% save ep2-sep.mat ep2; % save data for debug
% 
% FindCommonTangentofTwoEllipse(ep1, ep2);


%% generate ellipses
% ellipse 1
[ A, B, C, D, E, F] = generateEllipse(ellipse1(1), ellipse1(2), ellipse1(3), ellipse1(4), ellipse1(5));
% check the ellipse equation coefficients by calcuating center
xc=(B*E-2*C*D)/(4*A*C-B^2);  
yc=(B*D-2*A*E)/(4*A*C-B^2); 
center1 = [xc,yc];
eps1= [ A B C D E F]';

% ellipse 2
[ A, B, C, D, E, F] = generateEllipse(ellipse2(1), ellipse2(2), ellipse2(3), ellipse2(4), ellipse2(5));
% check the ellipse equation coefficients by calcuating center
xc=(B*E-2*C*D)/(4*A*C-B^2);
yc=(B*D-2*A*E)/(4*A*C-B^2);
center2 = [xc,yc];
eps2= [ A B C D E F]';

%draw ellipse1 and ellipse2
figure;
A=eps1;
a=A(1); b=A(2);  c=A(3); d=A(4); e=A(5); f=A(6);
eq0=@(x,y) a*x^2 + b*x*y + c*y^2 +d*x + e*y + f;
hold on;
h=ezplot(eq0,[-250,250,-180,180]); % ellipse 1
set(h,'Color','r');
plot(center1(1), center1(2), '+', 'Color', 'r');

A=eps2;
a=A(1); b=A(2);  c=A(3); d=A(4); e=A(5); f=A(6);
eq0=@(x,y) a*x^2 + b*x*y + c*y^2 +d*x + e*y + f;
h=ezplot(eq0,[-250,250,-180,180]); % ellipse 2
set(h,'Color','g');
plot(center2(1), center2(2), '+', 'Color', 'g');

%% solve the common tangent line
eps1 = eps1/eps1(6); % F normalization
eps2 = eps2/eps2(6); % F normalization
A1=eps1(1);B1=eps1(2);C1=eps1(3);D1=eps1(4);E1=eps1(5);F1=eps1(6);
A2=eps2(1);B2=eps2(2);C2=eps2(3);D2=eps2(4);E2=eps2(5);F2=eps2(6);

% check condition: slope of the line is infinite, i.e. k=inf
% deal with this special case, let x=t.
syms t
eq1 = (B1*t+E1)^2-4*C1*(A1*t^2+D1*t+F1);
eq2 = (B2*t+E2)^2-4*C2*(A2*t^2+D2*t+F2);
s1=solve(eq1,t);
s2=solve(eq2,t);
b1 = double(s1);
b2 = double(s2);
kinf = 0;
if( norm(b1-b2) == 0) || (norm(b1- flipud(b2)) == 0) 
    sx1 = b1;
    sy1 = -(B1*b1+E1)/(2*C1);
    sx2 = b1;
    sy2 = -(B2*b1+E2)/(2*C2);
    kinf = 1;
end

% deal with general case
syms k b
% eq1 = (B1*b+2*C1*k*b+D1+E1*k)^2-4*(A1+B1*k+C1*k^2)*(C1*b^2+E1*b+F1);
% eq2 = (B2*b+2*C2*k*b+D2+E2*k)^2-4*(A2+B2*k+C2*k^2)*(C2*b^2+E2*b+F2);
% work better when expand the above equations, the expansion process is
% given below
% syms k b A1 B1 C1 D1 E1 F1
% ss = (B1*b+2*C1*k*b+D1+E1*k)^2-4*(A1+B1*k+C1*k^2)*(C1*b^2+E1*b+F1);
% eq = expand(ss);
eq1 = B1^2*b^2 + 2*B1*D1*b - 2*B1*E1*b*k - 4*F1*B1*k + D1^2 + 2*D1*E1*k + ...
4*C1*D1*b*k + E1^2*k^2 - 4*A1*E1*b - 4*A1*C1*b^2 - 4*C1*F1*k^2 - 4*A1*F1;
eq2 = B2^2*b^2 + 2*B2*D2*b - 2*B2*E2*b*k - 4*F2*B2*k + D2^2 + 2*D2*E2*k + ...
4*C2*D2*b*k + E2^2*k^2 - 4*A2*E2*b - 4*A2*C2*b^2 - 4*C2*F2*k^2 - 4*A2*F2;

% first attempt, use default calculation precision of Matlab
s=solve(eq1,eq2,k,b);
k = double(s.k);
b = double(s.b);

% check solution, only real solutions are accepted
realFlag = 1;
for i=1:size(k,1)
    if (~isreal(k(i)) ) 
        realFlag = 0;
    end
end

% if first attempt fails, increase the calculation precision and try again.
if((size(k,1) == 0) || realFlag == 0)
    disp('Try again, with higher precision!');
    digits(20);
    s=solve(vpa(eq1),vpa(eq2),k,b);
    k = double(s.k);
    b = double(s.b);
end

% sometimes the soultions above have a very large k, which is not good for
% calculating point of tangency, it should be neglected
if(kinf)
    temp = find(abs(k) > 1e14 ); % hack for nearly infinity line slope
    k(temp) = [];
    b(temp) = [];
end

% calculate point of tangency
aa1=A1+B1*k+C1*k.^2;
bb1=B1*b+2*C1*k.*b+D1+E1*k;
x1 = -bb1./(2*aa1);
y1 = k.*x1+b;
if(kinf)            % deal with infinity k
    x1 = [sx1;x1];
    y1 = [sy1;y1];
end

aa2=A2+B2*k+C2*k.^2;
bb2=B2*b+2*C2*k.*b+D2+E2*k;
x2 = -bb2./(2*aa2);
y2 = k.*x2+b;
if(kinf)           % deal with infinity k
    x2 = [sx2;x2];
    y2 = [sy2;y2];
end

% draw point of tangency and common tangent line
eum = ['r', 'g', 'b', 'c'];
for i=1:size(x1,1)
    plot(x1(i), y1(i), '*', 'Color',eum(i));
    plot(x2(i), y2(i), '*', 'Color',eum(i));
    line([x1(i), x2(i)], [y1(i), y2(i)], 'Color',eum(i));
end

hold off;
end

function [A, B, C, D, E, F]  = generateEllipse(halfMajor, halfMinor, centerX, centerY, theta)
% use a general ellipse equation found in: 
% https://en.wikipedia.org/wiki/Ellipse

a = halfMajor;
b = halfMinor;
x0 = centerX;
y0 = centerY;
t = deg2rad(theta);

A = a^2*sin(t)^2 + b^2*cos(t)^2;
B = 2*(b^2-a^2)*sin(t)*cos(t);
C = a^2*cos(t)^2+b^2*sin(t)^2;
D = -2*A*x0-B*y0;
E = -B*x0-2*C*y0;
F = A*x0^2+B*x0*y0+C*y0^2-a^2*b^2;

end
