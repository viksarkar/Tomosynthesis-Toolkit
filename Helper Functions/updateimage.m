function handles = updateimage(handles, orientation, ApplyCheckerVal, currentval) 

if (orientation==1) %Axial
    set(handles.RegSlider,'Sliderstep',[1/handles.fixedzsize, 10/handles.fixedzsize]);
%     set(handles.RegSlider,'Value',currentval);
    set(handles.RegSlider,'Max',handles.fixedzsize);
    set(handles.top,'string','+y');
    set(handles.bottom,'string','-y');
    set(handles.left,'string','-x');
    set(handles.right,'string','+x');
    set(handles.texthori,'string','x');
    set(handles.textvert,'string','y');
    set(handles.textangle,'string','Roll');
    axes(handles.RegAxes);
    if(handles.manualregister)
        switch ApplyCheckerVal
            case 1
                dispimage = handles.registeredimbrightness*handles.regim;
            case 2
                dispimage = handles.fixedimbrightness*handles.fixeddata(:,:,currentval);
            case 3
                dispimage = ApplyChecker(double(handles.fixedimbrightness*handles.fixeddata(:,:,currentval)), 1.0*double(handles.registeredimbrightness*handles.regim));
        end
        dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
        imshow(dispimage,[handles.registeredminval,handles.registeredmaxval]); axis square; colormap(gray); axis off;
        if (handles.showcontoursboolean)
            plotcontours(handles,1,currentval,handles.numcontours);
        end
    else
        switch ApplyCheckerVal
            case 1
                dispimage = handles.registeredimbrightness*handles.registereddata(:,:,currentval);
            case 2
                dispimage = handles.fixedimbrightness*handles.fixeddata(:,:,currentval);
            case 3
                dispimage = ApplyChecker(double(handles.fixedimbrightness*handles.fixeddata(:,:,currentval)), 1.0*double(handles.registeredimbrightness*handles.registereddata(:,:,currentval)));
        end
        dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
        imshow(dispimage,[handles.registeredminval,handles.registeredmaxval]); axis square; colormap(gray); axis off;
        if (handles.showcontoursboolean)
            plotcontours(handles,1,currentval,handles.numcontours);
        end        
    end
end
if (orientation==2) %Coronal
    set(handles.RegSlider,'Sliderstep',[1/handles.fixedysize, 10/handles.fixedysize]);
%     set(handles.RegSlider,'Value',currentval);
    set(handles.RegSlider,'Max',handles.fixedysize);
    set(handles.top,'string','-z');
    set(handles.bottom,'string','+z');
    set(handles.left,'string','-x');
    set(handles.right,'string','+x');
    set(handles.texthori,'string','x');
    set(handles.textvert,'string','z');
    set(handles.textangle,'string','Yaw');
    axes(handles.RegAxes);
    if(handles.manualregister)
        switch ApplyCheckerVal
            case 1
                dispimage = handles.registeredimbrightness*handles.regim;                
            case 2
                dispimage = handles.fixedimbrightness*squeeze(handles.fixeddata(:,currentval,:));
            case 3
                dispimage = ApplyChecker(squeeze(double(handles.fixedimbrightness*handles.fixeddata(:,currentval,:))), 1.0*double(handles.registeredimbrightness*handles.regim));
        end
        dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
        imshow(dispimage,[handles.registeredminval,handles.registeredmaxval]); axis square; colormap(gray); axis off;
        if (handles.showcontoursboolean)
            plotcontours(handles,2,currentval,handles.numcontours);
        end
    else
        switch ApplyCheckerVal
            case 1
                dispimage = squeeze(handles.registeredimbrightness*handles.registereddata(:,currentval,:));
            case 2
                dispimage = handles.fixedimbrightness*squeeze(handles.fixeddata(:,currentval,:));
            case 3
                dispimage = ApplyChecker(squeeze(double(handles.fixedimbrightness*handles.fixeddata(:,currentval,:))), squeeze(1.0*double(handles.registeredimbrightness*handles.registereddata(:,currentval,:))));
        end
        dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
        imshow(dispimage,[handles.registeredminval,handles.registeredmaxval]); axis square; colormap(gray); axis off;
        if (handles.showcontoursboolean)
            plotcontours(handles,2,currentval,handles.numcontours);
        end        
    end
end
if (orientation==3) %Sagittal
    set(handles.RegSlider,'Sliderstep',[1/handles.fixedxsize, 10/handles.fixedxsize]);
%     set(handles.RegSlider,'Value',currentval);
    set(handles.RegSlider,'Max',handles.fixedxsize);
    set(handles.top,'string','-z');
    set(handles.bottom,'string','+z');
    set(handles.left,'string','+y');
    set(handles.right,'string','-y');
    set(handles.texthori,'string','y');
    set(handles.textvert,'string','z');
    set(handles.textangle,'string','Pitch');
    axes(handles.RegAxes);
    if(handles.manualregister)
        switch ApplyCheckerVal
            case 1
                dispimage = handles.registeredimbrightness*handles.regim;
            case 2
                dispimage = handles.fixedimbrightness*squeeze(handles.fixeddata(currentval,:,:));
            case 3
                dispimage = ApplyChecker(squeeze(double(squeeze(handles.fixedimbrightness*handles.fixeddata(currentval,:,:)))), 1.0*double(squeeze(handles.registeredimbrightness*handles.regim)));
        end
        dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
        imshow(dispimage,[handles.registeredminval,handles.registeredmaxval]); axis square; colormap(gray); axis off;
        if (handles.showcontoursboolean)
            plotcontours(handles,3,currentval,handles.numcontours);
        end
    else
        switch ApplyCheckerVal
            case 1
                dispimage = squeeze(handles.registeredimbrightness*handles.registereddata(currentval,:,:));
            case 2
                dispimage = handles.fixedimbrightness*squeeze(handles.fixeddata(currentval,:,:));
            case 3
                dispimage = ApplyChecker(double(squeeze(handles.fixedimbrightness*handles.fixeddata(currentval,:,:))), 1.0*double(squeeze(handles.registeredimbrightness*handles.registereddata(currentval,:,:))));
        end
        dispimage = rot90(dispimage,3); dispimage = fliplr(dispimage);
        imshow(dispimage,[handles.registeredminval,handles.registeredmaxval]); axis square; colormap(gray); axis off;
        if (handles.showcontoursboolean)
            plotcontours(handles,3,currentval,handles.numcontours);
        end        
    end
end