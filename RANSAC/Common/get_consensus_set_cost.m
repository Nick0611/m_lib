function J = get_consensus_set_cost(E, T_noise_squared, mode)

% J = get_consensus_set_cost(E, T_noise_squared, mode)
%
% DESC:
% get the cost of a consensus set given the error E (MSAC formulation)
%
% VERSION:
% 1.0.1
%
% INPUT:
% E                 = error associated to each data element
% T_noise_squared   = noise threshold
% mode              = specify the M-estimator
%                     0 -> Torr & Zissermann (default)
%                     1 -> Huber
%
% OUTPUT:
% J                 = consensus set cost


% AUTHOR:
% Marco Zuliani, email: marco.zuliani@gmail.com
% Copyright (C) 2008 by Marco Zuliani 
% 
% LICENSE:
% This toolbox is distributed under the terms of the GNU LGPL.
% Please refer to the files COPYING and COPYING.LESSER for more information.


% HISTORY:
%
% 1.0.0             - 01/13/08 - Initial version
% 1.0.1             - 01/17/08 - Added different M-estimators

if nargin < 3
    mode = 0;
end;

% Using a re-descending M-estimator the inliers are scored according to their
% fitness to the model while the outilers are still given a constant weight
ind = E <= T_noise_squared;

switch mode

    case 0

        % Torr
        N = length(E);
        rho = T_noise_squared * ones(1, N);
        rho(ind) = E(ind);
        
    case 1
        
        % Huber
        T_noise = sqrt(T_noise_squared);
        N = length(E);
        rho = zeros(1, N);
        rho(ind) = 0.5*E(ind);
        rho(~ind) = T_noise*(sqrt(E(~ind)) - 0.5*T_noise);
        
    otherwise
        
        error('Unknown M-estimator')
        
end

J = sum( rho ) / sum(ind);


return