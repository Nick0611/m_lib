function [Theta, k] = estimate_homography(X, s)

% [Theta k] = estimate_homography(X, s)
%
% DESC:
% estimate the parameters of an homography homography using the normalized
% DLT algorithm. Note that Theta = H(:)
%
% VERSION:
% 1.0.0
%
% INPUT:
% X                 = 2D point correspondences
% s                 = indices of the points used to estimate the parameter
%                     vector. If empty all the points are used
%
% OUTPUT:
% Theta             = estimated parameter vector Theta = H(:)
% k                 = dimension of the minimal subset


% AUTHOR:
% Marco Zuliani, email: marco.zuliani@gmail.com
% Copyright (C) 2008 by Marco Zuliani 
% 
% LICENSE:
% This toolbox is distributed under the terms of the GNU LGPL.
% Please refer to the files COPYING and COPYING.LESSER for more information.


% HISTORY:
% 1.0.0             = ??/??/05 - initial version

% cardinality of the MSS
k = 4;

if (nargin == 0) || isempty(X)
    Theta = [];
    return;
end;

if (nargin == 2) || ~isempty(s)
    X = X(:, s);
end;
    
% check if we have enough points
N = size(X, 2);
if (N < k)
    error('At least 4 point correspondences are required');
end;

H = HomographyDLT(X(1:2, :), X(3:4, :));
Theta = H(:);

return;