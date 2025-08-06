function y = QuaternionTimes(q1,q2)
% y = zeros(size(q1)); % 不能要，如果传进来的是syms形，会报不能转换为double错
y(1) = q1(1)*q2(1)-dot(q1(2:4),q2(2:4));
y(2:4) = q1(1)*q2(2:4)+q2(1)*q1(2:4)+cross(q1(2:4),q2(2:4));