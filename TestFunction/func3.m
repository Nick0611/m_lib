function y = func3(x)
%x should be row vector
y = 0;
for i = 1:size(x,2)
    y = y + sum(x(1:i))^2;
end