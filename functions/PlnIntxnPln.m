% function [line_n,line_p0] = PlnIntxnPln(n1,p1,n2,p2)
% ��������ƽ��Ľ��߷��̣���������ʽ����
% ����1~4��ƽ��1�ķ�����������һ�㣬ƽ��2�ķ�����������һ��,3 by 1
% ���1�����߷�����
% ���2��������һ��
% ���ߣ�Zachary Liang
% ���ڣ�2023-10-10
function [line_n,line_p0] = PlnIntxnPln(n1,p10,n2,p20)
line_n = cross(n1,n2);
N = [line_n,n1,n2]';
N0 = [line_n'*p10;n1'*p10;n2'*p20];
line_p0 = N\N0;