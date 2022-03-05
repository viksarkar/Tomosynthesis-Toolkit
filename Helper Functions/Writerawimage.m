function rawheadername = Writerawimage(image,header,filename,IsoX,IsoY,IsoZ)
%***********************************************************
% This is a function used to write images as raw data format
% Two kinds of raw data format:
% One is for Pinncale TPS *.img
% The other is for image registration *.raw meta image format
% Copyright at Lan Lin, llin@ctrc.net, Oct-2006
% Modified by Vikren Sarkar, Jun 2008
%************************************************************
image = permute(image,[2 1 3]);

%write raw data as *.raw. This is for later registration
image = CTimagesample(image,2,1);
fid = fopen(filename,'w');
fwrite(fid,image,'ushort');
fclose(fid);
%Update Offset Values based on Isocenter Placement
xisovoxel = ceil(((IsoX - header.xstart)/header.xpixdim)+1);
xstart = -(xisovoxel-1)*header.xpixdim;
yisovoxel = floor((-IsoY + header.ystart)/header.ypixdim);
ystart = yisovoxel*header.ypixdim;
zisovoxel = ceil(((IsoZ + header.zstart)/header.zpixdim)+1);
zstart = -(zisovoxel-1)*header.zpixdim;
%write raw header data as *.mhd. This is for later registration
rawheadername = strcat(filename(1:findstr('.raw',filename)-1),'.mhd');
fid = fopen(rawheadername,'w');
h = cell(1,8);
h{1} = sprintf('ObjectType = Image');
h{2} = sprintf('NDims = %i',length(size(image)));
h{3} = sprintf('DimSize = %i %i %i',header.xdim/2,header.ydim/2,header.zdim);
h{4} = sprintf('ElementSpacing = %.5f %.5f %.5f',header.xpixdim*2,-header.ypixdim*2,header.zpixdim);
h{5} = sprintf('Offset = %.4f %.4f %.4f',xstart,ystart,zstart);
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

%Update Offset Values based on Isocenter Placement (x direction is reversed from the first mhd file)
xisovoxel = ceil(((-IsoX - header.xstart)/header.xpixdim)+1);
xstart = -(xisovoxel-1)*header.xpixdim;
yisovoxel = floor((-IsoY + header.ystart)/header.ypixdim);
ystart = yisovoxel*header.ypixdim;
zisovoxel = ceil(((IsoZ + header.zstart)/header.zpixdim)+1);
zstart = -(zisovoxel-1)*header.zpixdim;
%write a second .mhd file for contour imports (this one uses P3 coordinate system)
contourheader = strcat(filename(1:findstr('.raw',filename)-1),'contour.mhd');
fid = fopen(contourheader,'w');
h = cell(1,9);
h{1} = sprintf('ObjectType = Image');
h{2} = sprintf('NDims = %i',length(size(image)));
h{3} = sprintf('DimSize = %i %i %i',header.xdim,header.ydim,header.zdim);
h{4} = sprintf('ElementSpacing = %.5f %.5f %.5f',header.xpixdim,-header.ypixdim,header.zpixdim);
h{5} = sprintf('Offset = %.4f %.4f %.4f',xstart,ystart,zstart);
h{6} = sprintf('ContourOrigin = %.4f %.4f %.4f', header.xstart, header.ystart, -header.zstart);
h{7} = sprintf('ElementByteOrderMSB = False');
h{8} = sprintf('ElementType = MET_USHORT');
temp = findstr(filename,'\');
if ~isempty(temp)
    elementname = filename(temp(end)+1:end);
else
    elementname = filename;
end
h{9} = sprintf('ElementDataFile = %s',elementname);
fprintf(fid,'%s\n',h{:});
fclose(fid);
    
    
