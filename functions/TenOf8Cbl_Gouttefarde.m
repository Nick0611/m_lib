%%% function v_fea = TenOf8Cbl_Gouttefarde(N,tp,tmin,tmax)
% author: Zahcary Leung
% Date: 2023-4-2
% A Versatile Tension Distribution Algorithm for $n$ -DOF Parallel Robots Driven by $n+2$ Cables
% Note: ����ʽ�жϲ��ֵȺŵ�ȡ�������ײ�ͬ
% input1: �ṹ�������ռ���� n by (m-n)
% input2: ��ƽ�ⷽ�̵�ͨ�� n by 1
% input3: ��������С����ʸ�� m by 1
% input4: �������������ʸ�� m by 1
% output1: ���ж���εĶ��� 2 by ��ȷ��
% Revision 20230424
% ������ֱ���غϵ�����жϣ�Ҳ����N��������ͬ
function v_fea = TenOf8Cbl_Gouttefarde(N,tp,tmin,tmax)
v_fea = []; % ��¼���м�
i = 1;
j = 2; % j�ǻ�׼��i��Ҫ�ƶ��ķ���
vli = linecross2D(-N(j,1)/N(j,2),(tmin(j)-tp(j))/N(j,2),-N(i,1)/N(i,2),(tmax(i)-tp(i))/N(i,2)); % ����ѡ�ˡ�jmin�͡�imax�������ж�niB
vf = vli;
I = find(round(tmin-tp,6) <= round(N*vli,6) & round(N*vli,6) <= round(tmax-tp,6)); % round��ԭ�򣺽��������������뵽�ض��ľ��ȣ�������С����ֵ��
% scatter3S(vf);
% textS(vf,'text','0');
b = [1;2]; % ��׼����min����max�ı�־
itr_num = 0;
for ccc = 1:100
    idx = [];
    itr_num = itr_num+1;
%     disp(itr_num);
    ni = N(i,:);
    nj = N(j,:);
    niB = [ni(2) -ni(1)];
    if b(end-1) == 1
        if nj*niB' < 0
            niB = -niB;
        end
    end
    if b(end-1) == 2
        if nj*niB' > 0
            niB = -niB;
        end
    end
    alpha_k = ones(1,8)*nan;
    bk = [];
    k_itx = 1:8;
    k_itx(find(k_itx==i))=[];
    for itx = 1:7
        k = k_itx(itx);
        nk = N(k,:);
        if abs(nk*niB' - 0) < eps % ���
            ;
        elseif nk*niB'>0
            if round(nk*vli,6) < round(tmin(k)-tp(k),6)
                alpha_k(k) = (tmin(k)-tp(k)-nk*vli)/(nk*niB');
                bk(k) = 1;
            elseif round(tmin(k)-tp(k),6) <= round(nk*vli,6) & round(nk*vli,6) < round(tmax(k)-tp(k),6)
                alpha_k(k) = (tmax(k)-tp(k)-nk*vli)/(nk*niB');
                bk(k) = 2;
            else
                ;
            end
        else
            if nk*vli <= tmin(k)-tp(k)
                ;
            elseif round(tmin(k)-tp(k),6) < round(nk*vli,6) & round(nk*vli,6) <= round(tmax(k)-tp(k),6)
                alpha_k(k) = (tmin(k)-tp(k)-nk*vli)/(nk*niB');
                bk(k) = 1;
            else
                alpha_k(k) = (tmax(k)-tp(k)-nk*vli)/(nk*niB');
                bk(k) = 2;
            end
        end
    end
    alpha_k(alpha_k<1e-6) = nan; % ���߽���һ�����ȥ
    [alpha_l,idxtmp] = min(alpha_k);
    for Reptmp = 1:8 % ��ֱ���غϵ����
        if ismembertol(alpha_k(Reptmp),alpha_k(idxtmp),1e-6)
            idx(end+1) = Reptmp;
        end
    end
    b(end+1) = bk(idx(1));
    vli = vli+alpha_l*niB';
    v_fea(:,end+1) = vli;
%     scatter3S(vli);
%     textS(vli,'text',num2str(itr_num));
    
    if all(ismember(idx,I))
        if all(ismembertol(vli,vf,1e-6)) % �ж�vli��vf���
            if isequal(I,[1:8]')
%                 disp('all detected!');
%                 patch('Vertices',v_fea','Faces',1:size(v_fea,2),'FaceColor','red','FaceAlpha',.3); % �����м�
                break;
            else
                v_fea = [];
%                 disp([num2str(itr_num),' not exist!']);
                break;
            end
        else
            I = I;
            j = i;
            i = idx(1);
        end
    else
        I = unique([I;idx']);
        vf = vli;
        v_fea = [];
        v_fea(:,end+1) = vf;
        j = i;
        i = idx(1);
    end
end