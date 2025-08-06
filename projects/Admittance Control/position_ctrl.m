function [sys,x0,str,ts] = position_ctrl(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 3,
    sys=mdlOutputs(t,x,u);
case {2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end

function [sys,x0,str,ts] = mdlInitializeSizes
sizes = simsizes;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 4;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [];

function sys = mdlOutputs(t,x,u)

% 质量
m = 1.0; % 单位：kg

% PD控制系数
kp = 1e6; % 单位：N/m
kd = 2*0.7*sqrt(kp*m); % 单位：N*s/m

Xd = u(1); 
% dXd = u(2);
% 实际值
X = u(3);  dX = u(4);

% 控制力
F = kp*(Xd-X) - kd*dX;

sys = F;
