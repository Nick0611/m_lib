%%% function out = LayerBlending(bg,mix,mode)
% ʵ������ͼƬ������PS��ͼ���ϣ�bg,mix����double�������룬��������ٽ�outתΪuint8��
% ����1����һ��ͼƬ
% ����2���ڶ���ͼƬ
% ����3��ģʽѡ��
% 11 ����
% 21 �䰵
% 22 ��Ƭ����
% 23 ��ɫ����
% 24 ���Լ���
% 25 ��ɫ
% 31 ����
% 32 ��ɫ
% 33 ��ɫ����
% 34 ���Լ���
% 35 ǳɫ
% 41 ����
% 42 ���
% 43 ǿ��
% 44 ����
% 45 ���Թ�
% 46 ���
% 47 ʵɫ���
% 51 ��ֵ
% 52 �ų�
% 53 ��ȥ
% 54 ����
% �������Ϻ��ͼƬ
% ���ߣ������d
% ���ڣ�2022-1-10
% ��Դ��https://blog.csdn.net/xsz591541060/article/details/108004221

function out = LayerBlending(bg,mix,mode)

% �жϳߴ�
if ~isequal(size(bg),size(mix))
    message("ͼ��ߴ粻���")
end
if size(bg,3)~=3
    message("ͼ���ǲ�ɫͼ")
end

% ��ʼ��
bg = double(bg);
mix = double(mix);
switch mode
    case 11
        out = do1_1(bg,mix);
    case 12
        out = do1_2(bg,mix);
    case 21
        out = do2_1(bg,mix);
    case 22
        out = do2_2(bg,mix);
    case 23
        out = do2_3(bg,mix);
    case 24
        out = do2_4(bg,mix);
    case 25
        out = do2_5(bg,mix);
    case 31
        out = do3_1(bg,mix);
    case 32
        out = do3_2(bg,mix);
    case 33
        out = do3_3(bg,mix);
    case 34
        out = do3_4(bg,mix);
    case 35
        out = do3_5(bg,mix);
    case 41
        out = do4_1(bg,mix);
    case 42
        out = do4_2(bg,mix);
    case 43
        out = do4_3(bg,mix);
    case 44
        out = do4_4(bg,mix);
    case 45
        out = do4_5(bg,mix);
    case 46
        out = do4_6(bg,mix);
    case 47
        out = do4_7(bg,mix);
    case 51
        out = do5_1(bg,mix);
    case 52
        out = do5_2(bg,mix);
    case 53
        out = do5_3(bg,mix);
    case 54
        out = do5_4(bg,mix);
    case 61
        out = do6_1(bg,mix);
    case 62
        out = do6_2(bg,mix);
    case 63
        out = do6_3(bg,mix);
    case 64
        out = do6_4(bg,mix);
end

out = uint8(out);

%%%%%%%%%%%%%%%%%% 1. ���ģʽ���������ܽ⣩ %%%%%%%%%%%%%%%%%%%%%%%
% ���� mix��ȫ����bg
function out = do1_1(bg,mix)
out = mix;
end

%%%%%%%%%%%%%%%%%% 2. ������ģʽ���䰵����Ƭ���ס���ɫ������Լ����ɫ�� %%%%%%%%%%%%%%%%%%%%%%%
% �䰵 ȡ��������Сֵ
function out = do2_1(bg,mix)
R = min(cat(3,bg(:,:,1),mix(:,:,1)),[],3);
G = min(cat(3,bg(:,:,2),mix(:,:,2)),[],3);
B = min(cat(3,bg(:,:,3),mix(:,:,3)),[],3);
out = cat(3,R,G,B);
end

% ��Ƭ���� �Ҷȳ˻��󣬵�����0~255��Χ
function out = do2_2(bg,mix)
out = bg.*mix/255;
end

% ��ɫ����
function out = do2_3(bg,mix)
out = bg-(255-bg).*(255-mix)./(mix+0.0001);
end

% ���Լ��� ��ȥmix�ķ�ɫ
function out = do2_4(bg,mix)
out = bg+mix-255;
end

% ��ɫ �����������ȸ��͵ĵ�
function out = do2_5(bg,mix)
bgsum = 0.299*bg(:,:,1)+0.587*bg(:,:,2)+0.114*bg(:,:,3);
mixsum = 0.299*mix(:,:,1)+0.587*mix(:,:,2)+0.114*mix(:,:,3);
flag = double(bgsum<mixsum);
out = bg.*flag+mix.*(~flag);
end

%%%%%%%%%%%%%%%%%% 3. �������ģʽ����������ɫ����ɫ���������Լ�����ǳɫ�� %%%%%%%%%%%%%%%%%%%%%%%
% ���� ȡ���������ֵ
function out = do3_1(bg,mix)
R = max(cat(3,bg(:,:,1),mix(:,:,1)),[],3);
G = max(cat(3,bg(:,:,2),mix(:,:,2)),[],3);
B = max(cat(3,bg(:,:,3),mix(:,:,3)),[],3);
out = cat(3,R,G,B);
end

% ��ɫ
function out = do3_2(bg,mix)
out = 255-(255-bg).*(255-mix)/255;
end

% ��ɫ��������mix�Ҷȣ�����bg������
function out = do3_3(bg,mix)
out = bg+bg.*mix./(255.0001-mix);
end

% ���Լ��� ֱ���ۼ�
function out = do3_4(bg,mix)
out = bg+mix;
end

% ǳɫ �����������ȸ��ߵĵ�
function out = do3_5(bg,mix)
bgsum = 0.299*bg(:,:,1)+0.587*bg(:,:,2)+0.114*bg(:,:,3);
mixsum = 0.299*mix(:,:,1)+0.587*mix(:,:,2)+0.114*mix(:,:,3);
flag = double(bgsum>mixsum);
out = bg.*flag+mix.*(~flag);
end

%%%%%%%%%%%%%%%%%% 4. �ԱȻ��ģʽ�����ӡ���⡢ǿ�⡢���⡢���Թ⡢��⡢ʵɫ��ϣ� %%%%%%%%%%%%%%%%%%%%%%%
% ����
function out = do4_1(bg,mix)
out = zeros(size(bg));
idx = bg<128;
out(idx) = bg(idx).*mix(idx)/128;
out(~idx) = 255-(255-bg(~idx)).*(255-mix(~idx))/128;
end

% ���
function out = do4_2(bg,mix)
out = zeros(size(bg));
idx = bg<128;
out(idx) = bg(idx)+(2*mix(idx)-255).*(bg(idx)/255-(bg(idx)/255).^2);
out(~idx) = bg(~idx)+(2*mix(~idx)-255).*(sqrt(bg(~idx)/255)-bg(~idx)/255);
end

% ǿ��
function out = do4_3(bg,mix)
out = zeros(size(bg));
idx = bg<128;
out(idx) = 255-(255-bg(idx)).*(255-mix(idx))/128;
out(~idx) = bg(~idx).*mix(~idx)/128;
end

% ����
function out = do4_4(bg,mix)
out = zeros(size(bg));
idx = bg<128;
out(idx) = 255-(255-mix(idx))./(2*bg(idx)+0.0001)*255;
out(~idx) = mix(~idx)./(2*(255-bg(~idx))+0.0001)*255;
end

% ���Թ⣺���Լ���+���Լ���
function out = do4_5(bg,mix)
out = bg+mix*2-255;
end

% ��� ��mixΪ��׼����bg̫���ĵ�����̫���ĵ���
function out = do4_6(bg,mix)
out = bg;
idx1 = bg<2*mix-255;
idx2 = bg>2*mix;
out(idx1) = 2*mix(idx1)-255;
out(idx2) = 2*mix(idx2);
end

% ʵɫ��� ��ͨ�������ۼӺͽ��ж�ֵ��
function out = do4_7(bg,mix)
out = double((bg+mix)>=255)*255;
end

%%%%%%%%%%%%%%%%%% 5. �Ƚϻ��ģʽ����ֵ���ų�����ȥ�����֣� %%%%%%%%%%%%%%%%%%%%%%%
% ��ֵ ��ͼ�ľ��Բ�ֵ
function out = do5_1(bg,mix)
out = abs(bg-mix);
end

% �ų�
function out = do5_2(bg,mix)
out = bg+mix-bg.*mix/128;
end

% ��ȥ ֱ�Ӽ�ȥmix������ȡ0
function out = do5_3(bg,mix)
out = bg-mix;
end

% ���� ����mix��ֵ������bg
function out = do5_4(bg,mix)
out = bg./(mix+0.0001)*255;
end

%%%%%%%%%%%%%%%%%% 6. ɫ�ʻ��ģʽ��ɫ�ࡢ���Ͷȡ���ɫ�����ȣ� %%%%%%%%%%%%%%%%%%%%%%%

end
