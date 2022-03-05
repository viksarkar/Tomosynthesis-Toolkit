function varargout = RegisterWindow1(varargin)
% REGISTERWINDOW1 M-file for RegisterWindow1.fig
%      REGISTERWINDOW1, by itself, creates a new REGISTERWINDOW1 or raises the existing
%      singleton*.
%
%      H = REGISTERWINDOW1 returns the handle to a new REGISTERWINDOW1 or the handle to
%      the existing singleton*.
%
%      REGISTERWINDOW1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REGISTERWINDOW1.M with the given input arguments.
%
%      REGISTERWINDOW1('Property','Value',...) creates a new REGISTERWINDOW1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RegisterWindow1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RegisterWindow1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RegisterWindow1

% Last Modified by GUIDE v2.5 20-Oct-2008 21:47:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RegisterWindow1_OpeningFcn, ...
                   'gui_OutputFcn',  @RegisterWindow1_OutputFcn, ...
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


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes just before RegisterWindow1 is made visible.
function RegisterWindow1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RegisterWindow1 (see VARARGIN)

% Choose default command line output for RegisterWindow1
handles.output = hObject;

% Update handles structure

% Turn off axis labels
axes(handles.CTAxes); axis off; 
axes(handles.DTSAxes); axis off;

% Turn off 3D slice-select sliders and plane selectors
set(handles.CTSliceSlider,'Visible','OFF'); 
set(handles.DTSSliceSlider,'Visible','OFF');
set(handles.CTPlaneSelector,'Visible','OFF');
set(handles.DTSPlaneSelector,'Visible','OFF');

% Slider min values
set(handles.CTSliceSlider, 'Min', 1);
set(handles.DTSSliceSlider, 'Min', 1);

% Turn off un-used Panel
set(handles.CPPanel,'Visible','OFF');

% Turn off Register Button and instructions
set(handles.RegisterButton,'Visible','OFF');
set(handles.ManualRegisterInstructions, 'Visible', 'off');

%Initialize data information
handles.fixeddata=[];
handles.movingdata=[];

%Initialize Path and Filenames
handles.fixedpathname = '';
handles.fixedfilename = '';
handles.movingpathname = '';
handles.movingfilename = '';

%Initialize Image Size Parameters
handles.fixedxsize = 0;
handles.fixedysize = 0;
handles.fixedzsize = 0;
handles.movingxsize = 0;
handles.movingysize = 0;
handles.movingzsize = 0;

%Initialize Image Size Parameters
handles.fixedxvoxdim = 1;
handles.fixedyvoxdim = 1;
handles.fixedzvoxdim = 1;
handles.movingxvoxdim = 1;
handles.movingyvoxdim = 1;
handles.movingzvoxdim = 1;

%Initialize Image Offset Parameters
handles.fixedxoffset = 0;
handles.fixedyoffset = 0;
handles.fixedzoffset = 0;
handles.movingxoffset = 0;
handles.movingyoffset = 0;
handles.movingzoffset = 0;

%Initialize slice selection parameters
handles.fixedslicenum = 1;
handles.movingslicenum = 1;
handles.registeredslicenum = 1;

%Initialize Center Parameters
handles.fixedxcenter=0;
handles.fixedycenter=0;
handles.fixedzcenter=0;
handles.movingxcenter=0;
handles.movingycenter=0;
handles.movingzcenter=0;

%Initialize various boolean flags
handles.fixedopen = 0;
handles.movingopen = 0;

%Initialize Contol Point Parameters
handles.numcontrolpoints = 0;
handles.fixedpoints = [];
handles.movingpoints = [];

%Initialize min and max values and brightness multipliers
handles.fixedminval = 0;
handles.fixedmaxval = 0;
handles.movingminval = 0;
handles.movingmaxval = 0;
handles.fixedbrightness = 1;
handles.movingbrightness = 1;

guidata(hObject, handles);

% UIWAIT makes RegisterWindow1 wait for user response (see UIRESUME)
uiwait(handles.figure1);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Outputs from this function are returned to the command line.
function varargout = RegisterWindow1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1,1} = handles.fixeddata;
varargout{1,2} = handles.fixedxvoxdim;
varargout{1,3} = handles.fixedyvoxdim;
varargout{1,4} = handles.fixedzvoxdim;
varargout{1,5} = handles.fixedpoints;
varargout{1,6} = handles.movingpoints;
varargout{1,7} = handles.movingpathname;
varargout{1,8} = handles.movingfilename;
delete(handles.figure1);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on slider movement.
function CTSliceSlider_Callback(hObject, eventdata, handles)
% hObject    handle to CTSliceSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
orientation = get(handles.CTPlaneSelector,'Value');
if (orientation==1)
    currentval = floor(get(handles.CTSliceSlider,'Value'));
    axes(handles.CTAxes);
    dispimage = handles.fixedbrightness*handles.fixeddata(:,:,currentval);
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.fixedminval,handles.fixedmaxval]); axis square; colormap(gray); axis off;
end
if (orientation==2)
    currentval = floor(get(handles.CTSliceSlider,'Value'));
    axes(handles.CTAxes);
    dispimage = handles.fixedbrightness*squeeze(handles.fixeddata(:,currentval,:));
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.fixedminval,handles.fixedmaxval]); axis square; colormap(gray); axis off;
end
if (orientation==3)
    currentval = floor(get(handles.CTSliceSlider,'Value'));
    axes(handles.CTAxes);
    dispimage = handles.fixedbrightness*squeeze(handles.fixeddata(currentval,:,:));
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.fixedminval,handles.fixedmaxval]); axis square; colormap(gray); axis off;
end


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes during object creation, after setting all properties.
function CTSliceSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CTSliceSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on slider movement.
function DTSSliceSlider_Callback(hObject, eventdata, handles)
% hObject    handle to DTSSliceSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
orientation = get(handles.DTSPlaneSelector,'Value');
if (orientation==1)
    currentval = floor(get(handles.DTSSliceSlider,'Value'));
    axes(handles.DTSAxes);
    dispimage = handles.movingbrightness*handles.movingdata(:,:,currentval);
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.movingminval,handles.movingmaxval]); axis square; colormap(gray); axis off;
end
if (orientation==2)
    currentval = floor(get(handles.DTSSliceSlider,'Value'));
    axes(handles.DTSAxes);
    dispimage = handles.movingbrightness*squeeze(handles.movingdata(:,currentval,:));
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.movingminval,handles.movingmaxval]); axis square; colormap(gray); axis off;
end
if (orientation==3)
    currentval = floor(get(handles.DTSSliceSlider,'Value'));
    axes(handles.DTSAxes);
    dispimage = handles.movingbrightness*squeeze(handles.movingdata(currentval,:,:));
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.movingminval,handles.movingmaxval]); axis square; colormap(gray); axis off;
end

%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes during object creation, after setting all properties.
function DTSSliceSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DTSSliceSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in OpenDTSButton.
function OpenDTSButton_Callback(hObject, eventdata, handles)
% hObject    handle to OpenDTSButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.movingfilename, handles.movingpathname] = uigetfile({'*.mhd;*.mha','META Header Files (*.mhd, *.mha)'},'Open DTS Dataset');
if(handles.movingfilename~=0)
    [handles.movingxsize,handles.movingysize,handles.movingzsize, ...
        handles.movingxoffset,handles.movingyoffset,handles.movingzoffset,...
        handles.movingxvoxdim,handles.movingyvoxdim,handles.movingzvoxdim,filename]=...
        Readmhd([handles.movingpathname, handles.movingfilename]);
    fid = fopen([handles.movingpathname,filename],'r');
    handles.movingdata = fread(fid,'uint16');
    fclose(fid);
    handles.movingminval = min(handles.movingdata);
    handles.movingmaxval = max(handles.movingdata);
    handles.movingdata = reshape(handles.movingdata, handles.movingxsize, handles.movingysize, handles.movingzsize);
    axes(handles.DTSAxes);
    dispimage = handles.movingbrightness*handles.movingdata(:,:,handles.movingslicenum);
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.movingminval,handles.movingmaxval]); axis square; axis off; colormap(gray);
    handles.movingopen = 1;
    if (handles.movingzsize > 1)
        set(handles.DTSSliceSlider,'Max',handles.movingzsize);
        set(handles.DTSSliceSlider,'Sliderstep',[1/handles.movingzsize, 10/handles.movingzsize]);
        set(handles.DTSSliceSlider,'Value',1);
        set(handles.DTSSliceSlider,'Visible','ON');
        set(handles.DTSPlaneSelector,'Value',1);
        set(handles.DTSPlaneSelector,'Visible','ON');
    end
    if (handles.fixedopen && handles.movingopen)
        set(handles.CPPanel,'Visible','ON');
        set(handles.ManualRegisterInstructions, 'Visible', 'on');
    end
    zoom on;
end
guidata(hObject, handles);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on selection change in DTSPlaneSelector.
function DTSPlaneSelector_Callback(hObject, eventdata, handles) %#ok<INUSD>
% hObject    handle to DTSPlaneSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns DTSPlaneSelector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DTSPlaneSelector
orientation = get(handles.DTSPlaneSelector,'Value');
if (orientation==1) %Axial
    set(handles.DTSSliceSlider,'Value',1);
    set(handles.DTSSliceSlider,'Max',handles.movingzsize);
    set(handles.DTSSliceSlider,'Sliderstep',[1/handles.movingzsize, 10/handles.movingzsize]);
    axes(handles.DTSAxes);
    dispimage = handles.movingbrightness*handles.movingdata(:,:,1);
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.movingminval,handles.movingmaxval]); axis square; colormap(gray); axis off;
end
if (orientation==2) %Coronal
    set(handles.DTSSliceSlider,'Value',1);
    set(handles.DTSSliceSlider,'Max',handles.movingysize);
    set(handles.DTSSliceSlider,'Sliderstep',[1/handles.movingysize, 10/handles.movingysize]);
    axes(handles.DTSAxes);
    dispimage = handles.movingbrightness*squeeze(handles.movingdata(:,1,:));
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.movingminval,handles.movingmaxval]); axis square; colormap(gray); axis off;
end
if (orientation==3) %Sagittal
    set(handles.DTSSliceSlider,'Value',1);
    set(handles.DTSSliceSlider,'Max',handles.movingxsize);
    set(handles.DTSSliceSlider,'Sliderstep',[1/handles.movingxsize, 10/handles.movingxsize]);
    axes(handles.DTSAxes);
    dispimage = handles.movingbrightness*squeeze(handles.movingdata(1,:,:));
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.movingminval,handles.movingmaxval]); axis square; colormap(gray); axis off;
end


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes during object creation, after setting all properties.
function DTSPlaneSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DTSPlaneSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in OpenCTButton.
function OpenCTButton_Callback(hObject, eventdata, handles)
% hObject    handle to OpenCTButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.fixedfilename, handles.fixedpathname] = uigetfile({'*.mhd;*.mha','META Header Files (*.mhd, *.mha)'},'Open CT Dataset');
if(handles.fixedfilename~=0)
    [handles.fixedxsize,handles.fixedysize,handles.fixedzsize, ...
        handles.fixedxoffset,handles.fixedyoffset,handles.fixedzoffset,...
        handles.fixedxvoxdim,handles.fixedyvoxdim,handles.fixedzvoxdim,filename]=...
        Readmhd([handles.fixedpathname, handles.fixedfilename]);
    fid = fopen([handles.fixedpathname,filename],'r');
    handles.fixeddata = fread(fid,'uint16');
    fclose(fid);
    handles.fixedminval = min(handles.fixeddata);
    handles.fixedmaxval = max(handles.fixeddata);
    handles.fixeddata = reshape(handles.fixeddata, handles.fixedxsize, handles.fixedysize, handles.fixedzsize);
    axes(handles.CTAxes);
    dispimage = handles.fixedbrightness*handles.fixeddata(:,:,handles.fixedslicenum);
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.fixedminval,handles.fixedmaxval]); axis square; axis off; colormap(gray);
    handles.fixedopen = 1;
    if (handles.fixedzsize > 1)
        set(handles.CTSliceSlider,'Max',handles.fixedzsize);
        set(handles.CTSliceSlider,'Value',1);
        set(handles.CTSliceSlider,'SliderStep',[1/handles.fixedzsize, 10/handles.fixedzsize]);
        set(handles.CTSliceSlider,'Visible','ON');
        set(handles.CTPlaneSelector,'Value',1);
        set(handles.CTPlaneSelector,'Visible','ON');
    end
    if (handles.fixedopen && handles.movingopen)
        set(handles.CPPanel,'Visible','ON');
        set(handles.ManualRegisterInstructions, 'Visible', 'on');
    end
    zoom on;
end
guidata(hObject, handles);
     

%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on selection change in CTPlaneSelector.
function CTPlaneSelector_Callback(hObject, eventdata, handles)
% hObject    handle to CTPlaneSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns CTPlaneSelector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from CTPlaneSelector
orientation = get(handles.CTPlaneSelector,'Value');
if (orientation==1) %Axial
    set(handles.CTSliceSlider,'Value',1);
    set(handles.CTSliceSlider,'Max',handles.fixedzsize);
    set(handles.CTSliceSlider,'Sliderstep',[1/handles.fixedzsize, 10/handles.fixedzsize]);
    axes(handles.CTAxes);
    dispimage = handles.fixedbrightness*handles.fixeddata(:,:,1);
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.fixedminval,handles.fixedmaxval]); axis square; colormap(gray); axis off;
end
if (orientation==2) %Coronal
    set(handles.CTSliceSlider,'Value',1);
    set(handles.CTSliceSlider,'Max',handles.fixedysize);
    set(handles.CTSliceSlider,'Sliderstep',[1/handles.fixedysize, 10/handles.fixedysize]);
    axes(handles.CTAxes);
    dispimage = handles.fixedbrightness*squeeze(handles.fixeddata(:,1,:));
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.fixedminval,handles.fixedmaxval]); axis square; colormap(gray); axis off;
end
if (orientation==3) %Sagittal
    set(handles.CTSliceSlider,'Value',1);
    set(handles.CTSliceSlider,'Max',handles.fixedxsize);
    set(handles.CTSliceSlider,'Sliderstep',[1/handles.fixedxsize, 10/handles.fixedxsize]);
    axes(handles.CTAxes);
    dispimage = handles.fixedbrightness*squeeze(handles.fixeddata(1,:,:));
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.fixedminval,handles.fixedmaxval]); axis square; colormap(gray); axis off;
end


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes during object creation, after setting all properties.
function CTPlaneSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CTPlaneSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in GetCPButton.
function GetCPButton_Callback(hObject, eventdata, handles)
% hObject    handle to GetCPButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (handles.numcontrolpoints == 0)
    uiwait(msgbox('Please select point from CT first and point from DTS data second. To select another point, push button again.','Pick control point pair','modal'));
end
axes(handles.CTAxes);
[Cx, Cy]=ginput(1);
hold on;
plot(Cx,Cy,'r.');
hold off;
axes(handles.DTSAxes);
[Dx, Dy]=ginput(1);
hold on;
plot(Dx,Dy,'b.');
hold off;
if handles.fixedzcenter == 1
    handles.fixedpoints = [handles.fixedpoints; ((Cx-handles.fixedxcenter)*handles.fixedxvoxdim), (((handles.fixedysize-Cy+1)-handles.fixedycenter)*handles.fixedyvoxdim), 1];
else
    switch(get(handles.CTPlaneSelector,'Value'))
        case 1 % Axial
            xcoord = handles.fixedxoffset + ((round(Cx)-1)*handles.fixedxvoxdim);
            ycoord = handles.fixedyoffset - ((round(Cy)-1)*handles.fixedyvoxdim);
            zval = get(handles.CTSliceSlider,'Value');
            zcoord = handles.fixedzoffset + ((round(zval)-1)*handles.fixedzvoxdim);
            handles.fixedpoints = [handles.fixedpoints; xcoord, ycoord, zcoord];
        case 2 % Coronal
            xcoord = handles.fixedxoffset + ((round(Cx)-1)*handles.fixedxvoxdim);
            yval = get(handles.CTSliceSlider,'Value');
            ycoord = handles.fixedyoffset - ((round(yval)-1)*handles.fixedyvoxdim);
            zcoord = handles.fixedzoffset + ((round(Cy)-1)*handles.fixedzvoxdim);
            handles.fixedpoints = [handles.fixedpoints; xcoord, ycoord, zcoord];
        case 3 %Sagittal
            xval = get(handles.CTSliceSlider,'Value');
            xcoord = handles.fixedxoffset + ((round(xval)-1)*handles.fixedxvoxdim);
            ycoord = handles.fixedyoffset - ((round(Cx)-1)*handles.fixedyvoxdim);
            zcoord = handles.fixedzoffset + ((round(Cy)-1)*handles.fixedzvoxdim);
            handles.fixedpoints = [handles.fixedpoints; xcoord, ycoord, zcoord];
    end
end
if handles.fixedzcenter == 1
    handles.movingpoints = [handles.movingpoints; ((Dx-handles.movingxcenter)*handles.movingxvoxdim), (((handles.movingysize-Dy+1)-handles.movingycenter)*handles.movingyvoxdim), 1];
else
    switch(get(handles.DTSPlaneSelector,'Value'))
        case 1 % Axial
            xcoord = handles.movingxoffset + ((round(Dx)-1)*handles.movingxvoxdim);
            ycoord = handles.movingyoffset - ((round(Dy)-1)*handles.movingyvoxdim);
            zval = get(handles.DTSSliceSlider,'Value');
            zcoord = handles.movingzoffset + ((round(zval)-1)*handles.movingzvoxdim);
            handles.movingpoints = [handles.movingpoints; xcoord, ycoord, zcoord];
        case 2 % Coronal
            xcoord = handles.movingxoffset + ((round(Dx)-1)*handles.movingxvoxdim);
            yval = get(handles.DTSSliceSlider,'Value');
            ycoord = handles.movingyoffset - ((round(yval)-1)*handles.movingyvoxdim);
            zcoord = handles.movingzoffset + ((round(Dy)-1)*handles.movingzvoxdim);
            handles.movingpoints = [handles.movingpoints; xcoord, ycoord, zcoord];
        case 3 %Sagittal
            xval = get(handles.DTSSliceSlider,'Value');
            xcoord = handles.movingxoffset + ((round(xval)-1)*handles.movingxvoxdim);
            ycoord = handles.movingyoffset - ((round(Dx)-1)*handles.movingyvoxdim);
            zcoord = handles.movingzoffset + ((round(Dy)-1)*handles.movingzvoxdim);
            handles.movingpoints = [handles.movingpoints; xcoord, ycoord, zcoord];
    end
end
handles.numcontrolpoints = handles.numcontrolpoints + 1;
set(handles.NumCP,'String',num2str(handles.numcontrolpoints));
set(handles.RegisterButton,'Visible','ON');
zoom on;

%  handles.fixedpoints
%  handles.movingpoints

guidata(hObject, handles);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in RegisterButton.
function RegisterButton_Callback(hObject, eventdata, handles)
% hObject    handle to RegisterButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% % % Resample Datasets for registration
deletefixed = 0; deletemoving = 0;
if (fopen(handles.fixedfilename)==-1)
    deletefixed = 1;
    newfixedfilename = substr(handles.fixedfilename,0,-3);
    newfixedfilename = strcat(newfixedfilename,'*');
    copyfile([handles.fixedpathname,newfixedfilename]);
end
if (fopen(handles.movingfilename)==-1)
    deletemoving = 1;
    newmovingfilename = substr(handles.movingfilename,0,-3);
    newmovingfilename = strcat(newmovingfilename,'*');
    copyfile([handles.movingpathname,newmovingfilename]);
end
h = showinfowindow('Resampling Data before Registration');
commandstring = ['LinearResample ',handles.fixedfilename,' ',handles.movingfilename];
dos(commandstring);
if (deletefixed)
    delete(newfixedfilename);
end
if (deletemoving)
    delete(newmovingfilename);
end
close(h);
uiresume(handles.figure1);

%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in DeleteCPButton.
function DeleteCPButton_Callback(hObject, eventdata, handles)
% hObject    handle to DeleteCPButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.fixedpoints(handles.numcontrolpoints,:)=[];
handles.movingpoints(handles.numcontrolpoints,:)=[];
handles.numcontrolpoints = handles.numcontrolpoints - 1;
set(handles.NumCP,'String',num2str(handles.numcontrolpoints));
if (handles.numcontrolpoints == 0)
    set(handles.RegisterButton,'Visible','OFF');
end
guidata(hObject, handles);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in CTLowerBrightnessButtton.
function CTLowerBrightnessButtton_Callback(hObject, eventdata, handles)
% hObject    handle to CTLowerBrightnessButtton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.fixedminval = handles.fixedminval * 0.9;
handles.fixedmaxval = handles.fixedmaxval * 1.1;

orientation = get(handles.CTPlaneSelector,'Value');
if (orientation==1)
    currentval = floor(get(handles.CTSliceSlider,'Value'));
    axes(handles.CTAxes);
    dispimage = handles.fixedbrightness*handles.fixeddata(:,:,currentval);
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.fixedminval,handles.fixedmaxval]); axis square; colormap(gray); axis off;
end
if (orientation==2)
    currentval = floor(get(handles.CTSliceSlider,'Value'));
    axes(handles.CTAxes);
    dispimage = handles.fixedbrightness*squeeze(handles.fixeddata(:,currentval,:));
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.fixedminval,handles.fixedmaxval]); axis square; colormap(gray); axis off;
end
if (orientation==3)
    currentval = floor(get(handles.CTSliceSlider,'Value'));
    axes(handles.CTAxes);
    dispimage = handles.fixedbrightness*squeeze(handles.fixeddata(currentval,:,:));
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.fixedminval,handles.fixedmaxval]); axis square; colormap(gray); axis off;
end

guidata(hObject, handles);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in CTHigherBrightnessButtton.
function CTHigherBrightnessButtton_Callback(hObject, eventdata, handles)
% hObject    handle to CTHigherBrightnessButtton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.fixedminval = handles.fixedminval / 0.9;
handles.fixedmaxval = handles.fixedmaxval / 1.1;

orientation = get(handles.CTPlaneSelector,'Value');
if (orientation==1)
    currentval = floor(get(handles.CTSliceSlider,'Value'));
    axes(handles.CTAxes);
    dispimage = handles.fixedbrightness*handles.fixeddata(:,:,currentval);
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.fixedminval,handles.fixedmaxval]); axis square; colormap(gray); axis off;
end
if (orientation==2)
    currentval = floor(get(handles.CTSliceSlider,'Value'));
    axes(handles.CTAxes);
    dispimage = handles.fixedbrightness*squeeze(handles.fixeddata(:,currentval,:));
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.fixedminval,handles.fixedmaxval]); axis square; colormap(gray); axis off;
end
if (orientation==3)
    currentval = floor(get(handles.CTSliceSlider,'Value'));
    axes(handles.CTAxes);
    dispimage = handles.fixedbrightness*squeeze(handles.fixeddata(currentval,:,:));
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.fixedminval,handles.fixedmaxval]); axis square; colormap(gray); axis off;
end

guidata(hObject, handles);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in DTSLowerBrightnessButtton.
function DTSLowerBrightnessButtton_Callback(hObject, eventdata, handles)
% hObject    handle to DTSLowerBrightnessButtton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.movingminval = handles.movingminval * 0.9;
handles.movingmaxval = handles.movingmaxval * 1.1;

orientation = get(handles.DTSPlaneSelector,'Value');
if (orientation==1)
    currentval = floor(get(handles.DTSSliceSlider,'Value'));
    axes(handles.DTSAxes);
    dispimage = handles.movingbrightness*handles.movingdata(:,:,currentval);
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.movingminval,handles.movingmaxval]); axis square; colormap(gray); axis off;
end
if (orientation==2)
    currentval = floor(get(handles.DTSSliceSlider,'Value'));
    axes(handles.DTSAxes);
    dispimage = handles.movingbrightness*squeeze(handles.movingdata(:,currentval,:));
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.movingminval,handles.movingmaxval]); axis square; colormap(gray); axis off;
end
if (orientation==3)
    currentval = floor(get(handles.DTSSliceSlider,'Value'));
    axes(handles.DTSAxes);
    dispimage = handles.movingbrightness*squeeze(handles.movingdata(currentval,:,:));
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.movingminval,handles.movingmaxval]); axis square; colormap(gray); axis off;
end

guidata(hObject, handles);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in DTSHigherBrightnessButtton.
function DTSHigherBrightnessButtton_Callback(hObject, eventdata, handles)
% hObject    handle to DTSHigherBrightnessButtton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.movingminval = handles.movingminval / 0.9;
handles.movingmaxval = handles.movingmaxval / 1.1;

orientation = get(handles.DTSPlaneSelector,'Value');
if (orientation==1)
    currentval = floor(get(handles.DTSSliceSlider,'Value'));
    axes(handles.DTSAxes);
    dispimage = handles.movingbrightness*handles.movingdata(:,:,currentval);
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.movingminval,handles.movingmaxval]); axis square; colormap(gray); axis off;
end
if (orientation==2)
    currentval = floor(get(handles.DTSSliceSlider,'Value'));
    axes(handles.DTSAxes);
    dispimage = handles.movingbrightness*squeeze(handles.movingdata(:,currentval,:));
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.movingminval,handles.movingmaxval]); axis square; colormap(gray); axis off;
end
if (orientation==3)
    currentval = floor(get(handles.DTSSliceSlider,'Value'));
    axes(handles.DTSAxes);
    dispimage = handles.movingbrightness*squeeze(handles.movingdata(currentval,:,:));
    dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
    imshow(dispimage,[handles.movingminval,handles.movingmaxval]); axis square; colormap(gray); axis off;
end

guidata(hObject, handles);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in DeleteAllCPButton.
function DeleteAllCPButton_Callback(hObject, eventdata, handles)
% hObject    handle to DeleteAllCPButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.fixedpoints = [];
handles.movingpoints = [];
handles.numcontrolpoints = 0;
set(handles.NumCP,'String','0');
set(handles.RegisterButton,'Visible','OFF');
axes(handles.CTAxes);
dispimage = handles.fixedbrightness*handles.fixeddata(:,:,1);
imshow(dispimage,[handles.fixedminval,handles.fixedmaxval]); axis square; axis off; colormap(gray);
set(handles.CTSliceSlider,'Value',1);
set(handles.CTPlaneSelector,'Value',1);
axes(handles.DTSAxes);
dispimage = handles.movingbrightness*handles.movingdata(:,:,1);
imshow(dispimage,[handles.movingminval,handles.movingmaxval]); axis square; axis off; colormap(gray);
set(handles.DTSSliceSlider,'Value',1);
set(handles.DTSPlaneSelector,'Value',1);
zoom on;
guidata(hObject, handles);