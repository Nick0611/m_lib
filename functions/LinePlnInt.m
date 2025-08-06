% nP：平面的法向量
% pP：平面的参考点
% nL：直线的方向向量
% nL：直线的参考点
% l：交点到参考点的长度
function l = LinePlnInt(conf,nP,pP,varargin)
if conf==13
    u = varargin{1};
    pL = varargin{2};
    if isequal(nP,u)
        l = NaN;
    else
        l = (nP'*(pP-pL))/(nP'*nL);
    end
else
    nL = varargin{1};
    pL = varargin{2};
    if nP'*nL==0
        l = NaN;
    else
        l = (nP'*(pP-pL))/(nP'*nL);
    end
end