%%% function y = ColNorm(x)
% �Ծ����ÿһ���������
% ���룺x�� 3 by N
% �����y�� 1 by N
function y = ColNorm(x)
[row,col] = size(x);
for i = 1:col
    y(i) = norm(x(:,i));
end