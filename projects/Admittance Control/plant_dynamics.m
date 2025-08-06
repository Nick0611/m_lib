function [sys,x0,str,ts]= plant_dynamics(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {2, 4, 9 }
    sys = [];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end

function [sys,x0,str,ts] = mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 2;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 3;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0 = [0 0];
str = [];
ts = [];

function sys = mdlDerivatives(t,x,u)

% 质量
m = 1.0; % 单位：kg
% 弹簧刚度
ke = 10; % 单位：N/m
% 粘性系数和库仑摩擦系数（coefficients of viscous and Coulomb friction）
cv = 1.0; % 单位：N*s/m
Fc = 3.0; % 单位：N

X0 = u(1);
F = u(2); 

% 环境外力
Fext = u(3);
% Fext = -ke*x(1);

% 摩擦力
Ff = -sign(x(2))*(cv*abs(x(2))+Fc);

% 系统动力学
S = (F + Fext + Ff)/m;

sys(1) = x(2);
sys(2) = S(1);


function sys = mdlOutputs(t,x,u)
sys(1) = x(1);
sys(2) = x(2);
