%
% Copyright 2017 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.
%

function [result] = evc_white_balance(input, white)
%evc_white_balance performs white balancing manually.

%   INPUT
%   input       ... image
%   white       ... a color (as RGB vector) that should become the new white

%   OUTPUT
%   result      ... result after white balance

    %NOTE:  The following line can be removed. It prevents the framework
    %       from crashing.
  
 
    
    %TODO:  perform white balancing using the 'white' variable
    
    %NOTE:  pixels brighter than 'white' will have values > 1.
    %       This requires a normalization which will be performed
    %       during the histogram clipping. 
	
	%HINT: Make sure the program does not crash if 'white' is zero!
    
    %result = zeros(size(input));
    if(white==0)
        white=0.00001;
    end
    white=1./white; %K.wert
    R = input(:,:,1) / white(1);
    G = input(:,:,2) / white(2);
    B = input(:,:,3) / white(3);
    result = cat(3,R,G,B);
	
end