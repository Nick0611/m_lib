function [s, Theta_hat] = get_minimal_sample_set(k, X, P_s, est_fun, ind_tabu)

% [s, Theta_hat] = get_minimal_sample_set(k, X, P_s, est_fun, ind_tabu)
%
% DESC:
% select the minimal sample set using different sampling strategies
%
% VERSION:
% 1.0.2
%
% INPUT:
% k                 = minimal sample set cardinality
% X                 = input data
% P_s               = sampling probabilities
% est_fun           = function that estimates Theta. Should be in the form of:
%
%                     Theta = est_fun(X)
%
% ind_tabu          = indices of elements excluded from the sample set
%
% OUTPUT:
% s                 = minimal sample set
% Theta_hat         = estimated parameter vector on s


% AUTHOR:
% Marco Zuliani, email: marco.zuliani@gmail.com
% Copyright (C) 2008 by Marco Zuliani 
% 
% LICENSE:
% This toolbox is distributed under the terms of the GNU LGPL.
% Please refer to the files COPYING and COPYING.LESSER for more information.


% HISTORY:
%
% 1.0.0             - ??/??/05 - Initial version
% 1.0.1             - ??/??/05 - Added probabilistic sampling
% 1.0.2             - 06/25/08 - Handles seed of the random number
%                     generator

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Check input parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin < 3
    P_s = [];
end

if nargin < 4
    est_fun = [];
end

if nargin < 5
    ind_tabu = [];
end

N = size(X, 2);

% remove tabu elements
if ~isempty(ind_tabu)
    ind = setdiff(1:N, ind_tabu);
else
    ind = 1:N;
end;
NN = length(ind);

% get the seed for the random number generator
global RANSAC_TWISTER_STATE_UPDATED;

% if we have an estimation function then loop until the MSS actually
% produces an estimate
while true

    % update the seed
    if ~isempty(RANSAC_TWISTER_STATE_UPDATED)
        RANSAC_TWISTER_STATE_UPDATED = RANSAC_TWISTER_STATE_UPDATED + 1;
    end;

    % uniform sampling
    if isempty(P_s)
        % uniform sampling
        mask = get_rand(k, NN, RANSAC_TWISTER_STATE_UPDATED);
    else
        % probabilistic sampling
        mask = get_rand_prob(k, P_s(ind), RANSAC_TWISTER_STATE_UPDATED);
    end;

    s = ind(mask);
        
    % check if we are done
    if isempty(est_fun)
        Theta_hat = [];
        break;
    end;
    
    % estimate the parameter and the residual error
    Theta_hat = feval(est_fun, X, s);

    % verify that the estimation produced something
    if ~isempty(Theta_hat)
        break;
    end;

end;

return