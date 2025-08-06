function LaTeX = sym2latex(poly)
%SYM2LATEX  ������ʽת��ΪLaTeX��ʽ���
% ����syms������ű�����Ȼ���÷��ű���ȥ������ʽ����Ϊ����

LaTeX = latex(poly);

% ����ͼ��������ʾ�����޹صĲ˵�����
figure;
fig = gcf;
fig.Name = '';
fig.NumberTitle= 'off';
fig.MenuBar = 'None';
fig.Position = [300, 300, 600, 300];
fig.Color = 'w';

% ����ʾ��
ax = gca;
ax.XTick = [];
ax.YTick = [];
ax.XAxis.Visible = 'off';
ax.YAxis.Visible = 'off';

% ���text����
t1 = text(0, .6, ['$$', 'y =', LaTeX,'$$'], 'interpreter', 'latex'); % ע��˴��ı��
t1.FontSize = 20;
t1.Color = 'k';
t1.FontWeight = 'Bold';

end