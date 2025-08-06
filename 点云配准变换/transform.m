function [Data] = transform(T,data)
%This function transforms the Nby3 data point using 4by4 transformation
% Date 2021-07-06
% ��Դ ������
% ���� 3byN
% ��� 3byN ��׼��ĵ���
%matrix
% if size(data,1)~=3
%     data=data';
% end
data=data';% 3byN
N=size(data,2);
data_h=[data;ones(1,N)];%transform data to homogeneous coordinates
Data=T*data_h;
Data=Data(1:3,:);%Nby3
end

