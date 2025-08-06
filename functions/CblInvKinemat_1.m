%%% function l = CblInvKinemat_1(A,b,g)
% author: Zachary Leung
% Date: 2023-3-23
% input1: ����������ȫ������ 3 by n
% input2: �����ڶ�ƽ̨�ϵ�ê��ľֲ����� 3 by n
% input3: ��ƽ̨����ϵ�����ȫ������ϵ��λ�� 4 by 4
% output1: �������� n by 1
function l = CblInvKinemat_1(A,b,g)
bh = b;
bh(4,:) = 1;
B = [eye(3),zeros(3,1)]*g*bh;
l = sqrt(diag((B-A)'*(B-A)));
