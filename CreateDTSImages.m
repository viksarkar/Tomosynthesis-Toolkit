function varargout = CreateDTSImages(varargin)
% CREATEDTSIMAGES M-file for CreateDTSImages.fig
%      CREATEDTSIMAGES, by itself, creates a new CREATEDTSIMAGES or raises the existing
%      singleton*.
%
%      H = CREATEDTSIMAGES returns the handle to a new CREATEDTSIMAGES or the handle to
%      the existing singleton*.
%
%      CREATEDTSIMAGES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CREATEDTSIMAGES.M with the given input arguments.
%
%      CREATEDTSIMAGES('Property','Value',...) creates a new CREATEDTSIMAGES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CreateDTSImages_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CreateDTSImages_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CreateDTSImages

% Last Modified by GUIDE v2.5 14-Jul-2008 16:22:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CreateDTSImages_OpeningFcn, ...
                   'gui_OutputFcn',  @CreateDTSImages_OutputFcn, ...
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


% --- Executes just before CreateDTSImages is made visible.
function CreateDTSImages_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CreateDTSImages (see VARARGIN)

handles.sourcedirectoryname = [];
handles.sourcefilename = [];
handles.savedirectoryname = [];
handles.savefilename = [];
handles.paramdirectoryname = [];

% Choose default command line output for CreateDTSImages
handles.output = hObject;

set(handles.SAAPixDimPanel,'Visible','Off');
set(handles.SARTParamPanel,'Visible','Off');
set(handles.SARTOutputPanel,'Visible','Off');
set(handles.SAAOutputPanel,'Visible','Off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CreateDTSImages wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CreateDTSImages_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in AlgorithmMenu.
function AlgorithmMenu_Callback(hObject, eventdata, handles)
% hObject    handle to AlgorithmMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns AlgorithmMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from AlgorithmMenu
algorithm = get(handles.AlgorithmMenu,'Value');
switch(algorithm)
    case 1 % FDK
        set(handles.DsoDsdPanel,'Visible','On');
        set(handles.SAAPixDimPanel,'Visible','Off');
        set(handles.SARTParamPanel,'Visible','Off');
        set(handles.SARTOutputPanel,'Visible','Off');
        set(handles.SAAOutputPanel,'Visible','Off');
        set(handles.FDKPixDimPanel,'Visible','On');
        set(handles.FDKOutputPanel,'Visible','On');
    case 2 % SAA
        set(handles.DsoDsdPanel,'Visible','On');
        set(handles.FDKPixDimPanel,'Visible','Off');
        set(handles.SAAPixDimPanel,'Visible','On');        
        set(handles.SARTParamPanel,'Visible','Off');
        set(handles.FDKOutputPanel,'Visible','Off');
        set(handles.SARTOutputPanel,'Visible','Off');
        set(handles.SAAOutputPanel,'Visible','On');                
    case 3 % SART
        set(handles.DsoDsdPanel,'Visible','Off');
        set(handles.FDKPixDimPanel,'Visible','Off');
        set(handles.SAAPixDimPanel,'Visible','Off');
        set(handles.SARTParamPanel,'Visible','On');
        set(handles.FDKOutputPanel,'Visible','Off');
        set(handles.SARTOutputPanel,'Visible','On');
        set(handles.SAAOutputPanel,'Visible','Off');                
end
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function AlgorithmMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AlgorithmMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dso_Callback(hObject, eventdata, handles)
% hObject    handle to dso (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dso as text
%        str2double(get(hObject,'String')) returns contents of dso as a double


% --- Executes during object creation, after setting all properties.
function dso_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dso (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dsd_Callback(hObject, eventdata, handles)
% hObject    handle to dsd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dsd as text
%        str2double(get(hObject,'String')) returns contents of dsd as a double


% --- Executes during object creation, after setting all properties.
function dsd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dsd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NumPixx_Callback(hObject, eventdata, handles)
% hObject    handle to NumPixx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumPixx as text
%        str2double(get(hObject,'String')) returns contents of NumPixx as a double


% --- Executes during object creation, after setting all properties.
function NumPixx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumPixx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NumPixy_Callback(hObject, eventdata, handles)
% hObject    handle to NumPixy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumPixy as text
%        str2double(get(hObject,'String')) returns contents of NumPixy as a double


% --- Executes during object creation, after setting all properties.
function NumPixy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumPixy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PixDimx_Callback(hObject, eventdata, handles)
% hObject    handle to PixDimx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PixDimx as text
%        str2double(get(hObject,'String')) returns contents of PixDimx as a double


% --- Executes during object creation, after setting all properties.
function PixDimx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PixDimx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PixDimy_Callback(hObject, eventdata, handles)
% hObject    handle to PixDimy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PixDimy as text
%        str2double(get(hObject,'String')) returns contents of PixDimy as a double


% --- Executes during object creation, after setting all properties.
function PixDimy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PixDimy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in GetInputImages.
function GetInputImages_Callback(hObject, eventdata, handles)
% hObject    handle to GetInputImages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.sourcefilename, handles.sourcedirectoryname] = uigetfile('*.img','Where are source images kept?');
if (handles.sourcefilename==0)
    set(handles.InputPath,'string','');
else
    set(handles.InputPath,'string',[handles.sourcedirectoryname,handles.sourcefilename]);
end

guidata(hObject, handles);


function StartAngle_Callback(hObject, eventdata, handles)
% hObject    handle to StartAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StartAngle as text
%        str2double(get(hObject,'String')) returns contents of StartAngle as a double


% --- Executes during object creation, after setting all properties.
function StartAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StartAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EndAngle_Callback(hObject, eventdata, handles)
% hObject    handle to EndAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EndAngle as text
%        str2double(get(hObject,'String')) returns contents of EndAngle as a double


% --- Executes during object creation, after setting all properties.
function EndAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EndAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DeltaAngle_Callback(hObject, eventdata, handles)
% hObject    handle to DeltaAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DeltaAngle as text
%        str2double(get(hObject,'String')) returns contents of DeltaAngle as a double


% --- Executes during object creation, after setting all properties.
function DeltaAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DeltaAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SAAPixDim_Callback(hObject, eventdata, handles)
% hObject    handle to SAAPixDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SAAPixDim as text
%        str2double(get(hObject,'String')) returns contents of SAAPixDim as a double


% --- Executes during object creation, after setting all properties.
function SAAPixDim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SAAPixDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SaveAsButton.
function SaveAsButton_Callback(hObject, eventdata, handles)
% hObject    handle to SaveAsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[handles.savefilename, handles.savedirectoryname] = uiputfile('*.raw','Where would you like to save the results?');
if (handles.savefilename==0)
    set(handles.OutputPath,'string','');
else
    set(handles.OutputPath,'string',[handles.savedirectoryname,handles.savefilename]);
end
guidata(hObject, handles);

function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit20_Callback(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit20 as text
%        str2double(get(hObject,'String')) returns contents of edit20 as a double


% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit24 as text
%        str2double(get(hObject,'String')) returns contents of edit24 as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit25_Callback(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit25 as text
%        str2double(get(hObject,'String')) returns contents of edit25 as a double


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit26_Callback(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit26 as text
%        str2double(get(hObject,'String')) returns contents of edit26 as a double


% --- Executes during object creation, after setting all properties.
function edit26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FDKNumVoxx_Callback(hObject, eventdata, handles)
% hObject    handle to FDKNumVoxx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FDKNumVoxx as text
%        str2double(get(hObject,'String')) returns contents of FDKNumVoxx as a double


% --- Executes during object creation, after setting all properties.
function FDKNumVoxx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FDKNumVoxx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FDKVoxDimx_Callback(hObject, eventdata, handles)
% hObject    handle to FDKVoxDimx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FDKVoxDimx as text
%        str2double(get(hObject,'String')) returns contents of FDKVoxDimx as a double


% --- Executes during object creation, after setting all properties.
function FDKVoxDimx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FDKVoxDimx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FDKVoxDimy_Callback(hObject, eventdata, handles)
% hObject    handle to FDKVoxDimy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FDKVoxDimy as text
%        str2double(get(hObject,'String')) returns contents of FDKVoxDimy as a double


% --- Executes during object creation, after setting all properties.
function FDKVoxDimy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FDKVoxDimy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FDKVoxDimz_Callback(hObject, eventdata, handles)
% hObject    handle to FDKVoxDimz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FDKVoxDimz as text
%        str2double(get(hObject,'String')) returns contents of FDKVoxDimz as a double


% --- Executes during object creation, after setting all properties.
function FDKVoxDimz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FDKVoxDimz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FDKNumVoxy_Callback(hObject, eventdata, handles)
% hObject    handle to FDKNumVoxy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FDKNumVoxy as text
%        str2double(get(hObject,'String')) returns contents of FDKNumVoxy as a double


% --- Executes during object creation, after setting all properties.
function FDKNumVoxy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FDKNumVoxy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function FDKNumVoxz_Callback(hObject, eventdata, handles)
% hObject    handle to FDKNumVoxz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FDKNumVoxz as text
%        str2double(get(hObject,'String')) returns contents of FDKNumVoxz as a double


% --- Executes during object creation, after setting all properties.
function FDKNumVoxz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FDKNumVoxz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SARTNumVoxx_Callback(hObject, eventdata, handles)
% hObject    handle to SARTNumVoxx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SARTNumVoxx as text
%        str2double(get(hObject,'String')) returns contents of SARTNumVoxx as a double


% --- Executes during object creation, after setting all properties.
function SARTNumVoxx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SARTNumVoxx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SARTNumVoxy_Callback(hObject, eventdata, handles)
% hObject    handle to SARTNumVoxy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SARTNumVoxy as text
%        str2double(get(hObject,'String')) returns contents of SARTNumVoxy as a double


% --- Executes during object creation, after setting all properties.
function SARTNumVoxy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SARTNumVoxy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SARTNumVoxz_Callback(hObject, eventdata, handles)
% hObject    handle to SARTNumVoxz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SARTNumVoxz as text
%        str2double(get(hObject,'String')) returns contents of SARTNumVoxz as a double


% --- Executes during object creation, after setting all properties.
function SARTNumVoxz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SARTNumVoxz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SARTNumItr_Callback(hObject, eventdata, handles)
% hObject    handle to SARTNumItr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SARTNumItr as text
%        str2double(get(hObject,'String')) returns contents of SARTNumItr as a double


% --- Executes during object creation, after setting all properties.
function SARTNumItr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SARTNumItr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SARTRelaxParam_Callback(hObject, eventdata, handles)
% hObject    handle to SARTRelaxParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SARTRelaxParam as text
%        str2double(get(hObject,'String')) returns contents of SARTRelaxParam as a double


% --- Executes during object creation, after setting all properties.
function SARTRelaxParam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SARTRelaxParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SAANumSlices_Callback(hObject, eventdata, handles)
% hObject    handle to SAANumSlices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SAANumSlices as text
%        str2double(get(hObject,'String')) returns contents of SAANumSlices as a double


% --- Executes during object creation, after setting all properties.
function SAANumSlices_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SAANumSlices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SAASliceSep_Callback(hObject, eventdata, handles)
% hObject    handle to SAASliceSep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SAASliceSep as text
%        str2double(get(hObject,'String')) returns contents of SAASliceSep as a double


% --- Executes during object creation, after setting all properties.
function SAASliceSep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SAASliceSep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CreateDTSButton.
function CreateDTSButton_Callback(hObject, eventdata, handles)
% hObject    handle to CreateDTSButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
algorithm = get(handles.AlgorithmMenu,'Value');
deletefile = 0;
try %#ok<TRYNC>
    [s m mid] = copyfile([handles.sourcedirectoryname,handles.sourcefilename]);
    if (s)
        deletefile = 1;
    end
end

switch(algorithm)
    case 1
        % Write instruction file to run algorithm
        fid = fopen('fdkinstructions.txt','w');
        fprintf(fid,'%s\n',handles.sourcefilename);
        fprintf(fid,'%s\n',get(handles.StartAngle,'string'));
        fprintf(fid,'%s\n',get(handles.DeltaAngle,'string'));
        fprintf(fid,'%s\n',get(handles.EndAngle,'string'));
        fprintf(fid,'%s\n',get(handles.dso,'string'));
        fprintf(fid,'%s\n',get(handles.dsd,'string'));
        fprintf(fid,'%s\n',get(handles.FDKNumVoxx,'string'));
        fprintf(fid,'%s\n',get(handles.FDKVoxDimx,'string'));
        fprintf(fid,'%s\n',get(handles.FDKNumVoxy,'string'));
        fprintf(fid,'%s\n',get(handles.FDKVoxDimy,'string'));
        fprintf(fid,'%s\n',get(handles.FDKNumVoxz,'string'));
        fprintf(fid,'%s\n',get(handles.FDKVoxDimz,'string'));
        fprintf(fid,'%s\n',get(handles.NumPixx,'string'));
        fprintf(fid,'%s\n',get(handles.PixDimx,'string'));
        fprintf(fid,'%s\n',get(handles.NumPixy,'string'));
        fprintf(fid,'%s\n',get(handles.PixDimy,'string'));
        fprintf(fid,'%s',handles.savefilename);
        fclose(fid);
        % Run the C++ file to create dataset
        dos('start /wait fdk fdkinstructions.txt');
        delete('fdkinstructions.txt');
        try %#ok<TRYNC>
            movefile(handles.savefilename, [handles.savedirectoryname, handles.savefilename]);
        end
        % Write mhd file for FDK dataset
        mhdfilename = substr(handles.savefilename,0,-4);
        mhdfilename = [mhdfilename,'.mhd'];
        FDKNumVoxx = str2num(get(handles.FDKNumVoxx,'string'));
        FDKNumVoxy = str2num(get(handles.FDKNumVoxy,'string'));
        FDKNumVoxz = str2num(get(handles.FDKNumVoxz,'string'));
        FDKVoxDimx = str2num(get(handles.FDKVoxDimx,'string'));
        FDKVoxDimy = str2num(get(handles.FDKVoxDimy,'string'));
        FDKVoxDimz = str2num(get(handles.FDKVoxDimz,'string'));
        xstart = -((FDKNumVoxx-1)/2)*FDKVoxDimx*10;
        ystart = ((FDKNumVoxy-1)/2)*FDKVoxDimy*10;
        zstart = -((FDKNumVoxz-1)/2)*FDKVoxDimz*10;
        fid = fopen([handles.savedirectoryname,mhdfilename],'w');
        h = cell(1,8);
        h{1} = sprintf('ObjectType = Image');
        h{2} = sprintf('NDims = 3');
        h{3} = sprintf('DimSize = %i %i %i',FDKNumVoxx,FDKNumVoxy,FDKNumVoxz);
        h{4} = sprintf('ElementSpacing = %.5f %.5f %.5f',10*FDKVoxDimx,-10*FDKVoxDimy,10*FDKVoxDimz);
        h{5} = sprintf('Offset = %.4f %.4f %.4f',xstart,ystart,zstart);
        h{6} = sprintf('ElementByteOrderMSB = False');
        h{7} = sprintf('ElementType = MET_USHORT');
        h{8} = sprintf('ElementDataFile = %s',handles.savefilename);
        fprintf(fid,'%s\n',h{:});
        fclose(fid);
    case 2
        % Write instruction file to run algorithm
        fid = fopen('saainstructions.txt','w');
        fprintf(fid,'%s\n',handles.sourcefilename);
        fprintf(fid,'%s\n',get(handles.NumPixx,'string'));
        fprintf(fid,'%s\n',get(handles.NumPixy,'string'));
        fprintf(fid,'%s\n',get(handles.dso,'string'));
        fprintf(fid,'%s\n',get(handles.dsd,'string'));
        fprintf(fid,'%s\n',get(handles.SAAPixDim,'string'));
        fprintf(fid,'%s\n',get(handles.SAANumSlices,'string'));
        fprintf(fid,'%s\n',get(handles.SAASliceSep,'string'));
        fprintf(fid,'%s\n',get(handles.StartAngle,'string'));
        fprintf(fid,'%s\n',get(handles.DeltaAngle,'string'));
        fprintf(fid,'%s\n',get(handles.EndAngle,'string'));
        fprintf(fid,'%s',handles.savefilename);
        fclose(fid);
        % Run the C++ file to create dataset
        dos('start /wait saa saainstructions.txt');
        delete('saainstructions.txt');
        try %#ok<TRYNC>
            movefile(handles.savefilename, [handles.savedirectoryname, handles.savefilename]);
        end
        % Write mhd file for SAA dataset
        mhdfilename = substr(handles.savefilename,0,-4);
        mhdfilename = [mhdfilename,'.mhd'];
        NumPixx = str2num(get(handles.NumPixx,'string'));
        NumPixy = str2num(get(handles.NumPixy,'string'));
        dso = str2num(get(handles.dso,'string'));
        dsd = str2num(get(handles.dsd,'string'));
        minfactor = dso/dsd;
        SAAPixDim = str2num(get(handles.SAAPixDim,'string'))*minfactor;
        SAANumSlices = str2num(get(handles.SAANumSlices,'string'));
        SAASliceSep = str2num(get(handles.SAASliceSep,'string'));
        xstart = -((NumPixx-1)/2)*SAAPixDim*10;
        ystart = ((SAANumSlices-1)/2)*SAASliceSep*10;
        zstart = -((NumPixy-1)/2)*SAAPixDim*10;
        fid = fopen([handles.savedirectoryname,mhdfilename],'w');
        h = cell(1,8);
        h{1} = sprintf('ObjectType = Image');
        h{2} = sprintf('NDims = 3');
        h{3} = sprintf('DimSize = %i %i %i',NumPixx,SAANumSlices,NumPixy);
        h{4} = sprintf('ElementSpacing = %.5f %.5f %.5f',10*SAAPixDim,-10*SAASliceSep,10*SAAPixDim);
        h{5} = sprintf('Offset = %.4f %.4f %.4f',xstart,ystart,zstart);
        h{6} = sprintf('ElementByteOrderMSB = False');
        h{7} = sprintf('ElementType = MET_USHORT');
        h{8} = sprintf('ElementDataFile = %s',handles.savefilename);
        fprintf(fid,'%s\n',h{:});
        fclose(fid);
    case 3
        % Write instruction file to run algorithm
        fid = fopen('sartinstructions.txt','w');
        fprintf(fid,'%s\n',handles.sourcefilename);
        fprintf(fid,'%s\n',get(handles.NumPixx,'string'));
        fprintf(fid,'%s\n',get(handles.NumPixy,'string'));
        fprintf(fid,'%s\n',get(handles.SARTNumVoxx,'string'));
        fprintf(fid,'%s\n',get(handles.SARTNumVoxy,'string'));
        fprintf(fid,'%s\n',get(handles.SARTNumVoxz,'string'));
        fprintf(fid,'%s\n',get(handles.SARTRelaxParam,'string'));
        fprintf(fid,'%s\n',get(handles.SARTNumItr,'string'));
        fprintf(fid,'%s\n',get(handles.StartAngle,'string'));
        fprintf(fid,'%s\n',get(handles.DeltaAngle,'string'));
        fprintf(fid,'%s\n',get(handles.EndAngle,'string'));
        fprintf(fid,'%s',handles.savefilename);
        fclose(fid);
        % Move all .param and .weight files to current directory
        startangle = str2num(get(handles.StartAngle,'String'));
        deltaangle = str2num(get(handles.DeltaAngle,'String'));
        endangle = str2num(get(handles.EndAngle,'String'));
        for i=startangle:deltaangle:endangle
            try %#ok<TRYNC>
                commandtoexecute = ['movefile(''',handles.paramdirectoryname,'\',num2str(i),'.*'')'];
                eval(commandtoexecute);
            end
        end
        % Run the C++ file to create dataset
        dos('start /wait sart sartinstructions.txt');
        delete('sartinstructions.txt');
        try %#ok<TRYNC>
            movefile(handles.savefilename, [handles.savedirectoryname, handles.savefilename]);
        end
        % Move all .param and .weight files back to original directory
        for i=startangle:deltaangle:endangle
            try %#ok<TRYNC>
                commandtoexecute = ['movefile(''',num2str(i),'.*'',','''',handles.paramdirectoryname,'\',''')'];
                eval(commandtoexecute);
            end
        end
        % Write mhd file for SART dataset
        mhdfilename = substr(handles.savefilename,0,-4);
        mhdfilename = [mhdfilename,'.mhd'];
        SARTNumVoxx = str2num(get(handles.SARTNumVoxx,'string'));
        SARTNumVoxy = str2num(get(handles.SARTNumVoxy,'string'));
        SARTNumVoxz = str2num(get(handles.SARTNumVoxz,'string'));
        SARTVoxDimx = str2num(get(handles.SARTVoxDimx,'string'));
        SARTVoxDimy = str2num(get(handles.SARTVoxDimy,'string'));
        SARTVoxDimz = str2num(get(handles.SARTVoxDimz,'string'));
        xstart = -((SARTNumVoxx-1)/2)*SARTVoxDimx*10;
        ystart = ((SARTNumVoxy-1)/2)*SARTVoxDimy*10;
        zstart = -((SARTNumVoxz-1)/2)*SARTVoxDimz*10;
        fid = fopen([handles.savedirectoryname,mhdfilename],'w');
        h = cell(1,8);
        h{1} = sprintf('ObjectType = Image');
        h{2} = sprintf('NDims = 3');
        h{3} = sprintf('DimSize = %i %i %i',SARTNumVoxx,SARTNumVoxy,SARTNumVoxz);
        h{4} = sprintf('ElementSpacing = %.5f %.5f %.5f',10*SARTVoxDimx,-10*SARTVoxDimy,10*SARTVoxDimz);
        h{5} = sprintf('Offset = %.4f %.4f %.4f',xstart,ystart,zstart);
        h{6} = sprintf('ElementByteOrderMSB = False');
        h{7} = sprintf('ElementType = MET_USHORT');
        h{8} = sprintf('ElementDataFile = %s',handles.savefilename);
        fprintf(fid,'%s\n',h{:});
        fclose(fid);
end

if(deletefile)
    delete([handles.sourcefilename]);
end

msgbox('Your data was successfully created. You can now close this window or create a different dataset');

guidata(hObject,handles);


% --- Executes on button press in GetParamDirectory.
function GetParamDirectory_Callback(hObject, eventdata, handles)
% hObject    handle to GetParamDirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.paramdirectoryname = uigetdir('Directory containing SART parameter files');
if (handles.paramdirectoryname==0)
    set(handles.ParamLoc,'string','');
else
    set(handles.ParamLoc,'string',handles.paramdirectoryname);
end

guidata(hObject, handles);



function SARTVoxDimx_Callback(hObject, eventdata, handles)
% hObject    handle to SARTVoxDimx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SARTVoxDimx as text
%        str2double(get(hObject,'String')) returns contents of SARTVoxDimx as a double


% --- Executes during object creation, after setting all properties.
function SARTVoxDimx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SARTVoxDimx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SARTVoxDimy_Callback(hObject, eventdata, handles)
% hObject    handle to SARTVoxDimy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SARTVoxDimy as text
%        str2double(get(hObject,'String')) returns contents of SARTVoxDimy as a double


% --- Executes during object creation, after setting all properties.
function SARTVoxDimy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SARTVoxDimy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SARTVoxDimz_Callback(hObject, eventdata, handles)
% hObject    handle to SARTVoxDimz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SARTVoxDimz as text
%        str2double(get(hObject,'String')) returns contents of SARTVoxDimz as a double


% --- Executes during object creation, after setting all properties.
function SARTVoxDimz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SARTVoxDimz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


