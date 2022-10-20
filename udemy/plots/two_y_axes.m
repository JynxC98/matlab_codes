clc
clear

month = 1:1:12;
precip = randi([0,10],1,12);
temp = randi([10,20],1,12);

yyaxis left

plot(month, precip);
ylabel("precipitation");
xlabel("month")

yyaxis right
plot(month, temp);
ylabel("temperature");
xlabel("month");