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
v_inactive_list = zeros(1, spaces);
v_active_list = zeros(1, spaces);

% Productivity takes 3 states: {Low, medium, high}
nstates = 3;
[productivity, probability] = tauchen(nstates, 0, rho, sigma, m);
itr = 0;
itr_kprime = 1;
% Value Functions 
value_old = zeros(spaces, nstates); % Guess the initial value of V_0
value_new = zeros(spaces, nstates); % Update the value of V_1

k_prime = zeros(spaces, nstates);   % Capital for the next period

tolerance = 15;
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
                    (gamma/2)*investment^2 - p * investment + beta * expected_value;
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

% Investment Policy Function
investment = NaN(spaces, nstates);
for itheta = 1:nstates
    investment(:,itheta) = k_prime(:,itheta) - capital;
end

% for val = 1: nstates
%     investment_grid(:, val) = k_prime(:, val) - capital;
% end

% Plotting value function
figure(1)
plot(capital, value(:, 1: nstates), "LineWidth",2);
xlabel("Capital (K)")
ylabel("Value Function")
legend("low productivity", "Medium productivity", "high productivity")
%Plotting v_active and v_inactive
% figure(2)
% plot(capital, v_active_list, "LineWidth", 2, Color="red");
% hold on;
% plot(capital, v_inactive_list, "LineWidth", 2, Color="green");

figure(2)
plot(capital,investment(:,1:nstates),'LineWidth',2) % plot graph
xlabel('K');
ylabel('I(K,\theta)');
title('Optimal Investment I(K,\theta)')
legend('Low Theta \theta_L','Medium Theta \theta_M','High Theta \theta_H')
