%%% sigma3filter
% ���� ��ʵ�����ݲɻ����ĵ�������ⱶ����sigma�˲�
% Data 2021-07-06
% ���� �����d
% ����1 ����λ�õ� 3byN OR 2byN
% ����2 ʵ��λ�õ� 3byN OR 2byN
% ����3 sigma���������� 1; Ĭ��3
% ���1 �˲��������
% ���2 �˲���ĵ�����߼�����
% ���3 �˲���ĵ�����
function varargout = sigma3filter(varargin)
n = 3;
p_ideal = varargin{1};
p_given = varargin{2};
if nargin == 3
    n = varargin{3};
end
num = size(p_given,2);
d = diag(dist(p_ideal',p_given));
UpperBound = mean(d)+n*std(d);
LowerBound = mean(d)-n*std(d);
for i = 1:num
    if dist(p_ideal(:,i)',p_given(:,i)) <= UpperBound & dist(p_ideal(:,i)',p_given(:,i)) >= LowerBound
        emp_prob(i)=1;
    else
        emp_prob(i)=0;
    end
end
emp_prob = logical(emp_prob);
varargout{1} = p_given(:,emp_prob);
varargout{2} = emp_prob;
varargout{3} = size(varargout{1},2);