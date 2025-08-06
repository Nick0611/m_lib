%%% function [X]=linecross2D(k1,b1,k2,b2)
% Author: Zachary Leung
% Date: 2023-3-31
% Source: 网上
% 功能：二维平面上求两个直线的交点
% input1: 第一条直线的斜率
% input2: 第一条直线的截距
% input3: 第二条直线的斜率
% input4: 第二条直线的截距
% output1: 交点
function [X]=linecross2D(k1,b1,k2,b2)
% 已知两条直线的斜率和截距，求交点坐标
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