function newpoints = htransform_planes(pointlist, hmatlist)
%
% takes a list of points (nplanes, 3, npoints) and a list of 4x4
% transfomations (4,4,nplanes) and applies the respective transformation to
% the points on each plane.  Where the transformations come from or what
% they are supposed to do is someone else's business.  We just plug and
% chug.
%
% C. Pelizzari Nov 07

nplanes = size(pointlist, 1);
npoints = size(pointlist, 3);

% list of output points is identical in dimensions to the input list
newpoints=zeros(size(pointlist));

for i = 1: nplanes
    mypointlist = squeeze(pointlist(i,:,:));
    % mypointlist is a column vector (3 rows, npoints columns) but we need
    % a row vector (3 columns, nponts rows) for htransform_vectors, so just
    % transpose on the fly with the matlab ' operator
    rotpts = htransform_vectors(hmatlist(:,:,i), mypointlist');
    % and transpose back again, of course.
    newpoints(i,:,:) = rotpts';
end