% �ɿɷ�˹���� �����㷨��ʱ�临�Ӷ�O(n^2)
% https://zhuanlan.zhihu.com/p/621941782
% given a convex hull X, each row of X represents a vertex
% given a convex hull Y, each row of Y represents a vertex
% obtain the Minkowski sum of X and Y
% Revision 20230901
% Ϊ�������߽��ƽ��㷨��Z = [X;Y];Ҫ����ƽ���֮ǰ��͹���ĵ㶼Ҫ������ͨ��removeRedundantVertexȥ������㡣
% Revision 20230902
% ����ͨ��removeRedundantVertexȥ��������ˣ�ֱ���ڱ��������жϣ�ȥ�����࣬����͹���߽�㣩
function [Z] = MinkowskiSumVertex(X,Y)
Z = [X;Y];

for i = 1:size(X,1)
    for j = 1:size(Y,1)
        Z = [Z; X(i,:)+Y(j,:)];
    end
end
Z = uniquetol(Z,'ByRows',true);
if size(Z,1)>size(Z,2)
    for iter_line = 1:size(Z,1)-2
        if abs(normS((Z(1,:)-Z(2,:)))*normS(Z(iter_line+2,:)-Z(2,:))') ~= 1
            n = normS(cross(Z(1,:)-Z(2,:),Z(iter_line+2,:)-Z(2,:)))'; % �ҵ������ߵ�������
            for i = 1:size(Z,1)-3
                dis(i) = n'*(Z(i+3,:)-Z(2,:))'; % �ж��Ƿ���
                if abs(dis(i))>eps
                    K = convhulln(Z);
                    Z = Z(K);
                    break;
                end
            end
            break;
        end
    end 
end
% Z = removeRedundantVertex(Z);

end