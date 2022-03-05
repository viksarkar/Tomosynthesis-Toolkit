function varargout = CreateMeta_Dialog(varargin)
% CREATEMETA_DIALOG M-file for CreateMeta_Dialog.fig
%      CREATEMETA_DIALOG, by itself, creates a new CREATEMETA_DIALOG or raises the existing
%      singleton*.
%
%      H = CREATEMETA_DIALOG returns the handle to a new CREATEMETA_DIALOG or the handle to
%      the existing singleton*.
%
%      CREATEMETA_DIALOG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CREATEMETA_DIALOG.M with the given input arguments.
%
%      CREATEMETA_DIALOG('Property','Value',...) creates a new CREATEMETA_DIALOG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CreateMeta_Dialog_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CreateMeta_Dialog_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CreateMeta_Dialog

% Last Modified by GUIDE v2.5 29-Jun-2008 19:51:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CreateMeta_Dialog_OpeningFcn, ...
                   'gui_OutputFcn',  @CreateMeta_Dialog_OutputFcn, ...
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


% --- Executes just before CreateMeta_Dialog is made visible.
function CreateMeta_Dialog_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CreateMeta_Dialog (see VARARGIN)

% Choose default command line output for CreateMeta_Dialog
handles.output = hObject;

handles.SourceDirectory = [];

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CreateMeta_Dialog wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CreateMeta_Dialog_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function IsoX_Callback(hObject, eventdata, handles)
% hObject    handle to IsoX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IsoX as text
%        str2double(get(hObject,'String')) returns contents of IsoX as a double


% --- Executes during object creation, after setting all properties.
function IsoX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IsoX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IsoY_Callback(hObject, eventdata, handles)
% hObject    handle to IsoY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IsoY as text
%        str2double(get(hObject,'String')) returns contents of IsoY as a double


% --- Executes during object creation, after setting all properties.
function IsoY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IsoY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IsoZ_Callback(hObject, eventdata, handles)
% hObject    handle to IsoZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IsoZ as text
%        str2double(get(hObject,'String')) returns contents of IsoZ as a double


% --- Executes during object creation, after setting all properties.
function IsoZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IsoZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in GetSourceDirectory.
function GetSourceDirectory_Callback(hObject, eventdata, handles)
% hObject    handle to GetSourceDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.SourceDirectory = uigetdir();
set(handles.SourceDirectoryTag,'String',handles.SourceDirectory);
if(handles.SourceDirectory == 0)
    handles.SourceDirectory = [];
    set(handles.SourceDirectoryTag,'String',handles.SourceDirectory);
end

guidata(hObject, handles);

% % --- Executes on button press in GetSaveDirectory.
% function GetSaveDirectory_Callback(hObject, eventdata, handles)
% % hObject    handle to GetSaveDirectory (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% handles.SaveDirectory = uigetdir();
% set(handles.SaveDirectoryTag,'String',handles.SaveDirectory);
% 
% guidata(hObject, handles);

% --- Executes on button press in CreateData.
function CreateData_Callback(hObject, eventdata, handles)
% hObject    handle to CreateData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(isempty(handles.SourceDirectory))
    msgbox('You did not choose a source directory','error','error','modal');
else
    [handles.fiximg,handles.header] = ReadDicom(handles.SourceDirectory);
    [filename,pathname] = uiputfile('*.raw','Save the image as raw data');
    IsoX = str2num(get(handles.IsoX,'string'))*10;
    IsoY = str2num(get(handles.IsoY,'string'))*10;
    IsoZ = str2num(get(handles.IsoZ,'string'))*10;
    if ((~isequal(filename, 0)) && (~isequal(pathname,0)))
        name = [pathname,filename];
        rawheadername = Writerawimage(handles.fiximg,handles.header,name,IsoX,IsoY,IsoZ);
    else
        errordlg('No valid file selected! Please check!');
        return;
    end
    delete(CreateMeta_Dialog);
    msgbox('You can now register by going to Registration -> Register Images','modal');
end