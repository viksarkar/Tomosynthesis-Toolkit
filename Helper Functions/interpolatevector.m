function M = interpolatevector(B)
% This function will double the amount of data in B vector by 
% using linear interpolation on all vector columns
[m,n]=size(B);
M = zeros(2*m-1,n);
for z = 0:m-2
   M((2*z)+1,1)=B(z+1,1);
   M((2*z)+1,2)=B(z+1,2);
   M((2*z)+1,3)=B(z+1,3);
   M((2*z)+2,1)=(B(z+1,1)+B(z+2,1))/2;
   M((2*z)+2,2)=(B(z+1,2)+B(z+2,2))/2;
   M((2*z)+2,3)=(B(z+1,3)+B(z+2,3))/2;
end
M((2*m-1),1) = B(m,1);
M((2*m-1),2) = B(m,2);
M((2*m-1),3) = B(m,3);
