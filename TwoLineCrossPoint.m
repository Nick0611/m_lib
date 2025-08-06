%%% ������ֱ���������
% Date 2021-06-22
% Note ������
function P = TwoLineCrossPoint(p1,p2,q1,q2)
s1=p2-p1;%��������
s2=q2-q1;
res1=((s1*s2')*((p1-q1)*s2')-(s2*s2')*((p1-q1)*s1'))/((s1*s1')*(s2*s2')-(s1*s2')*(s1*s2'));     %lamta1
res2=-((s1*s2')*((p1-q1)*s1')-(s1*s1')*((p1-q1)*s2'))/((s1*s1')*(s2*s2')-(s1*s2')*(s1*s2'));    %lamta2
if(res1<=1&&res1>=0&&res2<=1&&res2>=0)  %����������㶼������ֱ�߶��ϣ���lamta���룬�ɵõ������������꣬���䳤�ȼ���
    tmp1=p1+res1*s1;
    tmp2=q1+res2*s2;
    tmp=tmp1-tmp2;
    d=sqrt(tmp*tmp');
else
    res3=(q1-p1)*s1'/(s1*s1');           %����д��㲻�����߶��ϣ���Ҫ������һ���жϣ��ֱ���������߶ε��ĸ�����㣬������һ���߶εĳ���
    if (res3>=0&&res3<=1)                %q1�㵽p1p2�߶εľ��룬ͬ������lamta,�����0~1��ʾ�������߶��ϣ�������ֵ
         tmp=q1-(p1+res3*s1);
         d1=sqrt(tmp*tmp');
    else
         d1=sqrt(min((q1-p1)*(q1-p1)',(q1-p2)*(q1-p2)'));%������㲻���߶��ϣ�ֱ���жϵ��������˵���߶γ��ȼ��ɣ�ȡ��С
    end
    res4=(q2-p1)*s1'/(s1*s1');           %q2���߶�p1p2����
    if (res4>=0&&res4<=1)
        tmp=q2-(p1+res4*s1);
        d2=sqrt(tmp*tmp');
    else
        d2=sqrt(min((q2-p1)*(q2-p1)',(q2-p2)*(q2-p2)'));
    end

    res5=(p1-q1)*s2'/(s2*s2');            %p1���߶�q1q2����
   if (res5>=0&&res5<=1)
        tmp=p1-(q1+res5*s2);
        d3=sqrt(tmp*tmp');
   else
        d3=sqrt(min((p1-q1)*(p1-q1)',(p1-q2)*(p1-q2)'));
   end

   res6=(p2-q1)*s2'/(s2*s2');            %p2���߶�q1q2����
   if (res6>=0&&res6<=1)
       tmp=p2-(q1+res6*s2);
       d4=sqrt(tmp*tmp');
   else
       d4=sqrt(min((p2-q1)*(p2-q1)',(p2-q2)*(p2-q2)'));
   end
   d=min(min(d1,d2),min(d3,d4));%ȡ�ĸ���̵�һ������
end
