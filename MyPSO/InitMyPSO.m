function MyPSO = InitMyPSO(SwarmSize, ParticleDim, ParticleScope, FitnessFunc)
%% ������������ʼ������Ⱥ���޶�����Ⱥ��λ���Լ��ٶ���ָ���ķ�Χ��
%���������SwarmSize:��Ⱥ��С�ĸ���
%���������ParticleDim��һ�����ӵ�ά��
%���������ParticleScope:һ�������������и�ά�ķ�Χ��
%����������ParticleScope��ʽ:3ά���ӵ�ParticleScope��ʽ:
%��������������������������������[x1Min,x1Max
%��������������������������������x2Min,x2Max
%��������������������������������x3Min,x3Max]
%���������FitnessFunc����Ӧ�Ⱥ���
%% Check Input
[row,colum]=size(ParticleDim);
if row>1||colum>1
    error('��������ӵ�ά�����󣬱�����һ��1��1�е����ݡ�');
end
[row,colum]=size(ParticleScope);
if row~=ParticleDim||colum~=2
    error('��������ӵ�ά����Χ����');
end
%% ��ʼ������Ⱥ��λ�����ٶȾ���
% global MyPSO;
MyPSO.SwarmSize = SwarmSize;                        %����Ⱥ��С
MyPSO.ParticleDim = ParticleDim;                    %����ά��
MyPSO.ParticleScope = ParticleScope;                %���ӷ�Χ
MyPSO.FitnessFunc = FitnessFunc;                    %��Ӧֵ����
MyPSO.IsInitialized = true;                         %�Ƿ��ʼ����־
for i = 1:SwarmSize
    MyPSO.ParticlePos(i,:) = unifrnd(ParticleScope(:,1),ParticleScope(:,2),ParticleDim,1)';    %���ӵ�λ�þ��� %�����·�ĳ�ʼ����
end
MyPSO.ParticleVel = unifrnd(-0.1,0.1,SwarmSize,ParticleDim);    %���ӵ��ٶȾ���
MyPSO.ParticleFitness = zeros(SwarmSize,1);         %���ӵĵ�ǰ��Ӧֵ
MyPSO.PBest = zeros(SwarmSize,ParticleDim+1);       %���ӵ���ʷ����ֵ=����+Fitness
MyPSO.GBest = zeros(1,ParticleDim+1);               %���ӵ�ȫ������ֵ=����+Fitness
%������Ⱥ��λ��,�ٶȵķ�Χ���е���
for k=1:ParticleDim
    MyPSO.ParticlePos(:,k) = MyPSO.ParticlePos(:,k);
    MyPSO.ParticleVel(:,k) = MyPSO.ParticleVel(:,k);
end
%% ��ʼ�����ӵ���ʷ����ֵ��ȫ������ֵ
%���ӵ���ʷ����ֵ���ǳ�ʼ����λ�þ�������Ƚ�
MyPSO.PBest(:,1:end-1) = MyPSO.ParticlePos;

% ��ÿһ�����Ӽ�������Ӧ�Ⱥ�����ֵ
for k=1:SwarmSize
    MyPSO.ParticleFitness(k) = FitnessFunc(MyPSO.ParticlePos(k,:));
    MyPSO.PBest(k,end) = MyPSO.ParticleFitness(k);
end
% ȫ������ֵ
[minValue,row]=min(MyPSO.ParticleFitness);
MyPSO.GBest(:,1:end-1) = MyPSO.ParticlePos(row,:);
MyPSO.GBest(end) = minValue;
