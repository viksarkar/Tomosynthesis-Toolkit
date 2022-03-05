function [dicomVolume,header]=ReadDicom(dirname)
%************************************************************************
%This function is used to read DICOM images    
%
%   Output Arguments
%     dicomVolume                 =  MxNxP matrix where M x N is image
%                                    array and P indicates img no.
%     header    a structure includes the following info:
%               xdim---dimension of x, ydim---dimension of y,
%               zdim---dimension of z, xpixdim---resolution of x,
%               ypixdim---resolution of y, zpixdim---resolution of z,
%               xstart---start of x, ystart---start of y, 
%               zstart---start of z
%     NOTE: It is assumed that this is an isotropic volume and all dicom
%     files belong to the same volume. 
%
%Copyright @ Lan Lin, llin@ctrc.net, May 2006
%************************************************************************
dfiles = dir(dirname);
dfiles = dfiles(3:end);                   % avoid . and ..in the folder
nfiles = length(dfiles);
filenames = {dfiles.name};
if nfiles<1
    errordlg('No DICOM files available! Please check!')
    return;
end
for i = 1:nfiles
    temp(i) = str2num(filenames{i}(ismember(filenames{i},'0123456789')));
end
[fakeorder,trueorder] = sort(temp);
files = filenames(trueorder);
fileCount = 1;
% % Progress bar
h = waitbar(0,['Loading progress:'],'CreateCancelBtn','delete(h)');
set(h,'Name','Loading CT images');
% set the wait bar as green color
set(findobj(h,'type','patch'),'FaceColor', [0 1 0], 'EdgeColor', [0 1 0]);
for i = 1:nfiles
    filename = strcat(dirname,'\',files{i});
    [dicomVolume(:,:,i)] = dicomread(filename);
    if fileCount == 1
        dicomHeaderInfo = dicominfo(filename);
    end
    fileCount = fileCount + 1;
    waitbar(i/nfiles,h);
end
delete(h);
sizeof = size(dicomVolume);
header = struct('xdim',sizeof(1),...
                'ydim',sizeof(2),...
                'zdim',sizeof(3),...
				'xpixdim',dicomHeaderInfo.PixelSpacing(1),...
				'ypixdim',dicomHeaderInfo.PixelSpacing(2),...
				'zpixdim',dicomHeaderInfo.SliceThickness,...
				'xstart',dicomHeaderInfo.ImagePositionPatient(1),...
                'ystart',dicomHeaderInfo.ImagePositionPatient(2),...
				'zstart',dicomHeaderInfo.ImagePositionPatient(3));
            
