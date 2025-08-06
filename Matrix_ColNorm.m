%% Matrix column vector normalization
% INPUT:
%   A;
% OUTPUT:
%   matrix after column vector's normlization
%%
function [varargout] = Matrix_ColNorm(varargin)
A = varargin{1};
varargout{1} = bsxfun(@rdivide,A,vecnorm(A));
