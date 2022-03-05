function varargout = CreateSARTParam(varargin)
% CREATESARTPARAM M-file for CreateSARTParam.fig
%      CREATESARTPARAM, by itself, creates a new CREATESARTPARAM or raises the existing
%      singleton*.
%
%      H = CREATESARTPARAM returns the handle to a new CREATESARTPARAM or the handle to
%      the existing singleton*.
%
%      CREATESARTPARAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CREATESARTPARAM.M with the given input arguments.
%
%      CREATESARTPARAM('Property','Value',...) creates a new CREATESARTPARAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CreateSARTParam_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CreateSARTParam_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CreateSARTParam

% Last Modified by GUIDE v2.5 15-Jul-2008 14:46:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CreateSARTParam_OpeningFcn, ...
                   'gui_OutputFcn',  @CreateSARTParam_OutputFcn, ...
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


% --- Executes just before CreateSARTParam is made visible.
function CreateSARTParam_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CreateSARTParam (see VARARGIN)

handles.paramdirectoryname = 0;

% Choose default command line output for CreateSARTParam
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CreateSARTParam wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CreateSARTParam_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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



function NumVoxx_Callback(hObject, eventdata, handles)
% hObject    handle to NumVoxx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumVoxx as text
%        str2double(get(hObject,'String')) returns contents of NumVoxx as a double


% --- Executes during object creation, after setting all properties.
function NumVoxx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumVoxx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NumVoxy_Callback(hObject, eventdata, handles)
% hObject    handle to NumVoxy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumVoxy as text
%        str2double(get(hObject,'String')) returns contents of NumVoxy as a double


% --- Executes during object creation, after setting all properties.
function NumVoxy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumVoxy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NumVoxz_Callback(hObject, eventdata, handles)
% hObject    handle to NumVoxz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumVoxz as text
%        str2double(get(hObject,'String')) returns contents of NumVoxz as a double


% --- Executes during object creation, after setting all properties.
function NumVoxz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumVoxz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function VoxDimx_Callback(hObject, eventdata, handles)
% hObject    handle to VoxDimx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of VoxDimx as text
%        str2double(get(hObject,'String')) returns contents of VoxDimx as a double


% --- Executes during object creation, after setting all properties.
function VoxDimx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VoxDimx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function VoxDimy_Callback(hObject, eventdata, handles)
% hObject    handle to VoxDimy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of VoxDimy as text
%        str2double(get(hObject,'String')) returns contents of VoxDimy as a double


% --- Executes during object creation, after setting all properties.
function VoxDimy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VoxDimy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function VoxDimz_Callback(hObject, eventdata, handles)
% hObject    handle to VoxDimz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of VoxDimz as text
%        str2double(get(hObject,'String')) returns contents of VoxDimz as a double


% --- Executes during object creation, after setting all properties.
function VoxDimz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VoxDimz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CreateParamsButton.
function CreateParamsButton_Callback(hObject, eventdata, handles)
% hObject    handle to CreateParamsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.paramdirectoryname == 0)
    msgbox('You need to choose a directory to save data');
else
    % Write instruction file to run algorithm
    fid = fopen('args_sartparam.txt','w');
    fprintf(fid,'%s\n',get(handles.dso,'string'));
    fprintf(fid,'%s\n',get(handles.dsd,'string'));
    fprintf(fid,'%s\n',get(handles.NumVoxx,'string'));
    fprintf(fid,'%s\n',get(handles.VoxDimx,'string'));
    fprintf(fid,'%s\n',get(handles.NumVoxy,'string'));
    fprintf(fid,'%s\n',get(handles.VoxDimy,'string'));
    fprintf(fid,'%s\n',get(handles.NumVoxz,'string'));
    fprintf(fid,'%s\n',get(handles.VoxDimz,'string'));
    fprintf(fid,'%s\n',get(handles.StartAngle,'string'));
    fprintf(fid,'%s\n',get(handles.DeltaAngle,'string'));
    fprintf(fid,'%s\n',get(handles.EndAngle,'string'));
    fprintf(fid,'%s\n',get(handles.NumPixx,'string'));
    fprintf(fid,'%s\n',get(handles.PixDimx,'string'));
    fprintf(fid,'%s\n',get(handles.NumPixy,'string'));
    fprintf(fid,'%s',get(handles.PixDimy,'string'));
    fclose(fid);
    % Run the C++ file to create dataset
    dos('start /wait sartparam');
    delete('args_sartparam.txt');
    % Move all .param and .weight files back to save directory
    startangle = str2num(get(handles.StartAngle,'String'));
    deltaangle = str2num(get(handles.DeltaAngle,'String'));
    endangle = str2num(get(handles.EndAngle,'String'));
    for i=startangle:deltaangle:endangle
        try %#ok<TRYNC>
            commandtoexecute = ['movefile(''',num2str(i),'.*'',','''',handles.paramdirectoryname,'\',''')'];
            eval(commandtoexecute);
        end
    end
    if (startangle == endangle)
        try %#ok<TRYNC>
            i = startangle;
            commandtoexecute = ['movefile(''',num2str(i),'.*'',','''',handles.paramdirectoryname,'\',''')'];
            eval(commandtoexecute);
        end
    end
end
msgbox('Your parameter files were successfully created. You may create more files or close this window.');

guidata(hObject, handles);



% --- Executes on button press in SaveDirectoryButton.
function SaveDirectoryButton_Callback(hObject, eventdata, handles)
% hObject    handle to SaveDirectoryButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.paramdirectoryname = uigetdir('Directory to save SART parameter files');
if (handles.paramdirectoryname==0)
    set(handles.SaveDirectoryPath,'string','');
else
    set(handles.SaveDirectoryPath,'string',handles.paramdirectoryname);
end

guidata(hObject, handles);

