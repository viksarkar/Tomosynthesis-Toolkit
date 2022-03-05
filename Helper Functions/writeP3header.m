function writeP3header(filename)
[x_dim,y_dim,z_dim,x_start,y_start,z_start,x_pixdim,y_pixdim,z_pixdim,rawfilename] = Readmhd([filename,'.mhd']);
name = [filename,'.header'];
fid = fopen(name,'w');
fprintf(fid,'%s\n', 'byte_order = 0;');
fprintf(fid,'%s\n','read_conversion = "";');
fprintf(fid,'%s\n','write_conversion = "";');
fprintf(fid,'%s\n','t_dim = 0;');
fprintf(fid,'%s\n',['x_dim = ',num2str(x_dim),';']);
fprintf(fid,'%s\n',['y_dim = ',num2str(y_dim),';']);
fprintf(fid,'%s\n',['z_dim = ',num2str(z_dim),';']);
fprintf(fid,'%s\n','datatype = 1;');
fprintf(fid,'%s\n','bitpix = 16;');
fprintf(fid,'%s\n','bytes_pix = 2;');
fprintf(fid,'%s\n','t_pixdim = 0.000000;');
fprintf(fid,'%s\n',['x_pixdim = ',num2str(x_pixdim),';']);
fprintf(fid,'%s\n',['y_pixdim = ',num2str(y_pixdim),';']);
fprintf(fid,'%s\n',['z_pixdim = ',num2str(z_pixdim),';']);
fprintf(fid,'%s\n','t_start = 0.000000;');
fprintf(fid,'%s\n',['x_start = ',num2str(x_start),';']);
y_start = y_start - (y_dim*y_pixdim);
fprintf(fid,'%s\n',['y_start = ',num2str(y_start),';']);
fprintf(fid,'%s\n',['z_start = ',num2str(z_start),';']);
fprintf(fid,'%s\n','z_time = 0.000000;');
fprintf(fid,'%s\n','dim_units : cm');
fprintf(fid,'%s\n','voxel_type :');
fprintf(fid,'%s\n','id = 0;');
fprintf(fid,'%s\n','vis_only = 0;');
fprintf(fid,'%s\n','data_type : ');
fprintf(fid,'%s\n','vol_type : ');
fprintf(fid,'%s\n',strcat('db_name : ',filename));
fprintf(fid,'%s\n','medical_record : ');
fprintf(fid,'%s\n','originator : ');
daterecorder=date;
fprintf(fid,'%s%s\n','date : ',daterecorder);
fprintf(fid,'%s\n','scanner_id : ');
fprintf(fid,'%s\n','patient_position : ');
fprintf(fid,'%s\n','orientation = 0;');
fprintf(fid,'%s\n','scan_acquisition = 0;');
fprintf(fid,'%s\n','comment : Resampled Data for DTS-based ART;');
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
fprintf(fid,'%s\n','modality : CT');
fclose(fid);