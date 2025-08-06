clear
clc
close all
namelist = dir('iter experiment\points20_ave5_dev4\Regularization\*.mat');
% namelist1 = dir('C:\Users\DELL\Desktop\data\helen\train\train_res\*.txt');
 
% 读取后namelist 的格式为
% name -- filename
% date -- modification date
% bytes -- number of bytes allocated to the file
% isdir -- 1 if name is a directory and 0 if not

len = length(namelist);
err_degree = 0;
err_pos = 0;
for i = 1:len
    file_name{i}=namelist(i).name;
    data{i}= load(strcat('iter experiment\points20_ave5_dev4\Regularization\',file_name{i}));
    err_temp = data{i}.err;
    for iter = 1:size(err_temp,2)
        if any(err_temp(:,size(err_temp,2)-iter+1))
            break;
        end
    end
    err_degree = err_degree+err_temp(10,size(err_temp,2)-iter+1);    
    err_pos = err_pos+err_temp(11,size(err_temp,2)-iter+1); 
end
err_degree = err_degree/len;
err_pos = err_pos/len;

