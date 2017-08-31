%
% Copyright 2017 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.
%

function[image_swapped, image_mark_green, image_masked, image_reshaped, image_convoluted, image_edge] = Images()

%% Initialization. Do not change anything here
input_path = 'lena_color.jpg';
output_path = 'lena_output.png';

image_swapped = [];
image_mark_green = [];
image_masked = [];
image_reshaped = [];
image_edge = [];


%% I. Images basics
% 1) Load image from 'input_path'

image = imread(input_path);

% 2) Convert the image from 1) to double format with range [0, 1]. DO NOT USE LOOPS.
image = im2double(image);

% 3) Use the image from 2) to create an image where the red and the green channel
% are swapped. The result should be stored in image_swapped. DO NOT USE LOOPS.
red = image(:,:,1);
green = image(:,:,2);
image_swapped(:,:,1) = green;
image_swapped(:,:,2) = red;
image_swapped(:,:,3) = image(:,:,3);

% 4) Display the swapped image
%imshow(image_swapped);

% 5) Write the swapped image to the path specified in output_path. The
% image should be in png format.
imwrite(image_swapped,output_path);

% 6) Create logical image where every pixel is marked that has a green channel
% which is greater or equal 0.7. The result should be stored in image_mark_green. 
% Use the image from step 2 for this step.
% DO NOT USE LOOPS.
% HINT:
% see http://de.mathworks.com/help/matlab/matlab_prog/find-array-elements-that-meet-a-condition.html).
image_mark_green = logical(image(:,:,2)>0.7)


% 7) Set all pixels in the original image (the double image from step 2) to black where image_mark_green is
% true (where green >= 0.7). Store the result in image_masked. 
% You can use 'repmat' to complete this task. DO NOT USE LOOPS. 

image_masked = image;
r=image_masked(:,:,1);
g=image_masked(:,:,2);
b=image_masked(:,:,3);
r(image_mark_green==1) = 0;
g(image_mark_green==1) = 0;
b(image_mark_green==1) = 0;
image_masked(:,:,1) = r;
image_masked(:,:,2) = g;
image_masked(:,:,3) = b;

% 8) Convert the original image (the double image from step 2) to a grayscale image and reshape it from
% 512x512 to 1024x256. Cut off the right half of the image and attach it to the bottom of the left half.
% The result should be stored in 'image_reshaped' DO NOT USE LOOPS.
% (Hint: Matlab adresses matrices with "height x width")

image_reshaped = image;
image_reshaped = rgb2gray(image_reshaped);
right_half = image_reshaped(:,1:256);
left_half = image_reshaped(:,257:512);
image_reshaped = [right_half; left_half]
%imshow(image_reshaped)

%% II. Filters and convolutions

% 1) Use fspecial to create a 5x5 gaussian filter with sigma=2.0
%TODO: Delete the next line and add your code here
gauss_kernel = fspecial('gaussian',[5 5],2.0);
% 2) Implement the evc_filter function. You are allowed to use loops for
% this task. You can assume that the kernel is always of size 5x5.
% For pixels outside the image use 0. 
% Do not use the conv or the imfilter or similar functions here. The result should be
% stored in image_convoluted
% The output image should have the same size as the input image.
image_convoluted = evc_filter(image_swapped, gauss_kernel);
imshow(image_convoluted)

% 3) Create a image showing the horizontal edges in image_reshaped using the sobel filter.
% For this task you can use imfilter/conv.
% Attention: Do not use evc_filter for this task!
% The result should be stored in image_edge. DO NOT USE LOOPS.
% The output image should have the same size as the input image.
% For this task it is your choice how you handle pixels outside the
% image, but you should use a typical method to do this.
image_edge = imfilter(image_reshaped, [ -1,  -2, -1;
                                         0,   0,  0;
                                         1,   2,  1], 'replicate');
%imshow(image_edge);

end
function [result] = evc_filter(input, kernel)
   
    matrixSize = size(input);
    
    for row=1:matrixSize(1)
        for column=1:matrixSize(2)
            
                       newValue = wert(row-2,column-2,input) * kernel(1,1);
            newValue = newValue + wert(row-2,column-1,input) * kernel(1,2);
            newValue = newValue + wert(row-2,column,input) * kernel(1,3);
            newValue = newValue + wert(row-2,column+1,input) * kernel(1,4);
            newValue = newValue + wert(row-2,column+2,input) * kernel(1,5);  
            
            newValue = newValue + wert(row-1,column-2,input) * kernel(2,1);
            newValue = newValue + wert(row-1,column-1,input) * kernel(2,2);
            newValue = newValue + wert(row-1,column,input) * kernel(2,3);
            newValue = newValue + wert(row-1,column+1,input) * kernel(2,4);
            newValue = newValue + wert(row-1,column+2,input) * kernel(2,5);
     
            newValue = newValue + wert(row,column-2,input) * kernel(3,1);
            newValue = newValue + wert(row,column-1,input) * kernel(3,2);
            newValue = newValue + wert(row,column,input) * kernel(3,3);
            newValue = newValue + wert(row,column+1,input) * kernel(3,4);
            newValue = newValue + wert(row,column+2,input) * kernel(3,5);
            
            newValue = newValue + wert(row+1,column-2,input) * kernel(4,1);
            newValue = newValue + wert(row+1,column-1,input) * kernel(4,2);
            newValue = newValue + wert(row+1,column,input) * kernel(4,3);
            newValue = newValue + wert(row+1,column+1,input) * kernel(4,4);
            newValue = newValue + wert(row+1,column+2,input) * kernel(4,5);
            
            
            newValue = newValue + wert(row+2,column-2,input) * kernel(5,1);
            newValue = newValue + wert(row+2,column-1,input) * kernel(5,2);
            newValue = newValue + wert(row+2,column,input) * kernel(5,3);
            newValue = newValue + wert(row+2,column+1,input) * kernel(5,4);
            newValue = newValue + wert(row+2,column+2,input) * kernel(5,5);
            
          
            input(row,column) = newValue;
        end
    end
    
    result = input;
 
end
function [value] = wert(x,y,input)
    if (x<1 || y<1 || x> size(input,2)|| y > size(input,1))
        value = 0;
    else
        value = input(x,y);
    end
end
