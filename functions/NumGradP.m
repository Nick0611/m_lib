%%% x = NumGradP(f,x0,prc)
% ֻ������ֵ�ݶ�
% ʱ�䣺2022-8-16
% ����1������ֵ���㺯���ľ�� �� @+���������� m by 1
% ����2���Ա�����ֵ n by 1
% ����3�����ȣ�0.00001
% ���1���ſ˱Ⱦ���
% revision 2023-8-19
% function varargout = NumGradP(f,varargin)
% ����varargin��ԭ����fֻ�ܴ���x0һ���βΣ����ڿ����������룬�������һ������Ĭ����prc
% author�� Zachary Liang

function varargout = NumGradP(f,x0,varargin)
x = x0;
dimx = size(x,1);
prc = varargin{end};
d1 = f(x0,varargin{1:end-1});
for i = 1:dimx
    N = zeros(dimx,1);
    N(i) = prc;
    tmp =  f(x+N,varargin{1:end-1});
    d2(:,i) = tmp-d1;
end
J = d2/prc; %�����Ԫ�ض��Ա���Ԫ�ص�ƫ��

varargout{1} = J;
end
