function [ i, j, k] = findijk( m, posx )
%convert position that Matlab gives as in 1 Dimension back to 3D
%   The find function in Matlab considers matrixes and arrays of matrixes
%   as one single array hence the position this function gives need to be
%   converted

x_plane = mod(posx,m^2);
if mod(x_plane, m) == 0
    i = m;
    j = x_plane / m;
else 
    i = mod(x_plane,m);
    j = floor(x_plane/m)+1;
end


  k=floor(posx/m^2)+1;
  if mod(posx,m^2) == 0
      k=posx/m^2;
      i=m;
      j=m;
  end
end

