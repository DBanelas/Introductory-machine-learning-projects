function v = fisherLinearDiscriminant(X1, X2)

    %number of features for each class
    numOfFeat = size(X1, 2);
    
    %number of samples for each class
    m1 = size(X1, 1);
    m2 = size(X2, 1);

   
    % mean value of X1
    for  i = 1 : numOfFeat
        mu1(i) = sum(X1(:,i))*(1/m1);
    end
    % making mu1 an column vector
    mu1 = mu1';
    
    
   % mean value of X2
    for  i = 1 : numOfFeat
        mu2(i) = sum(X2(:,i))*(1/m2);
    end
    % making mu2 an column vector
    mu2 = mu2';
    
    % scatter matrix of X1
    S1 = (1/m1).*(transpose(X1) * X1);
    
    % scatter matrix of X2
    S2 = (1/m2).*(transpose(X2) * X2);
    
    %sum of the covariance matrices*(a-priori p of each class) is the total within-class variance if
    %the 2 classes
    p1 = m1/(m1+m2);
    p2 = m2/(m1+m2);
    
    Sw =p1*S1 + p2*S2;

    % optimal direction for maximum class separation 
    v = inv(Sw)*(mu1-mu2);

    v = v/norm(v);
