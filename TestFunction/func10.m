function y = func10(x)
%x should be row vector
y = -20*exp(-0.2*sqrt(1/size(x,2)*sum(x.^2))) - exp(1/size(x,2)*sum(cos(2*pi*x))) + 20 + exp(1);