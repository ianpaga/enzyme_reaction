function [ i,j ] = findij(posx, m)
%convert position that Matlab gives as in 1 Dimension back to 2D
%   The find function in Matlab considers matrixes and arrays of matrixes
%   as one single array hence the position this function gives need to be
%   converted
if mod(posx, m) == 0
    i = m;
    j = posx / m;
else 
    i = mod(posx,m);
    j = floor(posx/m)+1;
end

end

