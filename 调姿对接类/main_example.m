g1 =[1, 0, 0, 0;
        0, 1, 0, 0;
        0, 0, 1, 0;
        0, 0, 0, 1];
g2 =[ 0.987672114350896, -0.118130739494685, 0.102707949643980, 20.000000000000000;
        0.130029500651719, 0.984447793103679, -0.118130739494685, 6.000000000000000;
        -0.087155742747658, 0.130029500651719, 0.987672114350896, 10.000000000000000;
        0, 0, 0, 1.000000000000000];
g3 =[ 0.957662196942549, -0.217368451944987, 0.188769893378714, 30.000000000000000;
        0.256604812292571, 0.941756298841337, -0.217368451944987, 18.000000000000000;
        -0.130526192220052, 0.256604812292571, 0.957662196942549, 16.000000000000000;
        0, 0, 0, 1.000000000000000];
g4 =[ 0.987672114350896, -0.010464336979314, 0.156186722179623, 40.000000000000000;
        0.086410113286383, 0.868417969278302, -0.488245351187684, 12.00000000000000;
        -0.130526192220052, 0.495722430686905, 0.858616436401261, 16.000000000000000;
        0, 0, 0,   1.000000000000000];

gB = {g1,g2}; %活动段当前连体坐标系和目标连体坐标系
gB_in_O = RigidBodyTrajectory(gB); % 计算刚体的路径

PS_in_B = [0, 0, 0;
    -3, 0, 0;
    -6, 0, 0;
    -9, 0, 0;
    -9, -2, 0;
    -6, -2, 0;
    -3, -2, 0;
    0, -2, 0;
    0, -4, 0;
    -3, -4, 0;
    -6, -4, 0;
    -9, -4, 0;
    -9, -6, 0;
    -6, -6, 0;
    -3, -6, 0;
    0, -6, 0]'*3;
PS_in_B = mat2cell(PS_in_B, 3,ones(1, 16)); % 球窝在连体系B中的坐标

l0_in_C = cell(1,length(PS_in_B)); % 球头在小车坐标系中的零位坐标
gC_in_O = cell(1,length(PS_in_B)); % 车身坐标系在全局坐标系中的位姿
for i = 1:length(PS_in_B)
    l0_in_C{i} = rand(3,1);
    gC_in_O{i} = [eye(3) PS_in_B{i}-2*rand(3,1);0 0 0 1];
end

for i = 1:length(PS_in_B) % 小车索引
    PS_in_O{i} = SphereJointTrajectory_Inv(gB_in_O,PS_in_B{i}); % 计算每个球窝在全局O的路径
    PS_in_C{i} = NonHomo_g(inv(gC_in_O{i}),PS_in_O{i},1); % 计算每个球窝在车身C的路径
    for j = 1:length(PS_in_C{i}) % 轨迹点索引
        Drive{i} = HydraulicTrolleyXYZInv_2(l0_in_C{i},PS_in_C{i}); % i车的三个轴的伸长量
    end
end

%% 正解演示
for i = 1:length(PS_in_B) % 小车索引
    P_in_C{i} = HydraulicTrolleyXYZFor_2(l0_in_C{i},Drive{i});
    P_in_O{i} = NonHomo_g(gC_in_O{i},P_in_C{i},1);
    scatter3S(P_in_O{i}); hold on; % 画球头轨迹
    SolidPlot('cub',[1,0.8,0.6]*3,[0;0;1],0,gC_in_O{i}(1:3,4)+[1;0.8;-0.6]*3/2,'facealpha',0.5);
    P0_in_C{i}(:,1) = zeros(3,1);
    P0_in_C{i}(:,2) = P0_in_C{i}(:,1)+l0_in_C{i}(1)*[1;0;0];
    P0_in_C{i}(:,3) = P0_in_C{i}(:,2)+l0_in_C{i}(2)*[0;1;0];
    P0_in_C{i}(:,4) = P0_in_C{i}(:,3)+l0_in_C{i}(3)*[0;0;1];
    P0_in_O{i} = NonHomo_g(gC_in_O{i},P0_in_C{i},1);
    plot3S(P0_in_O{i}(:,1:2),'color','r','linewidth',6);
    plot3S(P0_in_O{i}(:,2:3),'color','g','linewidth',6);
    plot3S(P0_in_O{i}(:,3:4),'color','b','linewidth',6); % 画零位位置
    P_Drive_in_C{i}(:,1) = P0_in_C{i}(:,4);
    P_Drive_in_C{i}(:,2) = P_Drive_in_C{i}(:,1)+Drive{i}(1,1)*[1;0;0];
    P_Drive_in_C{i}(:,3) = P_Drive_in_C{i}(:,2)+Drive{i}(2,1)*[0;1;0];
    P_Drive_in_C{i}(:,4) = P_Drive_in_C{i}(:,3)+Drive{i}(3,1)*[0;0;1];
    P_Drive_in_O{i} = NonHomo_g(gC_in_O{i},P_Drive_in_C{i},1);
    plot3S(P_Drive_in_O{i}(:,1:2),'color','r','linewidth',3);
    plot3S(P_Drive_in_O{i}(:,2:3),'color','g','linewidth',3);
    plot3S(P_Drive_in_O{i}(:,3:4),'color','b','linewidth',3); % 画球头的第一个坐标的位置
end
axis equal;

     








