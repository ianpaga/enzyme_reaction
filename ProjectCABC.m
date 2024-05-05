%-----ABC reaction model!!! ------%

%---place walkers ------%
m = 30;  %number of elements in 1D
M = zeros(m,m,m);  %m*m*m elements cube
M_p = m*m*m; 
n = 9000;  %number of walkers
T = 98000; %maximum number of iterations
yay = 0;   %check if function works
delta_t = 10;  %time difference
time = 0;
array_time = zeros(T, 1); %stores time
b=5;  %walkers indication
a=1;
c=10;
p_a=1; %annihilation probabilities for particle groups
p_b =1;
p_c= 0.1;
array_zombies_a = zeros(T, 1);  %keeping track 
array_zombies_b = zeros(T, 1);
array_zombies_c = zeros(T, 1);

for k=1:m                                 % place walkers
    for j=1:m
        for i=1:m
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

M_wb = nan(m+2,m+2,m+2);
M_wb(2:m+1, 2:m+1, 2:m+1) = M;
%----ABC Reaction ---------%

for l=1:T

x = find(M);  %find all nonzero elements
if isempty(x) %check if empty
    break
end
pos = round((length(x)-1)*rand)+1;  %pick one randomly
posx=x(pos);

[ i, j, k] = findijk( m, posx );   %convert into 3D coordinates

  if M(i,j,k) ~= 0  
   yay = yay + 1;  %check if function works
  end
 
  
  sp=6;
  i_wb = i +1;  %transform coordinates to cube with boundaries
  j_wb = j+1;
  k_wb = k+1;
  if isnan(M_wb(i_wb,j_wb,k_wb))
      break
  end
  if isnan(M_wb(i_wb+1,j_wb,k_wb)) || isnan(M_wb(i_wb-1,j_wb,k_wb))    %finds number of surrounding points
      sp=sp-1;
  end
  if isnan(M_wb(i_wb,j_wb+1,k_wb)) || isnan(M_wb(i_wb,j_wb+1,k_wb))
      sp=sp-1;
  end
  if isnan(M_wb(i_wb,j_wb,k_wb+1)) || isnan(M_wb(i_wb,j_wb,k_wb-1))
      sp=sp-1;
  end
  
  d = (rand*(sp));  %creates random number
  r=i_wb;  %store old position
  s=j_wb;
  t=k_wb;

  
[ i_wb, j_wb, k_wb ] = move3D( i_wb, j_wb, k_wb, r, s, t, d, M_wb, sp ); %find new positions

  
  i=i_wb-1;   %transform back
  j=j_wb-1;
  k=k_wb-1;
  r=r-1;
  s=s-1;
  t=t-1;
  
  
  if M(i,j,k) == 0    %ABC reaction cases
      M(i,j,k) = M(r,s,t); %just move
      M(r,s,t) = 0;
  elseif M(r,s,t) == M(i,j,k)  %kill identical particles upon meeting
      if M(r,s,t) == a
          p=p_a;
      elseif M(r,s,t) == b
          p=p_b;
      elseif M(r,s,t) == c
          p=p_c;
      end
      if rand <= p     
           M(r,s,t) = 0;
           M(i,j,k) = 0;
      end
      
  elseif M(r,s,t) + M(i,j,k) == a+b %A+B=C
      M(r,s,t) = 0;
      M(i,j,k) = c;
  else
      temp = M(r,s,t);  %swap positions
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
end

plot(array_time(1:l), array_zombies_a(1:l));
hold on
plot(array_time(1:l), array_zombies_b(1:l));
hold on
plot(array_time(1:l), array_zombies_c(1:l));
hold off
