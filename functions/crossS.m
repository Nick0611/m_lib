%%% function y = crossS(A,B)
% ���ܣ�cross��������չ������ʵ�����������������Ķ�Ӧ���
% ����1��A 3 by n
% ����2��B 3 by n
function y = crossS(A,B)
for i = 1:size(A,2)
    y(:,i) = cross(A(:,i),B(:,i));
end