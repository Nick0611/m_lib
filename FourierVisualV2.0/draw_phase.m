function draw_phase(m,f,phase)
% ��λ�׻���
% f - Ƶ��
% ppy - ��ֵ��Ϣ
% phase - ��λ��Ϣ
h=stem(f(1,1:m+1),phase(1,1:m+1)*180/pi,'color',[123/255,159/255,47/255]);
set(h,'LineWidth',3*get(h,'LineWidth'));
axis([0,m+1,min(phase(1,1:m+1)*180/pi)-15,max(phase(1,1:m+1)*180/pi)+15])
title('��ɢ��λ�ף�����ͼ��');
xlabel('Ƶ��Χf');
ylabel('��λ�ǣ���λ���㣩');
grid on
end
