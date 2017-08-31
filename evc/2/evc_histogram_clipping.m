%
% Copyright 2017 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.
%

function [result, fnc_prep_histogram, fnc_tranform_histogram, fnc_clip_histogram] = evc_histogram_clipping(input, low, high)
% This function is our main function. It executes all functions, that
% were implemented by you, in the correct order.

% ATTENTION: You are not allowed to change this function!
    
	fnc_prep_histogram = @(input, low, high) 			evc_prepare_histogram_range(input, low, high);
	fnc_tranform_histogram = @(input, newLow, newHigh) 	evc_transform_histogram(input, newLow, newHigh);
	fnc_clip_histogram = @(input) 						evc_clip_histogram(input);
	
	[newLow, newHigh] 		= evc_prepare_histogram_range(input, low, high);
	result                  = evc_transform_histogram(input, newLow, newHigh);
	result                  = evc_clip_histogram(result);
end


function [newLow, newHigh] = evc_prepare_histogram_range(input, low, high)
%evc_prepare_histogram_range first calculates the new upper- and lower-
% bounds. During the normalization, those two values are then mapped to [0,1]. 
% If 'low' < 0, it should be set to 0.
% If 'high' > than the maximum intensity in the image, it should be set
% to the maximum intensity.

%   INPUT
%   input 		... image
%   low   		... current black value
%   high  		... current white value

%   OUTPUT	
%   newLow      ... new black value	
%   newHigh     ... new white value

	%TODO:	Implement this function.
   % maxIntensity = max(input(:));

  
     newLow = low;
    newLow(newLow < 0) = 0;
    

    maximum = max(input(:));

    newHigh = high;
    newHigh(newHigh > maximum) = maximum;
end

function [result] = evc_transform_histogram(input, newLow, newHigh)
%evc_transform_histogram performs the 'histogram normalization' and 
% maps the interval [newLow, newHigh] to [0, 1].

%   INPUT
%   input 		... image
%   newLow   	... black value
%   newHigh  	... white value

%   OUTPUT	
%   result		... image after the histogram normalization

	%HINT: 	If the current white value is smaller than the maximum intensity
    %       of the image, this function will create values larger than 1.
    
	%NOTE:  The following line can be removed. It prevents the framework
    %       from crashing.
    
	%TODO:	Implement this function.

     result= (input-newLow)/(newHigh-newLow);
end

function [result] = evc_clip_histogram(img)
% After the transformation of the histogram, evc_clip_histogram sets all 
% values that are < 0 to 0 and values that are > 1 to 1.

%   INPUT
%   img 		... image after the histogram normalization

%   OUTPUT	
%   result		... image after the clipping operation

	%NOTE: The following line can be removed. It prevents the framework
    %from crashing.
    
	%TODO:	Implement this function.
     result = img;
    result(result < 0) = 0;
    result(result > 1) = 1;
    
end