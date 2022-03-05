function rh = hmatrix_rotate_y(thet)
%HMATRIX_ROTATE_X create homogeneous 4x4 matrix for rotation about Y
%
% thet is in degrees
%  ct  0.0 -st    0.0
%  0.0 1.0 0.0   0.0
%  st 0.0 ct    0.0
%  0.0 0.0 0.0   1.0


tr = thet * pi / 180.0;
st = sin (tr);
ct = cos(tr);

rh = eye(4,4);

rh(1,1) = ct;
rh(1,3) = -st;
rh(3,1) = st;
rh(3,3) = ct;