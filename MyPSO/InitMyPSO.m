function MyPSO = InitMyPSO(SwarmSize, ParticleDim, ParticleScope, FitnessFunc)
%% 功能描述：初始化粒子群，限定粒子群的位置以及速度在指定的范围内
%输入参数：SwarmSize:种群大小的个数
%输入参数：ParticleDim：一个粒子的维数
%输入参数：ParticleScope:一个粒子在运算中各维的范围；
%　　　　　ParticleScope格式:3维粒子的ParticleScope格式:
%　　　　　　　　　　　　　　　　[x1Min,x1Max
%　　　　　　　　　　　　　　　　x2Min,x2Max
%　　　　　　　　　　　　　　　　x3Min,x3Max]
%输入参数：FitnessFunc：适应度函数
%% Check Input
[row,colum]=size(ParticleDim);
if row>1||colum>1
    error('输入的粒子的维数错误，必须是一个1行1列的数据。');
end
[row,colum]=size(ParticleScope);
if row~=ParticleDim||colum~=2
    error('输入的粒子的维数范围错误。');
end
%% 初始化粒子群的位置与速度矩阵
% global MyPSO;
MyPSO.SwarmSize = SwarmSize;                        %粒子群大小
MyPSO.ParticleDim = ParticleDim;                    %粒子维数
MyPSO.ParticleScope = ParticleScope;                %粒子范围
MyPSO.FitnessFunc = FitnessFunc;                    %适应值函数
MyPSO.IsInitialized = true;                         %是否初始化标志
for i = 1:SwarmSize
    MyPSO.ParticlePos(i,:) = unifrnd(ParticleScope(:,1),ParticleScope(:,2),ParticleDim,1)';    %粒子的位置矩阵 %传入管路的初始参数
end
MyPSO.ParticleVel = unifrnd(-0.1,0.1,SwarmSize,ParticleDim);    %粒子的速度矩阵
MyPSO.ParticleFitness = zeros(SwarmSize,1);         %粒子的当前适应值
MyPSO.PBest = zeros(SwarmSize,ParticleDim+1);       %粒子的历史最优值=粒子+Fitness
MyPSO.GBest = zeros(1,ParticleDim+1);               %粒子的全局最优值=粒子+Fitness
%对粒子群中位置,速度的范围进行调节
for k=1:ParticleDim
    MyPSO.ParticlePos(:,k) = MyPSO.ParticlePos(:,k);
    MyPSO.ParticleVel(:,k) = MyPSO.ParticleVel(:,k);
end
%% 初始化粒子的历史最优值与全局最优值
%粒子的历史最优值就是初始化的位置矩阵，无需比较
MyPSO.PBest(:,1:end-1) = MyPSO.ParticlePos;

% 对每一个粒子计算其适应度函数的值
for k=1:SwarmSize
    MyPSO.ParticleFitness(k) = FitnessFunc(MyPSO.ParticlePos(k,:));
    MyPSO.PBest(k,end) = MyPSO.ParticleFitness(k);
end
% 全局最优值
[minValue,row]=min(MyPSO.ParticleFitness);
MyPSO.GBest(:,1:end-1) = MyPSO.ParticlePos(row,:);
MyPSO.GBest(end) = minValue;
