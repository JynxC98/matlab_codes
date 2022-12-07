clc;
clear;
% Model parameters:
beta = 0.95;
theta = 0.7;
p = 1.2;
lambda = 0.5;
F = 0.25;
spaces = 401;
gamma = 0.2;
capital_grid = linspace(30, 80, spaces)';
% For calculation of productivity:
rho = 0.9;
sigma = 0.1;
m = 3;
% Productivity takes 3 states: {Low, medium, high}
nstates = 3;
[productivity, probability] = tauchen(nstates, 0, rho, sigma, m);
itr_kprime = 1;
% Value Functions 
value_active_old = zeros(spaces, nstates); 
value_active_new = zeros(spaces, nstates); 
value_inactive_old = zeros(spaces, nstates); 
value_inactive_new = zeros(spaces, nstates);

valueold = zeros(spaces, nstates); % guess V_0
valuenew = zeros(spaces, nstates); % update V_1

% Strong active and inactive investments
v_inactive_list = zeros(1, spaces);
v_active_list = zeros(1, spaces);

% Capital for the next period
k_prime = zeros(spaces, nstates);   
investment = zeros(spaces, 3);
tolerance = 1e-7;
itr = 1;
while true
    for itr_capital = 1:spaces 
        for itr_productivity = 1:nstates
            
            rhs = lambda * exp(productivity(itr_productivity)) * capital_grid(itr_capital) ^ theta ...
                    - F * capital_grid - p * (capital_grid-capital_grid(itr_capital)) + beta * ...
                    max(value_active_old, value_inactive_old)*probability(itr_productivity,:)';
            [value_active_new(itr_capital, itr_productivity), index] = max(rhs);
            % calculating the value of inactive investment.
            value_inactive_new(itr_capital, itr_productivity) = exp(productivity(itr_productivity)) ...
                *capital_grid(itr_capital)^theta + beta * max(value_active_old(itr_capital,:),value_inactive_old(itr_capital, :)) ...
                *probability(itr_productivity,:)';
            if value_active_new(itr_capital, itr_productivity) > value_inactive_new(itr_capital, itr_productivity)
                
                k_prime(itr_capital, itr_productivity) = capital_grid(index);
                investment(itr_capital, itr_productivity) = k_prime(itr_capital, itr_productivity) - capital_grid(itr_capital);              

            else
                
                k_prime(itr_capital, itr_productivity) = capital_grid(index);
                investment(itr_capital, itr_productivity) = 0;
            end
            
            
        end
        
    end

    % Iterating through the loops until the error reaches below the
    % tolerance
    error = max(max(abs(value_active_new - value_active_old), ...
        max(abs(value_inactive_old - value_inactive_new))));
    fprintf("iteration number: %d, Error = %d \n", itr, error);
    if error < tolerance
        break
    end
    value_active_old = value_active_new;
    value_inactive_old = value_inactive_new;
end
value = max(value_active_old, value_inactive_new);


% Plot value function
figure(1)
plot(capital_grid, value(:, 1: nstates), "LineWidth",2);
xlabel("Capital (K)")
ylabel("Value Function")
legend("low productivity", "Medium productivity", "high productivity")

figure(2)
plot(capital_grid,investment(:,1:3),'LineWidth',2)
xlabel('Capital');
ylabel('Optimal Investment-AM');
legend("low productivity", "Medium productivity", "high productivity")




