function varargout = ProcessSourceImages(varargin)
% PROCESSSOURCEIMAGES M-file for ProcessSourceImages.fig
%      PROCESSSOURCEIMAGES, by itself, creates a new PROCESSSOURCEIMAGES or raises the existing
%      singleton*.
%
%      H = PROCESSSOURCEIMAGES returns the handle to a new PROCESSSOURCEIMAGES or the handle to
%      the existing singleton*.
%
%      PROCESSSOURCEIMAGES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROCESSSOURCEIMAGES.M with the given input arguments.
%
%      PROCESSSOURCEIMAGES('Property','Value',...) creates a new PROCESSSOURCEIMAGES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ProcessSourceImages_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ProcessSourceImages_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ProcessSourceImages

% Last Modified by GUIDE v2.5 16-Jul-2008 14:17:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ProcessSourceImages_OpeningFcn, ...
                   'gui_OutputFcn',  @ProcessSourceImages_OutputFcn, ...
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


% --- Executes just before ProcessSourceImages is made visible.
function ProcessSourceImages_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ProcessSourceImages (see VARARGIN)

handles.firstfiledirectoryname = 0;
handles.firstfilefilename = 0;
handles.lastfiledirectoryname = 0;
handles.lastfilefilename = 0;
handles.savefilename = 0;
handles.savedirectoryname = 0;

% Choose default command line output for ProcessSourceImages
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ProcessSourceImages wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ProcessSourceImages_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in GetFirstFileButton.
function GetFirstFileButton_Callback(hObject, eventdata, handles)
% hObject    handle to GetFirstFileButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.lastfiledirectoryname ~= 0)
    [handles.firstfilefilename, handles.firstfiledirectoryname] = uigetfile({'*.*','All Files (*.*)'},'Please pick first image', handles.lastfiledirectoryname);
else
    [handles.firstfilefilename, handles.firstfiledirectoryname] = uigetfile({'*.*','All Files (*.*)'},'Please pick first image');
end
if (handles.firstfilefilename==0)
    set(handles.FirstFilePath,'string','');
else
    set(handles.FirstFilePath,'string',[handles.firstfiledirectoryname, handles.firstfilefilename]);
end

guidata(hObject, handles);



% --- Executes on button press in GetLastFileButton.
function GetLastFileButton_Callback(hObject, eventdata, handles)
% hObject    handle to GetLastFileButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.firstfiledirectoryname ~= 0)
    [handles.lastfilefilename, handles.lastfiledirectoryname] = uigetfile({'*.*','All Files (*.*)'},'Please pick last image',handles.firstfiledirectoryname);
else
    [handles.lastfilefilename, handles.lastfiledirectoryname] = uigetfile({'*.*','All Files (*.*)'},'Please pick last image');
end
if (handles.lastfilefilename==0)
    set(handles.LastFilePath,'string','');
else
    set(handles.LastFilePath,'string',[handles.lastfiledirectoryname, handles.lastfilefilename]);
end

guidata(hObject, handles);



function FileIncrement_Callback(hObject, eventdata, handles)
% hObject    handle to FileIncrement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FileIncrement as text
%        str2double(get(hObject,'String')) returns contents of FileIncrement as a double


% --- Executes during object creation, after setting all properties.
function FileIncrement_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FileIncrement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ImageType.
function ImageType_Callback(hObject, eventdata, handles)
% hObject    handle to ImageType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ImageType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ImageType


% --- Executes during object creation, after setting all properties.
function ImageType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImageType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SaveAsButton.
function SaveAsButton_Callback(hObject, eventdata, handles)
% hObject    handle to SaveAsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.firstfiledirectoryname ~= 0)
    [handles.savefilename, handles.savedirectoryname] = uiputfile({'*.img','IMG file (*.img)';},'Name to save file',handles.firstfiledirectoryname);
else if (handles.lastfiledirectoryname ~=0)
        [handles.savefilename, handles.savedirectoryname] = uiputfile({'*.img','IMG file (*.img)';},'Name to save file',handles.lastfiledirectoryname);
    else
            [handles.savefilename, handles.savedirectoryname] = uiputfile({'*.img','IMG file (*.img)';},'Name to save file');
    end
end
if (handles.savefilename==0)
    set(handles.SavePath,'string','');
else
    set(handles.SavePath,'string',[handles.savedirectoryname, handles.savefilename]);
end

guidata(hObject, handles);



% --- Executes on button press in CreateDataButton.
function CreateDataButton_Callback(hObject, eventdata, handles)
% hObject    handle to CreateDataButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imagetype = get(handles.ImageType,'Value');
increment = str2num(get(handles.FileIncrement,'string'));
if(isequal(handles.firstfilefilename,0)||isequal(handles.lastfilefilename,0)||isequal(handles.savefilename,0)...
        ||increment~=floor(increment)||~isequal(handles.firstfiledirectoryname,handles.lastfiledirectoryname))
    msg = '';
    if isequal(handles.firstfilefilename,0)
        msg = [msg,' You did not choose the name of the first image.'];
    end
    if isequal(handles.lastfilefilename,0)
        msg = [msg,' You did not choose the name of the last image.'];
    end
    if ~isequal(handles.firstfiledirectoryname,handles.lastfiledirectoryname)
        msg = [msg,' All files should be in the same directory.'];
    end
    if isequal(handles.savefilename,0)
        msg = [msg,' You did not choose where to save the results.'];
    end
    if increment ~=floor(increment)
        msg = [msg,' File increment should be a round number.'];
    end
    msgbox(msg,'ERROR','modal');
else
    switch(imagetype)
        case 1 % Theraview EPID
            filenames = [handles.firstfiledirectoryname, handles.firstfilefilename];
            filenames = substr(filenames,0,-2);
            fn = handles.firstfilefilename;
            ln = handles.lastfilefilename;
            firstnum = str2num(fn(length(fn)-1:length(fn)));
            lastnum = str2num(ln(length(ln)-1:length(ln)));
            list = [firstnum:increment:lastnum];
            try %#ok<TRYNC>
                h = showinfowindow('Creating your dataset. Please wait');
                img = GUIprocessEPID(filenames,list);
                fid = fopen([handles.savedirectoryname, handles.savefilename],'w');
                fwrite(fid,img,'uint8');
                fclose(fid);
                close(h);
            end
        case 2 % P3 DRR
            fn = handles.firstfilefilename;
            ln = handles.lastfilefilename;
            firstnum = str2num(fn(1:length(fn)-4));
            lastnum = str2num(ln(1:length(ln)-4));
            list = [firstnum:increment:lastnum];
            try %#ok<TRYNC>
                h = showinfowindow('Creating your dataset. Please wait');
                img = GUIprocessDRRs(handles.firstfiledirectoryname,list);
                fid = fopen([handles.savedirectoryname, handles.savefilename],'w');
                fwrite(fid,img,'uint8');
                fclose(fid);
                close(h);
            end
    end
end
msgbox('Your results were saved. You can either create another one or close this window.');
guidata(hObject, handles);