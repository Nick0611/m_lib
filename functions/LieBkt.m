%%% function xi = LieBkt(xi1,xi2)
% Author: Zachary Leung
% Date: 2023-3-16
% ���ܣ�������
% ����������������������������6*1��ʽ����xi1ת��Ϊ4*4��ʽ�������棬�����õ�xi2��
% �����4*1��ʽ����xi1*xi2-xi2*xi1��
function xi = LieBkt(xi1,xi2)
if size(xi1,1) == 6
    xi = Adj(Wed(xi1))*xi2;
end
if size(xi1,1) == 4
    xi = xi1*xi2-xi2*xi1;
end