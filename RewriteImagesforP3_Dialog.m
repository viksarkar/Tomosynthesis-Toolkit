function varargout = RewriteImagesforP3_Dialog(varargin)
% REWRITEIMAGESFORP3_DIALOG M-file for RewriteImagesforP3_Dialog.fig
%      REWRITEIMAGESFORP3_DIALOG, by itself, creates a new REWRITEIMAGESFORP3_DIALOG or raises the existing
%      singleton*.
%
%      H = REWRITEIMAGESFORP3_DIALOG returns the handle to a new REWRITEIMAGESFORP3_DIALOG or the handle to
%      the existing singleton*.
%
%      REWRITEIMAGESFORP3_DIALOG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REWRITEIMAGESFORP3_DIALOG.M with the given input arguments.
%
%      REWRITEIMAGESFORP3_DIALOG('Property','Value',...) creates a new REWRITEIMAGESFORP3_DIALOG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RewriteImagesforP3_Dialog_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RewriteImagesforP3_Dialog_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RewriteImagesforP3_Dialog

% Last Modified by GUIDE v2.5 12-Nov-2008 10:44:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RewriteImagesforP3_Dialog_OpeningFcn, ...
                   'gui_OutputFcn',  @RewriteImagesforP3_Dialog_OutputFcn, ...
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


% --- Executes just before RewriteImagesforP3_Dialog is made visible.
function RewriteImagesforP3_Dialog_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RewriteImagesforP3_Dialog (see VARARGIN)

% Choose default command line output for RewriteImagesforP3_Dialog
handles.output = hObject;

% Read in values passed to the function
handles.xt = varargin{1,1};
handles.yt = varargin{1,2};
handles.zt = varargin{1,3};
handles.pitchval = varargin{1,4};
handles.yawval = varargin{1,5};
handles.rollval = varargin{1,6};
handles.movingpathname = varargin{1,7};
handles.movingfilename = varargin{1,8};

% Make final button invisible while no name has been chosen
set(handles.WriteImageButton,'Visible','Off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes RewriteImagesforP3_Dialog wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RewriteImagesforP3_Dialog_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in RewriteforP3SaveAsButton.
function RewriteforP3SaveAsButton_Callback(hObject, eventdata, handles)
% hObject    handle to RewriteforP3SaveAsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.savefilename, handles.savepathname] = uiputfile('*.header','Save imageset as:');
if(handles.savefilename==0)
    set(handles.SavePath,'string','');
    set(handles.WriteImageButton,'Visible','Off');
else
    set(handles.SavePath,'string',[handles.savepathname,handles.savefilename]);
    set(handles.WriteImageButton,'Visible','On');    
end
guidata(hObject, handles);

% --- Executes on selection change in DTSImageOrientation.
function DTSImageOrientation_Callback(hObject, eventdata, handles)
% hObject    handle to DTSImageOrientation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns DTSImageOrientation contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DTSImageOrientation


% --- Executes during object creation, after setting all properties.
function DTSImageOrientation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DTSImageOrientation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in WriteImageButton.
function WriteImageButton_Callback(hObject, eventdata, handles)
% hObject    handle to WriteImageButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Orientation = get(handles.DTSImageOrientation,'Value');
WriteP3Images(handles,Orientation);
guidata(hObject,handles);


