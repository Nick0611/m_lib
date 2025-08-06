function [E T_noise] = error_foo(Theta, X, sigma, P_inlier)

% [E T_noise] = error_foo(Theta, X, sigma, P_inlier)
%
% DESC:
% Template to estimate the error due to the foo constraint. To return
% just the error threshold the function should be called as:
% [dummy T_noise] = error_foo([], [], sigma, P_inlier);
%
% INPUT:
% Theta             = foo parameter vector
% X                 = samples on the manifold
% sigma             = noise std
% P_inlier          = Chi squared probability threshold for inliers
%                     If 0 then use directly sigma.
%
% OUTPUT:
% E                 = squared error 
% T_noise           = noise threshold


% AUTHOR:
% Marco Zuliani, email: marco.zuliani@gmail.com
% Copyright (C) 2008 by Marco Zuliani 
% 
% LICENSE:
% This toolbox is distributed under the terms of the GNU LGPL.
% Please refer to the files COPYING and COPYING.LESSER for more information.


% compute the error obtained by the orthogonal projection of
% the data points X onto the model manifold instantiated with the
% parameters Theta
E = [];
if ~isempty(Theta) && ~isempty(X)
    
    % error computation
    
end;

% compute the error threshold
if (nargout > 1)
    
    if (P_inlier == 0)
	% in this case the parameter sigma coincides with the noise
	% threshold
        T_noise = sigma;
    else
	% In this case we compute the error threshold given the standard
	% deviation of the noise assuming that the errors are normally 
	% distributed. Hence the sum of their squares is Chi2 distributed 
	% with d degrees of freedom
        d = ;
        
        % compute the inverse probability
        T_noise = sigma^2 * chi2inv_LUT(P_inlier, d);

    end;
    
end;

return;