function [H A] = HomographyDLT(X1, X2, mode, normalization)

% [H A] = HomographyDLT(X1, X2, mode)
%
% DESC:
% computes the homography between the point pairs X1, X2
%
% VERSION:
% 1.0.0
%
% INPUT:
% X1, X2        = point matches (cartesian coordinates)
% mode          = 0 -> Hartley Zisserman formulation
%                 1 -> Zuliani formulation (default)
% normalization = true (default) or false to enable/disable point 
%                 normalzation
%
% OUTPUT:
% H             = homography
% A             = homogenous linear system matrix 


% AUTHOR:
% Marco Zuliani, email: marco.zuliani@gmail.com
% Copyright (C) 2008 by Marco Zuliani 
% 
% LICENSE:
% This toolbox is distributed under the terms of the GNU LGPL.
% Please refer to the files COPYING and COPYING.LESSER for more information.


if (nargin < 3)
    mode = 'MZ';
end;

if (nargin < 4)
    normalization = true;
end;

N = size(X1, 2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% checks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (size(X2, 2) ~= N)
    error('The set of input points should have the same cardinality')
end;
if N < 4
    error('At least 4 point correspondences are needed')
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% normalize the input
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if normalization
    % fprintf('\nNormalizing...')
    [X1, T1] = normalize_points(X1);
    [X2, T2] = normalize_points(X2);
end;

% compute h
switch mode
    case 'HZ'
    A = get_A_HZ(X1, X2);
    case 'MZ'
    A = get_A_MZ(X1, X2);        
end;
[U S V] = svd(A);
h = V(:, 9);
    
% reshape the output
switch mode
    case 'HZ'
    H = [h(1:3)'; h(4:6)'; h(7:9)'];
    case 'MZ'
    H = reshape(h, 3, 3);
end;

% and denormalize
if normalization
    H = inv(T2)*H*T1;
end;

return

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matrix construction routine
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Hartley Zisserman formulation
function A = get_A_HZ(X1, X2)

X1 = cart2homo(X1);
X2 = cart2homo(X2);

N = size(X1, 2);

A = zeros(2*N, 9);
zero = [0; 0; 0];

row = 1;
for h = 1:N        
    
    a = X2(3,h)*X1(:,h)';
    b = X2(2,h)*X1(:,h)';
    c = X2(1,h)*X1(:,h)';
    A(row, :) = [zero' -a b];
    A(row+1, :) = [a zero' -c];
    
    row = row + 2;
    
end;

% Zuliani's formulation
function A = get_A_MZ(X1, X2)

N = size(X1, 2);

A = zeros(2*N, 9);

row = 1;
for h = 1:N        
    
    A(row, :)   = [X1(1,h) 0 -X1(1,h)*X2(1,h) X1(2,h) 0 -X1(2,h)*X2(1,h) 1 0 -X2(1,h)];
    A(row+1, :) = [0 X1(1,h) -X1(1,h)*X2(2,h) 0 X1(2,h) -X1(2,h)*X2(2,h) 0 1 -X2(2,h)];
    
    row = row + 2;
    
end;

return