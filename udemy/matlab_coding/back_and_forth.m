clc
clear

disp(backAndForth(4));


function result = backAndForth(num)
result = zeros(num);
for itr = 1: num
    min_value = ((itr - 1)* num) + 1;
    max_value = itr * num;

    if mod(itr, 2) == 0
        result(itr,:) = flip(min_value: max_value);
    else
        result(itr,:) = min_value: max_value;
    end
end
end