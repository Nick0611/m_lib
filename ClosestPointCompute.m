function [coresp]=ClosestPointCompute(source,target)
% find the corresponding point set for Data from target model;
% 作者 陈坤勇
% 程序获得时间 2021-06-23
% input: target is Nby3 point set
% source is Nby3 point set
% output:coresp is the corresponding closet point set of source set in the target set. 
source=source';target=target';
 m = size(target,2);
    n = size(source,2);    
    match = zeros(1,m);
    mindist = zeros(1,m);
    for ki=1:m
        d=zeros(1,n);
        for ti=1:3
            d=d+(source(ti,:)-target(ti,ki)).^2;
        end
        
        [mindist(ki),match(ki)]=min(d);
    end
   
% mindist = sqrt(mindist);
coresp=source(:,match)';


