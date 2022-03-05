function Writeautocontour(contour)
%***********************************************************************************
%This function is used to write the auto-recontouring file as Pinnacle format(*.roi)
%Copyright @ lan lin, llin@ctrc.net, Dec,2006
%Modified by Vikren Sarkar, Nov 2008
%***********************************************************************************

points = contour.Points;
roiname = contour.ROI;
croi = contour.Croi;
density = contour.Density;
[filename,pathname] = uiputfile({'*.roi','Pinnacle contour file (*.roi)'},'Save a Pinnacle contour file as');
if (~isequal(filename, 0)) && (~isequal(pathname,0))
    filename = fullfile(pathname,filename);
    fid = fopen(filename,'wt');
    %write the annotation at the beginning
    fprintf(fid,'%s\n','// Region of Interest file');
    fprintf(fid,'%s\n','// Data set: ');
    temp = sprintf('// File created: %s',datestr(now,31));
    fprintf(fid,'%s\n',temp);
    fprintf(fid,'\n');
    fprintf(fid,'%s\n','//');
    fprintf(fid,'%s\n','// Pinnacle Treatment Planning System');
    fprintf(fid,'%s\n','// 8.0d');
    fprintf(fid,'\n');
    color = {'red','blue','orange','tomato','green','yellow','forest','slateblue','forest','lavender','purple''skyblue','khaki',...
        'yellowgreen','lightblue','lightorange','seashell','aquamarine','brown','olive','teal','grey','Thermal','steelblue',...
        'maroon'};
    %write the contour points for the organs
    %roiname: the names of the organs
    %croi: the number of the organs
    for i = 1:croi %loop the number of organ
        fprintf(fid,'%s\n','//-----------------------------------------------------');
        temp = sprintf('//  Beginning of ROI:%s',roiname{i});
        fprintf(fid,'%s\n',temp);
        fprintf(fid,'%s\n','//-----------------------------------------------------');
        fprintf(fid,'\n');
        %write the header for each roi
        roi{i}{1} = sprintf(' roi={');
        roi{i}{2} = sprintf(' name: %s',roiname{i});
        roi{i}{3} = sprintf(' volume_name: contour propagation');%need patient name here,change later
        roi{i}{4} = sprintf(' stats_volume_name: contour propagation');
        roi{i}{5} = sprintf(' flags = 130172;');
        roi{i}{6} = sprintf(' color: %s',color{i});
        roi{i}{7} = sprintf(' box_size = 5;');
        roi{i}{8} = sprintf(' line_2d_width =  1;');
        roi{i}{9} = sprintf(' line_3d_width =  1;');
        roi{i}{10} = sprintf(' paint_brush_radius =  0.5;');
        roi{i}{11} = sprintf(' paint_allow_curve_closing = 1;');
        roi{i}{12} = sprintf(' lower = 800;');
        roi{i}{13} = sprintf(' upper = 3600;');
        roi{i}{14} = sprintf(' radius = 0;');
        roi{i}{15} = sprintf(' density = %i;',density{i});
        roi{i}{16} = sprintf(' density_units: g/cm^3');
        roi{i}{17} = sprintf(' override_data = 0;');
        roi{i}{18} = sprintf(' invert_density_loading = 0;');
        roi{i}{19} = sprintf(' volume = 0;');
        roi{i}{20} = sprintf(' pixel_min = 0;');
        roi{i}{21} = sprintf(' pixel_max = 0;');
        roi{i}{22} = sprintf(' pixel_mean = 0;');
        roi{i}{23} = sprintf(' pixel_std = 0;');
        roi{i}{24} = sprintf(' num_curve = %i;',length(points{i}));
        for ii = 1:24 %write the header information for roi
            fprintf(fid,'%s\n',roi{i}{ii});
        end
        for j = 1:length(points{i})
            fprintf(fid,'%s\n','//-----------------------------------------------------');
            temp = sprintf('//  ROI:%s',roiname{i});
            fprintf(fid,'%s\n',temp);
            temp = sprintf('//  Curve %i of %i',j,length(points{i}));
            fprintf(fid,'%s\n',temp);
            fprintf(fid,'%s\n','//-----------------------------------------------------');
            fprintf(fid,'%s\n','curve={');
            fprintf(fid,'%s\n',sprintf(' flags = 131092;'));
            fprintf(fid,'%s\n',sprintf(' block_size = 32;'));
            sizeofcurve = size(points{i}{j});
            fprintf(fid,'%s\n',sprintf(' num_points = %i;',sizeofcurve(1)));
            fprintf(fid,'%s\n','points={');
            fprintf(fid,'%f %f %.2f\n',points{i}{j}');
            fprintf(fid,'%s\n',sprintf('};  // End of points for curve %i',j));
            fprintf(fid,'%s\n',sprintf('}; // End of curve %i',i));
        end
        fprintf(fid,'%s\n',sprintf('}; // End of ROI %s',roiname{i}));
    end
    fclose(fid);
end