function y = func7(x)
%x should be row vector
y = 0;
for i =1:size(x,2)
    y = y + i*x(i)^4 + rand(1);
end