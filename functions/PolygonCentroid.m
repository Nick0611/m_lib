%%% function y = PolygonCentroid(X)
% ���ܣ� �������εļ�������
% ����1�� X 3 by n �㼯
% ���1�� �������ĵ�����
% ���ߣ� Zachary Leung
function y = PolygonCentroid(X)
if ~isequal(X(:,1),X(:,end)) % ��β��Ӧͬһ����
    X(:,end+1) = X(:,1);
end
num = size(X,2)-1;
for i = 1:num
    ZA(i) = X(1,i)*X(2,i+1)-X(1,i+1)*X(2,i);
    ZX(i) = (X(1,i)+X(1,i+1))*ZA(i);
    ZY(i) = (X(2,i)+X(2,i+1))*ZA(i);
end
A = 1/2*sum(ZA);
y(1,1) = 1/(6*A)*sum(ZX);
y(2,1) = 1/(6*A)*sum(ZY);