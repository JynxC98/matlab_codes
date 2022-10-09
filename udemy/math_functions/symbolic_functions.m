clc
clear

syms x y;
f(x, y) = 2.*x^2 + 3.*y^2;

disp(diff(f(x, y)));
f(y + 1, y)