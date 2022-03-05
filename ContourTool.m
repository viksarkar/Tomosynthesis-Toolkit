function varargout = ContourTool(varargin)
% CONTOURTOOL M-file for ContourTool.fig
%      CONTOURTOOL, by itself, creates a new CONTOURTOOL or raises the existing
%      singleton*.
%
%      H = CONTOURTOOL returns the handle to a new CONTOURTOOL or the handle to
%      the existing singleton*.
%
%      CONTOURTOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONTOURTOOL.M with the given input arguments.
%
%      CONTOURTOOL('Property','Value',...) creates a new CONTOURTOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ContourTool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ContourTool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ContourTool

% Last Modified by GUIDE v2.5 19-Jul-2008 21:24:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ContourTool_OpeningFcn, ...
                   'gui_OutputFcn',  @ContourTool_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ContourTool is made visible.
function ContourTool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ContourTool (see VARARGIN)

% Choose default command line output for ContourTool
handles.output = hObject;

% Initialize various variables
handles.C = []; %Keeps contour information
handles.roiopened = 0; %Boolean to determine if an ROI file was opened
handles.headeropened = 0; %Boolean to determine if a contour header file was opened
handles.fixedheaderopened = 0; %Boolean to determine if a fixed image header file was opened
handles.contourmatrix = [];
handles.fixedfilename = 0;
handles.fixedpathname = 0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ContourTool wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ContourTool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1,1} = handles.pathname;
varargout{1,2} = handles.filename;
delete(handles.figure1);




% --- Executes on button press in GetROIButton.
function GetROIButton_Callback(hObject, eventdata, handles)
% hObject    handle to GetROIButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[roifilename, roipathname] = uigetfile({'*.roi','ROI File (*.roi)'},'Open ROI File');
if(roifilename == 0)
    set(handles.ROIpath,'String','');
    set(handles.ContourInstructions,'Visible','Off');
    set(handles.OrganPanel,'Visible','Off');
    handles.roiopened = 0;
    set(handles.GetContourButton,'Visible','Off');
else
    set(handles.ROIpath,'String',[roipathname, roifilename]);
    h = showinfowindow('Reading ROI file. Please wait.');
    handles.C = Readp3roifile([roipathname,roifilename]);
    handles.roiopened = 1;
    set(handles.ContourInstructions,'Visible','On');
    set(handles.OrganPanel,'Visible','On');
    if handles.C.Croi<=16
        for i=1:handles.C.Croi
            commandtoexecute = strcat('set(handles.Organ',num2str(i),',''string'',''',handles.C.ROI{i},''');');
            eval(commandtoexecute);
            commandtoexecute = strcat('set(handles.Organ',num2str(i),',''Visible'',''On'');');
            eval(commandtoexecute);
        end
        for i=handles.C.Croi+1:16
            commandtoexecute = strcat('set(handles.Organ',num2str(i),',''string'','''');');
            eval(commandtoexecute);
            commandtoexecute = strcat('set(handles.Organ',num2str(i),',''Visible'',''Off'');');
            eval(commandtoexecute);
        end
    else
        for i=1:16
            commandtoexecute = strcat('set(handles.Organ',num2str(i),',''string'',''',handles.C.ROI{i},''');');
            eval(commandtoexecute);
            commandtoexecute = strcat('set(handles.Organ',num2str(i),',''Visible'',''On'');');
            eval(commandtoexecute);
        end
    end
    close(h);
end

if(handles.roiopened && handles.headeropened && handles.fixedheaderopened)
    set(handles.GetContourButton,'Visible','on');
end

guidata(hObject,handles);


% --- Executes on button press in GetContourHeaderButton.
function GetContourHeaderButton_Callback(hObject, eventdata, handles)
% hObject    handle to GetContourHeaderButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[contourfilename, contourpathname] = uigetfile({'*contour.mhd','Contour Header File (*contour.mhd)'},'Open Contour Header');
if(contourfilename ~= 0)
    set(handles.MHDpath,'String',[contourpathname, contourfilename]);
    [handles.contourxsize,handles.contourysize,handles.contourzsize, ...
        handles.imagexoffset,handles.imageyoffset,handles.imagezoffset,...
        handles.contourxvoxdim,handles.contouryvoxdim,handles.contourzvoxdim,filename,...
        handles.contourxoffset,handles.contouryoffset,handles.contourzoffset]=...
        Readcontourmhd([contourpathname, contourfilename]);
    handles.headeropened = 1;
else
    set(handles.MHDpath,'String','');
    handles.headeropened = 0;
    set(handles.GetContourButton,'Visible','Off');    
end
if (handles.roiopened && handles.headeropened && handles.fixedheaderopened)
    set(handles.GetContourButton,'Visible','On');
end
guidata(hObject,handles);

% --- Executes on button press in GetContourButton.
function GetContourButton_Callback(hObject, eventdata, handles)
% hObject    handle to GetContourButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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
h{3} = sprintf('DimSize = %i %i %i',handles.fixedxsize,handles.fixedysize,handles.fixedzsize);
h{4} = sprintf('ElementSpacing = %.5f %.5f %.5f',handles.fixedxvoxdim,-handles.fixedyvoxdim,handles.fixedzvoxdim);
h{5} = sprintf('Offset = %.4f %.4f %.4f',handles.fixedxoffset,handles.fixedyoffset,handles.fixedzoffset);
h{6} = sprintf('ElementByteOrderMSB = False');
h{7} = sprintf('ElementType = MET_USHORT');
h{8} = sprintf('ElementDataFile = tempcontours.raw');
fprintf(fid,'%s\n',h{:});
fclose(fid);

[handles.filename, handles.pathname] = uiputfile('*.contour','Save the contour file you just generated');

organnum = 0;
organ = [];

for i=1:16
    commandtoexecute = strcat('get(handles.Organ',num2str(i),',''Value'');');
    Includeorgan = eval(commandtoexecute);
    if(Includeorgan)
        infowindow = showinfowindow(strcat('Creating and resampling ROI matrix for ',handles.C.ROI{i},'. Please wait.'));
        organnum = organnum + 1;
        organ = [organ, i];
        creatematrix(handles.C,i,handles.contourxoffset,handles.contouryoffset,handles.contourzoffset,handles.contourxvoxdim,handles.contouryvoxdim,handles.contourzvoxdim,handles.contourxsize, handles.contourysize, handles.contourzsize);
        dos('ContourResample to.mhd from.mhd');
        fid = fopen('Resampledsinglecontour.raw','r');
        tempmatrix = fread(fid,'uint16');
        fclose(fid);
        tempmatrix = reshape(tempmatrix, handles.fixedxsize, handles.fixedysize, handles.fixedzsize);
        resampledmatrix = findedges(tempmatrix);
        delete('tempcontours.raw');
        delete('Resampledsinglecontour.mhd');
        delete('Resampledsinglecontour.raw');
        for x = 1:handles.fixedxsize
            for y = 1:handles.fixedysize
                for z = 1:handles.fixedzsize
                    if(resampledmatrix(x,y,z) == 25000)
                        resampledmatrix(x,y,z) = 1;
                    end
                end
            end
        end
        file = strcat(handles.filename,'.',num2str(organnum));
        fid = fopen([handles.pathname,file],'w');
        fwrite(fid,resampledmatrix,'ubit1');
        fclose(fid);
        clear resampledmatrix tempmatrix;
        close(infowindow);
    end
end

h = cell(1,organnum+1);
h{1} = sprintf(num2str(organnum));
for i = 1:organnum
    h{i+1} = sprintf(handles.C.ROI{organ(i)});
end
fid = fopen([handles.pathname,handles.filename],'w');
fprintf(fid,'%s\n',h{:});
fclose(fid);

delete('from.mhd');
delete('to.mhd');

guidata(hObject, handles);
uiresume(handles.figure1);

    

% --- Executes on button press in Organ1.
function Organ1_Callback(hObject, eventdata, handles)
% hObject    handle to Organ1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Organ1


% --- Executes on button press in Organ2.
function Organ2_Callback(hObject, eventdata, handles)
% hObject    handle to Organ2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Organ2


% --- Executes on button press in Organ3.
function Organ3_Callback(hObject, eventdata, handles)
% hObject    handle to Organ3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Organ3


% --- Executes on button press in Organ4.
function Organ4_Callback(hObject, eventdata, handles)
% hObject    handle to Organ4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Organ4


% --- Executes on button press in Organ9.
function Organ9_Callback(hObject, eventdata, handles)
% hObject    handle to Organ9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Organ9


% --- Executes on button press in Organ10.
function Organ10_Callback(hObject, eventdata, handles)
% hObject    handle to Organ10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Organ10


% --- Executes on button press in Organ5.
function Organ5_Callback(hObject, eventdata, handles)
% hObject    handle to Organ5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Organ5


% --- Executes on button press in Organ6.
function Organ6_Callback(hObject, eventdata, handles)
% hObject    handle to Organ6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Organ6


% --- Executes on button press in Organ7.
function Organ7_Callback(hObject, eventdata, handles)
% hObject    handle to Organ7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Organ7


% --- Executes on button press in Organ8.
function Organ8_Callback(hObject, eventdata, handles)
% hObject    handle to Organ8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Organ8


% --- Executes on button press in Organ12.
function Organ12_Callback(hObject, eventdata, handles)
% hObject    handle to Organ12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Organ12


% --- Executes on button press in Organ11.
function Organ11_Callback(hObject, eventdata, handles)
% hObject    handle to Organ11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Organ11


% --- Executes on button press in Organ13.
function Organ13_Callback(hObject, eventdata, handles)
% hObject    handle to Organ13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Organ13


% --- Executes on button press in Organ15.
function Organ15_Callback(hObject, eventdata, handles)
% hObject    handle to Organ15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Organ15


% --- Executes on button press in Organ14.
function Organ14_Callback(hObject, eventdata, handles)
% hObject    handle to Organ14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Organ14


% --- Executes on button press in Organ16.
function Organ16_Callback(hObject, eventdata, handles)
% hObject    handle to Organ16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Organ16


% --- Executes on button press in GetFixedHeader.
function GetFixedHeader_Callback(hObject, eventdata, handles)
% hObject    handle to GetFixedHeader (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.fixedfilename, handles.fixedpathname] = uigetfile({'*.mhd','Fixed Image Header File (*.mhd)'},'Open Fixed Image Header');
if(handles.fixedfilename ~= 0)
    set(handles.FixedHeaderPath,'String',[handles.fixedpathname, handles.fixedfilename]);
    [handles.fixedxsize,handles.fixedysize,handles.fixedzsize, ...
        handles.fixedxoffset,handles.fixedyoffset,handles.fixedzoffset,...
        handles.fixedxvoxdim,handles.fixedyvoxdim,handles.fixedzvoxdim,filename]=...
        Readmhd([handles.fixedpathname, handles.fixedfilename]);
    handles.fixedheaderopened = 1;
else
    set(handles.FixedHeaderPath,'String','');
    handles.fixedheaderopened = 0;
    set(handles.GetContourButton,'Visible','Off');    
end
if (handles.roiopened && handles.headeropened && handles.fixedheaderopened)
    set(handles.GetContourButton,'Visible','On');
end
guidata(hObject,handles);


