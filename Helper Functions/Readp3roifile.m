%**************************************************************************
%This program is used to read organ contour for each phase in Pinnacle format
%**************************************************************************

%This is a program to open ROI file from Pinnacle treatment planning
%station. The file should be named as *.ROI and we can load the contours
%into the system. 
%ROI---ROI name for all the ROI 
%Points---Cell matrix to store point coordinates for all ROI
%Density---density information for all ROI
%Croi---ROI counts

%fnamecontour = 'C:\MATLAB6p5p1\work\apt4d\nomos\nomos_project\Feb12th\plan.roi';
function contour = Readp3roifile(fnamecontour)

try 
    fullname=fnamecontour;
    ROIALL = textread(fullname,'%s','delimiter','\n');
    version = ROIALL{7};
    %tell the version of ROI file from Pinnacle
    if ~isempty(findstr('7.6c',version))
        versionN = 7;
    elseif ~isempty(findstr('8.0',version))
        versionN = 8;
    end
    if versionN == 7
        [m,n]=size(ROIALL);%m is the line number of the file
            
        %read in necessary information
        Croi=0;%Count of roi
        Ccurves=0;%Count of curves for each roi
        Cpoints=0;%Count of points for each curve
        findit=0;%find something
        i=1;
        while(i<=m)
            temp=ROIALL{i};%get current line value
            
            findit = strfind(temp,'roi={');
            
           %Count ROI number and find name
            if (findit>0)
                slice = [];
                
                Croi=Croi+1;    
                
                %find name of current roi
                [token,rem] = strtok(ROIALL{i+1},':');
                [token,rem]=strtok(rem,' ');
                ROI{Croi}=rem;
                
                %find density of current roi
                [token,rem] = strtok(ROIALL{i+14},'=');
                [token,rem]=strtok(rem,' ');
                Density{Croi}=str2num(rem);
                
                %find number of curves of current roi
                [token,rem] = strtok(ROIALL{i+23},'=');
                [token,rem]=strtok(rem,' ');
                Ccurves=str2num(rem);
                
                for j=1:Ccurves %loop curves
                    if (j==1)
                        i=i+32; %jump 32 lines to reach number of point line
                    else
                        i = i+Cpoints+10;
                    end
                    
                    %get number of points for current curve
                    [token,rem] = strtok(ROIALL{i},'num_points =');
                    Cpoints=str2num(token); %number of points for current curve
                    i=i+1;
                    xyz = zeros(Cpoints,3);
                    if Cpoints >= 3 % If there are less than 3 points in one slice, forget it!
                        % Get point coordinates for current curve
                        for k=1:Cpoints %loop points
                            [xyz(k,1),xyz(k,2),xyz(k,3)] = strread(ROIALL{i+k},'%f %f %f','delimiter',',');
                        end
                        slice = [slice;xyz];
                    end
                end
                Points{Croi} = slice;
             end
             i=i+1;
        end
    elseif versionN == 8
        [m,n]=size(ROIALL);%m is the line number of the file
        %read in necessary information
        Croi=0;%Count of roi
        Ccurves=0;%Count of curves for each roi
        Cpoints=0;%Count of points for each curve
        findit=0;%find something
        i=1;
        while(i<=m)
            temp=ROIALL{i};%get current line value
            
            findit = strfind(temp,'roi={');
            
            %Count ROI number and find name
            if (findit>0)
                slice = [];
                Croi=Croi+1;    
                
                %find name of current roi
                [token,rem] = strtok(ROIALL{i+1},':');
                [token,rem]=strtok(rem,' ');
                ROI{Croi}=rem;
                
                %find density of current roi
                [token,rem] = strtok(ROIALL{i+18},'=');
                [token,rem]=strtok(rem,' ');
                Density{Croi}=str2num(rem);
                
                %find number of curves of current roi
                [token,rem] = strtok(ROIALL{i+32},'=');
                
                [token,rem]=strtok(rem,' ');
                Ccurves=str2num(rem);
                
                for j=1:Ccurves %loop curves
                    if (j==1)
                        i=i+40; %jump 32 lines to reach number of point line
                    else
                        i=i+Cpoints+10;
                    end
                    
                    %get number of points for current curve
                    [token,rem] = strtok(ROIALL{i},'num_points =');
                    Cpoints=str2num(token); %number of points for current curve
                    i=i+1;
                    % Get point coordinates for current curve
                    xyz = zeros(Cpoints,3);
                    if Cpoints >= 3 % If there are less than 3 points in one slice, forget it!
                        % Get point coordinates for current curve
                        for k=1:Cpoints %loop points
                            [xyz(k,1),xyz(k,2),xyz(k,3)] = strread(ROIALL{i+k},'%f %f %f','delimiter',',');
                        end
                        Points{Croi}{j} = xyz;
                    end
                end
                    NumCurves{Croi} = Ccurves;
             end
             i=i+1;
        end
    end
    
    % Check for empty sets of coordinates
    for thisroi = 1:Croi
        totalcurves{thisroi} = 0;
        for thiscurve = 1:NumCurves{thisroi}
            if size(Points{thisroi}{thiscurve},1) > 3
                NewPoints{thisroi}{(totalcurves{thisroi}+1)} = Points{thisroi}{thiscurve};
                totalcurves{thisroi} = totalcurves{thisroi} + 1;
            end
        end
    end
    
    contour.ROI = ROI;
    contour.Points = NewPoints;
    contour.NumCurves = totalcurves;
    contour.Density = Density;
    contour.Croi = Croi;
catch
    errmsg = lasterr;
    msgbox(errmsg);
end
