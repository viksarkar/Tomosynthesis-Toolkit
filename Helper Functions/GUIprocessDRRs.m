function img = GUIprocessDRRs(directory,ang)
% This saves images to be used with VC++ code
% Function assumes the files are numerically named consecutively with a .dcm extension
% Function to clean up garbage from DRRs exported from Pinnacle (removes plan info and field indicator)
% Final images are 462 x 462 pixels with pixdim of (40/410) cm
% Written by V Sarkar, Jul 2008
img = zeros(462,462,size(ang,2));
for currentangle = 1:size(ang,2)
    filename = strcat(directory,num2str(ang(currentangle)),'.dcm');
    fid = fopen(filename, 'r');
    A = fread(fid, 'uint8');
    fclose(fid);
    headersize = size(A,1)-(512*512);
    A = A(headersize+1:size(A,1));
    A = reshape(A, 512, 512);
%     A = rot90(A,3);
%     A = fliplr(A);
    % Determine location of vertical line representing middle of field
    if A(54,256)==A(55,256) && A(54,256)==A(56,256) && A(54,256)==255
        vertmidlineposupper = 256;
    else if A(54,257)==A(55,257) && A(54,257)==A(56,257) && A(54,257)==255
            vertmidlineposupper = 257;
        else if A(54,258)==A(55,258) && A(54,258)==A(56,258) && A(54,258)==255
                vertmidlineposupper = 258;
            end
        end
    end
    if A(459,256)==A(458,256) && A(459,256)==A(457,256) && A(459,256)==255
        vertmidlineposlower = 256;
    else if A(459,257)==A(458,257) && A(459,257)==A(457,257) && A(459,257)==255
            vertmidlineposlower = 257;
        else if A(459,258)==A(458,258) && A(459,258)==A(457,258) && A(459,258)==255
                vertmidlineposlower = 258;
            end
        end
    end
    % Determine location of horizontal line representing middle of field
    if A(256,54)==A(256,55) && A(256,54)==A(256,56) && A(256,54)==255
        horimidlineposleft = 256;
    else if A(257,54)==A(257,55) && A(257,54)==A(257,56) && A(257,54)==255
            horimidlineposleft = 257;
        else if A(258,54)==A(258,55) && A(258,54)==A(258,56) && A(258,54)==255
                horimidlineposleft = 258;
            end
        end
    end
    if A(256,459)==A(256,458) && A(256,459)==A(256,457) && A(256,459)==255
        horimidlineposright = 256;
    else if A(257,459)==A(257,458) && A(257,459)==A(257,457) && A(257,459)==255
            horimidlineposright = 257;
        else if A(258,459)==A(258,458) && A(258,459)==A(258,457) && A(258,459)==255
                horimidlineposright = 258;
            end
        end
    end
    % Erase field marker vertical line
    for vertpos = 52:horimidlineposleft
        A(vertpos, vertmidlineposupper)=(A(vertpos, vertmidlineposupper+1)+A(vertpos, vertmidlineposupper-1))/2;
    end
    for vertpos = horimidlineposleft+1:461
        A(vertpos, vertmidlineposlower)=(A(vertpos, vertmidlineposlower+1)+A(vertpos, vertmidlineposlower-1))/2;
    end
    % Erase field marker horizontal lines
    for horipos = 52:vertmidlineposupper
        A(horimidlineposleft, horipos)=(A(horimidlineposleft+1, horipos)+A(horimidlineposleft-1, horipos))/2;
    end
    for horipos = vertmidlineposupper+1:461
        A(horimidlineposright, horipos)=(A(horimidlineposright+1, horipos)+A(horimidlineposright-1, horipos))/2;
    end
    % Erase all horizontal tickmarks
    shorttickloc = [62,72,82,93,113,123,134,144,164,175,185,195,216,226,236,246,267,277,287,297,318,328,338,349,369,379,390,400,420,431,441,451];
    longtickloc = [103,154,205,308,359,410];
    for i=1:size(shorttickloc,2)
        for j = 252:260
            A(shorttickloc(1,i),j) = (A(shorttickloc(1,i)-1,j) + A(shorttickloc(1,i)+1,j))/2;
        end
    end
    for i=1:size(longtickloc,2)
        for j = 248:264
            A(longtickloc(1,i),j) = (A(longtickloc(1,i)-1,j) + A(longtickloc(1,i)+1,j))/2;
        end
    end
    % Erase all vertical tickmarks
    for i= 252:260
        for j = 1:size(shorttickloc,2)
            A(i,shorttickloc(1,j)) = (A(i,shorttickloc(1,j)-1) + A(i,shorttickloc(1,j)+1))/2;
        end
    end
    for i=248:264
        for j = 1:size(longtickloc,2)
            A(i,longtickloc(1,j)) = (A(i,longtickloc(1,j)-1) + A(i,longtickloc(1,j)+1))/2;
        end
    end
    A = A(103:410, 103:410);
    A = imresize(A,1.5);
    for i = 1:462
        for j = 1:462
            A(i,j) = 255 - A(i,j);
        end
    end
    img(:,:,currentangle) = A;
end