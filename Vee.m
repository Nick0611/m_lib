function y=Vee(x)
N=length(x);   
if N==3
    x=0.5*(x-x');
    x1=-x(2,3); 
    x2= x(1,3);
    x3=-x(1,2);
    y=[x1;x2;x3];
else
    x0=x(1:3,1:3);
    x0=0.5*(x0-x0');
    x1=-x0(2,3);
    x2= x0(1,3);
    x3=-x0(1,2);
    x4= x(1,4); 
    x5= x(2,4);
    x6= x(3,4);
    y=[x1;x2;x3;x4;x5;x6];
end