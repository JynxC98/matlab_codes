%% Lab 1:Introduction to Matlab - - ECON5068 ONLINE
%Written by Vasileios Karaferis for ECON5068-ifap.

%%This file contains too much material. It is unrealistic that we will go
%%through everything in one session but you can review some of the extra
%%stuff at home and let me know if you have any questions.

% Disclamer: You do not need to know how to code for ECON5068-ifap. 

% Why MATLAB?
% - MAtrix LABoratory
% - Matrix operations 
% - Widely used in Ecomomics
% - Many inbuilt functions/packages
% - Great Debugger

% Why would you want to learn to how to code?
% - Data analysis
% - Solving Complicated models
% - Your own projects/Dissertasion

% => Most of the basic tools are the very similar across languages 
%   (data structures, loops, etc.)
%   Check QuantEcon if you are interested in learning Python or julia!

% Motivation : In most cases, you get get very few information/results
% using pen and papper.
% -> i.e. DSGE models: once you have system of equations, need
%   computational power to analyze it
 

%No need of prior knowledge in coding is assumed.

%% Goals 4 the day
% - Create new file
% - Path
% - Create new function
% - Command window
% - Command History
% - Save your work!
% - Debugger
% - How to comment % and %%
% - The use of %% sections 
% - help function 
% - See examples

%% 2.1 Preliminaries && Housekeeping
clear;
close all;
clc;

2+3; % ; suppresses output 

2+3

pi

format long

pi

format short

%% 2.2 Declaring variables
op = 1

A = [1 2 3 
    4 5 6];

A = [1 2 3; 4 5 6]

size(A)

yt = A(2,2)

A(2,2) = 65;

A
% Careful: 
C(1,1)=3; 
C(1,2)=4; 
C(1,3)=5; 
C(2,1)=6; 
C(2,2)=7; 
C(2,3)=8;

disp(C)

% If a variable has previously been assigned a value, the new value overrides the predecessor.
%% 2.2.2 Declaring an empty matrix
D=[]

% kapa = ones(2,2);
kapa = zeros(2,2);

for i = 1:2
    for j= 1:2
        
        
        if i == j || j==i
            kapa(i,j) = 1;
        else
            kapa(i,j) =0;
        end
    end
end
    
disp(kapa)

jp = eye(2,2)
    
% 
% for i =1:2
%     for j = 1:2
%         if i==j
%             kapa(i,j) = 1;
%         else
%             kapa(i,j) = 0;
%         end
%     end
% end


%% 2.2.3 Building a matrix out of several submatrices
A=[1 2; 3 4];
B=[5 6 7; 8 9 10];
C=[3 4; 5 6];
D=[1 2 3; 4 5 6];

E = [A B; C D]
size(E)
%% 2.2.4 Declaring a string matrix
% String: different data type!

x=['ab';'cd']
a = 1
b = '1'

help rand

% a not the same as b!

%% 2.5.5 Declaring a vector

f=[1 2 3]
g = [1; 2; 3;]

ft = transpose(g)
h = f'
h = [1 2 3]'

g = 1:0.5:5

%% 2.2.6 Declaring a scalar (or 1-by-1 matrix)
a = 2;

%% 2.3 Basic manipulations of matrices
% 2.3.1 Using partitions of matrices
A=[1 2 3 4 5; 
   2 3 4 5 1;  
   3 4 5 1 2; 
   4 5 1 2 3; 
   5 1 2 3 4];

size(A)


B=A(1:4,2:3)



%% 2.3.2 Making vectors from matrices and reverse
Ab=[1 2; 3 4; 5 6;]

b=Ab(:) % : select all

Ab=reshape(b,3,2)

%% 2.4 Matrix and array operations
% 2.4.1 Transposition of a matrix
C=[3 4 5; 6 7 8]
C'

%% 2.4.2 Basic matrix operations
a=1:5;
size(a)
b=[5:9]';
size(b)
i=4;

d=a+i*a

E=b*a

% E=a*d % Does not work!

%% 2.4.3 Array operators
A = [1 2];
B = [3 3];

C=A./B % Don't confuse array operators with the usual matrix operators

RR = randn(5,4);
disp(RR)

TT = i.*RR;

%% 2.5 Relational and logical operators
% a<b  a>b  % Less (greater) than
% a<=b a>=b % Less (greater) than or equal to
% a==b      % Equal to
% a~=b      % Not equal to
% &         % AND
% |         % OR
% ~         % NOT

A = [1 2 3 4 5 6 7 8 9 10]

G= [1 2;3 4]; 

T1= G<=2

T2=~(G<=2)

t = A <= 4 & A > 2

[i,j] = find(A <= 4&A > 2);
i
j

%% This subsections was given to me by Jorge Pinheiro
% 2.5.1 Loops "for" and "while" 
%This is useful if we want to repeat a command several times, but instead of writing it over and over, we can
%use a loop. 


for i=1:20
    F(i)=i;
end

for i=1:20
    G(i)=i*i;
end

for i=1:20
  H(i) = log(i);  
end
%% 2.6 Building special matrices
% 2.6.1 Declaring a zero (or Null) matrix
D=zeros(2,3)

%% 2.6.2 Declaring a ones matrix
E=ones(2,3)

%% 2.6.3 Declaring an identity matrix
F=eye(3)

%% 2.6.4 Declaring a random matrix
R=rand(5,1)

help randn


%% 2.7 Sizes of each dimension of an array
[m,n]=size(A)

B=sum(A)

B=cumsum(A)

min(A)
max(A)

%% 2.7.1 Determinant of a matrix
% det(A) returns the determinant of the square matrix A.
A=[4 2;1 3];
B=det(A)

%% 2.7.2 Inverse of a matrix
% inv(A) returns the inverse of the square matrix A.
C=inv(A)

%% 2.8 Declaring a function

% First let;s create a grid.

K =1:1:100;

L = K.^2;

HH = K.^3;
%% 2.9. Figures and Graphs

figure (1)

plot (K,L);
xlabel('X axis');
ylabel('values of Quad function');

figure (2)

plot (K,HH);
xlabel('X axis');
ylabel('values of Cubic function');
hold on
plot (K,L);
hold off

figure(3)
subplot(1,2,1)
plot (K,L);
xlabel('X axis');
ylabel('values of Quad function');

subplot(1,2,2)
plot (K,HH);
xlabel('X axis');
ylabel('values of Cubic function');

%% Example with production function

clear all;
close all;
clc;

%Parameters

a = 0.33;
beta = 1-a;

% Grid for Capital and for Labour
K = 0.00:0.01:10; % grid over capital stock
[rk,dimK]=size(K);


Ln = ones(1,dimK);

for i = 2:(dimK);
    Ln(i) = Ln(i-1) - 0.0001;
end

%%Production Function

% Let's create some random values for the production technology
A = ones(1,dimK);
for i=2:dimK
    A(i) = rand;
    if A(i)<0.7;
        A(i) = 0.7;
    end
    
end

Y = A(1,1).*(K.^a).*(Ln.^beta);

figure(1)
plot(K,Y);
xlabel('Capital');
ylabel('Output');
hold on 
plot(K,K);
hold off
 
figure(2)
plot3(K,Ln,Y);
xlabel('Capital');
ylabel('Labor');
zlabel('Output');
% 
% figure(4)
% plot3(K,Ln,A(1,1).*(K.^a).*(Ln.^beta));
% xlabel('Capital');
% ylabel('Labor');
% zlabel('Output- Simple');


%% Marginal product of Capital
MPK = a.*A(1,1).*(K.^(a-1)).*(Ln.^(beta));

figure(3)
plot(K,MPK);
xlabel('Capital');
ylabel('MPK');

figure(4)
plot(K,MPK);
xlabel('Capital');
ylabel('MPK- Simple');
hold on
plot(K,Y);
hold off
