close all;
clear all;
clc;
% set(0,'defaultfigurecolor','w')
width=910  ;      %pattern的宽 mm
height=910     ;          %pattern的高 mm
img_final=zeros(height,width);
reinforceconner=1       ;%是否加强角点
row=90;                 %pattern中棋盘格的行数
col=90 ;              %pattern中棋盘格的列数
length=10;           %pattern中棋盘格的大小
% org_X=(height-row*length)/2;        %pattern关于纵轴方向的位置，默认放在中间
% org_Y=(width-col*length)/2;             %pattern关于横轴方向的位置，默认放在中间
org_X=length/2;        %pattern关于纵轴方向的位置，默认放在中间
org_Y=length/2;             %pattern关于横轴方向的位置，默认放在中间
color1=1;
color2=color1;
img=zeros(row*length,col*length);
for i=0:(row-1)
    color2=color1;
    for j=0:(col-1)
        if color2==1
            img(i*length+1:(i+1)*length-1,j*length+1:(j+1)*length-1)=color2;
        end
        %不加的话，可以注释掉
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