function varargout = RegisterWindow2(varargin)
% REGISTERWINDOW2 M-file for RegisterWindow2.fig
%      REGISTERWINDOW2, by itself, creates a new REGISTERWINDOW2 or raises the existing
%      singleton*.
%
%      H = REGISTERWINDOW2 returns the handle to a new REGISTERWINDOW2 or the handle to
%      the existing singleton*.
%
%      REGISTERWINDOW2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REGISTERWINDOW2.M with the given input arguments.
%
%      REGISTERWINDOW2('Property','Value',...) creates a new REGISTERWINDOW2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RegisterWindow2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RegisterWindow2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RegisterWindow2

% Last Modified by GUIDE v2.5 18-Nov-2008 20:40:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RegisterWindow2_OpeningFcn, ...
                   'gui_OutputFcn',  @RegisterWindow2_OutputFcn, ...
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
% --- Executes just before RegisterWindow2 is made visible.
function RegisterWindow2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RegisterWindow2 (see VARARGIN)

% Choose default command line output for RegisterWindow2
handles.output = hObject;

% Update handles structure

% Turn off axis labels
axes(handles.RegAxes); axis off;

% Turn off 3D slice-select sliders and plane selectors
set(handles.RegSlider,'Visible','OFF');
set(handles.RegPlaneSelector,'Visible','OFF');

% Slider min values
set(handles.RegSlider, 'Min', 1);

% Turn off Registration Labels
set(handles.top,'string','');
set(handles.bottom,'string','');
set(handles.left,'string','');
set(handles.right,'string','');

% Turn off checker selector
set(handles.ApplyChecker, 'visible', 'off');

%Initialize manual registration parameters
handles.horitrans = 0;
handles.verttrans = 0;
handles.angle = 0;

%Initialize min and max values
handles.fixedminval = 0;
handles.fixedmaxval = 0;
handles.registeredminval = 0;
handles.registeredmaxval = 0;

% Initialize values passed in from RegisterWindow1
handles.fixeddata = varargin{1,1};
handles.fixedxvoxdim = varargin{1,2};
handles.fixedyvoxdim = varargin{1,3};
handles.fixedzvoxdim = varargin{1,4};
handles.fixedpoints = varargin{1,5};
handles.movingpoints = varargin{1,6};
handles.movingpathname = varargin{1,7};
handles.movingfilename = varargin{1,8};

handles.fixedminval = min(min(min(handles.fixeddata)));
handles.fixedmaxval = max(max(max(handles.fixeddata)));

[handles.fixedxsize, handles.fixedysize, handles.fixedzsize] = size(handles.fixeddata);

% Boolean to determine whether to instruct how to use manual registration
handles.showpreviewmessage = 1;

% Boolean to determine whether we are in manual registration mode
handles.manualregister = 0;

% Create handle to contain registered image
handles.regim = [];

% Boolean to determine whether to show contours or not
handles.showcontoursboolean = 0;

% Brightness Controls
handles.fixedimbrightness = 1.0;
handles.registeredimbrightness = 1.0;

% Set Contour Legend Colors and turn off panel for now.
set(handles.Organ1,'string','', 'ForegroundColor',[1,0,0]);
set(handles.Organ2,'string','', 'ForegroundColor',[0,1,0]);
set(handles.Organ3,'string','', 'ForegroundColor',[0,0,1]);
set(handles.Organ4,'string','', 'ForegroundColor',[1,1,0]);
set(handles.Organ5,'string','', 'ForegroundColor',[1,0,1]);
set(handles.Organ6,'string','', 'ForegroundColor',[0,1,1]);
set(handles.Organ7,'string','', 'ForegroundColor',[1,0.5,0]);
set(handles.Organ8,'string','', 'ForegroundColor',[1,0,0.5]);
set(handles.Organ9,'string','', 'ForegroundColor',[0.5,1,0]);
set(handles.Organ10,'string','', 'ForegroundColor',[0.5,0,1]);
set(handles.Organ11,'string','', 'ForegroundColor',[0,1,0.5]);
set(handles.Organ12,'string','', 'ForegroundColor',[0,0.5,1]);
set(handles.Organ13,'string','', 'ForegroundColor',[1,0.5,0.5]);
set(handles.Organ14,'string','', 'ForegroundColor',[0.5,1,0.5]);
set(handles.Organ15,'string','', 'ForegroundColor',[0.5,0.5,1]);
set(handles.Organ16,'string','','ForegroundColor',[0.25,0.5,0.5]);
set(handles.LegendPanel,'Visible','Off');

% Perform Registration
[qh, q, acen, bcen, err] = procrustes(handles.fixedpoints,handles.movingpoints);
[handles.xt, handles.yt, handles.zt, handles.pitchval, handles.yawval, handles.rollval] = decompmatrix(qh);

if handles.xt > 0
    stringxt = strcat(num2str(handles.xt),' to pt. left');
else
    stringxt = strcat(num2str(-handles.xt),' to pt. right');
end
set(handles.xtrans,'string',stringxt);
if handles.yt > 0
    stringyt = strcat(num2str(handles.yt),' anterior');
else
    stringyt = strcat(num2str(-handles.yt),' posterior');
end
set(handles.ytrans,'string',stringyt);
if handles.zt > 0
    stringzt = strcat(num2str(handles.zt),' to pt. foot');
else
    stringzt = strcat(num2str(-handles.zt),' to pt. head');
end
set(handles.ztrans,'string',stringzt);
if handles.pitchval > 0
    stringpitch = strcat(num2str(handles.pitchval),' (head up, foot down)');
else
    stringpitch = strcat(num2str(-handles.pitchval),' (head down, foot up)');
end
set(handles.pitch,'string',stringpitch);
if handles.yawval > 0
    stringyaw = strcat(num2str(handles.yawval),' (head to pt left)');
else
    stringyaw = strcat(num2str(-handles.yawval),' (head to pt right)');
end
set(handles.yaw,'string',stringyaw);
if handles.rollval > 0
    stringroll = strcat(num2str(handles.rollval),' CCW');
else
    stringroll = strcat(num2str(-handles.rollval),' CW');
end
set(handles.roll,'string',stringroll);
set(handles.ShiftsPanel,'visible','on');
[handles.movingxsize,handles.movingysize,handles.movingzsize, ...
        handles.movingxoffset,handles.movingyoffset,handles.movingzoffset,...
        handles.movingxvoxdim,handles.movingyvoxdim,handles.movingzvoxdim,filename]=...
        Readmhd('RegisteredData.mhd');
fid = fopen('RegisteredData.raw','r');
handles.movingdata = fread(fid,'uint16');
fclose(fid);
handles.movingminval = min(handles.movingdata); 
handles.movingmaxval = max(handles.movingdata);
difffixed = handles.fixedmaxval - handles.fixedminval;
handles.movingdata = handles.movingdata - handles.movingminval;
handles.movingdata = round(handles.movingdata*(difffixed/handles.movingmaxval));
handles.movingdata = handles.movingdata + handles.fixedminval;
handles.movingminval = handles.fixedminval;
handles.movingmaxval = handles.fixedmaxval;

% Register Datasets
commandtorun = ['Rigid3Dtransform RegisteredData.mhd RegisteredData1.mhd 0 0 0 ',...
    num2str(handles.pitchval*180/pi),' ',num2str(handles.yawval*180/pi),' ',num2str(handles.rollval*180/pi),' ',num2str(-handles.xt)...
    ,' ',num2str(-handles.yt),' ',num2str(handles.zt)];
h = showinfowindow('Creating your CT dataset. Please wait');
dos(commandtorun);
fid = fopen('RegisteredData1.raw','r');
handles.registereddata = fread(fid,'uint16');
fclose(fid);
handles.registereddata = reshape(handles.registereddata,handles.movingxsize,handles.movingysize,handles.movingzsize);
clear handles.movingdata;
delete('RegisteredData1.mhd');
delete('RegisteredData1.raw');
delete(h);

% Display Registered Version
finalim = handles.registeredimbrightness*handles.registereddata(:,:,1);
finalim = rot90(finalim, 3); finalim = fliplr(finalim);
axes(handles.RegAxes);
handles.registeredminval = min(handles.fixedminval, handles.movingminval);
handles.registeredmaxval = max(handles.fixedmaxval, handles.movingmaxval);
imshow(finalim,[handles.registeredminval,handles.registeredmaxval]);
set(handles.RegAxes,'visible','on');
axis off; axis square;

% Set visibilities and various other parameters
set(handles.RegPlaneSelector,'value',1);
set(handles.RegPlaneSelector,'visible','on');
set(handles.RegSlider,'Max',handles.fixedzsize);
set(handles.RegSlider,'SliderStep',[1/handles.fixedzsize, 10/handles.fixedzsize]);
set(handles.RegSlider,'value',1);
set(handles.RegSlider,'visible','on');
set(handles.top,'string','+y');
set(handles.bottom,'string','-y');
set(handles.left,'string','-x');
set(handles.right,'string','+x');
set(handles.textangle,'string','Roll');
set(handles.ManualAngle,'string','0');
set(handles.texthori,'string','x');
set(handles.ManualHori,'string','0');
set(handles.textvert,'string','y');
set(handles.ManualVert,'string','0');
set(handles.ManualPanel,'visible','on');
set(handles.ManualApplyButton,'visible','off');
set(handles.ManualCancelButton,'visible','off');
set(handles.ApplyChecker,'value',1);
set(handles.ApplyChecker,'visible','on');
set(handles.ShowContours,'visible','off');

handles.planeselected = 1;
handles.sliceselected = 1;

guidata(hObject, handles);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% UIWAIT makes RegisterWindow2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Outputs from this function are returned to the command line.
function varargout = RegisterWindow2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
     

%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on selection change in RegPlaneSelector.
function RegPlaneSelector_Callback(hObject, eventdata, handles)
% hObject    handle to RegPlaneSelector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns RegPlaneSelector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from RegPlaneSelector
orientation = get(handles.RegPlaneSelector,'Value');
handles.planeselected = orientation;
ApplyCheckerVal = get(handles.ApplyChecker, 'Value');
handles = updateimage(handles,orientation,ApplyCheckerVal,1);
handles.sliceselected = 1;
set(handles.RegSlider,'Value',1);
guidata(hObject, handles);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes during object creation, after setting all properties.
function RegPlaneSelector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RegPlaneSelector (see GCBO)
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
% --- Executes on slider movement.
function RegSlider_Callback(hObject, eventdata, handles)
% hObject    handle to RegSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
orientation = get(handles.RegPlaneSelector,'Value');
ApplyCheckerVal = get(handles.ApplyChecker, 'Value');
handles = updateimage(handles,orientation,ApplyCheckerVal,handles.sliceselected);
handles.sliceselected = round(get(handles.RegSlider,'Value'));
guidata(hObject, handles)


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes during object creation, after setting all properties.
function RegSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RegSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
function ManualAngle_Callback(hObject, eventdata, handles)
% hObject    handle to ManualAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ManualAngle as text
%        str2double(get(hObject,'String')) returns contents of ManualAngle as a double


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes during object creation, after setting all properties.
function ManualAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ManualAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
function ManualYaw_Callback(hObject, eventdata, handles)
% hObject    handle to ManualYaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ManualYaw as text
%        str2double(get(hObject,'String')) returns contents of ManualYaw as a double


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes during object creation, after setting all properties.
function ManualYaw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ManualYaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
function ManualRoll_Callback(hObject, eventdata, handles)
% hObject    handle to ManualRoll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ManualRoll as text
%        str2double(get(hObject,'String')) returns contents of ManualRoll as a double


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes during object creation, after setting all properties.
function ManualRoll_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ManualRoll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in ApplyChecker.
function ApplyChecker_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyChecker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ApplyChecker
ApplyCheckerVal = get(handles.ApplyChecker,'value');
currentval = handles.sliceselected;
orientation = get(handles.RegPlaneSelector,'Value');
handles = updateimage(handles,orientation,ApplyCheckerVal,currentval);
guidata(hObject, handles);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in ManualPreviewButton.
function ManualPreviewButton_Callback(hObject, eventdata, handles)
% hObject    handle to ManualPreviewButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (handles.showpreviewmessage)
    msgbox('You can perform as many changes as you want. Changes will only be reflected for the currect slice, NOT the whole dataset. To do a full registration, click on ''Apply''. To start over, click on ''Cancel''.','modal');
    handles.showpreviewmessage = 0;
end
handles.manualregister = 1;

handles.horitrans = handles.horitrans + str2num(get(handles.ManualHori, 'string'));
handles.verttrans = handles.verttrans + str2num(get(handles.ManualVert, 'string'));
handles.angle = handles.angle + str2num(get(handles.ManualAngle, 'string'));

handles.planeselected = get(handles.RegPlaneSelector, 'Value');
handles.sliceselected = round(get(handles.RegSlider, 'Value'));
set(handles.RegSlider,'visible','off');
set(handles.RegPlaneSelector,'visible','off');
set(handles.ManualApplyButton,'visible','on');
set(handles.ManualCancelButton,'visible','on');

switch (handles.planeselected)
    case 1 %Axial
        fixedim = handles.fixeddata(:,:,handles.sliceselected);
        if isempty(handles.regim)
            movingim = handles.registereddata(:,:,handles.sliceselected);
        else
            movingim = handles.regim;
        end
        [numrows,numcols] = size(movingim);
        if (handles.movingyvoxdim>=handles.movingxvoxdim)
            expandratio = round(handles.movingyvoxdim/handles.movingxvoxdim);
            voxdim = handles.movingxvoxdim;
            movingim = imresize(movingim,[numrows,numcols*expandratio],'nearest');
        else
            expandratio = round(handles.movingxvoxdim/handles.movingyvoxdim);
            voxdim = handles.movingyvoxdim;
            movingim = imresize(movingim,[numrows*expandratio,numcols],'nearest');
        end   
        theta = -str2num(get(handles.ManualAngle,'string'))*pi/180;
        horitranstooffset = (0-handles.movingxoffset)/voxdim;
        verttranstooffset = -(handles.movingyoffset)/voxdim;
        horitrans = str2num(get(handles.ManualHori,'string'))/voxdim;
        verttrans = -str2num(get(handles.ManualVert,'string'))/voxdim;
        % All translations are inverted due to the rot90 done for correct display
        T1 = [1 0 0; 0 1 0; verttranstooffset -horitranstooffset 1];
        T2 = [cos(theta) sin(theta) 0; -sin(theta) cos(theta) 0; verttrans horitrans 1];
        T3 = [1 0 0; 0 1 0; -verttranstooffset horitranstooffset 1];
        tform = maketform('affine',(T1*T2*T3));
        if (handles.movingyvoxdim>=handles.movingxvoxdim)
            handles.regim = imtransform(movingim,tform,'bilinear','XData',[1,handles.movingysize*expandratio],'YData',[1,handles.movingxsize]);
        else
            handles.regim = imtransform(movingim,tform,'bilinear','XData',[1,handles.movingysize],'YData',[1,handles.movingxsize*expandratio]);
        end
        handles.regim = imresize(handles.regim,[numrows,numcols],'nearest');
        switch(get(handles.ApplyChecker,'Value'))
            case 1
                finalim = handles.registeredimbrightness*handles.regim;
            case 2
                finalim = handles.fixedimbrightness*handles.fixedim;            
            case 3
                finalim = ApplyChecker(handles.fixedimbrightness*fixedim, handles.registeredimbrightness*handles.regim);
        end
        finalim = rot90(finalim,3); finalim = fliplr(finalim);
        axes(handles.RegAxes);
        imshow(finalim,[handles.registeredminval,handles.registeredmaxval]);
        set(handles.RegAxes,'visible','on');
        axis off; axis square; colormap(gray);
        if (handles.showcontoursboolean)
            plotcontours(handles,1,handles.sliceselected,handles.numcontours);
        end
    case 2 %Coronal
        fixedim = squeeze(handles.fixeddata(:,handles.sliceselected,:));
        if isempty(handles.regim)
            movingim = squeeze(handles.registereddata(:,handles.sliceselected,:));
        else
            movingim = handles.regim;
        end
        [numrows,numcols] = size(movingim);
        if (handles.movingxvoxdim>=handles.movingzvoxdim)
            expandratio = round(handles.movingxvoxdim/handles.movingzvoxdim);
            voxdim = handles.movingzvoxdim;
            movingim = imresize(movingim,[numrows*expandratio,numcols],'nearest');
        else
            expandratio = round(handles.movingzvoxdim/handles.movingxvoxdim);
            voxdim = handles.movingxvoxdim;
            movingim = imresize(movingim,[numrows,numcols*expandratio],'nearest');
        end   
        theta = -str2num(get(handles.ManualAngle,'string'))*pi/180;
        horitranstooffset = (0-handles.movingxoffset)/voxdim;
        verttranstooffset = -(handles.movingzoffset)/voxdim;
        horitrans = str2num(get(handles.ManualHori,'string'))/voxdim;
        verttrans = str2num(get(handles.ManualVert,'string'))/voxdim;
        % All translations are inverted due to the rot90 done for correct display
        T1 = [1 0 0; 0 1 0; -verttranstooffset -horitranstooffset 1];
        T2 = [cos(theta) sin(theta) 0; -sin(theta) cos(theta) 0; verttrans horitrans 1];
        T3 = [1 0 0; 0 1 0; verttranstooffset horitranstooffset 1];
        tform = maketform('affine',(T1*T2*T3));
        if (handles.movingxvoxdim>=handles.movingzvoxdim)
            handles.regim = imtransform(movingim,tform,'bilinear','XData',[1,handles.movingzsize],'YData',[1,handles.movingxsize*expandratio]);
        else
            handles.regim = imtransform(movingim,tform,'bilinear','XData',[1,handles.movingzsize*expandratio],'YData',[1,handles.movingxsize]);
        end
        handles.regim = imresize(handles.regim,[numrows,numcols],'nearest');
        switch(get(handles.ApplyChecker,'Value'))
            case 1
                finalim = handles.registeredimbrightness*handles.regim;
            case 2
                finalim = handles.fixedimbrightness*handles.fixedim;            
            case 3
                finalim = ApplyChecker(handles.fixedimbrightness*fixedim, handles.registeredimbrightness*handles.regim);
        end
        finalim = rot90(finalim,3); finalim = fliplr(finalim);
        axes(handles.RegAxes);
        imshow(finalim,[handles.registeredminval,handles.registeredmaxval]);
        set(handles.RegAxes,'visible','on');
        axis off; axis square; colormap(gray);
        if (handles.showcontoursboolean)
            plotcontours(handles,2,handles.sliceselected,handles.numcontours);
        end
    case 3 %Saggital
        fixedim = squeeze(handles.fixeddata(handles.sliceselected,:,:));
        if isempty(handles.regim)
            movingim = squeeze(handles.registereddata(handles.sliceselected,:,:));
        else
            movingim = handles.regim;
        end
        [numrows,numcols] = size(movingim);
        if (handles.movingyvoxdim>=handles.movingzvoxdim)
            expandratio = round(handles.movingyvoxdim/handles.movingzvoxdim);
            voxdim = handles.movingzvoxdim;
            movingim = imresize(movingim,[numrows*expandratio,numcols],'nearest');
        else
            expandratio = round(handles.movingzvoxdim/handles.movingyvoxdim);
            voxdim = handles.movingxvoxdim;
            movingim = imresize(movingim,[numrows,numcols*expandratio],'nearest');
        end   
        theta = -str2num(get(handles.ManualAngle,'string'))*pi/180;
        horitranstooffset = (handles.movingyoffset)/voxdim;
        verttranstooffset = (0-handles.movingzoffset)/voxdim;
        horitrans = -str2num(get(handles.ManualHori,'string'))/voxdim;
        verttrans = str2num(get(handles.ManualVert,'string'))/voxdim;
        T1 = [1 0 0; 0 1 0; -verttranstooffset -horitranstooffset 1];
        T2 = [cos(theta) sin(theta) 0; -sin(theta) cos(theta) 0; verttrans horitrans 1];
        T3 = [1 0 0; 0 1 0; verttranstooffset horitranstooffset 1];
        tform = maketform('affine',(T1*T2*T3));
        if (handles.movingyvoxdim>=handles.movingzvoxdim)
            handles.regim = imtransform(movingim,tform,'bilinear','XData',[1,handles.movingzsize],'YData',[1,handles.movingysize*expandratio]);
        else
            handles.regim = imtransform(movingim,tform,'bilinear','XData',[1,handles.movingzsize*expandratio],'YData',[1,handles.movingysize]);
        end
        handles.regim = imresize(handles.regim,[numrows,numcols],'nearest');

        switch(get(handles.ApplyChecker,'Value'))
            case 1
                finalim = handles.registeredimbrightness*handles.regim;
            case 2
                finalim = handles.fixedimbrightness*handles.fixedim;            
            case 3
                finalim = ApplyChecker(handles.fixedimbrightness*fixedim, handles.registeredimbrightness*handles.regim);
        end
        finalim = rot90(finalim,3); finalim = fliplr(finalim);
        axes(handles.RegAxes);
        imshow(finalim,[handles.registeredminval,handles.registeredmaxval]);
        set(handles.RegAxes,'visible','on');
        axis off; axis square; colormap(gray);
        if (handles.showcontoursboolean)
            plotcontours(handles,3,handles.sliceselected,handles.numcontours);
        end
end

set(handles.ManualHori,'string','0');
set(handles.ManualVert,'string','0');
set(handles.ManualAngle,'string','0');

guidata(hObject, handles);

%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in ManualApplyButton.
function ManualApplyButton_Callback(hObject, eventdata, handles)
% hObject    handle to ManualApplyButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles.planeselected = get(handles.RegPlaneSelector,'value');
switch (handles.planeselected)
    case 1        
        xt = -handles.horitrans;
        yt = -handles.verttrans;
        zt = 0;
        pitch = 0;
        yaw = 0;
        roll = handles.angle;
    case 2
        xt = -handles.horitrans;
        yt = 0;
        zt =  -handles.verttrans;
        pitch = 0;
        yaw = handles.angle;
        roll = 0;
    case 3
        xt = 0;
        yt = -handles.horitrans;
        zt = -handles.verttrans;
        pitch = handles.angle;
        yaw = 0;
        roll = 0;
end
sliceval = round(get(handles.RegSlider,'Value'));
commandtorun = ['Rigid3Dtransform RegisteredData.mhd RegisteredData.mhd 0 0 0 ',...
    num2str(pitch),' ',num2str(yaw),' ',num2str(roll),' ',num2str(xt),' ',num2str(yt),' ',num2str(zt)];
h = showinfowindow('Re-registering Imageset. Please wait');
dos(commandtorun);
fid = fopen('RegisteredData.raw','r');
handles.registereddata = fread(fid,'uint16');
fclose(fid);
handles.registereddata = reshape(handles.registereddata,handles.movingxsize,handles.movingysize,handles.movingzsize);
clear handles.movingdata;
delete(h);

% Update alignment panel
switch (handles.planeselected)
    case 1
        % X translation
        handles.xt = handles.xt + handles.horitrans;
        if (handles.xt>0)
            stringx = strcat(num2str(handles.xt),' to pt left');
        else
            stringx = strcat(num2str(-handles.xt),' to pt right');
        end
        set(handles.xtrans,'string',stringx);
        % Y translation
        handles.yt = handles.yt - handles.verttrans;
        if (handles.yt>0)
            stringy = strcat(num2str(handles.yt),' Posterior');
        else
            stringy = strcat(num2str(-handles.yt),' Anterior');
        end
        set(handles.ytrans,'string',stringy);
        % Roll
        handles.rollval = handles.rollval - handles.angle;
        if (handles.rollval>0)
            stringroll = strcat(num2str(round(handles.rollval*10)/10),' CCW');
        else
            stringroll = strcat(num2str(round(-handles.rollval*10)/10),' CW');
        end
        set(handles.roll,'string',stringroll);
    case 2
        % X translation
        handles.xt = handles.xt + handles.horitrans;
        if (handles.xt>0)
            stringx = strcat(num2str(handles.xt),' to pt left');
        else
            stringx = strcat(num2str(-handles.xt),' to pt right');
        end
        set(handles.xtrans,'string',stringx);
        % Z Translation
        handles.zt = handles.zt - handles.verttrans;
        if (handles.zt>0)
            stringz = strcat(num2str(handles.zt),' to pt head');
        else
            stringz = strcat(num2str(-handles.zt),' to pt foot');
        end
        set(handles.ztrans,'string',stringz);
        % Yaw
        handles.yawval = handles.yawval + handles.angle;
        if (handles.yawval>0)
            stringyaw = strcat(num2str(round(handles.yawval*10)/10),' (head to pt left)');
        else
            stringyaw = strcat(num2str(round(-handles.yawval*10)/10),' (head to pt right)');
        end
        set(handles.yaw,'string',stringyaw);
    case 3
        % Y translation
        handles.yt = handles.yt - handles.horitrans;
        if (handles.yt>0)
            stringy = strcat(num2str(handles.yt),' Posterior');
        else
            stringy = strcat(num2str(-handles.yt),' Anterior');
        end
        set(handles.ytrans,'string',stringy);
         % Z Translation
        handles.zt = handles.zt - handles.verttrans;
        if (handles.zt>0)
            stringz = strcat(num2str(handles.zt),' to pt head');
        else
            stringz = strcat(num2str(-handles.zt),' to pt foot');
        end
        set(handles.ztrans,'string',stringz);
        % Pitch
        handles.pitchval = handles.pitchval - handles.angle;
        if (handles.pitchval>0)
            stringpitch = strcat(num2str(round(handles.pitchval*10)/10),' (head up, foot down)');
        else
            stringpitch = strcat(num2str(round(-handles.pitchval*10)/10),' (head down, foot up)');
        end
        set(handles.pitch,'string',stringpitch);
end

set(handles.RegPlaneSelector,'visible','on');
set(handles.RegSlider,'visible','on');

%Reset values to zero
handles.horitrans = 0;
handles.verttrans = 0;
handles.angle = 0;
handles.regim = [];
handles.manualregister = 0;
set(handles.ManualAngle,'string','0');
set(handles.ManualHori,'string','0');
set(handles.ManualVert,'string','0');
set(handles.ManualApplyButton,'visible','off');
set(handles.ManualCancelButton,'visible','off');
set(handles.RegSlider,'visible','on');
set(handles.RegPlaneSelector,'visible','on');

%Update Image
handles.showcontoursboolean = get(handles.ShowContours, 'Value');
ApplyCheckerVal = get(handles.ApplyChecker,'value');
currentval = handles.sliceselected;
orientation = get(handles.RegPlaneSelector,'Value');
handles = updateimage(handles,orientation,ApplyCheckerVal,currentval);
guidata(hObject, handles);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in ManualCancelButton.
function ManualCancelButton_Callback(hObject, eventdata, handles)
% hObject    handle to ManualCancelButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.horitrans = 0;
handles.verttrans = 0;
handles.angle = 0;
switch (handles.planeselected)
    case 1
        switch (get(handles.ApplyChecker,'Value'))
            case 1
                finalim = handles.registeredimbrightness*handles.registereddata(:,:,handles.sliceselected);
            case 2
                finalim = handles.fixedimbrightness*handles.fixeddata(:,:,handles.sliceselected);
            case 3
                finalim = ApplyChecker(double(handles.fixedimbrightness*handles.fixeddata(:,:,handles.sliceselected)), double(handles.registeredimbrightness*handles.registereddata(:,:,handles.sliceselected)));
        end
    case 2
        switch (get(handles.ApplyChecker,'Value'))
            case 1
                finalim = squeeze(handles.registeredimbrightness*handles.registereddata(:,handles.sliceselected,:));
            case 2
                finalim = squeeze(handles.fixedimbrightness*handles.fixeddata(:,handles.sliceselected,:));
            case 3
                finalim = ApplyChecker(double(squeeze(handles.fixedimbrightness*handles.fixeddata(:,handles.sliceselected,:))), double(squeeze(handles.registeredimbrightness*handles.registereddata(:,handles.sliceselected,:))));
        end
    case 3
        switch (get(handles.ApplyChecker,'Value'))
            case 1
                finalim = squeeze(handles.registeredimbrightness*handles.registereddata(handles.sliceselected,:,:));
            case 2
                finalim = squeeze(handles.fixedimbrightness*handles.fixeddata(handles.sliceselected,:,:));
            case 3
                finalim = ApplyChecker(double(squeeze(handles.fixedimbrightness*handles.fixeddata(handles.sliceselected,:,:))), squeeze(double(handles.registeredimbrightness*handles.registereddata(handles.sliceselected,:,:))));
        end
end        
finalim = rot90(finalim, 3); finalim = fliplr(finalim);
axes(handles.RegAxes);
imshow(finalim,[handles.registeredminval,handles.registeredmaxval]);
set(handles.RegAxes,'visible','on');
axis off; axis square;
handles.regim = [];
handles.manualregister = 0;
set(handles.ManualHori,'string','0');
set(handles.ManualVert,'string','0');
set(handles.ManualAngle,'string','0');
set(handles.ManualApplyButton,'visible','off');
set(handles.ManualCancelButton,'visible','off');
set(handles.RegSlider,'visible','on');
set(handles.RegPlaneSelector,'visible','on');

guidata(hObject, handles);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in GetContourButton.
function GetContourButton_Callback(hObject, eventdata, handles)
% hObject    handle to GetContourButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Answer = cell(1,2);
[Answer{1,1},Answer{1,2}] = ContourTool;
handles.contourpathname = Answer{1,1};
handles.contourfilename = Answer{1,2};
fid = fopen([handles.contourpathname,handles.contourfilename]);
C = textscan(fid,'%s','Delimiter','\n');
fclose(fid);
handles.numcontours = str2num(cell2mat(C{1,1}(1)));
for i=1:handles.numcontours
    commandtorun = ['set(handles.Organ',num2str(i),',''string'',''',cell2mat(C{1,1}(i+1)),''');'];
    eval(commandtorun);
    filename = [handles.contourpathname,handles.contourfilename,'.',num2str(i)];
    fid = fopen(filename,'r');
    commandtorun = ['handles.OrganContour',num2str(i),'=fread(fid,''ubit1'');'];
    eval(commandtorun);
    fclose(fid);
    commandtorun = ['handles.OrganContour',num2str(i),'=reshape(handles.OrganContour',num2str(i),',handles.movingxsize,handles.movingysize,handles.movingzsize);'];
    eval(commandtorun);
end
for i=handles.numcontours+1:16
    commandtorun = ['set(handles.Organ',num2str(i),',''string'','''');'];
    eval(commandtorun);
end
set(handles.LegendPanel,'Visible','on');
set(handles.ShowContours,'Visible','on');
guidata(hObject,handles);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in ShowContours.
function ShowContours_Callback(hObject, eventdata, handles)
% hObject    handle to ShowContours (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ShowContours
handles.showcontoursboolean = get(hObject, 'Value');
ApplyCheckerVal = get(handles.ApplyChecker,'value');
currentval = handles.sliceselected;
orientation = get(handles.RegPlaneSelector,'Value');
handles = updateimage(handles,orientation,ApplyCheckerVal,currentval);
guidata(hObject, handles);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in CancelCPRegButton.
function CancelCPRegButton_Callback(hObject, eventdata, handles)
% hObject    handle to CancelCPRegButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(hObject, 'Visible', 'Off');
set(handles.CancelCPText, 'Visible', 'Off');
[handles.movingxsize,handles.movingysize,handles.movingzsize, ...
        handles.movingxoffset,handles.movingyoffset,handles.movingzoffset,...
        handles.movingxvoxdim,handles.movingyvoxdim,handles.movingzvoxdim,filename]=...
        Readmhd('RegisteredData.mhd');
fid = fopen('RegisteredData.raw','r');
handles.movingdata = fread(fid,'uint16');
fclose(fid);
handles.movingminval = min(handles.movingdata); 
handles.movingmaxval = max(handles.movingdata);
difffixed = handles.fixedmaxval - handles.fixedminval;
handles.movingdata = handles.movingdata - handles.movingminval;
handles.movingdata = round(handles.movingdata*(difffixed/handles.movingmaxval));
handles.movingdata = handles.movingdata + handles.fixedminval;
handles.movingminval = handles.fixedminval;
handles.movingmaxval = handles.fixedmaxval;
handles.movingdata = reshape(handles.movingdata,handles.movingxsize,handles.movingysize,handles.movingzsize);
handles.registereddata = handles.movingdata;
clear handles.movingdata

% Reset all shift parameters to zero
handles.xt = 0;
handles.yt = 0;
handles.zt = 0;
handles.pitchval = 0;
handles.rollval = 0;
handles.yawval = 0;
set(handles.xtrans,'string','0');
set(handles.ytrans,'string','0');
set(handles.ztrans,'string','0');
set(handles.pitch,'string','0');
set(handles.roll,'string','0');
set(handles.yaw,'string','0');

% Display Registered Version
finalim = handles.registeredimbrightness*handles.registereddata(:,:,1);
finalim = rot90(finalim, 3); finalim = fliplr(finalim);
axes(handles.RegAxes);
handles.movingminval = min(min(min(handles.registereddata)));
handles.movingmaxval = max(max(max(handles.registereddata)));
handles.registeredminval = min(handles.fixedminval, handles.movingminval);
handles.registeredmaxval = max(handles.fixedmaxval, handles.movingmaxval);
imshow(finalim,[handles.registeredminval,handles.registeredmaxval]);
set(handles.RegAxes,'visible','on');
axis off; axis square;

% Set visibilities and various other parameters
set(handles.RegPlaneSelector,'value',1);
set(handles.RegPlaneSelector,'visible','on');
set(handles.RegSlider,'Max',handles.fixedzsize);
set(handles.RegSlider,'SliderStep',[1/handles.fixedzsize, 10/handles.fixedzsize]);
set(handles.RegSlider,'value',1);
set(handles.RegSlider,'visible','on');
set(handles.top,'string','+y');
set(handles.bottom,'string','-y');
set(handles.left,'string','-x');
set(handles.right,'string','+x');
set(handles.textangle,'string','Roll');
set(handles.ManualAngle,'string','0');
set(handles.texthori,'string','x');
set(handles.ManualHori,'string','0');
set(handles.textvert,'string','y');
set(handles.ManualVert,'string','0');
set(handles.ManualPanel,'visible','on');
set(handles.ManualApplyButton,'visible','off');
set(handles.ManualCancelButton,'visible','off');
set(handles.ApplyChecker,'value',1);
set(handles.ApplyChecker,'visible','on');

handles.planeselected = 1;
handles.sliceselected = 1;

guidata(hObject, handles);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in GetSavedContours.
function GetSavedContours_Callback(hObject, eventdata, handles)
% hObject    handle to GetSavedContours (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[handles.contourfilename,handles.contourpathname] = uigetfile('*.contour','Pick the contour file you wish to open');
if(handles.contourfilename~=0)
    fid = fopen([handles.contourpathname,handles.contourfilename]);
    C = textscan(fid,'%s','Delimiter','\n');
    fclose(fid);
    handles.numcontours = str2num(cell2mat(C{1,1}(1)));
    for i=1:handles.numcontours
        commandtorun = ['set(handles.Organ',num2str(i),',''string'',''',cell2mat(C{1,1}(i+1)),''');'];
        eval(commandtorun);
        filename = [handles.contourpathname,handles.contourfilename,'.',num2str(i)];
        fid = fopen(filename,'r');
        commandtorun = ['handles.OrganContour',num2str(i),'=fread(fid,''ubit1'');'];
        eval(commandtorun);
        fclose(fid);
        commandtorun = ['handles.OrganContour',num2str(i),'=reshape(handles.OrganContour',num2str(i),',handles.movingxsize,handles.movingysize,handles.movingzsize);'];
        eval(commandtorun);
    end
    for i=handles.numcontours+1:16
        commandtorun = ['set(handles.Organ',num2str(i),',''string'','''');'];
        eval(commandtorun);
    end
end
set(handles.LegendPanel,'Visible','on');
set(handles.ShowContours,'Visible','on');
guidata(hObject,handles);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in LowerWindowButton.
function LowerWindowButton_Callback(hObject, eventdata, handles)
% hObject    handle to LowerWindowButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.registeredminval = round(handles.registeredminval * 1.1);
handles.registeredmaxval = round(handles.registeredmaxval * 0.9);
ApplyCheckerVal = get(handles.ApplyChecker,'value');
currentval = handles.sliceselected;
orientation = get(handles.RegPlaneSelector,'Value');
handles = updateimage(handles,orientation,ApplyCheckerVal,currentval);
guidata(hObject, handles);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in IncreaseWindowButton.
function IncreaseWindowButton_Callback(hObject, eventdata, handles)
% hObject    handle to IncreaseWindowButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.registeredminval = round(handles.registeredminval / 1.1);
handles.registeredmaxval = round(handles.registeredmaxval / 0.9);
ApplyCheckerVal = get(handles.ApplyChecker,'value');
currentval = handles.sliceselected;
orientation = get(handles.RegPlaneSelector,'Value');
handles = updateimage(handles,orientation,ApplyCheckerVal,currentval);
guidata(hObject, handles);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in MovingImLowBrightnessButton.
function MovingImLowBrightnessButton_Callback(hObject, eventdata, handles)
% hObject    handle to MovingImLowBrightnessButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.registeredimbrightness = handles.registeredimbrightness - 0.1;
ApplyCheckerVal = get(handles.ApplyChecker,'value');
currentval = handles.sliceselected;
orientation = get(handles.RegPlaneSelector,'Value');
handles = updateimage(handles,orientation,ApplyCheckerVal,currentval);
guidata(hObject, handles);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in MovingImHighBrightnessButton.
function MovingImHighBrightnessButton_Callback(hObject, eventdata, handles)
% hObject    handle to MovingImHighBrightnessButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.registeredimbrightness = handles.registeredimbrightness + 0.1;
ApplyCheckerVal = get(handles.ApplyChecker,'value');
currentval = handles.sliceselected;
orientation = get(handles.RegPlaneSelector,'Value');
handles = updateimage(handles,orientation,ApplyCheckerVal,currentval);
guidata(hObject, handles);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in FixedImLowBrightnessButton.
function FixedImLowBrightnessButton_Callback(hObject, eventdata, handles)
% hObject    handle to FixedImLowBrightnessButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.fixedimbrightness = handles.fixedimbrightness - 0.1;
ApplyCheckerVal = get(handles.ApplyChecker,'value');
currentval = handles.sliceselected;
orientation = get(handles.RegPlaneSelector,'Value');
handles = updateimage(handles,orientation,ApplyCheckerVal,currentval);
guidata(hObject, handles);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in FixedImHighBrightnessButton.
function FixedImHighBrightnessButton_Callback(hObject, eventdata, handles)
% hObject    handle to FixedImHighBrightnessButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.fixedimbrightness = handles.fixedimbrightness + 0.1;
ApplyCheckerVal = get(handles.ApplyChecker,'value');
currentval = handles.sliceselected;
orientation = get(handles.RegPlaneSelector,'Value');
handles = updateimage(handles,orientation,ApplyCheckerVal,currentval);
guidata(hObject, handles);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in WriteP3FilesButton.
function WriteP3FilesButton_Callback(hObject, eventdata, handles)
% hObject    handle to WriteP3FilesButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% RewriteCTDialog(handles.xt, handles.yt, handles.zt, handles.pitchval, handles.yawval, handles.rollval);
RewriteP3FilesDialog(handles.xt, handles.yt, handles.zt, handles.pitchval, handles.yawval, handles.rollval);
guidata(hObject, handles);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes during object creation, after setting all properties.
function ApplyChecker_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ApplyChecker (see GCBO)
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
% --- Executes on button press in WriteImagesforP3Button.
function WriteImagesforP3Button_Callback(hObject, eventdata, handles)
% hObject    handle to WriteImagesforP3Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
RewriteImagesforP3_Dialog(-handles.xt, -handles.yt, -handles.zt, handles.pitchval, handles.yawval, handles.rollval, handles.movingpathname, handles.movingfilename);
guidata(hObject, handles);


%================================================================================================================================================
%================================================================================================================================================
%================================================================================================================================================
% --- Executes on button press in WriteResultsButton.
function WriteResultsButton_Callback(hObject, eventdata, handles)
% hObject    handle to WriteResultsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[regresultfile, regresultpath] = uiputfile('*.regresult','Save Registration Results As');
if (regresultfile~=0)
   fid = fopen([regresultpath,regresultfile],'wt');
   h = cell(1,6);
   h{1} = sprintf('x translation (mm) = %.3f', handles.xt);
   h{2} = sprintf('y translation (mm) = %.3f', handles.yt);
   h{3} = sprintf('z translation (mm) = %.3f', handles.zt);
   h{4} = sprintf('Roll (degrees) = %.3f', handles.rollval);
   h{5} = sprintf('Yaw (degrees) = %.3f', handles.yawval);
   h{6} = sprintf('Pitch (degrees) = %.3f', handles.pitchval);
   fprintf(fid,'%s\n',h{:});
   fclose(fid);
end
guidata(hObject, handles);