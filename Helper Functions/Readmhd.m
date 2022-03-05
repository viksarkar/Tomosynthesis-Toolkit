function [x_dim,y_dim,z_dim,x_start,y_start,z_start,x_pixdim,y_pixdim,z_pixdim,filename] = Readmhd(fname)
% Code written by Lan Lin
% Modified by Vikren Sarkar
try 
    header = textread(fname,'%s','delimiter','\n','whitespace','');
    for i = 1:length(header)
         if findstr('DimSize',header{i})
             %read in x_dim,y_dim,z_dim 
             [A,B,C,D] = strread(header{i},'%s%f%f%f','delimiter','=');
             x_dim = B;
             y_dim = C;
             z_dim = D;
         end
         if findstr('ElementSpacing',header{i})
             %read in x_pixdim,y_pixdim,z_pixdim
             [A,B,C,D] = strread(header{i},'%s%f%f%f','delimiter','=');
             x_pixdim = B;
             y_pixdim = -C;
             z_pixdim = D;
         end
         if findstr('Offset',header{i})
             %read in x_start,y_start,z_start
             [A,B,C,D] = strread(header{i},'%s%f%f%f','delimiter','=');
             x_start = B;
             y_start = C;
             z_start = D;
         end
         if findstr('ElementDataFile',header{i})
             %read in rawfilename
             [A B] = strread(header{i},'%s%s','delimiter','=');
             filename = cell2mat(B);
         end
     end
catch
    %errordlg('Error in reading the file! The file name may not be right or the file does not exist');
    errmsg = lasterr;
    msgbox(errmsg);
end