%%%%% Asymptotic Theory using OLS for CV %%%%%

clear all
clc
format long

tic % computation times - start

% Setting the variables
t=linspace(0,25,50);  
theta=[17 0.6 0.09];      
theta_0=[17.5 0.7 0.1];    
p=3; n=length(t);                              
lowb=[0 0 0]; uppb=[inf inf inf];                   
iterset=optimset('TolX',1.0e-4,'MaxFunEvals',10000);

y = LogisticModel(theta_0,t);                                                                      
Y = y+(0.1)*randn(1,n);

residual=sqrt(n/(n-p)).*(Y-y);
r=randsample(residual,n,'true');

% OLS estimates of Asymptotic theory
theta_hat=lsqcurvefit(@LogisticModel,theta,t,Y,lowb,uppb,iterset);

%%% Setting sensitivity Matrix and Covariance %%%

% initial conditions
y0=[theta_hat(3);0;0];

% Sensitivity Matrix computations
[t, senMatrix]=ode45(@sensitivityEquation,t,y0,[],theta_hat);

%Covariance Matrix
sigma2=sum((y-LogisticModel(theta_hat,t)').^2)*(1/(n-p));
CovMatrix=sigma2*inv(senMatrix'*senMatrix);

% The results of algorithm
theta_hat
StandardError=sqrt(diag(CovMatrix))'


% 95% confidence intervals from Asymptotic estimates
CI_lowerK=theta_hat(1)-1.96*StandardError(1);
CI_upperK=theta_hat(1)+1.96*StandardError(1);
CI_K=[CI_lowerK CI_upperK];

CI_lowerR=theta_hat(2)-1.96*StandardError(2);
CI_upperR=theta_hat(2)+1.96*StandardError(2);
CI_R=[CI_lowerR CI_upperR];

CI_lowerX=theta_hat(3)-1.96*StandardError(3);
CI_upperX=theta_hat(3)+1.96*StandardError(3);
CI_X=[CI_lowerX CI_upperX];

CI_ALL=[CI_K ; CI_R ; CI_X] % CI=[theta-1.96se theta+1.96se]

toc % computation times - end
