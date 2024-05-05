function [ i,j ] = movewalker( m, posx, i, j )
%Finds ne position for walker
%   Differentiates between all corners. edges and inside points

sp = 4;
if posx <= m
    if posx == 1
        sp = 2;
        if rand < (1/sp)
           i=i+1;
        else
            j=j+1;
        end
    elseif posx == m
        sp = 2;
        if rand < (1/sp)
           i=i-1;
        else
            j=j+1;
        end
    else 
        sp = sp-1;
        d = floor(rand*(sp));
        if d == 0
           i=i+1; 
        elseif d == 1
            i=i-1;
        elseif d == 2 || d == 3
            j=j+1;
        end
    end
elseif posx >m^2-m
   if posx == m^2-m+1
        sp = 2;
        if rand < (1/sp)
           i=i+1;
        else
            j=j-1;
        end
    elseif posx == m^2
        sp = 2;
        if rand < (1/sp)
           i=i-1;
        else
            j=j-1;
        end
    else 
        sp = sp-1;
        d = floor(rand*(sp));
        if d == 0
           i=i+1; 
        elseif d == 1
            i=i-1;
        elseif d == 2 || d == 3
            j=j-1;
        end
   end
elseif i == 1
        sp = sp-1;
        d = floor(rand*(sp));
        if d == 0
           i=i+1; 
        elseif d == 1
            j=j-1;
        elseif d == 2 || d == 3
            j=j+1;
        end
elseif i == m
        sp = sp-1;
        d = floor(rand*(sp));
        if d == 0
           j=j-1; 
        elseif d == 1
            i=i-1;
        elseif d == 2 || d == 3
            j=j+1;
        end
else
    d = floor(rand*(sp));
        if d == 0
           j=j-1; 
        elseif d == 1
            i=i-1;
        elseif d == 2 
            j=j+1;
        else
            i=i+1;
        end
end
end

