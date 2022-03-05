function varargout = RewriteP3FilesDialog(varargin)
% REWRITEP3FILESDIALOG M-file for RewriteP3FilesDialog.fig
%      REWRITEP3FILESDIALOG, by itself, creates a new REWRITEP3FILESDIALOG or raises the existing
%      singleton*.
%
%      H = REWRITEP3FILESDIALOG returns the handle to a new REWRITEP3FILESDIALOG or the handle to
%      the existing singleton*.
%
%      REWRITEP3FILESDIALOG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REWRITEP3FILESDIALOG.M with the given input arguments.
%
%      REWRITEP3FILESDIALOG('Property','Value',...) creates a new REWRITEP3FILESDIALOG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RewriteP3FilesDialog_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RewriteP3FilesDialog_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RewriteP3FilesDialog

% Last Modified by GUIDE v2.5 16-Oct-2008 09:34:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RewriteP3FilesDialog_OpeningFcn, ...
                   'gui_OutputFcn',  @RewriteP3FilesDialog_OutputFcn, ...
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


% --- Executes just before RewriteP3FilesDialog is made visible.
function RewriteP3FilesDialog_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RewriteP3FilesDialog (see VARARGIN)

% Choose default command line output for RewriteP3FilesDialog
handles.output = hObject;

set(handles.WriteFilesButton,'visible','off');
handles.POIopened = 0;
handles.Trialopened = 0;

% Initialize values passed in from RegisterWindow2
handles.xshift = varargin{1,1};
handles.yshift = varargin{1,2};
handles.zshift = varargin{1,3};
handles.pitchval = varargin{1,4};
handles.yawval = varargin{1,5};
handles.rollval = varargin{1,6};

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes RewriteP3FilesDialog wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Executes during object creation, after setting all properties.
function isoxval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to isoxval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function isoyval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to isoyval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function isozval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to isozval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SelectPOIButton.
function SelectPOIButton_Callback(hObject, eventdata, handles)
% hObject    handle to SelectPOIButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[handles.poifilename, handles.poipathname] = uigetfile({'*.points','POI File (*.points)'},'Open POI File');
if(handles.poifilename == 0)
    set(handles.POIPath,'String','');
    set(handles.WriteFilesButton,'Visible','Off');
    handles.POIopened = 0;
else
    set(handles.POIPath,'String',[handles.poipathname,handles.poifilename]);
    handles.POIopened = 1;
    if(handles.Trialopened && handles.POIopened)
        set(handles.WriteFilesButton,'Visible','On');
    end
end

guidata(hObject, handles);


% --- Executes on button press in GetTrialButton.
function GetTrialButton_Callback(hObject, eventdata, handles)
% hObject    handle to GetTrialButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[handles.trialfilename, handles.trialpathname] = uigetfile({'*.Trial','Trial File (*.Trial)'},'Open Trial File');
if(handles.trialfilename == 0)
    set(handles.TrialPath,'String','');
    set(handles.WriteFilesButton,'Visible','Off');
    handles.Trialopened = 0;
else
    set(handles.TrialPath,'String',[handles.trialpathname,handles.trialfilename]);
    handles.Trialopened = 1;
    if(handles.Trialopened && handles.POIopened)
        set(handles.WriteFilesButton,'Visible','On');
    end
end

guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = RewriteP3FilesDialog_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function isoxval_Callback(hObject, eventdata, handles)
% hObject    handle to isoxval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of isoxval as text
%        str2double(get(hObject,'String')) returns contents of isoxval as a double


function isoyval_Callback(hObject, eventdata, handles)
% hObject    handle to isoyval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of isoyval as text
%        str2double(get(hObject,'String')) returns contents of isoyval as a double


function isozval_Callback(hObject, eventdata, handles)
% hObject    handle to isozval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of isozval as text
%        str2double(get(hObject,'String')) returns contents of isozval as a double


% --- Executes on button press in WriteFilesButton.
function WriteFilesButton_Callback(hObject, eventdata, handles)
% hObject    handle to WriteFilesButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = showinfowindow('Re-writing the .POI file');
RewritePOIfile(handles.poipathname, handles.poifilename, handles);
delete(h);
h = showinfowindow('Re-writing the .Trial file');
rewritetrialfile(handles.trialpathname,handles.trialfilename,handles.yawval, handles.rollval);
delete(h);

