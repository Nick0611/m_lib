function MyPSO = UpdateMyPSO(MyPSO,MaxW,MinW,LoopCount,CurCount)
%% 功能描述：全局版本：基本的粒子群算法的单步更新位置,速度的算法
%输入参数：LoopCount：迭代的总次数
%输入参数：CurCount：当前迭代的次数

%% 设置惯性因子
%1.线形递减策略
% w=MaxW-CurCount*((MaxW-MinW)/LoopCount);
%2.固定不变策略
%w=0.7;
%3.非线形递减，以凹函数递减
%w=(MaxW-MinW)*(CurCount/LoopCount)^2+(MinW-MaxW)*(2*CurCount/LoopCount)+MaxW;
%4.非线形递减，以凹函数递减
%w=MinW*(MaxW/MinW)^(1/(1+10*CurCount/LoopCount));
%5.随机策略，适用于动态系统(Dynamic System)
w = 0.5 + rand()/2.0;
%% 设置学习因子
%1.固定策略
% c1 = 2;
% c2 = 2;
%2.固定策略，适用于动态系统(Dynamic System)
c1 = 1.494;
c2 = 1.494;

% global MyPSO;
%% Update Pos and velocity
for row=1:MyPSO.SwarmSize
    Part1 = c1*unifrnd(0,1)*(MyPSO.PBest(row,1:end-1)-MyPSO.ParticlePos(row,:));
    Part2 = c2*unifrnd(0,1)*(MyPSO.GBest(:,1:end-1)-MyPSO.ParticlePos(row,:));
    TempV = w*MyPSO.ParticleVel(row,:) + Part1 + Part2;
    %限制速度的代码
    for h=1:MyPSO.ParticleDim
        if TempV(:,h)>MyPSO.ParticleScope(h,2)
            TempV(:,h)=MyPSO.ParticleScope(h,2);
        end
        if TempV(:,h)<-MyPSO.ParticleScope(h,2)
            TempV(:,h)=-MyPSO.ParticleScope(h,2)+1e-10;
            %加1e-10防止适应度函数被零除
        end
    end
    %更新速度
    MyPSO.ParticleVel(row,:) = TempV;
     
    %限制位置的范围
    TempPos = MyPSO.ParticlePos(row,:) + TempV;
    for h=1:MyPSO.ParticleDim
        if TempPos(:,h)>MyPSO.ParticleScope(h,2)
            TempPos(:,h)=MyPSO.ParticleScope(h,2);
        end
        if TempPos(:,h)<=MyPSO.ParticleScope(h,1)
            TempPos(:,h)=MyPSO.ParticleScope(h,1)+1e-10;
        end
    end    
    %更新位置
    MyPSO.ParticlePos(row,:) = TempPos;
    
    %计算每个粒子的新的适应度值
    MyPSO.ParticleFitness(row) = MyPSO.FitnessFunc(MyPSO.ParticlePos(row,:));
    %更新每个粒子的历史最优值
    if MyPSO.ParticleFitness(row)<MyPSO.PBest(row,end)
        MyPSO.PBest(row,1:end-1) = MyPSO.ParticlePos(row,:);
        MyPSO.PBest(row,end) = MyPSO.ParticleFitness(row);
    end
end
%% update Global Optimum
%寻找适应度函数值最大/最小的解在矩阵中的位置(行数)，进行全局最优的改变
[minValue,row]=min(MyPSO.ParticleFitness);
if minValue < MyPSO.GBest(end)
   MyPSO.GBest(:,1:end-1) = MyPSO.ParticlePos(row,:);
   MyPSO.GBest(end) = minValue;
end