%%% function [fai,the] = Cartes2Spher(n)
% ���ѿ�������ϵת��Ϊ������ϵ
% ���룺n    3 by n
% ���1��fai  ��z��нǣ�1 by n ����
% ���2��the  xyƽ���ϵ�ͶӰ��x��нǣ�1 by n ����
% ���3��r  ���ȣ�1 by n ����
function [fai,the,r] = Cartes2Spher(n)
for i = 1:size(n,2)
    r(i) = norm(n(:,i));
    n(:,i) = n(:,i)/r(i);
    fai(i) = acos(n(3,i));
    the(i) = atan2(n(2,i),n(1,i));
end