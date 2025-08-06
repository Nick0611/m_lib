% function Gram = GramMatrix(X)
% ����X��Gram����Gram�����ǽ�X��ÿһ�п���һ��������G(i,j)���ǵ�i�к͵�j���������ڻ�
% ����1��X�� m by n��n��������
% ���1��Gram��n by n
% ���ߣ�Zachary Liang
% ���ڣ�2023-10-10
function Gram = GramMatrix(X)
% % ����1
% for i = 1:size(X,2)
%     for j = 1:size(X,2)
%         % �����i�к͵�j���������ڻ����õ�Gram�����Ԫ��
%         Gram(i, j) = dot(X(:, i), X(:, j));
%     end
% end
% ����2
Gram = X'*X;