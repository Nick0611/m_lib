%%% function g = IntrplLee(num,varargin)
% ���ܣ� ��������λ�ˣ���SE(3)�н��й켣��ֵ
% ע�⣺ ����Ӧ��ֵ����������2��g�����Բ�ֵ������3��g��2�β�ֵ
% ����1�� ��ֵ��Ĺ켣������ ������β���Ƶ�
% ����2�� ��ʼλ��g1 4 by 4, Ŀ��λ��g2,g3,...,gn 4 by 4������д������
% ���1�� ��ֵ�õ���ÿ����ֵ���ϵ�SE(3)��1 by num ��Ԫ��
% ���ߣ� Zachary Liang
% ʱ�䣺 2023-5-22

function g = IntrplLee(num,varargin)
i = linspace(0,1,num);
n = nargin-1;
gK = cell(1,n-1);
coder.varsize('gK');
for j = 1:n-1
    gK{j} = coder.nullcopy(cell(1,num));
    for iter = 1:num
        gK{j}{iter} = InterpolationLinear(varargin{j},varargin{j+1},i(iter));
    end
end
while(n-2)
    for k = 1:(n-2)
        for iter = 1:num
            gK{k}{iter} = InterpolationLinear(gK{k}{iter},gK{k+1}{iter},i(iter));
        end
    end
    n = n-1;
    gK(end) = [];
end
g = gK{1};

    