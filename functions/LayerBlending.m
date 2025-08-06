%%% function out = LayerBlending(bg,mix,mode)
% 实现两张图片类似于PS的图层混合，bg,mix均以double类型输入，计算完毕再将out转为uint8。
% 输入1：第一张图片
% 输入2：第二张图片
% 输入3：模式选择：
% 11 正常
% 21 变暗
% 22 正片叠底
% 23 颜色加深
% 24 线性加深
% 25 深色
% 31 变亮
% 32 滤色
% 33 颜色减淡
% 34 线性减淡
% 35 浅色
% 41 叠加
% 42 柔光
% 43 强光
% 44 亮光
% 45 线性光
% 46 点光
% 47 实色混合
% 51 差值
% 52 排除
% 53 减去
% 54 划分
% 输出：混合后的图片
% 作者：梁振鹍
% 日期：2022-1-10
% 来源：https://blog.csdn.net/xsz591541060/article/details/108004221

function out = LayerBlending(bg,mix,mode)

% 判断尺寸
if ~isequal(size(bg),size(mix))
    message("图像尺寸不相等")
end
if size(bg,3)~=3
    message("图像不是彩色图")
end

% 初始化
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

%%%%%%%%%%%%%%%%%% 1. 组合模式（正常、溶解） %%%%%%%%%%%%%%%%%%%%%%%
% 正常 mix完全覆盖bg
function out = do1_1(bg,mix)
out = mix;
end

%%%%%%%%%%%%%%%%%% 2. 加深混合模式（变暗、正片叠底、颜色加深、线性加深，深色） %%%%%%%%%%%%%%%%%%%%%%%
% 变暗 取各分量最小值
function out = do2_1(bg,mix)
R = min(cat(3,bg(:,:,1),mix(:,:,1)),[],3);
G = min(cat(3,bg(:,:,2),mix(:,:,2)),[],3);
B = min(cat(3,bg(:,:,3),mix(:,:,3)),[],3);
out = cat(3,R,G,B);
end

% 正片叠底 灰度乘积后，调整至0~255范围
function out = do2_2(bg,mix)
out = bg.*mix/255;
end

% 颜色加深
function out = do2_3(bg,mix)
out = bg-(255-bg).*(255-mix)./(mix+0.0001);
end

% 线性加深 减去mix的反色
function out = do2_4(bg,mix)
out = bg+mix-255;
end

% 深色 保留总体亮度更低的点
function out = do2_5(bg,mix)
bgsum = 0.299*bg(:,:,1)+0.587*bg(:,:,2)+0.114*bg(:,:,3);
mixsum = 0.299*mix(:,:,1)+0.587*mix(:,:,2)+0.114*mix(:,:,3);
flag = double(bgsum<mixsum);
out = bg.*flag+mix.*(~flag);
end

%%%%%%%%%%%%%%%%%% 3. 减淡混合模式（变亮、滤色、颜色减淡、线性减淡，浅色） %%%%%%%%%%%%%%%%%%%%%%%
% 变亮 取各分量最大值
function out = do3_1(bg,mix)
R = max(cat(3,bg(:,:,1),mix(:,:,1)),[],3);
G = max(cat(3,bg(:,:,2),mix(:,:,2)),[],3);
B = max(cat(3,bg(:,:,3),mix(:,:,3)),[],3);
out = cat(3,R,G,B);
end

% 滤色
function out = do3_2(bg,mix)
out = 255-(255-bg).*(255-mix)/255;
end

% 颜色减淡根据mix灰度，增加bg的亮度
function out = do3_3(bg,mix)
out = bg+bg.*mix./(255.0001-mix);
end

% 线性减淡 直接累加
function out = do3_4(bg,mix)
out = bg+mix;
end

% 浅色 保留总体亮度更高的点
function out = do3_5(bg,mix)
bgsum = 0.299*bg(:,:,1)+0.587*bg(:,:,2)+0.114*bg(:,:,3);
mixsum = 0.299*mix(:,:,1)+0.587*mix(:,:,2)+0.114*mix(:,:,3);
flag = double(bgsum>mixsum);
out = bg.*flag+mix.*(~flag);
end

%%%%%%%%%%%%%%%%%% 4. 对比混合模式（叠加、柔光、强光、亮光、线性光、点光、实色混合） %%%%%%%%%%%%%%%%%%%%%%%
% 叠加
function out = do4_1(bg,mix)
out = zeros(size(bg));
idx = bg<128;
out(idx) = bg(idx).*mix(idx)/128;
out(~idx) = 255-(255-bg(~idx)).*(255-mix(~idx))/128;
end

% 柔光
function out = do4_2(bg,mix)
out = zeros(size(bg));
idx = bg<128;
out(idx) = bg(idx)+(2*mix(idx)-255).*(bg(idx)/255-(bg(idx)/255).^2);
out(~idx) = bg(~idx)+(2*mix(~idx)-255).*(sqrt(bg(~idx)/255)-bg(~idx)/255);
end

% 强光
function out = do4_3(bg,mix)
out = zeros(size(bg));
idx = bg<128;
out(idx) = 255-(255-bg(idx)).*(255-mix(idx))/128;
out(~idx) = bg(~idx).*mix(~idx)/128;
end

% 亮光
function out = do4_4(bg,mix)
out = zeros(size(bg));
idx = bg<128;
out(idx) = 255-(255-mix(idx))./(2*bg(idx)+0.0001)*255;
out(~idx) = mix(~idx)./(2*(255-bg(~idx))+0.0001)*255;
end

% 线性光：线性加深+线性减淡
function out = do4_5(bg,mix)
out = bg+mix*2-255;
end

% 点光 以mix为标准，将bg太亮的调暗，太暗的调亮
function out = do4_6(bg,mix)
out = bg;
idx1 = bg<2*mix-255;
idx2 = bg>2*mix;
out(idx1) = 2*mix(idx1)-255;
out(idx2) = 2*mix(idx2);
end

% 实色混合 各通道根据累加和进行二值化
function out = do4_7(bg,mix)
out = double((bg+mix)>=255)*255;
end

%%%%%%%%%%%%%%%%%% 5. 比较混合模式（差值、排除、减去、划分） %%%%%%%%%%%%%%%%%%%%%%%
% 差值 两图的绝对差值
function out = do5_1(bg,mix)
out = abs(bg-mix);
end

% 排除
function out = do5_2(bg,mix)
out = bg+mix-bg.*mix/128;
end

% 减去 直接减去mix，负数取0
function out = do5_3(bg,mix)
out = bg-mix;
end

% 划分 根据mix的值，调亮bg
function out = do5_4(bg,mix)
out = bg./(mix+0.0001)*255;
end

%%%%%%%%%%%%%%%%%% 6. 色彩混合模式（色相、饱和度、颜色、亮度） %%%%%%%%%%%%%%%%%%%%%%%

end
