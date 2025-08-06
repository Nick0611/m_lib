function y = func5(x)
%x should be row vector
N = size(x,2);
if N<2
    error('error: size of x should be larger than 2');
end
y = 0;
for i = 1:N-1
    y = y + 100*(x(i+1)-x(i)^2)^2 + (x(i)-1)^2;
end