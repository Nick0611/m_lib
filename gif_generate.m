clear all; clc;

%% ���÷�ʽһ��ȡ���ͼ�񡣴˷�ʽ��Ҫ���ļ����д���ȡ��ͼ��������Ϊ1,2,3...���˴���ʽΪbmp��

str1 = 'D:\Users\hp\Desktop\20200302rotating mechanism\New\program\';
str = [str1,'buffer1\'];
files = dir(strcat(str,'*.png'));
files = sortObj(files);
number_files = length(files);
for i=1:number_files
    k = 1;
    img{i} = imread([str,files(i).name]) ; % ����һ��cell����img{}�����ζ�ȡ��5��ͼ��
end

start=1;
postpone=0.1;

% for idx = 1:21 % ��һ��figure��������ʾ��5��ͼ��
%    subplot(4,3,idx), imshow(img{idx});
% end

%% ���÷�ʽ����ȡ���ͼ�񡣴˷�ʽ����Ҫ���ļ����д���ȡ��ͼ����������
% % ���ú���uigetdir�õ�������ͼ���·����Ȼ��Դ�·���µ�����ͼ����д���
%
% srcDir = uigetdir('C:\Users\Tang\Desktop\��������ƽ�浯�Բ�����������\�����ռ�����\'); % ��ʾλ���ļ���F:\DS0�ڲ����ļ���
% % srcDir = uigetdir; % ��ʾλ�ڵ�ǰ����Ŀ¼�ڲ����ļ���
% % cd(srcDir); % ��ѡ����ļ��С����޴˾䣬��򿪵�ǰ�ļ���
% allnames = struct2cell(dir('*.png')); % struct2cell()�����ṹ��ת��Ϊcell���顣dir()���г��ļ������ݣ��˴��г���ʽΪbmp���ļ�
% [m,n] = size(allnames); % �����allnames��һ��m*n��cell���飬n��ʾ��ȡ�˼���ͼ��
% for i = 1:n
%    name = allnames{1, i}; % allnames{1��i}��ʾ����ͼ����
%    img{i} = imread(name); % ����һ��cell����img{}�����ζ�ȡͼ��
% end
%
% for idx = 1:n  % ��һ��figure��������ʾ��n��ͼ��
%    subplot(4,3,idx), imshow(img{idx});
% end
%%
filename = [str1,'laser1',datestr(now,30),'.gif']; % �����gif��
for idx = start:number_files  % for idx = 1:n
    %    [A, map] = gray2ind(img{idx}, 256);
    [A, map] = rgb2ind(img{idx}, 256);
    if idx == 1
        imwrite(A, map, filename, 'gif', 'LoopCount', Inf, 'DelayTime', postpone); % ��Ե�һ��ͼ��
        % ������ͼ�񱣴�Ϊvein.gif��LoopCount��ʾ�ظ������Ĵ�����Inf��LoopCountֵ��ʹ��������ѭ����DelayTimeΪ1����ʾ��һ֡ͼ����ʾ��ʱ��
    else if idx<number_files % ��Ժ���ͼ��
            imwrite(A, map, filename, 'gif', 'WriteMode', 'append', 'DelayTime', postpone);
            % ������ͼ�񱣴�Ϊvein.gif��WriteMode��ʾд��ģʽ����append����overwrite�����ʹ�ã�appendģʽ�£�imwrite���������ļ���ӵ���֡
            % DelayTimeΪ1����ʾ����ͼ��Ĳ���ʱ����Ϊ1��
        else
            imwrite(A, map, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 5);
        end
    end
end