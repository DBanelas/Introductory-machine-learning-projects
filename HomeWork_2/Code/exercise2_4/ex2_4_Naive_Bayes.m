clear all;
close all;
clc;

load('digits');
[n,m] = size(train0);

%3-dimensional matrix with all the training data
trainset = make_set(train0,train1,train2,train3,train4,train5,train6,train7,train8,train9);
%3-dimensional matrix with all the testing data
testset = make_set(test0,test1,test2,test3,test4,test5,test6,test7,test8,test9);


%compute bernoulli p parameter for every digit, for every pixel
%p is a 10 by 784 matrix (10 digits , 784 pixels per digit)
for i=1:10
  
    p(i,:) = (1/n) * sum(trainset(:,:,i));
    
end

%p = 0  and p = 1 makes the log function go nuts
e = 0.0000001;
p(p==1) = 1-e;
p(p==0) = e;


%make pictures of p parameters of every digit
%  for i = 1:10
%      figure(i);
%      A = reshape(p(i,:),28,28)';
%      imagesc(A);  
%      colorbar;
%  end


log_likelihood = zeros(1,10);
errors = zeros(1,10);
accuracy = zeros(1,10);
confusion_matrix = zeros(10,10);

%this block of code may contain a lot of information
% and may be dificult to read
% nevertheless it is compact and robust 
% and saves us from writing duplicate blocks of code

% iterate over every digits
for digit = 0 : 9
    
    test = testset(:,:,digit+1);
    
    %iterate over every test image of specific digit
    for i=1:n
    
        % compute log likelihood for every every p parameter
        for j=1:10

            log_likelihood(j)= test(i,:) * log(p(j,:))' + (1 - test(i,:)) * log(1 - p(j,:))';

        end
    
        % we decide based on the max log likelihood 
        [~,index_of_max]  = max(log_likelihood);
        decision = index_of_max - 1;
        
        %number of errors per digit
         if(decision~=digit)
            errors(digit+1) = errors(digit+1)+1;
         else
             accuracy(digit +1 ) = accuracy(digit +1 ) +1;
         end
             
        
        % construct confusion matrix
        confusion_matrix(digit+1, index_of_max) = confusion_matrix(digit+1, index_of_max) + 1;
    
    end
     
end

accuracy = (1/5)* accuracy;
nila = sum(accuracy)
avg = nila/size(accuracy,2)

%percentage of error per digit
errors = 100/n * errors;
















