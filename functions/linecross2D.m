%%% function [X]=linecross2D(k1,b1,k2,b2)
% Author: Zachary Leung
% Date: 2023-3-31
% Source: ����
% ���ܣ���άƽ����������ֱ�ߵĽ���
% input1: ��һ��ֱ�ߵ�б��
% input2: ��һ��ֱ�ߵĽؾ�
% input3: �ڶ���ֱ�ߵ�б��
% input4: �ڶ���ֱ�ߵĽؾ�
% output1: ����
function [X]=linecross2D(k1,b1,k2,b2)
% ��֪����ֱ�ߵ�б�ʺͽؾ࣬�󽻵�����
  if k1==k2&b1==b2
%       disp('chong he');
      X = [];
  elseif k1==k2&b1~=b2
      X = [];
%       disp('wu jiao dian');
  else
     X(1,1)=(b2-b1)/(k1-k2);
     X(2,1)=k1*X(1,1)+b1;
  end
end