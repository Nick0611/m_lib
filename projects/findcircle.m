%%% ����任���Բ�����ĺͰ���
Rmin = 10;
Rmax = 50;
[centersBright, radiiBright] = imfindcircles(d1,[Rmin Rmax],'ObjectPolarity','bright');
[centersDark, radiiDark] = imfindcircles(d1,[Rmin Rmax],'ObjectPolarity','dark');
viscircles(centersBright, radiiBright,'EdgeColor','b');
viscircles(centersDark, radiiDark,'LineStyle','--');