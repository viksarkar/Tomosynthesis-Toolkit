function varargout = CTP3toDTSP3_Dialog(varargin)
% CTP3TODTSP3_DIALOG M-file for CTP3toDTSP3_Dialog.fig
%      CTP3TODTSP3_DIALOG, by itself, creates a new CTP3TODTSP3_DIALOG or raises the existing
%      singleton*.
%
%      H = CTP3TODTSP3_DIALOG returns the handle to a new CTP3TODTSP3_DIALOG or the handle to
%      the existing singleton*.
%
%      CTP3TODTSP3_DIALOG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CTP3TODTSP3_DIALOG.M with the given input arguments.
%
%      CTP3TODTSP3_DIALOG('Property','Value',...) creates a new CTP3TODTSP3_DIALOG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CTP3toDTSP3_Dialog_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CTP3toDTSP3_Dialog_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CTP3toDTSP3_Dialog

% Last Modified by GUIDE v2.5 17-Nov-2008 14:46:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CTP3toDTSP3_Dialog_OpeningFcn, ...
                   'gui_OutputFcn',  @CTP3toDTSP3_Dialog_OutputFcn, ...
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


% --- Executes just before CTP3toDTSP3_Dialog is made visible.
function CTP3toDTSP3_Dialog_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CTP3toDTSP3_Dialog (see VARARGIN)

% Choose default command line output for CTP3toDTSP3_Dialog
handles.output = hObject;

% Initialize various variables
handles.C = []; %Keeps contour information
handles.roiopened = 0; %Boolean to determine if an ROI file was opened
handles.headeropened = 0; %Boolean to determine if a contour header file was opened
handles.fixedheaderopened = 0; %Boolean to determine if a fixed image header file was opened

% Hide create contour button for now
set(handles.CreateContourButton,'Visible','Off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CTP3toDTSP3_Dialog wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CTP3toDTSP3_Dialog_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in GetROIButton.
function GetROIButton_Callback(hObject, eventdata, handles)
% hObject    handle to GetROIButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[roifilename, roipathname] = uigetfile({'*.roi','ROI File (*.roi)'},'Open ROI File');
if(roifilename == 0)
    set(handles.ROIpath,'String','');
    handles.roiopened = 0;
    set(handles.CreateContourButton,'Visible','Off');
else
    set(handles.ROIpath,'String',[roipathname, roifilename]);
    h = showinfowindow('Reading ROI file. Please wait.');
    handles.C = Readp3roifile([roipathname,roifilename]);
    handles.roiopened = 1;
    close(h);
end

if(handles.roiopened && handles.headeropened && handles.fixedheaderopened)
    set(handles.CreateContourButton,'Visible','on');
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
    set(handles.CreateContourButton,'Visible','Off');    
end
if (handles.roiopened && handles.headeropened && handles.fixedheaderopened)
    set(handles.CreateContourButton,'Visible','On');
end
guidata(hObject,handles);


% --- Executes on button press in GetDTSHeader.
function GetDTSHeader_Callback(hObject, eventdata, handles)
% hObject    handle to GetDTSHeader (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.DTSfilename, handles.DTSpathname] = uigetfile({'*.mhd','Fixed Image Header File (*.mhd)'},'Open Fixed Image Header');
if(handles.DTSfilename ~= 0)
    set(handles.FixedHeaderPath,'String',[handles.DTSpathname, handles.DTSfilename]);
    [handles.DTSxsize,handles.DTSysize,handles.DTSzsize, ...
        handles.DTSxoffset,handles.DTSyoffset,handles.DTSzoffset,...
        handles.DTSxvoxdim,handles.DTSyvoxdim,handles.DTSzvoxdim,handles.DTSrawfilename]=...
        Readmhd([handles.DTSpathname, handles.DTSfilename]);
    handles.fixedheaderopened = 1;
else
    set(handles.FixedHeaderPath,'String','');
    handles.fixedheaderopened = 0;
    set(handles.CreateContourButton,'Visible','Off');    
end
if (handles.roiopened && handles.headeropened && handles.fixedheaderopened)
    set(handles.CreateContourButton,'Visible','On');
end
guidata(hObject,handles);


% --- Executes on button press in CreateContourButton.
function CreateContourButton_Callback(hObject, eventdata, handles)
% hObject    handle to CreateContourButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Orientation = get(handles.OrientationMenu, 'Value');
CTP3toDTSP3contour(handles, Orientation);
guidata(hObject, handles);


% --- Executes on selection change in OrientationMenu.
function OrientationMenu_Callback(hObject, eventdata, handles)
% hObject    handle to OrientationMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns OrientationMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from OrientationMenu


% --- Executes during object creation, after setting all properties.
function OrientationMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OrientationMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


