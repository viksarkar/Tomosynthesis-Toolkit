function newimg = CTimagesample(oldimg,sampleTrans,sampleAxis)
% this function downsamples the 3D CT image matrix

sV  = size(oldimg);

sampleSlices = ceil(sV(3)/sampleAxis);

newimg = zeros(sV(1)/sampleTrans,sV(2)/sampleTrans,ceil(sV(3)/sampleAxis));

indV = 1 : sampleAxis: sampleSlices;
for i = 1 : length(indV)
  maskM = getDownsample2(oldimg(:,:,indV(i)),sampleTrans);
  newimg(:,:,i) = maskM;
end

function outM = getDownsample2(inM,sample)
%Downsample of 2-D matrix in both directions

maskM = getDownsample1(inM,sample);
maskM = getDownsample1(maskM',sample)';
outM = maskM;

function outM = getDownsample1(inM,sample)
%function outM = getDownsample1(inM,sample)
%Downsample:  retain every 'sample' point.
%Operates on every column.
%Errors out is the number of rows divided by sample
%parameter is not an integer.
%
%JOD, May 02.

%create vector index:

sV = size(inM);

len = length(inM(:));

indexV = 1 : sample : len;

outM = inM(indexV);

outM = reshape(outM,sV(1)/sample,sV(2));
