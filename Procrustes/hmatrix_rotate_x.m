function rh = hmatrix_rotate_x(thet)
%HMATRIX_ROTATE_X create homogeneous 4x4 matrix for rotation about X
%
% thet is in degrees
%  1.0 0.0 0.0   0.0
%  0.0  ct st    0.0
%  0.0 -st ct    0.0
%  0.0 0.0 0.0   1.0


tr = thet * pi / 180.0;
st = sin (tr);
ct = cos(tr);

rh = eye(4,4);

rh(2,2) = ct;
rh(2,3) = st;
rh(3,2) = -st;
rh(3,3) = ct;