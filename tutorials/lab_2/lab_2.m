clc
clear

syms x;

%% Question 1
func = x^3 - 2.*x -5;
solution = newton_rhapson(func, 2);
disp(solution);




% Question 1 function
function value = newton_rhapson(equation, initial_guess)
    equation_prime = diff(equation);
    value = 0;
    tolerance = 1e-10;
    x_new = 0;
    itr = 0;
    while true
        derivative_ratio = vpa(subs(equation,initial_guess))/vpa(subs(equation_prime, initial_guess));
        value = initial_guess - derivative_ratio;
        if (abs(value - x_new) < tolerance)
            break
        end
        x_new = value;
        initial_guess = x_new;
        itr = itr + 1;
    end
    fprintf("The operation took %d iterations \n", itr);
end
