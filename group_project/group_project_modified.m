clear;
clc;

% Model parameters:
beta = 0.95;
thetha = 0.7;
p = 1.2;
lambda = 0.5;
F = 0.25;
spaces = 401;
gamma = 0.2;
capital = linspace(30, 80, spaces)';
% For calculation of productivity:
rho = 0.9;
sigma = 0.1;
m = 3;
% Productivity takes 3 states: {Low, medium, high}
nstates = 3;
[productivity, probability] = tauchen(nstates, 0, rho, sigma, m);
itr = 0;
itr_kprime = 1;
% Value Functions 
value_old = zeros(spaces, nstates); % Guess the initial value of V_0
value_new = zeros(spaces, nstates); % Update the value of V_1

% Stroing active and inactive investments
v_inactive_list = zeros(1, spaces);
v_active_list = zeros(1, spaces);

% Capital for the next period
k_prime = zeros(spaces, nstates);   

tolerance = 10;
while true
    for itr_capital_value= 1:spaces
        for itr_productivity_value = 1:nstates
            RHS = NaN(spaces, 1);
            % Looping over all the possible values of the kprime
            for itr_kprime_value = 1:spaces
                investment = capital(itr_kprime_value) - capital(itr_capital_value);
                expected_value = probability(itr_productivity_value, :)... 
                    * value_old(itr_kprime_value, :)';
                v_inactive = exp(productivity(itr_productivity_value)) ... 
                    *capital(itr_capital_value)^(thetha) +  beta * expected_value;
                v_inactive_list(itr_kprime_value) = v_inactive;
                v_active = exp(productivity(itr_productivity_value)) ...
                    * capital(itr_capital_value)^(thetha) * lambda - ...
                    F*capital(itr_capital_value) - p * investment + beta * expected_value;
                v_active_list(itr_kprime_value) = v_active;
                RHS(itr_kprime_value) = max(v_inactive, v_active);
                itr_kprime = itr_kprime + 1;
            end
            [value_new(itr_capital_value, itr_productivity_value), index] = max(RHS);
            k_prime(itr_capital_value, itr_productivity_value) = capital(index);
        end
    end
    error = max(abs(value_new - value_old), [], "all");
    fprintf("Iteration no: %d, error = %d \n", itr, error)
    if error < tolerance
        break
    end
    itr = itr + 1;
    value_old = value_new;
end

value = value_new;
investment = NaN(spaces, nstates);
for itheta = 1:nstates
    investment(:,itheta) = k_prime(:,itheta) - capital;
end
% Plotting value function
figure(1)
plot(capital, value(:, 1: nstates), "LineWidth",2);
xlabel("Capital (K)")
ylabel("Value Function")
title("Productivity and Value Function")
legend("low productivity", "Medium productivity", "high productivity")

figure(2)
plot(capital, v_active_list, "LineWidth", 2, Color="red");
hold on;
plot(capital, v_inactive_list, "LineWidth", 2, Color="green");
title("Active and Inactive Investment")

figure(3)
plot(capital,investment(:,1:nstates),'LineWidth',2) % plot graph
xlabel('K');
ylabel('I(K,\theta)');
title('Optimal Investment I(K,\theta)')
legend('Low Theta \theta_L','Medium Theta \theta_M','High Theta \theta_H')












function [Z,Zprob] = tauchen(N,mu,rho,sigma,m)
%Function TAUCHEN
%
%Purpose:    Finds a Markov chain whose sample paths
%            approximate those of the AR(1) process
%                z(t+1) = (1-rho)*mu + rho * z(t) + eps(t+1)
%            where eps are normal with stddev sigma
%
%Format:     {Z, Zprob} = Tauchen(N,mu,rho,sigma,m)
%
%Input:      N       scalar, number of nodes for Z
%            mu      scalar, unconditional mean of process
%            rho     scalar
%            sigma   scalar, std. dev. of epsilons
%            m       max +- std. devs.
%
%Output:     Z       N*1 vector, nodes for Z
%            Zprob   N*N matrix, transition probabilities
%
%    Martin Floden
%    Fall 1996
%
%    This procedure is an implementation of George Tauchen's algorithm
%    described in Ec. Letters 20 (1986) 177-181.
%


Z     = zeros(N,1);
Zprob = zeros(N,N);
a     = (1-rho)*mu;

Z(N)  = m * sqrt(sigma^2 / (1 - rho^2));
Z(1)  = -Z(N);
zstep = (Z(N) - Z(1)) / (N - 1);

for i=2:(N-1)
    Z(i) = Z(1) + zstep * (i - 1);
end 

Z = Z + a / (1-rho);

for j = 1:N
    for k = 1:N
        if k == 1
            Zprob(j,k) = cdf_normal((Z(1) - a - rho * Z(j) + zstep / 2) / sigma);
        elseif k == N
            Zprob(j,k) = 1 - cdf_normal((Z(N) - a - rho * Z(j) - zstep / 2) / sigma);
        else
            Zprob(j,k) = cdf_normal((Z(k) - a - rho * Z(j) + zstep / 2) / sigma) - ...
                         cdf_normal((Z(k) - a - rho * Z(j) - zstep / 2) / sigma);
        end
    end
end
end

function c = cdf_normal(x)
    c = 0.5 * erfc(-x/sqrt(2));
end



