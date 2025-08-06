% function f = plotPolyhedron(x,y,z)
% 功能：绘制多面体
% 来源：https://zhuanlan.zhihu.com/p/357836869
% 输入：X，n by 3，顶点坐标
%
% 实例1：菱形三十面体
% tau=(1+sqrt(5))/2;
% tria=[];
% for k=[-1 1]
%     for kk=[-1 1]
%         tria=[tria;k*tau^2 kk*tau 0;kk*tau 0 k*tau^2;0 k*tau^2 kk*tau];
%         tria=[tria;k*tau^2 0 kk;0 kk k*tau^2;kk k*tau^2 0];
%         for kkk=[-1 1]
%             tria=[tria;k*tau,kk*tau,kkk*tau];
%         end
%     end
% end
% plotPolyhedron(tria);
%
% 实例2：棱锥
% k=linspace(0,2*pi,10)';
% k=k(1:end-1);
% x=cos(k);
% y=sin(k);
% z=zeros(size(k));
% x(end+1)=0;
% y(end+1)=0;
% z(end+1)=2;k=linspace(0,2*pi,10)';
% k=k(1:end-1);
% x=cos(k);
% y=sin(k);
% z=zeros(size(k));
% x(end+1)=0;
% y(end+1)=0;
% z(end+1)=2;
% plotPolyhedron([x,y,z]);
%
% 实例3：正十二面体
% tau=(1+sqrt(5))/2;
% tria=[];
% for k=[-1 1]
%     for kk=[-1 1]
%         tria=[tria;k*tau kk/tau 0;kk/tau 0 k*tau;0 k*tau kk/tau];
%         for kkk=[-1 1]
%             tria=[tria;k,kk,kkk];
%         end
%     end
% end
% plotPolyhedron(tria);
%
% 实例4：圆柱
% k=linspace(0,2*pi,500)';
% k=k(1:end-1);
% x=cos(k);
% y=sin(k);
% z=zeros(size(k));
% x=repmat(x,2,1);
% y=repmat(y,2,1);
% z=[z;ones(size(k))];
% ([x,y,z]);
%
% revision-20240609
% 增加varargin绘图控制

function f = plotPolyhedron(X,varargin)
if nargin>1
    v = varargin(1:end);
else
    v = {'FaceColor',[1 1 1]*0.9,'FaceAlpha',0.5,'LineStyle','-'};
end
x = X(:,1); y = X(:,2); z = X(:,3);
shp=alphaShape(x,y,z);
shp.Alpha=20*max([max(x)-min(x),max(y)-min(y),max(z)-min(z)])/2;
[elements,nodes]=boundaryFacets(shp);
normalvec=zeros(size(elements));
for k=1:size(elements,1)
    normalvec(k,:)=cross(nodes(elements(k,2),:)-nodes(elements(k,1),:),nodes(elements(k,3),:)-nodes(elements(k,1),:));
end
faceNear=nchoosek(1:size(elements,1),2);
% figure
hold on
f = trisurf(elements,nodes(:,1),nodes(:,2),nodes(:,3),v{1:end});
for k=1:size(faceNear,1)
    isEdge=ismember(elements(faceNear(k,1),:),elements(faceNear(k,2),:));
    if sum(isEdge)>1 && vecnorm(cross(normalvec(faceNear(k,1),:),normalvec(faceNear(k,2),:)),1)/(vecnorm(normalvec(faceNear(k,1),:),1)*vecnorm(normalvec(faceNear(k,2),:),1))>1e-6
        %     if sum(isEdge)>1 && vecnorm(cross(normalvec(faceNear(k,1),:),normalvec(faceNear(k,2),:)),1)/(vecnorm(normalvec(faceNear(k,1),:),1)*vecnorm(normalvec(faceNear(k,2),:),1))>1e-1
%         plot3(nodes(elements(faceNear(k,1),isEdge),1),nodes(elements(faceNear(k,1),isEdge),2),nodes(elements(faceNear(k,1),isEdge),3),'Color','k');
%         plot3(nodes(elements(faceNear(k,1),isEdge),1),nodes(elements(faceNear(k,1),isEdge),2),nodes(elements(faceNear(k,1),isEdge),3));
    end
end
% axis equal
view(3)
% hold off


end