function outvecs = htransform_vectors(hmat, invecs)
% HTRANSFORM_VECTORS
% apply the transformation "hmat" (4x4)
% to each vector in the list "invecs" (Nx3)
%
% calls "augment" to add a fourth column of ones,
% then applies the 4x4 hmat to the augmented vectors.
%
% note that our matrices are designed to be PRE multipled by
% the vectors, i.e., V' = V * A where V is the vector and A is
% the matrix.
%
% C. Pelizzari

outvecs=zeros(size(invecs));
hvecs=augment(invecs);
result = hvecs * hmat;
outvecs = result(:,1:size(invecs,2));
%for i = 1:size(invecs,1)
%    result=hvecs(i,:)*hmat;
%    outvecs(i,:)=result(1:size(invecs,2));
%end

