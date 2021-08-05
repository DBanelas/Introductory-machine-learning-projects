function ce = cross_entropy(Y, Y_predicted)
    % your code here

    B = size(Y,1);
    
    
    ce = (1/B)*(-log(Y_predicted)*Y - log(1-Y_predicted)*(1-Y));
    
end