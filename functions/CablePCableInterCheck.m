% function y = CablePCableInterCheck(varargin)
% 功能：判断绳索之间是否发生干涉【单个构型下；相邻两个构型之间】
% 输入模式1：RelaTopo_last，RelaUpDown_last，分别是当前构型的交叉关系矩阵和位置关系矩阵
% 输入模式2：RelaTopo_last，RelaUpDown_last，RelaTopo_now，RelaUpDown_now，分别是上个构型的交叉关系矩阵和位置关系矩阵，
% 以及当前构型的交叉关系矩阵和位置关系矩阵
% 输出：0：存在干涉；1：不存在干涉
% 作者：Zachary Liang
% 时间：2024-6-12
% revision2024-6-16增加交叉关系为0的进一步判断，分两种情况，一种是自身和自身，一种是两个绳子。判断方式是：上一个位置状态时1，当前位置状态时0，则为干涉。
% revision2024-6-26增加varargout{2} = [];
% revision-2024-7-10 增加了共面交叉的判断 if any(RelaUpDown_now(idx) == 0)
function varargout = CablePCableInterCheck(varargin)
if nargin == 2
    RelaTopo_last = varargin{1};
    RelaUpDown_last = varargin{2};
    idx = find(RelaTopo_last==4);
    if any(RelaUpDown_last(idx) == 0) % 两绳索共面交叉
        varargout{1} = 0;
        tmp = RelaUpDown_last;
        mask = true(size(tmp));
        mask(idx) = false; % 做一个模板把非4的未知状态抹掉，因为交叉关系为4才需要进一步判断位置关系
        tmp(mask) = 100;
        [row,col] = find(tmp==0);
        varargout{2} = [row,col]; % 把干涉的绳索序号拿到
        return;
    end
    varargout{1} = 1;
    varargout{2} = [];
end
if nargin == 4
    RelaTopo_last = varargin{1};
    RelaUpDown_last = varargin{2};
    RelaTopo_now = varargin{3};
    RelaUpDown_now = varargin{4};
    idx = find(RelaTopo_last==0 & RelaTopo_now==0);
    tmp_now = RelaUpDown_now;
    tmp_last = RelaUpDown_last;
    mask = true(size(tmp_last));
    mask(idx) = false; % 做一个模板把非0的未知状态抹掉，因为交叉关系为0才需要进一步判断位置关系
    tmp_now(mask) = 100;
    tmp_last(mask) = 100;
    if any(RelaUpDown_now(idx) == 0 & RelaUpDown_last(idx) == 1)% 交叉状态为0时，上一个位置状态时1，当前位置状态时0，则为干涉
        varargout{1} = 0;
        [row,col] = find(tmp_now==0 & tmp_last==1);
        varargout{2} = [row,col]; % 把干涉的绳索序号拿到
        return;
    end
    idx = find(RelaTopo_last==4 & RelaTopo_now==4);
    tmp_now = RelaUpDown_now;
    tmp_last = RelaUpDown_last;
    mask = true(size(tmp_last));
    mask(idx) = false; % 做一个模板把非4的未知状态抹掉，因为交叉关系为4才需要进一步判断位置关系
    tmp_now(mask) = 100;
    tmp_last(mask) = 100;
    aa=0;
    if any(RelaUpDown_now(idx) == 0) % 两绳索共面交叉
        varargout{1} = 0;
        [row,col] = find(tmp_now==0);
        varargout{2} = [row,col]; % 把干涉的绳索序号拿到
        aa=1;
    end
    if ~all(RelaUpDown_last(idx) == RelaUpDown_now(idx)) % 两绳索运动前后发生了交叉
        varargout{1} = 0;
        [row,col] = find(tmp_now-tmp_last);
        if aa
            varargout{2} = [varargout{2};[row,col]];
        else
            varargout{2} = [row,col]; % 把干涉的绳索序号拿到
        end
        return;
    end
    if aa
        return;
    end
    varargout{1} = 1;
    varargout{2} = [];
end

