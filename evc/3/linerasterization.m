%
% Copyright 2017 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.
%

function linerasterization( mesh, framebuffer )
%LINERASTERIZATION iterates over all faces of mesh and draws lines between
%                  their vertices. 
%     mesh                  ... mesh object to rasterize
%     framebuffer           ... framebuffer

    for i=1:numel(mesh.faces)        
        for j=1:mesh.faces(i)
            v1 = mesh.getFace(i).getVertex(j);
            v2 = mesh.getFace(i).getVertex(mod(j, mesh.faces(i)) + 1);
            drawLine(framebuffer, v1, v2);
        end
    end
end

function drawLine( framebuffer, v1, v2 )
%DRAWLINE draws a line between v1 and v2 into the framebuffer using the DDA
%         algorithm.
%     framebuffer           ... framebuffer
%     v1                    ... vertex 1
%     v2                    ... vertex 2


[x1, y1, depth1] = v1.getScreenCoordinates();
[x2, y2, depth2] = v2.getScreenCoordinates();
dx = abs(x2 - x1);
dy = abs(y2 - y1);

if dx == 0 && dy == 0
return;
end

Richtungx = sign(x2-x1);
Richtungy = sign(y2-y1);

if dx >= dy
max = dx;
else
max = dy;
end

mx = dx/max;
my = dy/max;

x = x1;
y = y1;

for k = 1:max
x = x + mx*Richtungx;
y = y + my*Richtungy;

if x2 ~= x1

interpolationFaktor = abs((x - x1)/(x2 - x1));
else

interpolationFaktor = abs((y - y1)/(y2 - y1));
end

farbe = MeshVertex.mix(v1.getColor(),v2.getColor(),interpolationFaktor);

framebuffer.setPixel(round(x),round(y),0,farbe);
%weiss
% framebuffer.setPixel(round(x),round(y),0,[1 1 1]);

end



%   dx = x2 - x1;
%    dy = y2 - y1;
% for x=x1: x2
%  y = y1 + dy * (x1 - x1) / dx;
%  framebuffer.setPixel(x1,y,depth1);
%  y = y2 + dy * (x2 - x1) / dx;
%  framebuffer.setPixel(x2,y,depth2,[1 1 1]);

end

