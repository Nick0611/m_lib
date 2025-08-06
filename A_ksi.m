%% A_ksi Matrix in Lie Group derivation
% omi is the adjoint representation of twist coordinates;
% the denotes its magnitude;
%%
function [varargout] = A_ksi(varargin)
% if isempty(varargin) || length(varargin) > 2
if nargin == 0 || nargin > 2
    fprintf("     A_ksi:\n");
    fprintf("        Wrong Input!\n");
    return;
else
    if size(varargin{1},1) == 1
        if size(varargin{2},1) == 6 && size(varargin{2},2) == 6
            the = varargin{1};
            omi = varargin{2};
        else
            fprintf("   Wrong omi Matrix dimension!\n");
            return;
        end
    else
        if size(varargin{1},1) == 6 && size(varargin{1},2) == 6
            the = varargin{2};
            omi = varargin{1};
        else
            fprintf("   Wrong omi Matrix dimension!\n");
            return;
        end
    end
end

A = eye(6) + ...
    (4-the*sin(the)-4*cos(the))/(2*the^2)*omi + ...
    (4*the-5*sin(the)+the*cos(the))/(2*the^3)*omi^2 + ...
    (2-the*sin(the)-2*cos(the))/(2*the^4)*omi^3 + ...
    (2*the-3*sin(the)+the*cos(the))/(2*the^5)*omi^4;

varargout{1} = A;
