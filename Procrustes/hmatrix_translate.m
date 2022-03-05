function th = hmatrix_translate(t)
%HMATRIX_TRANSLATE create homogeneous 4x4 matrix from 1x3 translation

sr = size(t);
th = eye(sr(2) + 1, sr(2) + 1);
th(sr(2)+1, 1:sr(2)) = t;