%%% function CounterSlice3D(M,layer)
% 输入1：M counter函数的输出M
% 输入2：layer，想要在三维图中出现的高度
% 作者：梁振鹍
% 日期：2022-1-11

function CounterSlice3D(M,layer)
k=1;% 全局列数
m=1;% 局部列数
j=0;% 组数
for i=1:size(M,2)
    if i == k
        j = j+1;
        m = 1;
        k = i+M(2,k)+1;
    else
        num{j}(:,m) = M(:,i);
        m = m+1;
    end
end
for i = 1:j
    num{i}(3,:)=layer*ones(1,size(num{i},2));
    plot3(num{i}(1,:),num{i}(2,:),num{i}(3,:))
    hold on
end