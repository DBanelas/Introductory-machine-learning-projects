clear all
close all

C = 0.1; % Choose C = 0.01, 0.1, 1, 10, 100, 1000, 10000

load('./twofeature1.txt');
n = size(twofeature1, 1); % leave out the last example
y = twofeature1(1:n, 1);
X = twofeature1(1:n, 2:3);

Xpos = X(y==1, :); % positive examples
Xneg = X(y==-1, :); % negative examples

%  Visualize the example dataset
hold on
plot(Xpos(:, 1), Xpos(:, 2), 'b.');
plot(Xneg(:, 1), Xneg(:, 2), 'r.');
hold off
axis square;

% Form the matrices for the quadratic optimization. See the matlab manual for "quadprog"


for i=1:n
    
    for j=1:n
        
        H(i,j) = (y(i)*y(j)*X(i,:)*(X(j,:)'));
        
    end
    
end

f = -ones(n,1);

A = [];

b = [];

Aeq = y';

beq = 0;

lb = zeros(n,1);

ub = C* ones(n,1);

lambda = quadprog(H,f,A,b,Aeq,beq, lb, ub); % Find the Lagrange multipliers

indices = find(lambda > 0.0001 ); % Find the support vectors
Xsup = X(indices,:);% The support vectors only 
ysup = y(indices);
lambdasup = lambda(indices);

% Find the weights
w = zeros(1,size(Xsup,2));
for i=1:size(lambdasup)
    
    w = w + ysup(i)*lambdasup(i) * Xsup(i,:);
    
end

%find bias
w0 = -(max(w*Xneg') + min(w*Xpos'))/2;


% Plot support vectors
Xsup_pos = Xsup(ysup==1, :);
Xsup_neg = Xsup(ysup==-1, :);

hold on
title(['C = ' num2str(C)] );
plot(Xsup_pos(:, 1), Xsup_pos(:, 2), 'bo');
plot(Xsup_neg(:, 1), Xsup_neg(:, 2), 'ro');
hold off


% Find the width of the margin
width = (1/2)* norm(w);

% Plot decision boundary
x1 = linspace(0.5, 4.5, 100);
x2 = (-w0-w(1)*x1)/w(2);
hold on
plot(x1, x2, 'k')

sv1 = (1-w0-w(1)*x1)/w(2);
plot( x1,sv1 ,'b--');  %Plot the Margin of class +1

sv2 = (-1-w0-w(1)*x1)/w(2);
plot( x1,sv2 ,'r--')  %Plot the Margin of class -1
hold off


