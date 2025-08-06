clear;
clc
tic;
t1=tic;
format long;
mn = 500;
N=720;M=500; %number of the discretized points and the iterations, one degree for a point
%initializing the original shape
d_theta=2*pi/N; % 均分的角度
d0=0; % 步长初始猜测值为0
r0=d0*ones(1,N);
r=r0; % 第一条曲线上的点到名义位形的距离全为0，r表示距离名义位形的距离
p0=[0.06;0.14];
for i=1:M
    rr(:,i)=r;
    dr=dis(r); % the step of each point 根据当前曲线计算迭代步长，dr为步长
    r=r+dr; % 更新距离值
end
t2=toc(t1);

for i=1:M %getting the coordinats of the interface
    for j=1:N+1
        if j==N+1;
            rj=rr(1,i)*[cos(d_theta*0);sin(d_theta*0)];
        else
            rj=rr(j,i)*[cos(d_theta*(j-1));sin(d_theta*(j-1))];
        end
        x(j,i)=p0(1)+rj(1);
        y(j,i)=p0(2)+rj(2);
        XX(j,i)=p0(1)+6*rj(1);
        YY(j,i)=p0(2)+6*rj(2);
    end
end
%   for i=1:M
%       axis equal;
%       plot(XX(:,i),YY(:,i));
%       hold on;
%   end

%% 机构当前位型
A1 = [-0.1; 0];
L11 = 0.15;
L12 = 0.2;
A2 = [0.1; 0];
L21 = 0.15;
L22 = 0.2;

C = [0.06; 0.14];
THETA1 = DYAD1(C);
B1 = A1 + [L11*cos(THETA1); L11*sin(THETA1)];

THETA2 = DYAD2(C);
B2 = A2 + [L21*cos(THETA2); L21*sin(THETA2)];
dd = [A1, B1, C, B2, A2];
% figure;
% hold on;
% grid on;
% axis equal;
% plot(dd(1, :),dd(2, :),'-ok','linewidth',3,'markersize',9,'markerfacecolor','w','markeredgecolor','k');
% hold on;
% plot(dd(1,[1,5]),dd(2,[1,5]),'o','linewidth',2,'markersize',9,'markerfacecolor','r','markeredgecolor','k');
% plot(dd(1,3),dd(2,3),'o','linewidth',2,'markersize',9,'markerfacecolor','g','markeredgecolor','k');

%% 机构关节空间
% figure;
for j = 1:M
    for i = 1:N
        CC = [x(i, j);y(i, j)];
        phi_1(i, j) = 2*(DYAD1(CC)-DYAD1(C));
        phi_2(i, j) = 2*(DYAD2(CC)-DYAD2(C));
    end
end
TEMP=0.04;
d1 = [TEMP; TEMP];
d2 = [-TEMP; TEMP];
d3 = [-TEMP; -TEMP];
d4 = [TEMP; -TEMP];
ddd = [d1, d2, d3, d4, d1];
% hold on;
% plot(ddd(1, :),ddd(2, :));
% hold on;
% for j = 1:M
%     plot(phi_1(:, j), phi_2(:, j))
% end

%% 动画
A1 = [-0.1; 0];
L11 = 0.15;
L12 = 0.2;
A2 = [0.1; 0];
L21 = 0.15;
L22 = 0.2;
C = [0.06; 0.14];
THETA1 = DYAD1(C);
B1 = A1 + [L11*cos(THETA1); L11*sin(THETA1)];
THETA2 = DYAD2(C);
B2 = A2 + [L21*cos(THETA2); L21*sin(THETA2)];
dd = [A1, B1, C, B2, A2];

mode = 'errorspace';

if strcmp(mode,'workspace')
    figure('Name','workspace','Position',[100,100,1000,600])
    fig2 = plot(phi_1(:, 1), phi_2(:, 1),'linewidth',4);
    hold on
    fig3 = plot(ddd(1, :),ddd(2, :),'color',[0,0,0],'linewidth',4);
    axis manual
    xlim([min(min(phi_1)),max(max(phi_1))])
    ylim([min(min(phi_2)),max(max(phi_2))])
    axis equal
    axis off
    ax = gca;
    outerpos = ax.OuterPosition;
    ti = ax.TightInset;
    left = outerpos(1) + ti(1);
    bottom = outerpos(2) + ti(2);
    ax_width = outerpos(3) - ti(1) - ti(3);
    ax_height = outerpos(4) - ti(2) - ti(4);
    ax.Position = [left bottom ax_width ax_height];
    str = 'C:\Users\Mech2\Desktop\5-bar mechanism\buffer\'; % 图像路径
    for i=1:mn
        set(fig2,'Xdata',phi_1(:, i),'Ydata',phi_2(:, i),'linewidth',4)
        pict_name=['workspace-',num2str(i)];
        F=getframe(gcf);
        imwrite(F.cdata, [str,pict_name,'.png']);
        tempx=i;
    end
elseif strcmp(mode,'errorspace')
    figure('Name','errorspace','Position',[100,100,1000,600])
    fig1 = plot(XX(:,1),YY(:,1),'linewidth',4);
    hold on
    axis manual
    xlim([min(min(XX)),max(max(XX))])
    ylim([min(min(YY)),max(max(YY))])
    axis equal
    axis off
    str = 'C:\Users\Mech2\Desktop\5-bar mechanism\buffer\'; % 图像路径
    for i=1:mn
        set(fig1,'Xdata',XX(:,i),'Ydata',YY(:,i),'linewidth',4)
        pict_name=['errorspace-',num2str(i)];
        F=getframe(gcf);
        imwrite(F.cdata, [str,pict_name,'.png']);
    end
else
    fprintf('please input correct mode');
end

img = cell(mn,1);
if strcmp(mode,'workspace')
    filename = 'workspace.gif'; % 保存的gif名
    for idx = 1:mn  % 读取5幅图像
        pict_name=['workspace-',num2str(idx)];
        img{idx} = imread([str, pict_name, '.png']) ; % 建立一个cell数组img{}，依次读取这5幅图像
    end
elseif strcmp(mode,'errorspace')
    filename = 'errorspace.gif'; % 保存的gif名
    for idx = 1:mn  % 读取5幅图像
        pict_name=['errorspace-',num2str(idx)];
        img{idx} = imread([str, pict_name, '.png']) ; % 建立一个cell数组img{}，依次读取这5幅图像
    end
else
    fsprint('can not output!');
end

if strcmp(mode,'workspace') or strcmp(mode,'errorspace')
    postpone=1/30;
    for idx = 1:mn  % for idx = 1:n
        [A, map] = rgb2ind(img{idx}, 256);
        if idx == 1
            imwrite(A, map, filename, 'gif', 'LoopCount', Inf, 'DelayTime', 3); % 针对第一幅图像
            % 将索引图像保存为vein.gif，LoopCount表示重复动画的次数，Inf的LoopCount值可使动画连续循环，DelayTime为1，表示第一帧图像显示的时间
        elseif idx<200
            imwrite(A, map, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 3-idx/200*2);
        elseif idx<400
            imwrite(A, map, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 1-(idx-200)/200*29/30);
        else % 针对后续图像
            imwrite(A, map, filename, 'gif', 'WriteMode', 'append', 'DelayTime', postpone);
        end
    end
end

