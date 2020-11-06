%%%%% Bootstrapping using GLS for Non-Constant Variance data %%%%%
clear,clc
tic

t=linspace(0,25,50);                  % time variable
theta=[17 0.6 0.1];                   % initial value of theta
theta_0=[17.5 0.7 0.1];               % true value of theta = (K, r, x0)

p=3;                                  % the dimension of parameter space
n=length(t);                          % the length of the vector t
m=1000;                               % the number of bootstrap sample

lowb=[0 0 0];                         % lower bound of parameter space
uppb=[inf inf inf];                   % upper bound of parameter space

iterset=optimset('TolX',1.0e-4,'MaxFunEvals',10000);

y(1,:) = LogisticModel(theta_0,t);       % y is a value of random process Y.
                                                     
Y(1,:) = y(1,:)+(1+(0.05))*randn(1,n);

Weights(1,:)=1./(y(1,:).^2); % initial value of weights
residuesum = @(x) sum(Weights(1,:).*(Y(1,:)-LogisticModel(x,t)).^2); 
theta1(1,:) = lsqcurvefit(@LogisticModel,theta,t,Y(1,:),lowb,uppb,iterset);

for i=1:m
    y(i+1,:)=LogisticModel(theta1(i,:),t);       
    Y(i+1,:) = y(1,:)+(1+(0.05))*randn(1,n);       
    Weights(i+1,:)=1./(y(i+1,:).^2);               
    residuesum = @(x) sum(Weights(i+1,:).*(Y(i+1,:)-LogisticModel(x,t)).^2); 
    theta1(i+1,:)=lsqcurvefit(@LogisticModel,theta1(i,:),t,Y(i+1,:),lowb,uppb,iterset);
end

format long
theta_boot=(1/m)*sum(theta1) % Bootstrap mean

col_1=theta1(:,1)-theta_boot(1,1);
col_2=theta1(:,2)-theta_boot(1,2);
col_3=theta1(:,3)-theta_boot(1,3);
Covmatrix=[col_1 col_2 col_3];

Covariance_boot=(1/(m-1))*sum((Covmatrix)'*(Covmatrix)); % Bootstrap Covariance

StandardError_boot=sqrt(diag(Covariance_boot)) % Standard error for bootstrapping

% 95% confidence intervals from bootstrapping
CI_lowerK=theta_boot(1,1)-1.96*StandardError_boot(1,1);
CI_upperK=theta_boot(1,1)+1.96*StandardError_boot(1,1);
CI_K=[CI_lowerK CI_upperK];

CI_lowerR=theta_boot(1,2)-1.96*StandardError_boot(1,2);
CI_upperR=theta_boot(1,2)+1.96*StandardError_boot(1,2);
CI_R=[CI_lowerR CI_upperR];

CI_lowerX=theta_boot(1,3)-1.96*StandardError_boot(1,3);
CI_upperX=theta_boot(1,3)+1.96*StandardError_boot(1,3);
CI_X=[CI_lowerX CI_upperX];

CI_ALL=[CI_K ; CI_R ; CI_X] % CI=[theta-1.96se theta+1.96se]

toc