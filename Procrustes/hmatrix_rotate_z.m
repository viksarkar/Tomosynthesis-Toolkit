function rh = hmatrix_rotate_z(thet)
%HMATRIX_ROTATE_X create homogeneous 4x4 matrix for rotation about Z
%
% thet is in degrees
%  ct  st  0.0   0.0
% -st  ct  0.0   0.0
%  0.0 0.0 1.0   0.0
%  0.0 0.0 0.0   1.0

tr = thet * pi / 180.0;
st = sin (tr);
ct = cos(tr);

rh = eye(4,4);

rh(1,1) = ct;
rh(1,2) = st;
rh(2,1) = -st;
rh(2,2) = ct;