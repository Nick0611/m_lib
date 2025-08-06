clear all; clc;

%% 采用方式一读取多幅图像。此方式需要将文件夹中待读取的图像重命名为1,2,3...，此处格式为bmp。

str1 = 'D:\Users\hp\Desktop\20200302rotating mechanism\New\program\';
str = [str1,'buffer1\'];
files = dir(strcat(str,'*.png'));
files = sortObj(files);
number_files = length(files);
for i=1:number_files
    k = 1;
    img{i} = imread([str,files(i).name]) ; % 建立一个cell数组img{}，依次读取这5幅图像
end

start=1;
postpone=0.1;

% for idx = 1:21 % 在一个figure中依次显示这5幅图像
%    subplot(4,3,idx), imshow(img{idx});
% end

%% 采用方式二读取多幅图像。此方式不需要对文件夹中待读取的图像重命名。
% % 利用函数uigetdir得到待处理图像的路径，然后对此路径下的所有图像进行处理
%
% srcDir = uigetdir('C:\Users\Tang\Desktop\冗余驱动平面弹性并联机构工作\工作空间数据\'); % 显示位于文件夹F:\DS0内部的文件夹
% % srcDir = uigetdir; % 显示位于当前工作目录内部的文件夹
% % cd(srcDir); % 打开选择的文件夹。若无此句，则打开当前文件夹
% allnames = struct2cell(dir('*.png')); % struct2cell()，将结构体转换为cell数组。dir()，列出文件夹内容，此处列出格式为bmp的文件
% [m,n] = size(allnames); % 这里的allnames是一个m*n的cell数组，n表示读取了几幅图像
% for i = 1:n
%    name = allnames{1, i}; % allnames{1，i}表示的是图像名
%    img{i} = imread(name); % 建立一个cell数组img{}，依次读取图像
% end
%
% for idx = 1:n  % 在一个figure中依次显示这n幅图像
%    subplot(4,3,idx), imshow(img{idx});
% end
%%
filename = [str1,'laser1',datestr(now,30),'.gif']; % 保存的gif名
for idx = start:number_files  % for idx = 1:n
    %    [A, map] = gray2ind(img{idx}, 256);
    [A, map] = rgb2ind(img{idx}, 256);
    if idx == 1
        imwrite(A, map, filename, 'gif', 'LoopCount', Inf, 'DelayTime', postpone); % 针对第一幅图像
        % 将索引图像保存为vein.gif，LoopCount表示重复动画的次数，Inf的LoopCount值可使动画连续循环，DelayTime为1，表示第一帧图像显示的时间
    else if idx<number_files % 针对后续图像
            imwrite(A, map, filename, 'gif', 'WriteMode', 'append', 'DelayTime', postpone);
            % 将索引图像保存为vein.gif，WriteMode表示写入模式，与append（或overwrite）配合使用，append模式下，imwrite会向现有文件添加单个帧
            % DelayTime为1，表示后续图像的播放时间间隔为1秒
        else
            imwrite(A, map, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 5);
        end
    end
end