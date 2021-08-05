function [d_CE_d_W, d_CE_d_b] = backward(X, Y, Y_predicted)
    % your code here

        % Need to implement dJ/dW and dJ/db
        
        B = size(X,1);
        
        %partial derivative of cross entropy with respect to weight matrix
        %W
        d_CE_d_W = (1/B)*X'*(Y_predicted' - Y);
        
        %partial derivative of cross entropy with respect to bias b
        d_CE_d_b = (1/B)*sum((Y_predicted' - Y));
    
end