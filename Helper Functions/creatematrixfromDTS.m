function creatematrixfromDTS(C,i,offsetx, offsety, offsetz, voxdimx, voxdimy, voxdimz, voxnumx, voxnumy, voxnumz, orientation)
% Function to use the ROI file from Pinnacle and perform a flood fill to create a solid version of the 
% ROI which can then be resampled for display on DTS datasets. 
% Developed by Vikren Sarkar. Last Modified 11/10/08

switch orientation
    case 1
        tempmatrix = zeros(voxnumx,voxnumz,voxnumy);
        
        % Create vectors to hold coordinates of each slice for inpoly
        x = zeros(voxnumx*voxnumz,1);
        y = x;
        for xvox=1:voxnumx
            for yvox = 1:voxnumz
                x(((xvox-1)*voxnumx)+yvox) = xvox;
                y(((xvox-1)*voxnumz)+yvox) = yvox;
            end
        end
        % Process curves one at a time
        for currentcurve = 1:C.NumCurves{i}
            M = C.Points{i}{currentcurve};
%             M = interpolatevector(M);
            xv = zeros(size(M,1),1);
            yv = zeros(size(M,2),1);
            % Plot each point in the matrix
            for k = 1:size(M,1)
                xv(k) = round((((10*M(k,1))-(offsetx))/voxdimx)+1);
                yv(k) = voxnumz-round((((10*M(k,2))-(offsetz))/voxdimz)+1);
            end
            z = round((((10*M(1,3))-(offsety))/voxdimy)+1);
            % Use inpolygon to check if each point is within the contour denoted by [xv,yv]
            in = inpolygon(x,y,xv,yv);
            for xvox = 1:voxnumx
                for yvox = 1:voxnumz
                    if(in(((xvox-1)*voxnumx)+yvox))
                        tempmatrix(xvox,yvox,z) = 25500;
                    end
                end
            end
        end
        
        % Now set resample to the correct orientation
        newtempmatrix = zeros(voxnumx, voxnumy, voxnumz);
        for currentslice = 1:voxnumz
            newtempmatrix(:,:,currentslice) = squeeze(tempmatrix(:,currentslice,:));
        end
    case 2
        
end

% Write results to file
fid = fopen('tempcontours.raw','w');
fwrite(fid,newtempmatrix,'uint16');
fclose(fid);
