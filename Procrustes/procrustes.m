function [qh, q, acen, bcen, err] =procrustes(a,b)
%PROCRUSTES match homologous points with linear transformation 
%
%synopsis: [qh, q, acen, bcen, err] =procrustes(a,b)
% inputs:
% a = "reference" points to be matched: N rows x 3 cols
% b = "test" points to match with a
% outputs:
% qh = 4x4 homogeneous transformation (trans+rot) to match b to a
% q = rotation of *centered* b to match *centered* a
% acen = centroid of points a, "centering" translation
% bcen = centroid of points b
% err = matrix of errors, ah - (bh * qh): N rows x 3 cols
%   to use qh, must augment 1x3 vectors with fourth element = 1.0 (see AUGMENT)
%   so ah, bh are augmented versions of a and b
% - note that qh is the composition of 3 steps:
% hmatrix_translate(-bcen) * hmatrix_rotate(q) * hmatrix_translate(acen)
% - also note that qh is to be POST multiplied to the vectors it transforms!
% - so the registered points b onto a can be obtained
% - by calling htransform_vectors(qh, b)
%
% C. Pelizzari, April 2002

% check to see that reference and test sets have same numbers of points
[a1,a2] = size(a);
[b1,b2] = size(b);
if (~(a1 == b1) & (a2 == b2))
    error ('dimensions and numbers of points must be equal!')
end

% calculate centroids:  sum over first argument (rows)
acen = sum(a, 1) / a1;
bcen = sum(b, 1) / b1;

% %create the arrays of centered points
% ta =  0.0 * a;
% tb =  0.0 * b;
% 
% for i = 1:a1
%     ta(i, :) = acen;
%     tb(i, :) = bcen;
% end

ta = repmat(acen,a1,1);
tb = repmat(bcen,b1,1);

at = a - ta;
bt = b - tb;

c=bt'*at;
[u,w,v] = svd(c);
q=u*v';
err=a-(bt*q + ta);
qh = hmatrix_translate(-1.0 * bcen) * hmatrix_rotate(q) * hmatrix_translate(acen);