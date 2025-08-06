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

% ����
m = 1.0; % ��λ��kg

% PD����ϵ��
kp = 1e6; % ��λ��N/m
kd = 2*0.7*sqrt(kp*m); % ��λ��N*s/m

Xd = u(1); 
% dXd = u(2);
% ʵ��ֵ
X = u(3);  dX = u(4);

% ������
F = kp*(Xd-X) - kd*dX;

sys = F;
