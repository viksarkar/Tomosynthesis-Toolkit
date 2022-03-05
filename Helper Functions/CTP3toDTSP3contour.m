function CTP3toDTSP3contour(handles,orientation)

% Write the header files for resampling contours
fid = fopen('from.mhd','w');
h = cell(1,8);
h{1} = sprintf('ObjectType = Image');
h{2} = sprintf('NDims = %i',3);
h{3} = sprintf('DimSize = %i %i %i',handles.contourxsize,handles.contourysize,handles.contourzsize);
h{4} = sprintf('ElementSpacing = %.5f %.5f %.5f',handles.contourxvoxdim,-handles.contouryvoxdim,handles.contourzvoxdim);
h{5} = sprintf('Offset = %.4f %.4f %.4f',handles.imagexoffset,handles.imageyoffset,handles.imagezoffset);
h{6} = sprintf('ElementByteOrderMSB = False');
h{7} = sprintf('ElementType = MET_USHORT');
h{8} = sprintf('ElementDataFile = tempcontours.raw');
fprintf(fid,'%s\n',h{:});
fclose(fid);

fid = fopen('to.mhd','w');
h = cell(1,8);
h{1} = sprintf('ObjectType = Image');
h{2} = sprintf('NDims = %i',3);
h{3} = sprintf('DimSize = %i %i %i',handles.DTSxsize,handles.DTSysize,handles.DTSzsize);
h{4} = sprintf('ElementSpacing = %.5f %.5f %.5f',handles.DTSxvoxdim,-handles.DTSyvoxdim,handles.DTSzvoxdim);
h{5} = sprintf('Offset = %.4f %.4f %.4f',handles.DTSxoffset,handles.DTSyoffset,handles.DTSzoffset);
h{6} = sprintf('ElementByteOrderMSB = False');
h{7} = sprintf('ElementType = MET_USHORT');
h{8} = sprintf('ElementDataFile = tempcontours.raw');
fprintf(fid,'%s\n',h{:});
fclose(fid);

% handles.C = Readp3contour([handles.roipathname,handles.roifilename]);
organnum = 0;
layer = 1;

%Process all contours
for currentcontour = 1:handles.C.Croi
    infowindow = showinfowindow(strcat('Resampling ROI file for ',handles.C.ROI{currentcontour},'. Please wait.'));
    organnum = organnum + 1;
    creatematrix(handles.C,currentcontour,handles.contourxoffset,handles.contouryoffset,handles.contourzoffset,handles.contourxvoxdim,handles.contouryvoxdim,handles.contourzvoxdim,handles.contourxsize, handles.contourysize, handles.contourzsize);
    dos('ContourResample to.mhd from.mhd');
    fid = fopen('Resampledsinglecontour.raw','r');
    tempmatrix = fread(fid,'uint16');
    fclose(fid);
    tempmatrix = reshape(tempmatrix, handles.DTSxsize, handles.DTSysize, handles.DTSzsize);
    max(max(max(tempmatrix)))
    switch orientation 
        case 1 % Coronal DTS slices
            for currentslice = 1:handles.DTSysize
                tmpimg = squeeze(tempmatrix(:,currentslice,:));
                limits = bwboundaries(tmpimg,8); % Trace the contour(s)
                size(limits)
                for contour = 1:size(limits,1) % For each, create a list of coordinates to write the ROI file for P3
                    x(:,1) = limits{contour}(:,1)*(handles.DTSxvoxdim/10)+(handles.DTSxoffset/10);
                    x(:,2) = (handles.DTSzsize-limits{contour}(:,2))*(handles.DTSzvoxdim/10)+(handles.DTSzoffset/10);
                    x(:,3) = currentslice*(handles.DTSyvoxdim/10)+(handles.DTSyoffset/10);
                    handles.newcontour.Points{currentcontour}{layer} = x;
%                     size(handles.newcontour.Points)
                    x = [];
                    layer = layer+1;
                end
            end
    end
    delete('tempcontours.raw');
    delete('Resampledsinglecontour.mhd');
    delete('Resampledsinglecontour.raw');
    clear resampledmatrix tempmatrix;
    close(infowindow);
end
handles.newcontour.Croi = handles.C.Croi;
handles.newcontour.ROI = handles.C.ROI;
% size(handles.newcontour.Points)
Writeautocontour(handles.newcontour);