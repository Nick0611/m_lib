function [sys,x0,str,ts] = admittance_ctrl(t,x,u,flag)
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
sizes.NumInputs      = 4;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0 = [0 0];
str = [];
ts = [];

function sys = mdlDerivatives(t,x,u)

% 质量与估计质量
% m = 1.0; % 单位：kg
mhat = 0.8; % 单位：kg
% 弹簧刚度
ke = 10; % 单位：N/m
% % 粘性系数和库仑摩擦系数（coefficients of viscous and Coulomb friction）
% cv = 1.0; % 单位：N*s/m
% Fc = 3.0; % 单位：N
% PD控制系数
kp = 1e6; % 单位：N/m
% kd = 2*0.7*sqrt(kp*m); % 单位：N*s/m

Md = mhat; % 单位：kg
Kd = 100; % 单位：N/m
Dd = 2*0.7*sqrt(kp*Md); % 单位：N*s/m

% 设定值
X0 = u(1); dX0 = u(2); ddX0 = u(3); 
Fext = u(4);
% Fext = -ke*X;

Xd = x(1);
dXd = x(2);
ddXd = 1/Md*(Fext - Kd*(Xd-X0) - Dd*(dXd-dX0)) + ddX0;

sys(1) = dXd;
sys(2) = ddXd;

function sys = mdlOutputs(t,x,u)
sys(1) = x(1);
sys(2) = x(2);
