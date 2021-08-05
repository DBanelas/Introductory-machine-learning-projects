function [X_rec] = recoverDataLDA(Z, v)

% You need to return the following variables correctly.
X_rec = zeros(size(Z, 1), length(v));

% ====================== YOUR CODE HERE ======================

%Notes for my understanding
%Z contains the length of the projections of x_i(a line vector of X) onto v
%In order to get the actual points in 2 dimensional space we just need to
%scale v by the length of each projection
%X_rec contains all scaled v's 
X_rec = Z * v';

% =============================================================

end
