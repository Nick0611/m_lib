clear
clc
for i=-30:2:-2
    data{i/2+16} = csvread(strcat("D:\Users\hp\Downloads\BaiduNetdiskDownload\data1107\route_",num2str(abs(i)),".csv"),0,0);
end
for i=0:2:30
    data{i/2+16} = csvread(strcat("D:\Users\hp\Downloads\BaiduNetdiskDownload\data1107\route",num2str(i),".csv"),0,0);
end
arr = cell2mat(data');
csvwrite("Keypoints.csv",arr);