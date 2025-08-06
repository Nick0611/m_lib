%%% function y = NonHomo_g(g,x,param1)
% Author: Zachary Leung
% Date: 2023-3-30
% ���ܣ�ʹ��4*4���Ա任�����3*1���������任���õ��任��ķ�������꣬����ָ���ǵ�任���������任
% input1: g 4 by 4
% input2: x 3 by 3 ����ε�����
% input3: 1��Ϊ�㣻0��Ϊ����
% output: y 3 by 1 �任��ķ��������
% revision-2024-3-18
% ���������x��һ������ÿһ�б�ʾһ��Ԫ�أ���Ӧ�����ҲΪ����
function y = NonHomo_g(g,x,param1)
if param1 == 1
    xx = [x;ones(1,size(x,2))];
end
if param1 == 0
    xx = [x;zeros(1,size(x,2))];
end
y = [eye(3) zeros(3,1)]*g*xx;