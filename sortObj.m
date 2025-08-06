%%% 文件列表自然排序
% DESCRIPTIVE TEXT
function file=sortObj(file)
for i=1:length(file)
    A{i}=file(i).name;
end
[~, ind]=natsort(A);
for j=1:length(file)
    files(j)=file(ind(j));
end
clear file;
file=files';
