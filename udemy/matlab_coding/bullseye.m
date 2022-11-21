clc
clear

%% Bullseye matrix

elements = 5;
disp(bullseye_matrix_gen(elements));


function bullseye = bullseye_matrix_gen(elements)
bullseye = zeros(elements);
rings = (elements + 1)/2;
% conc = (elements + 1)/2;

for i = 1: rings
    % Left
    bullseye(i:(elements - i + 1), i) = (rings + 1 - i);
    % Top
    bullseye(i, i:(elements + 1 - i)) = (rings +1 - i);
    % Right
    bullseye(i:(elements - i + 1) ,(elements - i + 1)) = rings - i + 1;
    % Bottom
    bullseye((elements - i + 1), i:(elements + 1 - i)) = rings - i + 1;

end
end
