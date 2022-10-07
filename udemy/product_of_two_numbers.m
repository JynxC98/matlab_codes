% Prime Factors
clc
clear

number = input("Please enter a number \n");
result = product_of_digits(number);
disp(result);







function product = product_of_digits(number)
product = 1;
while (number > 0)
    remainder = mod(number, 10);
    number = int16(number/10);
    product = product * remainder;
end
end
