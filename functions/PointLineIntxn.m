%%% PointLineIntxn
% ���� �����d
% Date 2022-07-21
% �����p0��ֱ�ߴصľ���
% ����1���̶���p 3 by 1
% ����2: �ߴأ�6 by n��ǰ�����Ƿ��򣬺�������λ��
function dis = PointLineIntxn(p0,ksi)
n = ksi(1:3,:); p = ksi(4:6,:); num = size(ksi,2);
lambda = diag((n'*(p0-p)))./diag((n'*n));
pout = p+lambda'.*n;
for i = 1:num
    dis(i,1) = norm(pout(:,i)-p0);
end