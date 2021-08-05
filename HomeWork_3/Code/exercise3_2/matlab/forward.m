function y = forward(x, W, b)
    %Input x comes in batches

    %sum of weight * input + bias for every input
    temp = W'*x' + b;
    
    %sigmoid returns the prediction for every input
    y = sigmoid(temp);
  
end