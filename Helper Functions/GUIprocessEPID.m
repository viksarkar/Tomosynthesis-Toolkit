function img = GUIprocessEPID(filesuffix, filenumbers)
% Reads in EPID images in format to be used with VC++ code
% Routine to open a set of EPID Images (8-bit unsigned little endian format)
% Suffix is first part of filename (E.g. 1-00 if files named 1-0001, 1-0002 etc...)
% filenumbers is a vector giving image numbers to be read so that they correspond to the correct angles
numproj = size(filenumbers,2);
img = zeros(512,512,numproj);
for i=1:numproj
    if filenumbers(i)>=1 && filenumbers(i)<=9
        filename = strcat(filesuffix,'0',num2str(filenumbers(i)));
    else
        filename = strcat(filesuffix,num2str(filenumbers(i)));
    end
    fid = fopen(filename,'r','l');
    A = fread(fid, 'uint8');
    fclose(fid);
    A = reshape(A,512,512);
    for k = 1:512
        for j = 1:512
            if A(j,k)==0
                A(j,k) = 255;
            end
            if A(k,j)== 0
                A(k,j) = 255;
            end
        end
    end
    img(:,:,i)=A;
end