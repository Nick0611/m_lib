function y=Wed(x)
N=length(x);
if N==3
    x1=x(1); 
    x2=x(2);
    x3=x(3);
    y=[0,-x3,x2;...
       x3,0,-x1;...
       -x2,x1,0];
else
    x1=x(1); 
    x2=x(2);
    x3=x(3);
    y1=[  0,-x3, x2;...
         x3,  0,-x1;...
        -x2, x1,  0];
    y=zeros(4);
    y(1:3,1:3)=y1;
    y(1:3,4)=x(4:6);
end

    
    
