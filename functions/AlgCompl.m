%%% 求代数余子式
% 输入1：方阵
% 输入2：行标
% 输入3：列标
% 输出：代数余子式
% 作者：梁振鹍
% 日期：2021-11-27
function A = AlgCompl(varargin)
M = varargin{1};
rowInd = varargin{2};
colInd = varargin{3};

M(rowInd,:)=[];
M(:,colInd)=[];
 
n = rowInd+colInd;
A = det(M)*((-1)^n);