
%%function to plot a digit and its minimum rectangle

function plotDigit(figureNo, image_in)

    
     figure(figureNo);
     colormap(gray);
     image(image_in);
     hold on;
     [~, start_width, start_height, width, height] = computeAspectRatio(image_in);
     plot([start_width, start_width],[start_height, start_height+height], 'r', 'LineWidth' , 3);
     plot([start_width,start_width+width ],[start_height+height,start_height+height],'r', 'LineWidth' , 3 );
     plot([start_width+width,start_width+width],[start_height+height,start_height], 'r', 'LineWidth' , 3);
     plot([start_width+width, start_width], [start_height,start_height], 'r', 'LineWidth' , 3);
     hold off;



end