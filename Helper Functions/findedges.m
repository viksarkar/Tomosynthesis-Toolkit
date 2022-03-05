function results = findedges(A)

[m,n,o] = size(A);
tempdata = zeros(m,o,n);
se = strel('square',3);

for slice = 1:n
    tempdata(:,:,slice) = squeeze(A(:,slice,:));
    tmp = tempdata(:,:,slice);
    tmp = imerode(tmp, se);
    tempdata(:,:,slice) = tempdata(:,:,slice)-tmp;
end

% % % Allocate space to store limits
% % limits = zeros(n,4);
% % 
% % % Determine y limits of where the contours are
% % for z=1:n
% %     lowy = 0;
% %     highy = 0;
% %     for y=1:o
% %         for x=1:m
% %             if(tempdata(x,y,z)~=0)
% %                if(lowy==0)
% %                    lowy = y;
% %                end
% %                highy = y;
% %             end
% %         end
% %         limits(z,1)=lowy;
% %         limits(z,2)=highy;
% %     end
% % end
% % 
% % % Determine x limits of where the contours are
% % for z=1:n
% %     lowx = 10000;
% %     highx = 0;
% %     for y=1:o
% %         for x=1:m
% %             if(tempdata(x,y,z)~=0)
% %                if(lowx>x)
% %                    lowx = x;
% %                end
% %                if (highx<x)
% %                    highx = x;
% %                end
% %             end
% %         end
% %         limits(z,3)=lowx;
% %         limits(z,4)=highx;
% %     end
% % end
% % results = limits;
% % % Find contours and erase regions between the ends
% % for z=1:n
% %     if (limits(z,1)~=0)
% %         if limits(z,2)==o,
% %             highy = o-1;
% %         else
% %             highy = limits(z,2);
% %         end
% %         for x = limits(z,3)+1:limits(z,4)-1
% %             leftedge = 0;
% %             rightedge = 0;
% %             for y=limits(z,1):highy
% %                 if(tempdata(x,y,z)~=0)
% %                    if(leftedge == 0)
% %                        leftedge = y;
% %                    else if(tempdata(x,y+1,z)==0)
% %                            rightedge = y;
% %                        end                   
% %                    end
% %                 end
% %             end
% %             if (leftedge ~= 0 && (rightedge == 0 || rightedge == o-1) && tempdata(x,y,z)~=0)
% %                 rightedge = limits(z,2);
% %             end
% %             if(rightedge > leftedge)
% %                 tempdata(x,leftedge+1:rightedge-1,z)=0;
% %                 leftedge = 0;
% %                 rightedge = 0;
% %             end
% %         end
% %     end
% % end
results = zeros(size(A));
for z = 1:o
    results(:,:,z) = squeeze(tempdata(:,z,:));
end
clear tempdata
