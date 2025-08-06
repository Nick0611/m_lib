%%% FourierVisual Fourier变换可视化
% 输入1：‘sample’，采样率，默认1024
% 输入2：‘fun’，源函数，例如，的‘10*(x-0.5).^3’
function [varargout] = FourierVisual(varargin)

% 设置采样频率
SampleFreq = 1024;
% 重要参数 采样频率决定了频域展开的最高次为 0.5*SampleFreq
% 即，自定义展开级数的最大值默认为512
func = 0;
for i = 1:nargin
    switch varargin{i}
        case 'sample'
            SampleFreq = varargin{i+1};
        case 'fun'
            func = varargin{i+1};
    end
end

%% 原函数发生

% 生成采样序列
sample_seq = 0 : 1/SampleFreq : 1 - 1/SampleFreq;

% 产生原函数，并计算其频域幅值、相位特性
Select_AimFunction = 1;% 默认为方波函数 0.5占空比
if func == 0
    [point,t,f,ppy,phase,period] = Init_AimFunction(Select_AimFunction,sample_seq,SampleFreq);
else
    [point,t,f,ppy,phase,period] = Init_AimFunction(Select_AimFunction,sample_seq,SampleFreq,func);
end
%% GUI设计 - 用于设置主界面
GUI_Design;



