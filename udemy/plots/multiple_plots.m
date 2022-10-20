clc
clear

%% Creating multiple plots on the same graph

x = 0:0.2:10;
y = sin(x);

plot(x, y);

% Tells matlab to not create a new plot but write on the existing one

hold on 
z = cos(x);
plot(x, z);

u = 2.*sin(x);
scatter(x, u);