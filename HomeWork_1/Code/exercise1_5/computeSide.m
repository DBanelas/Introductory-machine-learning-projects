%Function to compute length of non black pixels
%in an image
function [start , diff] = computeSide(image, side)

    %if side == 1 we want to return the height side of the image
    %in order to do that we just flip the image and run th above algorithm
    if side == 1
        image = image';
    end
    
    [num_rows, num_cols] = size(image);
    start  = num_cols;
    the_end = 1;
    
    %Find starting column of wanted side
    for  i = 1 : num_rows
        for j = 1 : num_cols
            if(image(i,j)~=0)
                start = min([start j]);
                break;
            end
        end 
    end
    
    %Find ending column of wanted side
    for i = 1 : num_rows
        for j = num_cols: -1 : 1 
            if(image(i,j)~=0)
                 the_end = max([the_end j]);
                break;
            end 
        end
    end
    
    %width or height
    start = start -0.5;
    the_end = the_end  + 0.5;
    diff = the_end - start;
    
    


end