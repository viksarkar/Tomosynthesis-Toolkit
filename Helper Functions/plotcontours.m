function plotcontours(handles, orientation, slice, numcontours)
hold on;
for i = 1:numcontours
    switch i
        case 1
            switch orientation
                case 1
                    A = squeeze(handles.OrganContour1(:,:,slice));
                case 2
                    A = squeeze(handles.OrganContour1(:,slice,:));
                case 3
                    A = squeeze(handles.OrganContour1(slice,:,:));
            end
            [m,n] = size(A);
            for x = 1:m
                for y = 1:n
                    if(A(x,y)~=0)
                        plot(x,y,'Color',[1,0,0]);
                    end
                end
            end
        case 2
            switch orientation
                case 1
                    A = squeeze(handles.OrganContour2(:,:,slice));
                case 2
                    A = squeeze(handles.OrganContour2(:,slice,:));
                case 3
                    A = squeeze(handles.OrganContour2(slice,:,:));
            end
            [m,n] = size(A);
            for x = 1:m
                for y = 1:n
                    if(A(x,y)~=0)
                        plot(x,y,'Color',[0,1,0]);
                    end
                end
            end
        case 3
            switch orientation
                case 1
                    A = squeeze(handles.OrganContour3(:,:,slice));
                case 2
                    A = squeeze(handles.OrganContour3(:,slice,:));
                case 3
                    A = squeeze(handles.OrganContour3(slice,:,:));
            end
            [m,n] = size(A);
            for x = 1:m
                for y = 1:n
                    if(A(x,y)~=0)
                        plot(x,y,'Color',[0,0,1]);
                    end
                end
            end
        case 4
            switch orientation
                case 1
                    A = squeeze(handles.OrganContour4(:,:,slice));
                case 2
                    A = squeeze(handles.OrganContour4(:,slice,:));
                case 3
                    A = squeeze(handles.OrganContour4(slice,:,:));
            end
            [m,n] = size(A);
            for x = 1:m
                for y = 1:n
                    if(A(x,y)~=0)
                        plot(x,y,'Color',[1,1,0]);
                    end
                end
            end
        case 5
            switch orientation
                case 1
                    A = squeeze(handles.OrganContour5(:,:,slice));
                case 2
                    A = squeeze(handles.OrganContour5(:,slice,:));
                case 3
                    A = squeeze(handles.OrganContour5(slice,:,:));
            end
            [m,n] = size(A);
            for x = 1:m
                for y = 1:n
                    if(A(x,y)~=0)
                        plot(x,y,'Color',[1,0,1]);
                    end
                end
            end
        case 6
            switch orientation
                case 1
                    A = squeeze(handles.OrganContour6(:,:,slice));
                case 2
                    A = squeeze(handles.OrganContour6(:,slice,:));
                case 3
                    A = squeeze(handles.OrganContour6(slice,:,:));
            end
            [m,n] = size(A);
            for x = 1:m
                for y = 1:n
                    if(A(x,y)~=0)
                        plot(x,y,'Color',[0,1,1]);
                    end
                end
            end
        case 7
            switch orientation
                case 1
                    A = squeeze(handles.OrganContour7(:,:,slice));
                case 2
                    A = squeeze(handles.OrganContour7(:,slice,:));
                case 3
                    A = squeeze(handles.OrganContour7(slice,:,:));
            end
            [m,n] = size(A);
            for x = 1:m
                for y = 1:n
                    if(A(x,y)~=0)
                        plot(x,y,'Color',[1,0.5,0]);
                    end
                end
            end
        case 8
            switch orientation
                case 1
                    A = squeeze(handles.OrganContour8(:,:,slice));
                case 2
                    A = squeeze(handles.OrganContour8(:,slice,:));
                case 3
                    A = squeeze(handles.OrganContour8(slice,:,:));
            end
            [m,n] = size(A);
            for x = 1:m
                for y = 1:n
                    if(A(x,y)~=0)
                        plot(x,y,'Color',[1,0,0.5]);
                    end
                end
            end
        case 9
            switch orientation
                case 1
                    A = squeeze(handles.OrganContour9(:,:,slice));
                case 2
                    A = squeeze(handles.OrganContour9(:,slice,:));
                case 3
                    A = squeeze(handles.OrganContour9(slice,:,:));
            end
            [m,n] = size(A);
            for x = 1:m
                for y = 1:n
                    if(A(x,y)~=0)
                        plot(x,y,'Color',[0.5,1,0]);
                    end
                end
            end
        case 10
            switch orientation
                case 1
                    A = squeeze(handles.OrganContour10(:,:,slice));
                case 2
                    A = squeeze(handles.OrganContour10(:,slice,:));
                case 3
                    A = squeeze(handles.OrganContour10(slice,:,:));
            end
            [m,n] = size(A);
            for x = 1:m
                for y = 1:n
                    if(A(x,y)~=0)
                        plot(x,y,'Color',[0.5,0,1]);
                    end
                end
            end
        case 11
            switch orientation
                case 1
                    A = squeeze(handles.OrganContour11(:,:,slice));
                case 2
                    A = squeeze(handles.OrganContour11(:,slice,:));
                case 3
                    A = squeeze(handles.OrganContour11(slice,:,:));
            end
            [m,n] = size(A);
            for x = 1:m
                for y = 1:n
                    if(A(x,y)~=0)
                        plot(x,y,'Color',[0,1,0.5]);
                    end
                end
            end
        case 12
            switch orientation
                case 1
                    A = squeeze(handles.OrganContour12(:,:,slice));
                case 2
                    A = squeeze(handles.OrganContour12(:,slice,:));
                case 3
                    A = squeeze(handles.OrganContour12(slice,:,:));
            end
            [m,n] = size(A);
            for x = 1:m
                for y = 1:n
                    if(A(x,y)~=0)
                        plot(x,y,'Color',[0,0.5,1]);
                    end
                end
            end
        case 13
            switch orientation
                case 1
                    A = squeeze(handles.OrganContour13(:,:,slice));
                case 2
                    A = squeeze(handles.OrganContour13(:,slice,:));
                case 3
                    A = squeeze(handles.OrganContour13(slice,:,:));
            end
            [m,n] = size(A);
            for x = 1:m
                for y = 1:n
                    if(A(x,y)~=0)
                        plot(x,y,'Color',[1,0.5,0.5]);
                    end
                end
            end
        case 14
            switch orientation
                case 1
                    A = squeeze(handles.OrganContour14(:,:,slice));
                case 2
                    A = squeeze(handles.OrganContour14(:,slice,:));
                case 3
                    A = squeeze(handles.OrganContour14(slice,:,:));
            end
            [m,n] = size(A);
            for x = 1:m
                for y = 1:n
                    if(A(x,y)~=0)
                        plot(x,y,'Color',[0.5,1,0.5]);
                    end
                end
            end
        case 15
            switch orientation
                case 1
                    A = squeeze(handles.OrganContour15(:,:,slice));
                case 2
                    A = squeeze(handles.OrganContour15(:,slice,:));
                case 3
                    A = squeeze(handles.OrganContour15(slice,:,:));
            end
            [m,n] = size(A);
            for x = 1:m
                for y = 1:n
                    if(A(x,y)~=0)
                        plot(x,y,'Color',[0.5,0.5,1]);
                    end
                end
            end
        case 16
            switch orientation
                case 1
                    A = squeeze(handles.OrganContour16(:,:,slice));
                case 2
                    A = squeeze(handles.OrganContour16(:,slice,:));
                case 3
                    A = squeeze(handles.OrganContour16(slice,:,:));
            end
            [m,n] = size(A);
            for x = 1:m
                for y = 1:n
                    if(A(x,y)~=0)
                        plot(x,y,'Color',[0.25,0.5,0.5]);
                    end
                end
            end
    end
end
hold off;