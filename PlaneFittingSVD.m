%% SVDƽ�����
% ������ά���������ÿһ����һ�����xyz����
% �����һ��Ԫ�������ƽ���λ��p0(���е�ľ�ֵ)
% ����ڶ���Ԫ�������ƽ��ķ�����n0

% Revision
% Date 2021-6-20
% �޸���ͼ������fill�ķ�ʽ������е㹹�ɵ�ƽ��
%%
function [varargout] = PlaneFittingSVD(varargin)
if isempty(varargin)
    fprintf("    There's no input;\n");
    return
end
pl_store = varargin{1}';
if size(pl_store,2) ~= 3
    fprintf("    Wrong input;\n");
    return
end
% %%%%%%%%%%%% SVD�ֽ������ƽ�淨�� %%%%%%%%%%%%%
% Э��������SVD�任�У���С����ֵ��Ӧ��������������ƽ��ķ���
p0_fit=mean(pl_store,1);
centeredPlane=bsxfun(@minus,pl_store,p0_fit);
[U,S,V]=svd(centeredPlane);
n0_fit = [V(1,3) V(2,3) V(3,3)]';
d=-dot(n0_fit,p0_fit);

% ͼ�λ���
% xfit = min(pl_store(:,1)):(max(pl_store(:,1))-min(pl_store(:,1)))/20:max(pl_store(:,1));
% yfit = min(pl_store(:,2)):(max(pl_store(:,2))-min(pl_store(:,2)))/20:max(pl_store(:,2));
% [XFIT,YFIT]= meshgrid (xfit,yfit);
% d = -dot(n0_fit,p0_fit);
% ZFIT = -(d + n0_fit(1) * XFIT + n0_fit(2) * YFIT)/n0_fit(3);
% mesh(XFIT,YFIT,ZFIT); % ʹ��mesh�ķ�����ͼ����ƽ�汾��ӽ�ƽ��������ϵƽ��ʱ������ƽ���ǳ���
m = size(pl_store,1);
n = 10;
while m/n>100
    n = n*2;
end
p_new = pl_store([1:n:m],1:3); % ������
fill3(p_new(:,1),p_new(:,2),p_new(:,3),1); % ƽ����ͼ������fill�ķ�ʽ������е㹹�ɵ�ƽ��

% %%%%%%%%%%%% SVDn�ֽ������ƽ�淨�� %%%%%%%%%%%%%

varargout{1} = p0_fit;
varargout{2} = n0_fit;