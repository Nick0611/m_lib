%% EXCEL�к���ĸ��ʽ��������ʽת��
% mode1 Ϊ��ĸ��ʽת��Ϊ������ʽ
%   ������ĸ
% mode2 Ϊ������ʽת��Ϊ��ĸ��ʽ(��ʮ������)
%   �������֣�mode2
%%
function [varargout] = num2col(varargin)
if isempty(varargin)
    fprintf("       Empty Input!\n")
    return
end
if nargin > 2
    fprintf("       Wrong Input!\n")
    return
end
if nargin == 1
    mode = 1;
end
if nargin > 1
    in = varargin{2};
    if in == 'mode1'
        mode = 1;
    else if in == 'mode2'
            mode = 2;
        else
            fprintf("       Please select a mode!\n")
            return
        end
    end
end

if mode == 2
    n = varargin{1};
    r = 26;
    col = [];
    while n>0
        t = mod(n,r);
        n = floor((n-1)/r);
        if t == 0
            t = 26;
        end
        letter = char('A'+t-1);
        col = strcat(letter,col);
    end
    varargout{1} = col;
end

if mode == 1
    sum = 0;
    str = upper(varargin{1});
    for i = 1:26
        alphabet{i} = char('A'+i-1);
    end
    [C,matches] = strsplit(str,alphabet,'CollapseDelimiters',false);
    for i = 1:size(matches,2)
        num(i) = str2num(int2str(matches{i}))+1;
        sum = sum+(num(i)-str2num(int2str('A')))*26^(size(matches,2)-i);
    end
    varargout{1} = sum;
end
