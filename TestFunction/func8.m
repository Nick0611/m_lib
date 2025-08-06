function y = func8(x)
%x should be row vector
y = -sum(x.*sin(sqrt(abs(x))));