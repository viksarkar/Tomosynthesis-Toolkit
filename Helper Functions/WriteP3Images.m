function WriteP3Images(handles, orientation)
pitchval = num2str(-handles.pitchval);
rollval = num2str(-handles.rollval);
yawval = num2str(handles.yawval);
xt = num2str(-handles.xt);
yt = num2str(handles.yt);
zt = num2str(handles.zt);
copyfile([handles.movingpathname, handles.movingfilename],handles.movingfilename,'f');
rawfilename = [substr(handles.movingfilename,0,-3),'raw'];
copyfile([handles.movingpathname,rawfilename],rawfilename,'f');
commandtoexecute = ['Rigid3Dtransform ',handles.movingfilename,' TransformedData.mhd 0 0 0 ',pitchval,' ',yawval,' ',rollval,' ',xt,' ',yt,' ',zt];
% Transform data
h = showinfowindow('Please wait while the imageset is transformed and saved');
dos(commandtoexecute);
switch orientation
    case 1 %Coronal Data
        % Save file as img file instead of raw file
        fid = fopen('TransformedData.raw','r');
        A = fread(fid,'uint16');
        fclose(fid);
        [x_dim,y_dim,z_dim,x_start,y_start,z_start,x_pixdim,y_pixdim,z_pixdim,filename] = Readmhd([handles.movingpathname,handles.movingfilename]);
        A = reshape(A,x_dim,y_dim,z_dim);
        B = zeros(x_dim,z_dim,y_dim);
        for i = 1:y_dim
            B(:,:,i)=squeeze(A(:,i,:));
        end
        imagefilename = substr(handles.savefilename,0,-6);
        imagefilename = [imagefilename,'img'];
        fid = fopen([handles.savepathname,imagefilename],'w');
        fwrite(fid,B,'uint16');
        fclose(fid);
        clear A B
        % Now save header file
        fid = fopen([handles.savepathname,handles.savefilename],'wt');
        fprintf(fid,'%s\n', 'byte_order = 0;');
        fprintf(fid,'%s\n','read_conversion = "";');
        fprintf(fid,'%s\n','write_conversion = "";');
        fprintf(fid,'%s\n','t_dim = 0;');
        fprintf(fid,'%s\n',strcat('x_dim = ',num2str(x_dim),';'));
        fprintf(fid,'%s\n',strcat('y_dim = ',num2str(z_dim),';'));
        fprintf(fid,'%s\n',strcat('z_dim = ',num2str(y_dim),';'));
        fprintf(fid,'%s\n','datatype = 0;');
        fprintf(fid,'%s\n','bitpix = 0;');
        fprintf(fid,'%s\n','bytes_pix = 2;');
        fprintf(fid,'%s\n','t_pixdim = 0.000000;');
        fprintf(fid,'%s\n',strcat('x_pixdim = ',num2str(x_pixdim/10),';'));
        fprintf(fid,'%s\n',strcat('y_pixdim = ',num2str(z_pixdim/10),';'));
        fprintf(fid,'%s\n',strcat('z_pixdim = ',num2str(y_pixdim/10),';'));
        fprintf(fid,'%s\n','t_start = 0.000000;');
        fprintf(fid,'%s\n',strcat('x_start = ',num2str(x_start/10),';'));
        fprintf(fid,'%s\n',strcat('y_start = ',num2str(z_start/10),';'));
        fprintf(fid,'%s\n',strcat('z_start = ',num2str(y_start/10),';'));
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
end
delete('TransformedData.mhd');
delete('TransformedData.raw');
delete(handles.movingfilename);
delete(rawfilename);
delete(h);
