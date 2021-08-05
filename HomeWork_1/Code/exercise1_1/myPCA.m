function [U, S] = myPCA(X)
%PCA Run principal component analysis on the dataset X
%   [U, S, X] = myPCA(X) computes eigenvectors of the covariance matrix of X
%   Returns the eigenvectors U, the eigenvalues (on diagonal) in S
%

% Useful values
[m, n] = size(X);

% You need to return the following variables correctly.
U = zeros(n);
S = zeros(n);
covMatrix = zeros(n,n);

% ====================== YOUR CODE GOES HERE ======================
% Apply PCA by computing the eigenvectors and eigenvalues of the covariance matrix. 
%

%We calculate covariance matrix of the data
covMatrix = 1/m.*(transpose(X)*X);

%Get eigenvalues and eigenvectors from eig()
[tempU, tempS] = eig(covMatrix);

%sort eigenvectors with respect to their eigenvalues
[~,permutation]=sort(diag(tempS), 'descend');

tempS=tempS(permutation,permutation);
tempU=tempU(:,permutation);

%Matrices to be returned
S = tempS;
U = tempU;

% =========================================================================

end
