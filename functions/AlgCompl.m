%%% ���������ʽ
% ����1������
% ����2���б�
% ����3���б�
% �������������ʽ
% ���ߣ������d
% ���ڣ�2021-11-27
function A = AlgCompl(varargin)
M = varargin{1};
rowInd = varargin{2};
colInd = varargin{3};

M(rowInd,:)=[];
M(:,colInd)=[];
 
n = rowInd+colInd;
A = det(M)*((-1)^n);