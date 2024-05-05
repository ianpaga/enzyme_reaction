%-----ENZYME REACTION!!! ------%
tic
%---place particles ------%
m = 30;   %number of elements in 1D 
M = zeros(m,m,m); %m*m*m cube
M_p = m*m*m;
n = 6000; %number of walkers 
T = 1500000; %number of iterations
yay = 0;
delta_t = 10; %time difference
time = 0;
array_time = zeros(T, 1);
b=5;  %representation of different particle groups, needs to be chosen carefully
a=1;
c=10;
array_zombies_a = zeros(T, 1);
array_zombies_b = zeros(T, 1);
array_zombies_c = zeros(T, 1);

for k=1:m
    for j=1:m
        for i=1:m           %place particles
           if rand <= (n/M_p) 
               if rand < 0.5
               M(i,j,k) = a;
               else
                M(i,j,k) = b;
               end
               M_p = M_p -1;
               n = n-1;
           else
               M_p = M_p -1;
           end
        end
    end
end

%----create Boundary conditions------%

M_wb = nan(m+2,m+2,m+2);   %Surround cube with nan elements
M_wb(2:m+1, 2:m+1, 2:m+1) = M;
%----RUN HARRY RUN---------%

for l=1:T  

x = find(M);  %find nonzero elements
xaa = find(M==a);  %check if any A partices are left
if isempty(xaa) 
    break
end
pos = round((length(x)-1)*rand)+1; %pick one randomly

posx=x(pos);

[ i, j, k] = findijk( m, posx ); %convert coordinates into 3D

  if M(i,j,k) ~= 0  %check function
   yay = yay + 1;
    %M(i,j,k) = 0;
  end
 
  
  sp=6;  %number of surrounding points
  i_wb = i +1; %transform into boundary cube
  j_wb = j+1;
  k_wb = k+1;
  if isnan(M_wb(i_wb,j_wb,k_wb))
      break
  end
  if isnan(M_wb(i_wb+1,j_wb,k_wb)) || isnan(M_wb(i_wb-1,j_wb,k_wb))  %correct number of surrrounding points
      sp=sp-1;
  end
  if isnan(M_wb(i_wb,j_wb+1,k_wb)) || isnan(M_wb(i_wb,j_wb+1,k_wb))
      sp=sp-1;
  end
  if isnan(M_wb(i_wb,j_wb,k_wb+1)) || isnan(M_wb(i_wb,j_wb,k_wb-1))
      sp=sp-1;
  end
  
  d = (rand*(sp));
  r=i_wb;
  s=j_wb;
  t=k_wb;

  
 [ i_wb, j_wb, k_wb ] = move3D( i_wb, j_wb, k_wb, r, s, t, d, M_wb, sp ); %get new position

  
  i=i_wb-1;  %transform back
  j=j_wb-1;
  k=k_wb-1;
  r=r-1;  %transform old position to cube without boundaries
  s=s-1;
  t=t-1;
  
  
  if M(i,j,k) == 0  %move
      M(i,j,k) = M(r,s,t);
      M(r,s,t) = 0;
  elseif M(r,s,t) + M(i,j,k) == a+b 
      M(r,s,t) = c;  %create c
      M(i,j,k) = b;  %keep enzyme
  else
      temp = M(r,s,t);  %swap places
      M(r,s,t) = M(i,j,k);
      M(i,j,k) = temp;
  end
 % M(i,j,k) = M(i,j,k) +1;
  %M(M==2) = 0;
  time = time + delta_t/length(x);
  array_time(l) = time;
  x_a = find(M==a);
  array_zombies_a(l) = length(x_a);
  x_b = find(M==b);
  array_zombies_b(l) = length(x_b);
  x_c = find(M==c);
  array_zombies_c(l) = length(x_c);

disp(l);

end

plot(array_time(1:l-1), array_zombies_a(1:l-1));
hold on
legend('enzyme type A', 'Fontsize',15)

plot(array_time(1:l-1), array_zombies_b(1:l-1));
hold on
legend('enzyme type B', 'Fontsize',15)

plot(array_time(1:l-1), array_zombies_c(1:l-1));
hold on
legend('enzyme type C', 'Fontsize',15)

xlabel('Number of iterations', 'Fontsize',15)
ylabel('Number of enzymes', 'Fontsize',15)
title('Number of enzymes (random walkers) in 3D', 'Fontsize',15)

hold off
toc