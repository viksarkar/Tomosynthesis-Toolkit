function rewritetrialfile(path,file, yawang, rollang)
fid = fopen([path,file],'rt');
A = textscan(fid, '%s', 'delimiter', '\n', 'whitespace', '');
fclose(fid);
fid = fopen([path,'plan.Trial'],'wt');
for i = 1:size(A{1},1)
    str = A{1}{i};
    if(isempty(findstr(str,' Couch ')) && isempty(findstr(str,' Gantry ')) && isempty(findstr(str,' IsocenterName ')) && isempty(findstr(str,' NumberOfFractions ')))
        fprintf(fid,'%s\n',str);
    else
        % Reposition Couch
        loc = findstr(str,' Couch ');
        if(~isempty(loc))
            [S,angle] = strread(str,'%s%f','delimiter','=');
            angle = mod(angle - yawang, 360);
            finalstring = [];
            for k = 1:loc(1,1)
                finalstring = [finalstring,' '];
            end
            finalstring = [finalstring,'Couch = ',num2str(angle),';'];
            fprintf(fid,'%s\n',finalstring);
        end
        % Reposition Gantry
        loc = findstr(str,' Gantry ');
        if(~isempty(loc))
            [S,angle] = strread(str,'%s%f','delimiter','=');
            angle = mod(angle - rollang, 360);
            finalstring = [];
            for k = 1:loc(1,1)
                finalstring = [finalstring,' '];
            end
            finalstring = [finalstring,'Gantry = ',num2str(angle),';'];
            fprintf(fid,'%s\n',finalstring);
        end
        % Replace Isocenter Name
        loc = findstr(str,' IsocenterName ');
        if(~isempty(loc))
            finalstring = [];
            for k = 1:loc(1,1)
                finalstring = [finalstring,' '];
            end
            finalstring = [finalstring,'IsocenterName = "Shifted Isocenter";'];
            fprintf(fid,'%s\n',finalstring);
        end
        % Set Number of Fractions to 1
        loc = findstr(str,' NumberOfFractions ');
        if(~isempty(loc))
            finalstring = [];
            for k = 1:loc(1,1)
                finalstring = [finalstring,' '];
            end
            finalstring = [finalstring,'NumberOfFractions = 1;'];
            fprintf(fid,'%s\n',finalstring);
        end
    end
end
fclose(fid);