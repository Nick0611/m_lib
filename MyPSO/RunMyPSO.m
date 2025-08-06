function [OptimumParticle, OptimumFitness, OptimumFitnessHistory, MyPSO] = RunMyPSO(MyPSO,LoopCount,DispInfo)
%% 功能描述：一个循环n次的PSO算法完整过程
%Input:LoopCount---最大迭代次数
%DispInfo:是否显示必要信息，0不显示，1显示迭代结束原因，2显示最优变化图,3显示进度条,4全部显示,默认为0
if nargin == 2
    DispInfo = 0;
end

% global MyPSO;
OptimumFitnessHistory = zeros(1,LoopCount);

MaxW = 1.4;         %惯性权重最大值
MinW = 0.4;         %惯性权重最小值

CurCount = 0;       %当前迭代次数
RealErr = inf;      %当前误差

err = 1e-4;        %允许误差

MinLoopCount = 30;  %最小迭代次数，超过这个次数后才开始考虑误差计算
Counter = 0;        %计数器，表示连续满足允许误差的迭代次数

MaxCounter = 15;    %计数器最大值，超过此值即表示误差值在此连续迭代次数之间没有变化，迭代将停止,原来是30

if DispInfo==3 || DispInfo==4  %显示进度条
    HProgress = waitbar(0,'','Name','PSO Running,Please wait...');
end
%% cycle
while(CurCount < LoopCount)
    CurCount = CurCount+1;
    if DispInfo==3 || DispInfo==4   %显示进度条
        waitbar(CurCount/LoopCount,HProgress,...
            sprintf('当前迭代步数：%d\n当前最优值：%f',CurCount,MyPSO.GBest(end)));
    end
    %调用一步迭代的算法
    MyPSO = UpdateMyPSO(MyPSO,MaxW,MinW,LoopCount,CurCount);
    %记录每一次的全局最优值
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
if DispInfo==3 || DispInfo==4   %显示进度条
    if ishandle(HProgress)
        close(HProgress);
    end
end
%% 是否显示迭代结束原因
if DispInfo==1 || DispInfo==4
    if RealErr<=err
        disp(['RunMyPSO迭代结束，原因：满足误差要求，在连续' num2str(MaxCounter) '步迭代中误差小于' num2str(err) ',实际迭代步数为：' num2str(CurCount)]);
    else
        disp(['RunMyPSO迭代结束，原因：达到最大迭代步数，迭代步数为：' num2str(CurCount)]);
    end
end
RealLoopCount = CurCount;
OptimumFitnessHistory = OptimumFitnessHistory(1:RealLoopCount);
%% 是否显示最优变化图
if DispInfo==2 || DispInfo==4
    f1=figure;
    f1.Color=[1 1 1];
    hold on;
    title('RunMyPSO最优值变化图');
    xlabel('迭代次数');
    ylabel('最优值');
    grid on;
    plot(OptimumFitnessHistory,'linewidth',2);
end
%% 记录最终得到的最优结果
OptimumParticle = MyPSO.GBest(:,1:end-1);
OptimumFitness = MyPSO.GBest(end);