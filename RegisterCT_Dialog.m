function varargout = RegisterCT_Dialog(varargin)
% REGISTERCT_DIALOG M-file for RegisterCT_Dialog.fig
%      REGISTERCT_DIALOG, by itself, creates a new REGISTERCT_DIALOG or raises the existing
%      singleton*.
%
%      H = REGISTERCT_DIALOG returns the handle to a new REGISTERCT_DIALOG or the handle to
%      the existing singleton*.
%
%      REGISTERCT_DIALOG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REGISTERCT_DIALOG.M with the given input arguments.
%
%      REGISTERCT_DIALOG('Property','Value',...) creates a new REGISTERCT_DIALOG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RegisterCT_Dialog_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RegisterCT_Dialog_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RegisterCT_Dialog

% Last Modified by GUIDE v2.5 19-Nov-2008 13:36:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RegisterCT_Dialog_OpeningFcn, ...
                   'gui_OutputFcn',  @RegisterCT_Dialog_OutputFcn, ...
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


% --- Executes just before RegisterCT_Dialog is made visible.
function RegisterCT_Dialog_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RegisterCT_Dialog (see VARARGIN)

% Choose default command line output for RegisterCT_Dialog
handles.output = hObject;

% Initialize various variables
handles.ctopened = 0; %Boolean to determine if CT Set was opened
handles.regresultopened = 0; %Boolean to determine if a registration file was opened

% Hide create contour button for now
set(handles.ApplyRegistrationButton,'Visible','Off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes RegisterCT_Dialog wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RegisterCT_Dialog_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in GetCTButton.
function GetCTButton_Callback(hObject, eventdata, handles)
% hObject    handle to GetCTButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.CTfilename, handles.CTpathname] = uigetfile('*.mhd','Open CT Dataset');
if(handles.CTfilename == 0)
    set(handles.CTpath,'String','');
    handles.ctopened = 0;
    set(handles.ApplyRegistrationButton,'Visible','Off');
else
    set(handles.CTpath,'String',[handles.CTpathname, handles.CTfilename]);
    handles.ctopened = 1;
end

if(handles.ctopened && handles.regresultopened)
    set(handles.ApplyRegistrationButton,'Visible','on');
end

guidata(hObject,handles);


% --- Executes on button press in GetRegResultButton.
function GetRegResultButton_Callback(hObject, eventdata, handles)
% hObject    handle to GetRegResultButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[regresultfilename, regresultpathname] = uigetfile('*.regresult','Open Registration Result File');
if(regresultfilename ~= 0)
    set(handles.RegResultpath,'String',[regresultpathname, regresultfilename]);
    allresults = textread([regresultpathname,regresultfilename],'%s','delimiter','\n');
    [token,rem] = strtok(allresults{1},'=');
    [token,rem]=strtok(rem,' ');
    handles.xtrans = str2num(rem);
    [token,rem] = strtok(allresults{2},'=');
    [token,rem]=strtok(rem,' ');
    handles.ytrans = str2num(rem);
    [token,rem] = strtok(allresults{3},'=');
    [token,rem]=strtok(rem,' ');
    handles.ztrans = str2num(rem);
    [token,rem] = strtok(allresults{4},'=');
    [token,rem]=strtok(rem,' ');
    handles.roll = str2num(rem);
    [token,rem] = strtok(allresults{5},'=');
    [token,rem]=strtok(rem,' ');
    handles.yaw = str2num(rem);
    [token,rem] = strtok(allresults{6},'=');
    [token,rem]=strtok(rem,' ');
    handles.pitch = str2num(rem);
    handles.regresultopened = 1;
else
    set(handles.RegResultpath,'String','');
    handles.regresultopened = 0;
    set(handles.ApplyRegistrationButton,'Visible','Off');    
end
if (handles.ctopened && handles.regresultopened)
    set(handles.ApplyRegistrationButton,'Visible','On');
end
guidata(hObject,handles);


% --- Executes on button press in ApplyRegistrationButton.
function ApplyRegistrationButton_Callback(hObject, eventdata, handles)
% hObject    handle to ApplyRegistrationButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[savefilename, savepathname] = uiputfile('*.header','Save Image As');

h = showinfowindow('Please wait while the imageset is transformed and saved');

%Perform transformation
xt = num2str(-handles.xtrans);
yt = num2str(handles.ytrans);
zt = num2str(handles.ztrans);
roll = num2str(-handles.roll);
pitch = num2str(-handles.pitch);
yaw = num2str(handles.yaw);

copyfile([handles.CTpathname, handles.CTfilename],handles.CTfilename,'f');
rawfilename = [substr(handles.CTfilename,0,-3),'raw'];
copyfile([handles.CTpathname,rawfilename],rawfilename,'f');
commandtoexecute = ['Rigid3Dtransform ',handles.CTfilename,' TransformedData.mhd 0 0 0 ',pitch,' ',yaw,' ',roll,' ',xt,' ',yt,' ',zt];
dos(commandtoexecute);

% Read and save image information
fid = fopen('TransformedData.raw','r');
A = fread(fid,'uint16');
fclose(fid);
[x_dim,y_dim,z_dim,x_start,y_start,z_start,x_pixdim,y_pixdim,z_pixdim,filename] = Readmhd([handles.CTpathname,handles.CTfilename]);
A = reshape(A,x_dim,y_dim,z_dim);
imagefilename = substr(savefilename,0,-6);
imagefilename = [imagefilename,'img'];
fid = fopen([savepathname,imagefilename],'w');
fwrite(fid,A,'uint16');
fclose(fid);
clear A

% Now save header file
fid = fopen([savepathname,savefilename],'wt');
fprintf(fid,'%s\n', 'byte_order = 0;');
fprintf(fid,'%s\n','read_conversion = "";');
fprintf(fid,'%s\n','write_conversion = "";');
fprintf(fid,'%s\n','t_dim = 0;');
fprintf(fid,'%s\n',strcat('x_dim = ',num2str(x_dim),';'));
fprintf(fid,'%s\n',strcat('y_dim = ',num2str(y_dim),';'));
fprintf(fid,'%s\n',strcat('z_dim = ',num2str(z_dim),';'));
fprintf(fid,'%s\n','datatype = 0;');
fprintf(fid,'%s\n','bitpix = 0;');
fprintf(fid,'%s\n','bytes_pix = 2;');
fprintf(fid,'%s\n','t_pixdim = 0.000000;');
fprintf(fid,'%s\n',strcat('x_pixdim = ',num2str(x_pixdim/10),';'));
fprintf(fid,'%s\n',strcat('y_pixdim = ',num2str(y_pixdim/10),';'));
fprintf(fid,'%s\n',strcat('z_pixdim = ',num2str(z_pixdim/10),';'));
fprintf(fid,'%s\n','t_start = 0.000000;');
fprintf(fid,'%s\n',strcat('x_start = ',num2str(x_start/10),';'));
fprintf(fid,'%s\n',strcat('y_start = ',num2str((-y_start/10)-(y_dim*y_pixdim/10)),';'));
fprintf(fid,'%s\n',strcat('z_start = ',num2str(z_start/10),';'));
fprintf(fid,'%s\n','z_time = 0.000000;');
fprintf(fid,'%s\n','dim_units : ');
fprintf(fid,'%s\n','voxel_type :');
fprintf(fid,'%s\n','id = 0;');
fprintf(fid,'%s\n','vis_only = 0;');
fprintf(fid,'%s\n','data_type : ');
fprintf(fid,'%s\n','vol_type : ');
fprintf(fid,'%s\n',strcat('db_name : ',rawfilename));
fprintf(fid,'%s\n','medical_record : ');
fprintf(fid,'%s\n','originator : ');
daterecorder=date;
fprintf(fid,'%s%s\n','date : ',daterecorder);
fprintf(fid,'%s\n','scanner_id : ');
fprintf(fid,'%s\n','patient_position : ');
fprintf(fid,'%s\n','orientation = 0;');
fprintf(fid,'%s\n','scan_acquisition = 0;');
fprintf(fid,'%s\n',strcat('comment : ',rawfilename,';'));
fprintf(fid,'%s\n','fname_format : ');
fprintf(fid,'%s\n','fname_index_start = 0;');
fprintf(fid,'%s\n','fname_index_delta = 0;');
fprintf(fid,'%s\n','binary_header_size = 0;');
fprintf(fid,'%s\n','manufacturer : ');
fprintf(fid,'%s\n','model : ');
fprintf(fid,'%s\n','couch_pos = 0.000000;');
fprintf(fid,'%s\n','couch_height = 0.000000;');
fprintf(fid,'%s\n','X_offset = 0.000000;');
fprintf(fid,'%s\n','Y_offset = 0.000000;');
fprintf(fid,'%s\n','Z_offset = 0.000000;');
fprintf(fid,'%s\n','dataset_modified = 0;');
fprintf(fid,'%s\n','study_id : ');
fprintf(fid,'%s\n','exam_id : ');
fprintf(fid,'%s\n','patient_id : ');
fprintf(fid,'%s\n','modality : ');
fclose(fid);
delete('TransformedData.mhd');
delete('TransformedData.raw');
delete(handles.CTfilename);
delete(rawfilename);
delete(h)

guidata(hObject, handles);