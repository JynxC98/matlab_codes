clc
clear
syms x y z h;
equation_1 = 2.*x - 3.*y + 4.*z == 5;
equation_2 = y + 4.*z + x == 10;
equation_3 = -2.*z + 3.*x + 4.*y == 0;
disp(solve(equation_1, equation_2, equation_3));

%% Method 2
A = [2 -3 4; 1 1 4; 3 4 -2];
B = [5; 10; 0];
disp(A\B);

%% Exercise 4
Z = exp(x).*cos(y) + (sin(x^2 - y))^2;
% Calculating Z(-3, 4)
result = subs(Z, -3, -4);
disp(result);
% Partial derivative wrt x
disp(diff(Z,x));
% Partial derivative wrt Y
disp(diff(Z,y));
% Second order derivative wrt x
disp(diff(Z,2,x));
disp(diff(Z,y));
% Second order derivative wrt y
disp(diff(Z,2,x));

%% Exercise 5

func = sin(x);
result = limit(((sin(x + h) - sin(x))/h),h,0);
disp(result);
