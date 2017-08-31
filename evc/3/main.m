%
% Copyright 2017 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.
%

% main file to start GUI

clc;
clear workspace;

v = version('-release');

if str2double(v(1, 4)) < 2013     
    ViewerUI();
else     
    framebuffer = Framebuffer(600, 600); 
    % You can change the rasterization mode here to either 'line' or 'fill'
    rasterization_mode = 'line'; % 'fill'
    % You can load another mesh here
    mesh = loadTransformedModel('data/plane.ply', 1);
    
    rasterize(mesh, framebuffer, rasterization_mode);
    
    figure; imshow(framebuffer.image);
    imwrite(framebuffer.image, 'output.png');
end