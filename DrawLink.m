%% ���ӹ̶��㵽�����������
% ����1������fig���
% ����2���������������ÿһ�д���һ���������������
% ����3���̶�������������
% ����'color'��rgb��ɫ������
% ����'text'��'Y'���  'N'����ţ�Ĭ�ϲ����
% ����'fontsize'����ע���ֺŴ�С��Ĭ��12
% ����'linewidth'���߿�Ĭ��1
% ����'alpha'������͸���ȣ�Ĭ��1
%%
function [varargout] = DrawLink(varargin)
if nargin < 3
    fprintf("    Wrong input number!\n");
    return
end
%%% ������������ж�
if ~mod(nargin,2)
    fprintf("    Wrong input number!\n");
    return
end
definations;
fig1 = varargin{1};
figure(fig1);
T = varargin{2};
p0 = varargin{3};
color = [5;39;175]./255;
text_flag = 'N';
m_fontsize = 12;
m_linewidth = 1;
m_alpha = 1;

if nargin > 3
    for i = 4:nargin-1
        switch varargin{i}
            case 'color'
                color = varargin{i+1};
            case 'text'
                text_flag = upper(varargin{i+1});
            case 'fontsize'
                m_fontsize = varargin{i+1};
            case 'linewidth'
                m_linewidth = varargin{i+1};
            case 'alpha'
                m_alpha = varargin{i+1};
        end
    end
end

Px = [p0(1)*ones(1,size(T,2));T(1,:)];
Py = [p0(2)*ones(1,size(T,2));T(2,:)];
Pz = [p0(3)*ones(1,size(T,2));T(3,:)];
p = plot3(Px,Py,Pz,'color',color','linewidth',m_linewidth);
hold on
for i = 1:size(Px,2)
    p(i).Color(4) = m_alpha;
end
%%% ���
if text_flag == 'Y'
    for i = 1:size(T,2)
        text(T(1,i),T(2,i),T(3,i),num2str(i),'fontsize',m_fontsize);
    end
end

varargout{1} = fig1;
