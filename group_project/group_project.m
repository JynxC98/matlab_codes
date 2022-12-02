%% Group 39 project
% Members:
% Harsh Parikh
% Yuan 
% Ru Ye

clear; 
close all; 
clc;

% Model Parameters
alpha = 0.5;
delta = 0.05;
phi = 0.2;
beta = 0.9;

% State Space - (K,theta)
% 1.  Capital grid 
nk = 201; % of capital grid points
Kgrid = linspace(0,30,nk)';

%2. Productivity Grid
% Find transition matrix and discrete states of AR(1) process 
% using Tauchen (1986)
ntheta = 3;
[theta,Pr] = tauchen(ntheta,0,0.9,0.20,2);
%Pr[i,j] is the probability of transition from state i to state j --
%same as Pr[j|i]



% value function
valueold = zeros(nk,ntheta); % guess V_0
valuenew = zeros(nk,ntheta); % update V_1

Kprime = zeros(nk,ntheta);


% Value Function Iteration
maxiter = 1000;
tol = 1e-8; 

for iter = 1:maxiter 

    for ik = 1:nk
        for itheta = 1:ntheta
            RHS = NaN(nk,1);
            % loop over all possible kprime
            % thetaprime is averaged in to get conditional expectations ev
            for ikprime = 1:nk
                Inv = Kgrid(ikprime) - (1 - delta)*Kgrid(ik);
                ev = Pr(itheta,:)*valueold(ikprime,:)'; %expected value as dot product 
                RHS(ikprime) = exp(theta(itheta))*Kgrid(ik)^alpha - Inv - (phi/2)*Inv^2 + beta*ev;
            end
            [valuenew(ik,itheta),index] = max(RHS);
            Kprime(ik,itheta) = Kgrid(index);
        end
    end

    error = max(abs(valueold-valuenew),[],'all'); % note here you have an array and not vector
    fprintf('Iteration No. : %d Error : %d \n',iter,error) 
    if error < tol  % check if valueold and valuenew are close enough
        break 
    end 

    valueold = valuenew; 

end


% Value Function 
v = valuenew;

% Investment Policy Function
investment = NaN(nk,ntheta);
for itheta = 1:ntheta
    investment(:,itheta) = Kprime(:,itheta) - (1 - delta)*Kgrid;
end

%Plot value Function
figure(1)
plot(Kgrid,v(:,1:ntheta),'LineWidth',2)
xlabel('Capital (K)')
ylabel('Value Function (V(K,\theta))')
legend('Low Theta','Medium Theta','High Theta')


% plot optimal investment rule as a function of capital
figure(2)
plot(Kgrid,investment(:,1:ntheta),'LineWidth',2) % plot graph
xlabel('K');
ylabel('I(K,\theta)');
title('Optimal Investment I(K,\theta)')
legend('Low Theta \theta_L','Medium Theta \theta_M','High Theta \theta_H')
% if you increase grid points, investment will look smoother.





