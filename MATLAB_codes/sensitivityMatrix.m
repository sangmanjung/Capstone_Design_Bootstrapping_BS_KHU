function sense_X=sensitivityMatrix(t,theta)
x0=0.1;
theta(3)=x0;
A=((theta(1)/theta(3))-1)*exp(-theta(2)*t);
sense_X=[(A+1-exp(-theta(2)*t)./theta(3))/(A+1).^2 
          (t.^2)*theta(1).*A/(A+1).^2 
          (theta(1)/(theta(3).*(A+1))).^2];
      