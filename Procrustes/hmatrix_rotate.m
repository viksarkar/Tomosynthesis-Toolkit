function rh = hmatrix_rotate(r)
%HMATRIX_ROTATE create homogeneous 4x4 matrix from 3x3 rotation
sr = size(r);
rtemp = [r;repmat(0.0, 1, sr(2))];
rh = [rtemp, repmat(0.0, sr(1) + 1, 1)];
rh(sr(1)+1, sr(2)+1) = 1.0;