function varargout = RewriteCTDialog(varargin)
% REWRITECTDIALOG M-file for RewriteCTDialog.fig
%      REWRITECTDIALOG, by itself, creates a new REWRITECTDIALOG or raises the existing
%      singleton*.
%
%      H = REWRITECTDIALOG returns the handle to a new REWRITECTDIALOG or the handle to
%      the existing singleton*.
%
%      REWRITECTDIALOG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REWRITECTDIALOG.M with the given input arguments.
%
%      REWRITECTDIALOG('Property','Value',...) creates a new REWRITECTDIALOG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RewriteCTDialog_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RewriteCTDialog_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RewriteCTDialog

% Last Modified by GUIDE v2.5 10-Oct-2008 09:31:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RewriteCTDialog_OpeningFcn, ...
                   'gui_OutputFcn',  @RewriteCTDialog_OutputFcn, ...
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


% --- Executes just before RewriteCTDialog is made visible.
function RewriteCTDialog_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RewriteCTDialog (see VARARGIN)

% Choose default command line output for RewriteCTDialog
handles.output = hObject;

set(handles.WriteCTDataButton,'visible','off');
handles.POIopened = 0;

% Initialize values passed in from RegisterWindow2
handles.xshift = varargin{1,1};
handles.yshift = varargin{1,2};
handles.zshift = varargin{1,3};
handles.pitchval = varargin{1,4};
handles.yawval = varargin{1,5};
handles.rollval = varargin{1,6};

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes RewriteCTDialog wait for user response (see UIRESUME)
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


% --- Executes on button press in SelectCTButton.
function SelectCTButton_Callback(hObject, eventdata, handles)
% hObject    handle to SelectCTButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[handles.ctfilename, handles.ctpathname] = uigetfile('*.mhd','Open original CT File');
if(handles.ctfilename == 0)
    set(handles.POIPath,'String','');
    set(handles.WriteCTDataButton,'Visible','Off');
    handles.POIopened = 0;
else
    set(handles.POIPath,'String',[handles.ctpathname,handles.ctfilename]);
    set(handles.WriteCTDataButton,'Visible','On');
end

guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = RewriteCTDialog_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in WriteCTDataButton.
function WriteCTDataButton_Callback(hObject, eventdata, handles)
% hObject    handle to WriteCTDataButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[CTfilename, CTpathname] = uiputfile('*.img','Save new CT data as');
if (CTpathname == 0)
    msgbox('You need to choose a file name to save the file','modal');
    return;
else
    filename = substr(CTfilename,  0, -3);
    filename = [filename,'mhd'];
    isoxcoord = get(handles.isoxval,'string');
    isoycoord = get(handles.isoyval,'string');
    isozcoord = get(handles.isozval,'string');
    commandtorun = ['Rigid3Dtransform ',[handles.ctpathname,handles.ctfilename],' ',filename,' ',isoxcoord,' ',isoycoord,' ',...
        isozcoord,' ',num2str(handles.pitchval),' ',num2str(handles.yawval),' ',num2str(handles.rollval),' ',num2str(handles.xshift)...
        ,' ',num2str(handles.yshift),' ',num2str(handles.zshift)];
    h = showinfowindow('Creating your CT dataset. Please wait');
    dos(commandtorun);
    writeP3header(substr(filename, 0, -4));
    oldfilename = [substr(filename,0,-3),'raw'];
    newfilename = [substr(filename,0,-3),'img'];
    commandtorun = ['ren ',oldfilename,' ',newfilename];
    dos(commandtorun);
    commandtorun = ['move ',newfilename,' ',[CTpathname,newfilename]];
    dos(commandtorun);
    headername = [substr(filename,0,-3),'header'];
    commandtorun = ['move ',headername,' ',[CTpathname,headername]];
    dos(commandtorun);
    delete(filename);
    delete(h);
    clear oldfilename newfilename headername
end
guidata(hObject,handles);