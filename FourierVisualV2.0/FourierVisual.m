%%% FourierVisual Fourier�任���ӻ�
% ����1����sample���������ʣ�Ĭ��1024
% ����2����fun����Դ���������磬�ġ�10*(x-0.5).^3��
function [varargout] = FourierVisual(varargin)

% ���ò���Ƶ��
SampleFreq = 1024;
% ��Ҫ���� ����Ƶ�ʾ�����Ƶ��չ������ߴ�Ϊ 0.5*SampleFreq
% �����Զ���չ�����������ֵĬ��Ϊ512
func = 0;
for i = 1:nargin
    switch varargin{i}
        case 'sample'
            SampleFreq = varargin{i+1};
        case 'fun'
            func = varargin{i+1};
    end
end

%% ԭ��������

% ���ɲ�������
sample_seq = 0 : 1/SampleFreq : 1 - 1/SampleFreq;

% ����ԭ��������������Ƶ���ֵ����λ����
Select_AimFunction = 1;% Ĭ��Ϊ�������� 0.5ռ�ձ�
if func == 0
    [point,t,f,ppy,phase,period] = Init_AimFunction(Select_AimFunction,sample_seq,SampleFreq);
else
    [point,t,f,ppy,phase,period] = Init_AimFunction(Select_AimFunction,sample_seq,SampleFreq,func);
end
%% GUI��� - ��������������
GUI_Design;



