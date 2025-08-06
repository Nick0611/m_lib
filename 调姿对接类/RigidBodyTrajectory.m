% gB是一系列位姿变换矩阵构成的元胞，例如{gB_Current,gB_Target}
function g = RigidBodyTrajectory(gB,varargin)
num_Interpolation = 100;
ControlPointRatio = 0.2;
if nargin>1
    num_Interpolation = varargin{1};
end
if nargin>2
    ControlPointRatio = varargin{2};
end
g_Traj = IntrplBezier(ControlPointRatio,num_Interpolation,gB{:}); % 李群轨迹插值函数，默认两个关键点之间插值120个，包括首尾关键点

len = length(g_Traj);
g = [];
for i=1:len
    g = [g,g_Traj{i}];
end