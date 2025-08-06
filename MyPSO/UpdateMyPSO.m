function MyPSO = UpdateMyPSO(MyPSO,MaxW,MinW,LoopCount,CurCount)
%% ����������ȫ�ְ汾������������Ⱥ�㷨�ĵ�������λ��,�ٶȵ��㷨
%���������LoopCount���������ܴ���
%���������CurCount����ǰ�����Ĵ���

%% ���ù�������
%1.���εݼ�����
% w=MaxW-CurCount*((MaxW-MinW)/LoopCount);
%2.�̶��������
%w=0.7;
%3.�����εݼ����԰������ݼ�
%w=(MaxW-MinW)*(CurCount/LoopCount)^2+(MinW-MaxW)*(2*CurCount/LoopCount)+MaxW;
%4.�����εݼ����԰������ݼ�
%w=MinW*(MaxW/MinW)^(1/(1+10*CurCount/LoopCount));
%5.������ԣ������ڶ�̬ϵͳ(Dynamic System)
w = 0.5 + rand()/2.0;
%% ����ѧϰ����
%1.�̶�����
% c1 = 2;
% c2 = 2;
%2.�̶����ԣ������ڶ�̬ϵͳ(Dynamic System)
c1 = 1.494;
c2 = 1.494;

% global MyPSO;
%% Update Pos and velocity
for row=1:MyPSO.SwarmSize
    Part1 = c1*unifrnd(0,1)*(MyPSO.PBest(row,1:end-1)-MyPSO.ParticlePos(row,:));
    Part2 = c2*unifrnd(0,1)*(MyPSO.GBest(:,1:end-1)-MyPSO.ParticlePos(row,:));
    TempV = w*MyPSO.ParticleVel(row,:) + Part1 + Part2;
    %�����ٶȵĴ���
    for h=1:MyPSO.ParticleDim
        if TempV(:,h)>MyPSO.ParticleScope(h,2)
            TempV(:,h)=MyPSO.ParticleScope(h,2);
        end
        if TempV(:,h)<-MyPSO.ParticleScope(h,2)
            TempV(:,h)=-MyPSO.ParticleScope(h,2)+1e-10;
            %��1e-10��ֹ��Ӧ�Ⱥ��������
        end
    end
    %�����ٶ�
    MyPSO.ParticleVel(row,:) = TempV;
     
    %����λ�õķ�Χ
    TempPos = MyPSO.ParticlePos(row,:) + TempV;
    for h=1:MyPSO.ParticleDim
        if TempPos(:,h)>MyPSO.ParticleScope(h,2)
            TempPos(:,h)=MyPSO.ParticleScope(h,2);
        end
        if TempPos(:,h)<=MyPSO.ParticleScope(h,1)
            TempPos(:,h)=MyPSO.ParticleScope(h,1)+1e-10;
        end
    end    
    %����λ��
    MyPSO.ParticlePos(row,:) = TempPos;
    
    %����ÿ�����ӵ��µ���Ӧ��ֵ
    MyPSO.ParticleFitness(row) = MyPSO.FitnessFunc(MyPSO.ParticlePos(row,:));
    %����ÿ�����ӵ���ʷ����ֵ
    if MyPSO.ParticleFitness(row)<MyPSO.PBest(row,end)
        MyPSO.PBest(row,1:end-1) = MyPSO.ParticlePos(row,:);
        MyPSO.PBest(row,end) = MyPSO.ParticleFitness(row);
    end
end
%% update Global Optimum
%Ѱ����Ӧ�Ⱥ���ֵ���/��С�Ľ��ھ����е�λ��(����)������ȫ�����ŵĸı�
[minValue,row]=min(MyPSO.ParticleFitness);
if minValue < MyPSO.GBest(end)
   MyPSO.GBest(:,1:end-1) = MyPSO.ParticlePos(row,:);
   MyPSO.GBest(end) = minValue;
end