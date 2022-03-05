function WriterawCTimage(image,header,filename)
%***********************************************************
% This is a function used to write images as raw data format
% The data uses the Pinnacle coordinate system.
% Copyright at Lan Lin, llin@ctrc.net, Oct-2006
% Modified by Vikren Sarkar, Jun 2008
%************************************************************
image = permute(image,[2 1 3]);

%write raw data as *.raw. This is for later registration
% image = CTimagesample(image,2,1);
fid = fopen(filename,'w');
fwrite(fid,image,'ushort');
fclose(fid);
%write raw header data as *.mhd. This is for later registration
rawheadername = strcat(filename(1:findstr('.raw',filename)-1),'.mhd');
fid = fopen(rawheadername,'w');
h = cell(1,8);
h{1} = sprintf('ObjectType = Image');
h{2} = sprintf('NDims = %i',length(size(image)));
h{3} = sprintf('DimSize = %i %i %i',header.xdim,header.ydim,header.zdim);
h{4} = sprintf('ElementSpacing = %.5f %.5f %.5f',header.xpixdim,-header.ypixdim,header.zpixdim);
h{5} = sprintf('Offset = %.4f %.4f %.4f',header.xstart,-header.ystart,-header.zstart);
h{6} = sprintf('ElementByteOrderMSB = False');
h{7} = sprintf('ElementType = MET_USHORT');
temp = findstr(filename,'\');
if ~isempty(temp)
    elementname = filename(temp(end)+1:end);
else
    elementname = filename;
end
h{8} = sprintf('ElementDataFile = %s',elementname);
fprintf(fid,'%s\n',h{:});
fclose(fid);    
    
