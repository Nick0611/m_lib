function [Ak,y]=signi_rank(A,alp)
% ���÷����ȣ�fro norm��������������Ч����
% alp��ʾ�����ȵ���ֵ
[U,S,V]=svd(A);
norm_A=norm(A,'fro');
[row,col]=size(A);
for i=1:col
    Ai=U(:,1:i)*S(1:i,1:i)*V(:,1:i)';
    norm_Ai=norm(Ai,'fro');
    ratio=norm_Ai/norm_A;
    if ratio>=alp
        break;
    end
end
y=i;
Ak=Ai;