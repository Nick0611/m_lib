clear
clc
close all
namelist = dir('iter experiment\points20_ave0_dev0\Newton\*.png');
% namelist1 = dir('C:\Users\DELL\Desktop\data\helen\train\train_res\*.txt');
 
% 读取后namelist 的格式为
% name -- filename
% date -- modification date
% bytes -- number of bytes allocated to the file
% isdir -- 1 if name is a directory and 0 if not

len = length(namelist);
img = cell(len,1);
% text = cell(1954,1);
for i = 1:len
    file_name{i}=namelist(i).name;
%     file_name1{i}=namelist1(i).name;
    img{i}= imread(strcat('iter experiment\points20_ave0_dev0\Newton\',file_name{i}));
%     text{i} = load(strcat('C:\Users\DELL\Desktop\data\helen\train\train_res\',file_name1{i}));
end
for i = 1:4
    for j = 1:5
    subplot(4,5,5*(i-1)+j);
    imshow(img{5*(i-1)+j},'InitialMagnification','fit');
    end
end

