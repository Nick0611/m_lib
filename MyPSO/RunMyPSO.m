function [OptimumParticle, OptimumFitness, OptimumFitnessHistory, MyPSO] = RunMyPSO(MyPSO,LoopCount,DispInfo)
%% ����������һ��ѭ��n�ε�PSO�㷨��������
%Input:LoopCount---����������
%DispInfo:�Ƿ���ʾ��Ҫ��Ϣ��0����ʾ��1��ʾ��������ԭ��2��ʾ���ű仯ͼ,3��ʾ������,4ȫ����ʾ,Ĭ��Ϊ0
if nargin == 2
    DispInfo = 0;
end

% global MyPSO;
OptimumFitnessHistory = zeros(1,LoopCount);

MaxW = 1.4;         %����Ȩ�����ֵ
MinW = 0.4;         %����Ȩ����Сֵ

CurCount = 0;       %��ǰ��������
RealErr = inf;      %��ǰ���

err = 1e-4;        %�������

MinLoopCount = 30;  %��С�����������������������ſ�ʼ����������
Counter = 0;        %����������ʾ���������������ĵ�������

MaxCounter = 15;    %���������ֵ��������ֵ����ʾ���ֵ�ڴ�������������֮��û�б仯��������ֹͣ,ԭ����30

if DispInfo==3 || DispInfo==4  %��ʾ������
    HProgress = waitbar(0,'','Name','PSO Running,Please wait...');
end
%% cycle
while(CurCount < LoopCount)
    CurCount = CurCount+1;
    if DispInfo==3 || DispInfo==4   %��ʾ������
        waitbar(CurCount/LoopCount,HProgress,...
            sprintf('��ǰ����������%d\n��ǰ����ֵ��%f',CurCount,MyPSO.GBest(end)));
    end
    %����һ���������㷨
    MyPSO = UpdateMyPSO(MyPSO,MaxW,MinW,LoopCount,CurCount);
    %��¼ÿһ�ε�ȫ������ֵ
    OptimumFitnessHistory(CurCount) = MyPSO.GBest(end);
    if CurCount>MinLoopCount
        tempRealErr = abs(OptimumFitnessHistory(CurCount)-OptimumFitnessHistory(CurCount-1));
        if tempRealErr>err
            Counter = 0;
        else
            Counter = Counter+1;
            if Counter>=MaxCounter
                RealErr = tempRealErr;
                break;
            end
        end
    end
end
if DispInfo==3 || DispInfo==4   %��ʾ������
    if ishandle(HProgress)
        close(HProgress);
    end
end
%% �Ƿ���ʾ��������ԭ��
if DispInfo==1 || DispInfo==4
    if RealErr<=err
        disp(['RunMyPSO����������ԭ���������Ҫ��������' num2str(MaxCounter) '�����������С��' num2str(err) ',ʵ�ʵ�������Ϊ��' num2str(CurCount)]);
    else
        disp(['RunMyPSO����������ԭ�򣺴ﵽ��������������������Ϊ��' num2str(CurCount)]);
    end
end
RealLoopCount = CurCount;
OptimumFitnessHistory = OptimumFitnessHistory(1:RealLoopCount);
%% �Ƿ���ʾ���ű仯ͼ
if DispInfo==2 || DispInfo==4
    f1=figure;
    f1.Color=[1 1 1];
    hold on;
    title('RunMyPSO����ֵ�仯ͼ');
    xlabel('��������');
    ylabel('����ֵ');
    grid on;
    plot(OptimumFitnessHistory,'linewidth',2);
end
%% ��¼���յõ������Ž��
OptimumParticle = MyPSO.GBest(:,1:end-1);
OptimumFitness = MyPSO.GBest(end);