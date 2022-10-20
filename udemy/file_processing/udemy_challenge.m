%% Importing a file on matlab

clc
clear
% Task 1: Load the file on the matlab terminal.
required_file = fileread("Example_text.txt");
disp(required_file);

% Task 2: Replace all the punctuation.
required_file = erasePunctuation(string(required_file));
disp(required_file);

% Task 3: Break the string into individual words.
required_file = join(required_file).split();
disp(required_file);
 
% Task 4: Find frequencies of words
frequencies = tabulate(required_file);

[freq, index] = sort(cell2mat(frequencies(:,3)),'descend');

% Task 5: Bar plot of top 10 most visited words.
bar(categorical(frequencies(index(1:10), 1)), cell2mat(frequencies(index(1:10), 3)));
