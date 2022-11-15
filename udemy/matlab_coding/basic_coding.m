clc
clear
A = rand(4);
B = rand(4);
if isequal(length(A), length(B))
    C = [A;B];
    disp(C);
end

% Switch

% grade = input("Enter the grade \n");
% switch grade
%     case 90
%         fprintf("A+ \n");
%     case 80
%         fprintf("A \n");
%     otherwise
%         fprintf("Lol go back to your country \n")
% end


% For loop

% for i = 1:10
%     if mod(i, 2) == 0
%         disp(i)
%     end
% end

% Nested for loop
itr = 0;
for i = 1:5
    for j = 1:5
        itr = itr + 1;
    end
end
disp(itr)