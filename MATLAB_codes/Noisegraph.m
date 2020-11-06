clear all
clc

t=linspace(0,25,50);                       % time variable
theta=[17 0.6 0.1];                   % initial value of theta
theta_0=[17.5 0.7 0.1];               % true value of theta = (K, r, x0)
logis=LogisticModel(theta,t);
p=3;                                  % the dimension of parameter space
n=length(t);                          % the length of the vector t
m=1000;                               % the number of bootstrap sample

lowb=[0 0 0];                         % lower bound of parameter space
uppb=[inf inf inf];                   % upper bound of parameter space

iterset=optimset('TolX',1.0e-4,'MaxFunEvals',10000);

y(1,:) = LogisticModel(theta_0,t);       % y is a value of random process Y.                    
Y(1,:) = y(1,:)+(1/20)*randn(1,n);

plot(t,y,'r')
title('Logistic Curve with K=17.5, r=0.7 and x_0=0.1')
xlabel('Time')
ylabel('Model')
grid on
hold on
plot(t,Y(1,:),'*')
legend('Logistic curve','Noise points','Location','southeast')
hold off