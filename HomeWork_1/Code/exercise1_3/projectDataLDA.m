function [Z] = projectDataLDA(X, v)

% You need to return the following variables correctly.
Z = zeros(size(X, 1), 1);

% ====================== YOUR CODE HERE ======================

%Notes for my understanding
% Z contains the lengths of the projection onto v 
% every line contains the dot product of (x_i, v) 
% which is the length of the projection

Z = X*v;

% =============================================================

end
