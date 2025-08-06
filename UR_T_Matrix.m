%% q求UR法兰坐标系相对于基座坐标系的旋转矩阵
% 输出齐次变换矩阵
%%
function [varargout] = UR_T_Matrix(varargin)
UR = varargin{1};
the = sqrt(UR(4)^2+UR(5)^2+UR(6)^2);
kx = UR(4)/the;
ky = UR(5)/the;
kz = UR(6)/the;
R = [kx*kx*(1-cos(the))+cos(the) kx*ky*(1-cos(the))-kz*sin(the) kx*kz*(1-cos(the))+ky*sin(the); ...
    kx*ky*(1-cos(the))+kz*sin(the) ky*ky*(1-cos(the))+cos(the) ky*kz*(1-cos(the))-kx*sin(the); ...
    kx*kz*(1-cos(the))-ky*sin(the) ky*kz*(1-cos(the))+kx*sin(the) kz*kz*(1-cos(the))+cos(the)];
T = [R [UR(1);UR(2);UR(3)];zeros(1,3) 1];
varargout{1} = T;