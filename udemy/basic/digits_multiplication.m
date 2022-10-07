% Prime Factors
clc
clear

% Generating a random number between 1 million and 10 million.
number = randi([1000000, 10000000],1);
disp(number);
result = get_product(number);
disp(result);






function product = get_product(number)
    product = 1;
    while (number ~= 0)
        product = product * (mod(number, 10));
        number = int64(number/10);
    end
end

