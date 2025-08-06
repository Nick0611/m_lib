function [Theta, k] = estimate_line(X, s)

% [Theta k] = estimate_line(X)
%
% DESC:
% estimate the parameters of a 2D line given the pairs [x, y]^T
% Theta = [a; b; c] where a*x+b*yc = 0
%
% VERSION:
% 1.0.0
%
% INPUT:
% X                 = 2D points 
% s                 = indices of the points used to estimate the parameter
%                     vector. If empty all the points are used
%
% OUTPUT:
% Theta             = estimated parameter vector Theta = [a; b; c]
% k                 = dimension of the minimal subset


% AUTHOR:
% Marco Zuliani, email: marco.zuliani@gmail.com
% Copyright (C) 2008 by Marco Zuliani 
% 
% LICENSE:
% This toolbox is distributed under the terms of the GNU LGPL.
% Please refer to the files COPYING and COPYING.LESSER for more information.


% HISTORY:
% 1.0.0             = 01/26/08 - initial version

% cardinality of the MSS
k = 2;

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
    error('At least 2 points are required');
end;

A = [transpose(X(1, :)) transpose(X(2, :)) ones(N, 1)];
[U S V] = svd(A);
Theta = V(:, 3);

return;