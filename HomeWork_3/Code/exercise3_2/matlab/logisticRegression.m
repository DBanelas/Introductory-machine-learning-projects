clear all
close all

load('exam_scores_data1.txt')

X_all = exam_scores_data1(:, 1:2); % input
Y_all = exam_scores_data1(:, 3); % target

N = size(X_all, 1); % Number of examples

meanX = mean(X_all);
stdX = std(X_all);

% Normalization with 0 mean and standard deviation of 1
 X_all(:,1) = (X_all(:,1) - meanX(1))./stdX(1);
 X_all(:,2) = (X_all(:,2) - meanX(2))./stdX(2);

%finding samples with label 0 and with label 1
neg_samples = (Y_all == 0);
pos_samples = (Y_all == 1);

%visualizing the dataset
figure(1)
hold on;
grid on;
plot(X_all(neg_samples,1),X_all(neg_samples,2), 'b+');
plot(X_all(pos_samples,1),X_all(pos_samples,2), 'r+');
legend('actual 0', 'actual 1');



% Define the model
num_features = 2;
input_depth = num_features;
output_depth = 1;
batch_size = 8;
learning_rate = 0.001;

% Define the weights
%W = normrnd(0, sqrt(2.0/(input_depth + output_depth)), input_depth, output_depth); 
b = zeros(output_depth, 1); 

W = [1;1];

% Training the model
num_epochs = 55;
num_batches = N - batch_size;

for epoch = 1:num_epochs
    epoch_loss = 0; 
    for i = 1:num_batches % Sliding window of length = batch_size and shift = 1
        X = X_all(i:i+batch_size, :); 
        Y = Y_all(i:i+batch_size, :);

        Y_predicted = forward(X, W, b);
        batch_loss = cross_entropy(Y, Y_predicted);   
        epoch_loss = epoch_loss + batch_loss;

        %computing grad in order to implement gradient descent
        [d_CE_d_W, d_CE_d_b] = backward(X, Y, Y_predicted); 

        %gradient decent step
        W = W - learning_rate*d_CE_d_W;
        b = b - learning_rate*d_CE_d_b;
        
    end 

    epoch_loss = epoch_loss/num_batches;
    disp(strcat('epoch_loss = ', num2str(epoch_loss)));
end

% Using the trained model to predict the probabilities of some examples and the compute the accuracy 

% Predict the normalized example [45, 85]
example = ([45, 85] - meanX)./stdX;

disp('Predicting the probabilities of example [45, 85]');
pred = forward(example,W,b)
% Predict the accuracy of the training examples

%using forward function in order to predict the class of each sample
predictions = (forward(X_all,W,b)>=0.5);

%plotting predictions in order to see which samples were predicted wrong
pred_neg = (predictions==0);
pred_pos = (predictions==1);
plot(X_all(pred_neg,1),X_all(pred_neg,2),'bo');
plot(X_all(pred_pos,1),X_all(pred_pos,2),'ro');
hold off;
legend('actual 0', 'actual 1', 'predicted 0','predicted 1');

%calculating the accuracy of the nn as the num of correct predictions/
%total samples
accuracy = sum(predictions==Y_all')/N
 


