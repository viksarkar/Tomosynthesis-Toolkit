function newpoints = translate_rotate_planes(pointlist, angles, translations, center)
%
% on each of a number of planes, translate and rotate about the z axis, 
% with the rotation centered about a given point.
%
% Basically all we do here is make up the appropriate homogeneous
% transformation matrices, and call htransform_planes which knows how to do
% the work.
%
% C. Pelizzari Nov 07

nplanes = size(pointlist, 1);

hmats = zeros(4,4,nplanes);

for i = 1: nplanes
    hmats(:,:,i) = rotate_about_center(hmatrix_rotate_z(angles(i)), center)...
        * hmatrix_translate(translations(i,:));
end

newpoints = htransform_planes(pointlist, hmats);