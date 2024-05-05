function [ i_wb, j_wb, k_wb ] = move3D( i_wb, j_wb, k_wb, r, s, t, d, M_wb, sp )
%choose new position in all 3D cases
%   surround M with nan elements, choose, check if nan element, carry on
if d < 1               %move in any direction randomly
      i_wb=i_wb+1;
  elseif d < 2
      i_wb=i_wb-1;
  elseif d < 3
      j_wb=j_wb+1;
  elseif d <4
      j_wb=j_wb-1;
  elseif d < 5
      k_wb=k_wb+1;
  elseif d < 6
      k_wb=k_wb+1;
  end
  
   while isnan(M_wb(i_wb, j_wb, k_wb))  %check whether new position is NaN, repeat until it is not
      i_wb=r;    %go back to old position
      j_wb=s;
      k_wb=t;
  d = (rand*(sp));  % choose a different position
  if d < 1
      i_wb=i_wb+1;
  elseif d < 2
      i_wb=i_wb-1;
  elseif d < 3
      j_wb=j_wb+1;
  elseif d <4
      j_wb=j_wb-1;
  elseif d < 5
      k_wb=k_wb+1;
  elseif d < 6
      k_wb=k_wb+1;
  end
  end

end

