function dxdt = LogisticODE(t,x0,theta)
% initial value of x(0) = x0 = theta(3)
dxdt=theta(2).*x0.*(1-(x0./theta(1)));
