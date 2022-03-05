function a = connectedness(A,i,j,k)
a=0;
if (A(i-1,j-1,k)==A(i,j,k))
    a=a+1;
end
if (A(i,j-1,k)==A(i,j,k))
    a=a+1;
end
if (A(i+1,j-1,k)==A(i,j,k))
    a=a+1;
end
if (A(i-1,j,k)==A(i,j,k))
    a=a+1;
end
if (A(i+1,j,k)==A(i,j,k))
    a=a+1;
end
if (A(i-1,j+1,k)==A(i,j,k))
    a=a+1;
end
if (A(i,j+1,k)==A(i,j,k))
    a=a+1;
end
if (A(i+1,j+1,k)==A(i,j,k))
    a=a+1;
end