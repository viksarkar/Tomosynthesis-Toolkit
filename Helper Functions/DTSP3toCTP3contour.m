function DTSP3toCTP3contour(handles,orientation)

% Write the header files for resampling contours
fid = fopen('to.mhd','w');
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

fid = fopen('from.mhd','w');
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

organnum = 0;
layer = 1;
orientation = get(handles.DTSOrientation, 'value');

%Process all contours
for currentcontour = 1:handles.C.Croi
    infowindow = showinfowindow(strcat('Resampling ROI file for ',handles.C.ROI{currentcontour},'. Please wait.'));
    organnum = organnum + 1;
    switch orientation
        case 1
            creatematrixfromDTS(handles.C,currentcontour,handles.DTSxoffset,handles.DTSyoffset,handles.DTSzoffset,handles.DTSxvoxdim,handles.DTSyvoxdim,handles.DTSzvoxdim,handles.DTSxsize, handles.DTSysize, handles.DTSzsize, 1);
        case 2
            creatematrixfromDTS(handles.C,currentcontour,handles.DTSxoffset,handles.DTSyoffset,handles.DTSzoffset,handles.DTSxvoxdim,handles.DTSyvoxdim,handles.DTSzvoxdim,handles.DTSxsize, handles.DTSysize, handles.DTSzsize, 2);
    end
    dos('ContourResample to.mhd from.mhd');
    fid = fopen('Resampledsinglecontour.raw','r');
    tempmatrix = fread(fid,'uint16');
    fclose(fid);
    tempmatrix = reshape(tempmatrix, handles.contourxsize, handles.contourysize, handles.contourzsize);
    for currentslice = 1:handles.contourzsize
      tmpimg = squeeze(tempmatrix(:,:,currentslice));
      limits = bwboundaries(tmpimg,8); % Trace the contour(s)
      size(limits)
      for contour = 1:size(limits,1) % For each, create a list of coordinates to write the ROI file for P3
          x(:,1) = limits{contour}(:,1)*(handles.contourxvoxdim/10)+(handles.contourxoffset/10);
          x(:,2) = (handles.contourysize-limits{contour}(:,2))*(handles.contouryvoxdim/10)+(handles.contouryoffset/10);
          x(:,3) = currentslice*(handles.contourvoxdim/10)+(handles.contouroffset/10);
          handles.newcontour.Points{currentcontour}{layer} = x;
          x = [];
          layer = layer+1;
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
Writeautocontour(handles.newcontour);