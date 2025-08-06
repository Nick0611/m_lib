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

% ����
m = 1.0; % ��λ��kg
% ���ɸն�
ke = 10; % ��λ��N/m
% ճ��ϵ���Ϳ���Ħ��ϵ����coefficients of viscous and Coulomb friction��
cv = 1.0; % ��λ��N*s/m
Fc = 3.0; % ��λ��N

X0 = u(1);
F = u(2); 

% ��������
Fext = u(3);
% Fext = -ke*x(1);

% Ħ����
Ff = -sign(x(2))*(cv*abs(x(2))+Fc);

% ϵͳ����ѧ
S = (F + Fext + Ff)/m;

sys(1) = x(2);
sys(2) = S(1);


function sys = mdlOutputs(t,x,u)
sys(1) = x(1);
sys(2) = x(2);
