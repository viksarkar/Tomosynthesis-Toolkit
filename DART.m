function varargout = DART(varargin)
% DART M-file for DART.fig
%      DART, by itself, creates a new DART or raises the existing
%      singleton*.
%
%      H = DART returns the handle to a new DART or the handle to
%      the existing singleton*.
%
%      DART('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DART.M with the given input arguments.
%
%      DART('Property','Value',...) creates a new DART or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DART_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DART_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DART

% Last Modified by GUIDE v2.5 19-Nov-2008 13:31:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DART_OpeningFcn, ...
                   'gui_OutputFcn',  @DART_OutputFcn, ...
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


% --- Executes just before DART is made visible.
function DART_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DART (see VARARGIN)

axes(handles.Logo); axis off;
A = imread('Logo.jpg');
imshow(A);
% Choose default command line output for DART
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DART wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DART_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function CreateMenu_Callback(hObject, eventdata, handles)
% hObject    handle to CreateMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function CreateMenu_CreateImages_Callback(hObject, eventdata, handles)
% hObject    handle to CreateMenu_CreateImages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CreateDTSImages;


% --------------------------------------------------------------------
function RegisterMenu_Callback(hObject, eventdata, handles)
% hObject    handle to RegisterMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function RegisterMenu_CreateMeta_Callback(hObject, eventdata, handles)
% hObject    handle to RegisterMenu_CreateMeta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CreateMeta_Dialog;

% --------------------------------------------------------------------
function CreateMenu_ProcessRawImage_Callback(hObject, eventdata, handles)
% hObject    handle to CreateMenu_ProcessRawImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ProcessSourceImages;

% --------------------------------------------------------------------
function RegisterMenu_Register_Callback(hObject, eventdata, handles)
% hObject    handle to RegisterMenu_Register (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.outdata = cell(1,8);
[handles.outdata{1,1}, handles.outdata{1,2}, handles.outdata{1,3}, handles.outdata{1,4}, ...
    handles.outdata{1,5}, handles.outdata{1,6}, handles.outdata{1,7}, handles.outdata{1,8}] = RegisterWindow1;
RegisterWindow2(handles.outdata{1,1}, handles.outdata{1,2}, handles.outdata{1,3}, handles.outdata{1,4}, ...
    handles.outdata{1,5}, handles.outdata{1,6}, handles.outdata{1,7}, handles.outdata{1,8});


% --------------------------------------------------------------------
function CreateMenu_SARTParam_Callback(hObject, eventdata, handles)
% hObject    handle to CreateMenu_SARTParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CreateSARTParam;


% --------------------------------------------------------------------
function InfoMenu_Callback(hObject, eventdata, handles)
% hObject    handle to InfoMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function InfoMenu_AboutDART_Callback(hObject, eventdata, handles)
% hObject    handle to InfoMenu_AboutDART (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('This toolbox was created as part of Vikren Sarkar''s Ph.D. project at the UT Health Science Center at San Antonio.','INFO','modal');


% --------------------------------------------------------------------
function ContourMenu_Callback(hObject, eventdata, handles)
% hObject    handle to ContourMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function CreateCT_Callback(hObject, eventdata, handles)
% hObject    handle to CreateCT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CTdirectory = uigetdir('','Pick directory with DICOM Images');
if(CTdirectory==0)
    msgbox('You did not choose a source directory','error','error','modal');
else
    [CTimg,header] = ReadDicom(CTdirectory);
    [filename,pathname] = uiputfile('*.raw','Save the image as raw data');
    if ((~isequal(filename, 0)) && (~isequal(pathname,0)))
        name = [pathname,filename];
        WriterawCTimage(CTimg,header,name);
    else
        errordlg('No valid file selected! Please check!');
        return;
    end
    msgbox('CT Dataset was created','modal');
end

% --------------------------------------------------------------------
function CTP3toDTSP3_Callback(hObject, eventdata, handles)
% hObject    handle to CTP3toDTSP3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CTP3toDTSP3_Dialog;


% --------------------------------------------------------------------
function DTSforP3_Callback(hObject, eventdata, handles)
% hObject    handle to DTSforP3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SaveDTSImageforP3_Dialog;


% --------------------------------------------------------------------
function DTSP3toCTP3_Callback(hObject, eventdata, handles)
% hObject    handle to DTSP3toCTP3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
DTSP3toCTP3_Dialog;


% --------------------------------------------------------------------
function RegisterCT_Callback(hObject, eventdata, handles)
% hObject    handle to RegisterCT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
RegisterCT_Dialog;

