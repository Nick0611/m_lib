function [E T_noise] = error_line(Theta, X, sigma, P_inlier)

% [E T_noise] = error_line(Theta, X, sigma, P_inlier)
%
% DESC:
% estimate the squared fitting error for a line expresed in cartesian form
% ax + by + c =0
%
% VERSION:
% 1.0.0
%
% INPUT:
% Theta             = line parameter vector
% X                 = samples on the manifold
% sigma             = noise std
% P_inlier          = Chi squared probability threshold for inliers
%                     If 0 then use directly sigma.
%
% OUTPUT:
% E                 = squared symmetric reprojection error 
% T_noise           = noise threshold


% AUTHOR:
% Marco Zuliani, email: marco.zuliani@gmail.com
% Copyright (C) 2008 by Marco Zuliani 
% 
% LICENSE:
% This toolbox is distributed under the terms of the GNU LGPL.
% Please refer to the files COPYING and COPYING.LESSER for more information.


% HISTORY
%
% 1.0.0             - 01/26/08 initial version

% compute the squared error
E = [];
if ~isempty(Theta) && ~isempty(X)
    
    den = Theta(1)^2 + Theta(2)^2;
    
    E = ( Theta(1)*X(1,:) + Theta(2)*X(2,:) + Theta(3) ).^2 / den;
                
end;

% compute the error threshold
if (nargout > 1)
    
    if (P_inlier == 0)
        T_noise = sigma;
    else
        % Assumes the errors are normally distributed. Hence the sum of
        % their squares is Chi distributed (with 2 DOF since we are 
        % computing the distance of a 2D point to a line)
        
        % compute the inverse probability
        T_noise = sigma^2 * chi2inv_LUT(P_inlier, 2);

    end;
    
end;

return;