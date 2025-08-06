%% 画坐标系rgb代表xyz轴
% 输入1：已有fig句柄
% 输入2：齐次变换矩阵T或齐次变换矩阵构成的元胞{T}
% 输入3：比例放大系数
% 输入4：可选参数，指定画哪个轴 'axis'
% 输入5：可选参数，如输入'axis'，则需指定轴，例如'xy'
% Revision
% Date 2021-06-24
% 增加自适应线宽
% Revision
% Date 2021-12-16
% 优化输入元胞时的画图速度
% Revision
% Date 2022-1-10
% 修改元胞不能指定轴bug
% Revision
% Date 2022-7-15
% 通过v{1:end}传递图形属性

%%
function [varargout] = DrawCoor(varargin)
if nargin < 3
    fprintf("    DrawCoor: Wrong input number!\n");
end
definations;
str = [];
fig1 = varargin{1};
figure(fig1)
T = varargin{2};
l_plot1 = varargin{3};
v = cell(1);

if nargin>3
    v = varargin(4:end);
    for i = 4:nargin-1
        switch varargin{i}
            case 'axis'
                str = varargin{i+1};
                str_len = length(str);
                v(i-3:i-2) = [];
        end
    end
end

count = 0;

if iscell(T)
    [xx,xy,xz,yx,yy,yz,zx,zy,zz]=deal([],[],[],[],[],[],[],[],[]);
    [cell_row,cell_col] = size(T);
    if isempty(str)
        for j=1:cell_row
            for k = 1:cell_col
                for i=1:3
                    switch i
                        case 1
                            xx(:,end+1) = [T{(j-1)*cell_col+k}(1,4);T{(j-1)*cell_col+k}(1,4)+l_plot1*T{(j-1)*cell_col+k}(1,1)];
                            xy(:,end+1) = [T{(j-1)*cell_col+k}(2,4);T{(j-1)*cell_col+k}(2,4)+l_plot1*T{(j-1)*cell_col+k}(2,1)];
                            xz(:,end+1) = [T{(j-1)*cell_col+k}(3,4);T{(j-1)*cell_col+k}(3,4)+l_plot1*T{(j-1)*cell_col+k}(3,1)];
                        case 2
                            yx(:,end+1) = [T{(j-1)*cell_col+k}(1,4);T{(j-1)*cell_col+k}(1,4)+l_plot1*T{(j-1)*cell_col+k}(1,2)];
                            yy(:,end+1) = [T{(j-1)*cell_col+k}(2,4);T{(j-1)*cell_col+k}(2,4)+l_plot1*T{(j-1)*cell_col+k}(2,2)];
                            yz(:,end+1) = [T{(j-1)*cell_col+k}(3,4);T{(j-1)*cell_col+k}(3,4)+l_plot1*T{(j-1)*cell_col+k}(3,2)];
                        case 3
                            zx(:,end+1) = [T{(j-1)*cell_col+k}(1,4);T{(j-1)*cell_col+k}(1,4)+l_plot1*T{(j-1)*cell_col+k}(1,3)];
                            zy(:,end+1) = [T{(j-1)*cell_col+k}(2,4);T{(j-1)*cell_col+k}(2,4)+l_plot1*T{(j-1)*cell_col+k}(2,3)];
                            zz(:,end+1) = [T{(j-1)*cell_col+k}(3,4);T{(j-1)*cell_col+k}(3,4)+l_plot1*T{(j-1)*cell_col+k}(3,3)];
                    end
                    %                 plot3([T{(j-1)*cell_col+k}(1,4);T{(j-1)*cell_col+k}(1,4)+l_plot1*T{(j-1)*cell_col+k}(1,i)], ...,
                    %                     [T{(j-1)*cell_col+k}(2,4);T{(j-1)*cell_col+k}(2,4)+l_plot1*T{(j-1)*cell_col+k}(2,i)], ...,
                    %                     [T{(j-1)*cell_col+k}(3,4);T{(j-1)*cell_col+k}(3,4)+l_plot1*T{(j-1)*cell_col+k}(3,i)],'color',color(i,:),'linewidth',ceil(l_plot1/20),'linejoin','round'); hold on
                end
            end
        end
        if sum(size(v)) == 2
            count = count+1;
            h{count} = plot3(xx,xy,xz,'color',color(1,:),'linejoin','round');
            hold on
            count = count+1;
            h{count} = plot3(yx,yy,yz,'color',color(2,:),'linejoin','round');
            count = count+1;
            h{count} = plot3(zx,zy,zz,'color',color(3,:),'linejoin','round');
            
        else
            count = count+1;
            h{count} = plot3(xx,xy,xz,'color',color(1,:),'linejoin','round',v{1:end});
            hold on
            count = count+1;
            h{count} = plot3(yx,yy,yz,'color',color(2,:),'linejoin','round',v{1:end});
            count = count+1;
            h{count} = plot3(zx,zy,zz,'color',color(3,:),'linejoin','round',v{1:end});
        end
    else
        for i=1:str_len
            switch str(i)
                case 'x'
                    for j=1:cell_row
                        for k = 1:cell_col
                            xx(:,end+1) = [T{(j-1)*cell_col+k}(1,4);T{(j-1)*cell_col+k}(1,4)+l_plot1*T{(j-1)*cell_col+k}(1,1)];
                            xy(:,end+1) = [T{(j-1)*cell_col+k}(2,4);T{(j-1)*cell_col+k}(2,4)+l_plot1*T{(j-1)*cell_col+k}(2,1)];
                            xz(:,end+1) = [T{(j-1)*cell_col+k}(3,4);T{(j-1)*cell_col+k}(3,4)+l_plot1*T{(j-1)*cell_col+k}(3,1)];
                        end
                    end
                    if sum(size(v)) == 2
                        count = count+1;
                        h{count} = plot3(xx,xy,xz,'color',color(1,:),'linejoin','round');
                        hold on
                    else
                        count = count+1;
                        h{count} = plot3(xx,xy,xz,'color',color(1,:),'linejoin','round',v{1:end});
                        hold on
                    end
                case 'y'
                    for j=1:cell_row
                        for k = 1:cell_col
                            yx(:,end+1) = [T{(j-1)*cell_col+k}(1,4);T{(j-1)*cell_col+k}(1,4)+l_plot1*T{(j-1)*cell_col+k}(1,2)];
                            yy(:,end+1) = [T{(j-1)*cell_col+k}(2,4);T{(j-1)*cell_col+k}(2,4)+l_plot1*T{(j-1)*cell_col+k}(2,2)];
                            yz(:,end+1) = [T{(j-1)*cell_col+k}(3,4);T{(j-1)*cell_col+k}(3,4)+l_plot1*T{(j-1)*cell_col+k}(3,2)];
                        end
                    end
                    if sum(size(v)) == 2
                        count = count+1;
                        h{count} = plot3(yx,yy,yz,'color',color(2,:),'linejoin','round');
                        hold on
                    else
                        count = count+1;
                        h{count} = plot3(yx,yy,yz,'color',color(2,:),'linejoin','round',v{1:end});
                        hold on
                    end
                case 'z'
                    for j=1:cell_row
                        for k = 1:cell_col
                            zx(:,end+1) = [T{(j-1)*cell_col+k}(1,4);T{(j-1)*cell_col+k}(1,4)+l_plot1*T{(j-1)*cell_col+k}(1,3)];
                            zy(:,end+1) = [T{(j-1)*cell_col+k}(2,4);T{(j-1)*cell_col+k}(2,4)+l_plot1*T{(j-1)*cell_col+k}(2,3)];
                            zz(:,end+1) = [T{(j-1)*cell_col+k}(3,4);T{(j-1)*cell_col+k}(3,4)+l_plot1*T{(j-1)*cell_col+k}(3,3)];
                        end
                    end
                    if sum(size(v)) == 2
                        count = count+1;
                        h{count} = plot3(zx,zy,zz,'color',color(3,:),'linejoin','round');
                        hold on
                    else
                        count = count+1;
                        h{count} = plot3(zx,zy,zz,'color',color(3,:),'linejoin','round',v{1:end});
                        hold on
                    end
            end
        end
    end
else
    if isempty(str)
        for i=1:3
            if sum(size(v)) == 2
                count = count+1;
                h{count} = plot3([T(1,4);T(1,4)+l_plot1*T(1,i)], ...,
                    [T(2,4);T(2,4)+l_plot1*T(2,i)], ...,
                    [T(3,4);T(3,4)+l_plot1*T(3,i)],'color',color(i,:),'linejoin','round'); hold on
            else
                count = count+1;
                h{count} = plot3([T(1,4);T(1,4)+l_plot1*T(1,i)], ...,
                    [T(2,4);T(2,4)+l_plot1*T(2,i)], ...,
                    [T(3,4);T(3,4)+l_plot1*T(3,i)],'color',color(i,:),'linejoin','round',v{1:end}); hold on
            end
        end
    else
        for i=1:str_len
            switch str(i)
                case 'x'
                    xx = [T(1,4);T(1,4)+l_plot1*T(1,1)];
                    xy = [T(2,4);T(2,4)+l_plot1*T(2,1)];
                    xz = [T(3,4);T(3,4)+l_plot1*T(3,1)];
                    if sum(size(v)) == 2
                        count = count+1;
                        h{count} = plot3(xx,xy,xz,'color',color(1,:),'linejoin','round');
                        hold on
                    else
                        count = count+1;
                        h{count} = plot3(xx,xy,xz,'color',color(1,:),'linejoin','round',v{1:end});
                        hold on
                    end
                case 'y'
                    yx = [T(1,4);T(1,4)+l_plot1*T(1,2)];
                    yy = [T(2,4);T(2,4)+l_plot1*T(2,2)];
                    yz = [T(3,4);T(3,4)+l_plot1*T(3,2)];
                    if sum(size(v)) == 2
                        count = count+1;
                        h{count} = plot3(yx,yy,yz,'color',color(2,:),'linejoin','round');
                        hold on
                    else
                        count = count+1;
                        h{count} = plot3(yx,yy,yz,'color',color(2,:),'linejoin','round',v{1:end});
                        hold on
                    end
                case 'z'
                    zx = [T(1,4);T(1,4)+l_plot1*T(1,3)];
                    zy = [T(2,4);T(2,4)+l_plot1*T(2,3)];
                    zz = [T(3,4);T(3,4)+l_plot1*T(3,3)];
                    if sum(size(v)) == 2
                        count = count+1;
                        h{count} = plot3(zx,zy,zz,'color',color(3,:),'linejoin','round');
                        hold on
                    else
                        count = count+1;
                        h{count} = plot3(zx,zy,zz,'color',color(3,:),'linejoin','round',v{1:end});
                        hold on
                    end
            end
        end
    end
end
varargout{1} = fig1;
varargout{2} = h;
