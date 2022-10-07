% Prime Factors

clc
clear
N = input("Please enter a number \n");
factors = factor(N);
disp(factors);
unique_factors = unique(factors);
disp(unique_factors);