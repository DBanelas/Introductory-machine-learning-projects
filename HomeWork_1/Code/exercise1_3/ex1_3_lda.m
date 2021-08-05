%% Pattern Recognition 2019
%  Exercise 1.3 | Linear Discriminant Analysis
%
%  Instructions
%  ------------
%
%  This file contains code that helps you get started on the
%  exercise. You will need to complete the following functions:
%
%     myPCA.m
%     fisherLinearDiscriminant.m  (for 2-class LDA)
%	  myLDA.m  (for multiclass LDA)
%     projectDataLDA.m
%     projectDataPCA.m
%     recoverDataLDA.m
%     recoverDataPCA.m
%
%

%% Initialization
clear ; close all; clc

%% ================== Part 1: Load the Dataset  ===================
%  We start using a small dataset that is easy to
%  visualize
%
fprintf('Visualizing example dataset for LDA.\n\n');

%  The following command loads the dataset. You should now have the 
%  variable X in your environment
load ('ex1_3_data1.mat');


%  Before running PCA, it is important to first normalize X
[X_norm, mu, sigma] = featureNormalize(X);

X1 = X_norm(c==1, :);
X2 = X_norm(c==2, :);

%  Visualize the example dataset
figure(1)
hold on
plot(X1(:, 1), X1(:, 2), 'bo');
plot(X2(:, 1), X2(:, 2), 'rs');
axis([-2.1 2.1 -2.1 2.1]); axis square;
hold off

fprintf('Program paused. Press enter to continue.\n');
pause;


%% =============== 2-Class Fisher Linear Discriminant =============
% Add your code to the implement the following function
%

v = fisherLinearDiscriminant(X1, X2);


hold on
drawLine(-5*v', 5*v', '-g', 'LineWidth', 1);
hold off

fprintf('Program paused. Press enter to continue.\n');
pause;

%  Project the data onto the direction of the one dimensional vector v
[Z1] = projectDataLDA(X1, v);
[Z2] = projectDataLDA(X2, v);


% Reconstruct the data on the line defined by vector v
[X1_rec]  = recoverDataLDA(Z1, v);
[X2_rec]  = recoverDataLDA(Z2, v);



%  Draw lines connecting the projected points to the original points
fprintf('\nDisplaying LDA on example dataset.\n\n');
hold on;
plot(X1_rec(:, 1), X1_rec(:, 2), 'bo', 'MarkerFaceColor', 'b');
for i = 1:size(X1, 1)
    drawLine(X1(i,:), X1_rec(i,:), '--k', 'LineWidth', 1);
end

plot(X2_rec(:, 1), X2_rec(:, 2), 'rs', 'MarkerFaceColor', 'r');
for i = 1:size(X2, 1)
    drawLine(X2(i,:), X2_rec(i,:), '--k', 'LineWidth', 1);
end
hold off
title('Projected data using LDA');
fprintf('Program paused. Press enter to continue.\n');
pause;

%Code for understanding
%Plotting the data on 1 dimension
% figure(3);
% hold on;
% plot(Z1', zeros(1,7),'rs');
% plot(Z2', zeros(1,7),'bo');
% hold off;
% pause;

%% =============== Principal Component Analysis ===============

fprintf('\nRunning PCA on example dataset.\n\n');

%  Run PCA
[U, S] = myPCA(X_norm);


%  Project the data onto K = 1 dimension
K = 1;
Z = projectDataPCA(X_norm, U, K);

X_rec  = recoverDataPCA(Z, U, K);

%  Plot the normalized dataset (returned from principalComponentAnalysis)
%  Draw lines connecting the projected points to the original points
fprintf('\nVisualizing example dataset for PCA.\n\n');
figure(2)
hold on;
axis([-2.1 2.1 -2.1 2.1]); axis square;
drawLine(-2.3*U(:,1), 2.3*U(:,1), '-g', 'LineWidth', 1);
plot(X1(:, 1), X1(:, 2), 'bo');
plot(X2(:, 1), X2(:, 2), 'rs');
plot(X_rec(c==1, 1), X_rec(c==1, 2), 'bo', 'MarkerFaceColor', 'b');
plot(X_rec(c==2, 1), X_rec(c==2, 2), 'rs', 'MarkerFaceColor', 'r');
for i = 1:size(X_norm, 1)
    drawLine(X_norm(i,:), X_rec(i,:), '--k', 'LineWidth', 1);
end
title('Projected data using PCA');
hold off
fprintf('Program paused. Press enter to continue.\n');
pause;


%% =============== PART B: FisherIris DATA ===============
% Apply LDA to the Fisher Iris Dataset
clear;
clc;

%Load Fisher Iris Data

load('fisheriris.mat');

% Convert the species cell into an array containig class labels
% Class 0 for "setosa"
% Class 1 for "versicolor"
% Class 2 for "virginica"
iris_labels = 1*cellfun(@(x)isequal(x,'versicolor'),species)+2*cellfun(@(x)isequal(x,'virginica'),species);

%  Before running PCA, it is important to first normalize X
[meas_norm, mu, sigma] = featureNormalize(meas);

% Get the data for each class

 %Samples of Class 0
 IRIS1 = meas_norm(iris_labels==0,:); 
 
 %Samples of Class 1
 IRIS2 = meas_norm(iris_labels==1,:);
 
 %Samples of Class 2
 IRIS3 = meas_norm(iris_labels==2,:);		


%  Visualize the example dataset
 figure(3)
 hold on
 plot(IRIS1(:, 1), IRIS1(:, 2), 'bo');
 plot(IRIS2(:, 1), IRIS2(:, 2), 'rs');
 plot(IRIS3(:, 1), IRIS3(:, 2), 'g+');
 title('Data before LDA');
 hold off

 NewDim = 2; %The new feature dimension after applying LDA
 v = myLDA(meas_norm, iris_labels, NewDim);
 
%Alternative figure(3)
%Existing figure(3) must be commented in order to use this one.
%Shows the 3d plot of the 3/4 features along with the lines from the 2
%eigenvectors.
%These lines make the plane onto which we project the data in order to
%seperate them in 2 dimensions
%  figure(3) 
%  view(3);
%  hold on
%  grid on
%  plot3(IRIS1(:, 1),IRIS1(:, 2),IRIS1(:, 3),'bo');
%  plot3(IRIS2(:, 1),IRIS2(:, 2),IRIS2(:, 3),'rs');
%  plot3(IRIS3(:, 1),IRIS3(:, 2),IRIS3(:, 3),'g+');
%  plot3([-10*v(1,1) 10*v(1,1)] , [-10*v(2,1) 10*v(2,1)],[-10*v(3,1) 10*v(3,1)],'k','LineWidth', 1);
%  plot3([-10*v(1,2) 10*v(1,2)] , [-10*v(2,2) 10*v(2,2)],[-10*v(3,2) 10*v(3,2)],'k','LineWidth', 1);
%  hold off


%  Project the data on the direction of the two dimensional v
[meas_reduced] = projectDataLDA(meas_norm, v);

%  Visualize the sample dataset after LDA is applied
%  Use different color/symbol for each class

%Samples of Class 0
 IRIS1red = meas_reduced(iris_labels==0,:); 
 
 %Samples of Class 1
 IRIS2red = meas_reduced(iris_labels==1,:);
 
 %Samples of Class 2
 IRIS3red = meas_reduced(iris_labels==2,:);

figure(4)
hold on
plot(IRIS1red(:, 1), IRIS1red(:, 2), 'bo');
plot(IRIS2red(:, 1), IRIS2red(:, 2), 'rs');
plot(IRIS3red(:, 1), IRIS3red(:, 2), 'g+');
title('Data after LDA');
hold off


