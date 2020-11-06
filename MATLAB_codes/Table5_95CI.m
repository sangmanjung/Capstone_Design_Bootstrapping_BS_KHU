%%%Table 5. 95%CI difference%%%

clear all
clc

s=linspace(0,25,1001);
subplot(1,2,1);
scatter(s',theta1(:,1),'b.'); xlim([0 25]); ylim([16.9 18.1]);
hold on
line([0 25],[17.053121 17.053121],'Color','red','LineStyle','--')
line([0 25],[18.000990 18.000990],'Color','red','LineStyle','--')
xlabel('Time');
ylabel('K_{boot}');
title('n=50 in Table 5');
subplot(1,2,2);
scatter(s',theta1(:,1),'b.'); xlim([0 25]); ylim([16.9 18.1])
line([0 25],[17.401983 17.401983],'Color','red','LineStyle','--')
line([0 25],[17.627816 17.627816],'Color','red','LineStyle','--')
xlabel('Time');
ylabel('K_{boot}');
title('n=1000 in Table 5');
legend('K_{boot}','95%CI');
hold off