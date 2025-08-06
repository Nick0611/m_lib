%%% 取两个向量的公共最大值
% 输入1 数组A
% 输入2 数组B
% 输出1 公共最大值数组C
% Date 2021-08-01
% 作者 梁振鹍
function c = PubMax(A,B)
c=zeros(size(A)); %新向量
TF=(A>B);
c(TF)=A(TF);
c(~TF)=B(~TF);