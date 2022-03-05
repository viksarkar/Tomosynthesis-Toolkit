function varargout = SaveDTSImageforP3_Dialog(varargin)
% SAVEDTSIMAGEFORP3_DIALOG M-file for SaveDTSImageforP3_Dialog.fig
%      SAVEDTSIMAGEFORP3_DIALOG, by itself, creates a new SAVEDTSIMAGEFORP3_DIALOG or raises the existing
%      singleton*.
%
%      H = SAVEDTSIMAGEFORP3_DIALOG returns the handle to a new SAVEDTSIMAGEFORP3_DIALOG or the handle to
%      the existing singleton*.
%
%      SAVEDTSIMAGEFORP3_DIALOG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAVEDTSIMAGEFORP3_DIALOG.M with the given input arguments.
%
%      SAVEDTSIMAGEFORP3_DIALOG('Property','Value',...) creates a new SAVEDTSIMAGEFORP3_DIALOG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SaveDTSImageforP3_Dialog_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SaveDTSImageforP3_Dialog_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SaveDTSImageforP3_Dialog

% Last Modified by GUIDE v2.5 02-Nov-2008 19:57:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SaveDTSImageforP3_Dialog_OpeningFcn, ...
                   'gui_OutputFcn',  @SaveDTSImageforP3_Dialog_OutputFcn, ...
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


% --- Executes just before SaveDTSImageforP3_Dialog is made visible.
function SaveDTSImageforP3_Dialog_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SaveDTSImageforP3_Dialog (see VARARGIN)

% Choose default command line output for SaveDTSImageforP3_Dialog
handles.output = hObject;

% Initialize various variables
handles.savefilename = [];
handles.savepathname = [];
handles.dtspathname = [];
handles.dtsfilename = [];
handles.headeropened = 0; %Boolean to determine if a contour header file was opened
handles.savefileselected = 0; %Boolean to determine if a fixed image header file was opened

% Hide create contour button for now
set(handles.CreateImages,'Visible','Off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SaveDTSImageforP3_Dialog wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SaveDTSImageforP3_Dialog_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in SaveAsButton.
function SaveAsButton_Callback(hObject, eventdata, handles)
% hObject    handle to SaveAsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.savefilename, handles.savepathname] = uiputfile({'*.img','IMG File'},'Save Images As');
if(handles.savefilename ~= 0)
    set(handles.Savepath,'String',[handles.savepathname, handles.savefilename]);
    handles.savefileselected = 1;
else
    set(handles.Savepath,'String','');
    handles.savefileselected = 0;
    set(handles.CreateImages,'Visible','Off');    
end
if (handles.savefileselected && handles.headeropened)
    set(handles.CreateImages,'Visible','On');
end
guidata(hObject,handles);


% --- Executes on button press in GetDTSHeader.
function GetDTSHeader_Callback(hObject, eventdata, handles)
% hObject    handle to GetDTSHeader (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.dtsfilename, handles.dtspathname] = uigetfile({'*.mhd','Image Header File (*.mhd)'},'Open Source DTS Images');
if(handles.dtsfilename ~= 0)
    set(handles.DTSHeaderPath,'String',[handles.dtspathname, handles.dtsfilename]);
    handles.headeropened = 1;
else
    set(handles.DTSHeaderPath,'String','');
    handles.headeropened = 0;
    set(handles.CreateImages,'Visible','Off');    
end
if (handles.headeropened && handles.savefileselected)
    set(handles.CreateImages,'Visible','On');
end
guidata(hObject,handles);

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



function ImageNameTag_Callback(hObject, eventdata, handles)
% hObject    handle to ImageNameTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ImageNameTag as text
%        str2double(get(hObject,'String')) returns contents of ImageNameTag as a double


% --- Executes during object creation, after setting all properties.
function ImageNameTag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImageNameTag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CreateImages.
function CreateImages_Callback(hObject, eventdata, handles)
% hObject    handle to CreateImages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

imagename = get(handles.ImageNameTag,'string');
orientation = get(handles.OrientationMenu, 'value');
h = showinfowindow('Writing the Image File. Please wait.');
rewriteimageforP3(handles.dtspathname,handles.dtsfilename,imagename,orientation,handles.savepathname,handles.savefilename);
delete(h);
guidata(hObject, handles);