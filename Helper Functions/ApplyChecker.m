function checkered = ApplyChecker(fixim, regim)
box = 20;
[m,n]=size(fixim);
black = zeros(box);
white = ones(box);
A = ceil(m/box);
B = ceil(n/box);
tile = [black, white; white, black];
fixmask = repmat(tile,A,B);
fixmask = fixmask(1:m,1:n);
fiximmask = fixim.*fixmask;
tile = [white, black; black, white];
regmask = repmat(tile,A,B);
regmask = regmask(1:m,1:n);
regimmask = regim.*regmask;
checkered = fiximmask + regimmask;
clear fixmask fiximmask regmask regimmask;