function rtmat = rotate_about_center(rotmat, center)
% rotates by the matrix "rotmat" (4x4)
% about the center point (1x3)
%
% C. Pelizzari Nov 07
%

myrot=rotmat;
rotdim=size(myrot);
if (rotdim(1) ~= rotdim(2)), return, end
if (rotdim(1) ==3)
    myrot=eye(4,4);
    myrot(1:3,1:3)=rotmat;
end
% subtract the center; rotate; add the center back; that's the recipe.
% Work from left to right since these are designed to be premultipled by
% vectors.  The vector being transformed should "see" the first translation
% first, on the left of the chain.
rtmat = hmatrix_translate(-center) * myrot * hmatrix_translate(center);