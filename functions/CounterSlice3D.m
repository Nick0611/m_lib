%%% function CounterSlice3D(M,layer)
% ����1��M counter���������M
% ����2��layer����Ҫ����άͼ�г��ֵĸ߶�
% ���ߣ������d
% ���ڣ�2022-1-11

function CounterSlice3D(M,layer)
k=1;% ȫ������
m=1;% �ֲ�����
j=0;% ����
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