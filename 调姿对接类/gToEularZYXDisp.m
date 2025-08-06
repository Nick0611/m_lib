%%% function [ang,pos] = gToEularZYXDisp(g)
% ���ܣ� ��4 by 4��λ�˾���ת��ΪZYX˳���ŷ���Ǳ�����������
% ����1�� g 4 by 4��λ�˱任����
% ���1�� ŷ����[��x;��y;��z]
% ���2�� λ��[x;y;z]
% ���ߣ� Zachary Liang
% ʱ�䣺 2023-6-4
function [ang,pos] = gToEularZYXDisp(g)
the = -asin(g(3,1)); %y
pu = atan2(g(3,2)/cos(the),g(3,3)/cos(the)); %x
fai = atan2(g(2,1)/cos(the),g(1,1)/cos(the)); %z
ang = [pu;the;fai];
pos = g(1:3,4);