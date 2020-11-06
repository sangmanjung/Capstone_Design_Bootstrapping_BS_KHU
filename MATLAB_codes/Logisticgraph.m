theta=[17.5 0.7 0.1];
t=linspace(0,25,50);
n=length(t);
y=LogisticModel(theta,t);
plot(t,y,'r')
title('Logistic Curve with K=17.5, r=0.7 and x_0=0.1')
xlabel('Time')
ylabel('Model')
grid on
