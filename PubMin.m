%%% ȡ���������Ĺ�����Сֵ
% ����1 ����A
% ����2 ����B
% ���1 ������Сֵ����C
% Date 2021-08-01
% ���� �����d
function c = PubMin(A,B)
c=zeros(size(A)); %������
TF=(A<B);
c(TF)=A(TF);
c(~TF)=B(~TF);