function ret = mapFeature( X )
%MAPFEATURE Summary of this function goes here
%   Detailed explanation goes here

    [n,m] = size(X);
    ret = zeros(n,m+1);

    for i=1:n
        
        ret(i,:) = [X(i,1) X(i,2) norm(X(i,:))^2];
        
    end

end

