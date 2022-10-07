clc
clear
% syms function helps to create a variable for calculations of derivatives/
% integrals.
syms x  y;

func = sin(x.*y);
% Regular derivative.
disp(diff(func));

% Partial derivative.
disp(diff(func, x))

% Second order derivative.

disp(diff(func, 2))



% Integrals

disp(int(func))


% Solving equations

f = x^3 + 6.*x^2 == 6 - 11.*x;
result = solve(f);
disp(result)

% Examples of equations

clc
clear
syms x y z;
func_1 = x^2 + y^2 + z*2 == 25;
func_2 = x + y + z == 56;
func_3 = x + z - y == 34;
[x, y, z] = solve(func_1, func_2, func_3);

disp(x);
disp(y);
disp(z);

% substituting a value in the equation

disp(subs(func_1, y, x));

% getting the coefficients from an equation.
clear
syms x y z;

func_4 = 40.*(x^2) + 53.*x + 5;
disp(sym2poly(func_4));


