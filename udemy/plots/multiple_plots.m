clc
clear

% The code below generates 10 random integers between 1 and 10
x = randi([1,10],1,10);
y = randi([1,10],1,10);
z = randi([1,10],1,10);


subplot(2, 2, 1), plot(x,y);
subplot(2, 2, 2), plot(y,z);
subplot(2, 2, 3), plot(x,z);