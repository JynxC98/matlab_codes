clc
clear
y = [20 30 40 50 60];
x = 2000:1:2004;

% Normal bar graph
% bar(x, y, 0.3);

% Horizontal bar graph
% barh(x, y, 0.3);

% Stacked bar graph
bar(y, 'stacked');