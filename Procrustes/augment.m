function outvectors = augment(invectors)
%AUGMENT  - add 4th column to Nx3 array for homogeneous transformations
%
%synopsis: outvectors - augment(invectors)
%inputs: 
% invectors = Nx3 array, presumably N 3D points
% outvectors: Nx4 array with 4th column of 1's appended

szin = size(invectors);
lastcol = repmat(1.0, szin(1), 1);
outvectors = [invectors, lastcol];
