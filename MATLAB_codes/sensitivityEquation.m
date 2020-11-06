function seq=sensitivityEquation(t,x0,theta)
seq=[theta(2).*(1-(2*x0(1)./theta(1))) - theta(2)*(x0(1)*theta(1)).^2;
    theta(2).*(1-(2*x0(1)./theta(1)))*x0(2) + x0(1).*(1-(x0(1)./theta(1)));
    theta(2).*(1-(2*x0(1)./theta(1)))*x0(2)];
