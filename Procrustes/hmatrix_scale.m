function outmat = hmatrix_scale(inscales)
%HMATRIX_SCALE create homogeneous 4x4 matrix from 1x3 scales

sr = size(inscales);
outmat=eye(sr(2)+1,sr(2)+1);
for i = 1:sr(2) outmat(i,i) = inscales(i);end