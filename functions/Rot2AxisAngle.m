function [u,theta] = Rot2AxisAngle(R)
theta = acos((trace(R)-1)/2);
u = 1/(2*sin(theta))*[R(3,2)-R(2,3);R(1,3)-R(3,1);R(2,1)-R(1,2)];