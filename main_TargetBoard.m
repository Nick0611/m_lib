close all;
clear all;
clc;
% set(0,'defaultfigurecolor','w')
width=910  ;      %pattern�Ŀ� mm
height=910     ;          %pattern�ĸ� mm
img_final=zeros(height,width);
reinforceconner=1       ;%�Ƿ��ǿ�ǵ�
row=90;                 %pattern�����̸������
col=90 ;              %pattern�����̸������
length=10;           %pattern�����̸�Ĵ�С
% org_X=(height-row*length)/2;        %pattern�������᷽���λ�ã�Ĭ�Ϸ����м�
% org_Y=(width-col*length)/2;             %pattern���ں��᷽���λ�ã�Ĭ�Ϸ����м�
org_X=length/2;        %pattern�������᷽���λ�ã�Ĭ�Ϸ����м�
org_Y=length/2;             %pattern���ں��᷽���λ�ã�Ĭ�Ϸ����м�
color1=1;
color2=color1;
img=zeros(row*length,col*length);
for i=0:(row-1)
    color2=color1;
    for j=0:(col-1)
        if color2==1
            img(i*length+1:(i+1)*length-1,j*length+1:(j+1)*length-1)=color2;
        end
        %���ӵĻ�������ע�͵�
        %
        color2=~color2;
    end
    color1=~color1;
end
img_final(org_X:org_X+row*length-1,org_Y:org_Y+col*length-1)=img;
img_final=~img_final;
figure('position',[90 90 1000 1000],'units','centimeters');imshow(img_final);
for i=0:(row-1)
    if(mod(i,2)==0)
        text('units','data','position',[i*length -1/2*length],'fontsize',5,'string',num2str(i));
    else
        text('units','data','position',[i*length -length],'fontsize',5,'string',num2str(i));
    end
end
for j=0:(col-1)
    if(mod(j,2)==0)
        text('units','data','position',[-length j*length],'fontsize',6,'string',num2str(j));
    else
        text('units','data','position',[-3/2*length j*length],'fontsize',6,'string',num2str(j));
    end
end
hold on
plot([length/2;width-length/2;width-length/2;length/2;length/2], ...,
    [length/2;length/2;height-length/2;height-length/2;length/2],'linewidth',2,'color','k')
imwrite(img_final, 'cheesBoard.bmp','bmp');