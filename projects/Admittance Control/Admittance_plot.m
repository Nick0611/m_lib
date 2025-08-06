%% ø… ”ªØ
figure(1)
subplot(3,1,1);plot(t,x0(:,1),t,xp(:,1));
ylabel('{\itx} (m)');title('\bf Admittance Control');set(gca,'FontName','Times New Roman','FontSize',12)
subplot(3,1,2);plot(t,F);
ylabel('F (N)');hold on;set(gca,'FontName','Times New Roman','FontSize',12)
subplot(3,1,3);xref = xd(:,1) - x0(:,1);plot(t,xref,'r');
xlabel('{\itt} (s)');ylabel('{\itx_r_e_f} (m)');set(gca,'FontName','Times New Roman','FontSize',12)