figure
cameratoolbar
plot3([-5 5], [0 0] ,[0 0])
hold on
plot3([0 0],[-5 5], [0 0])
plot3([0 0],[0 0],[-5 5])
text(5,0,0,'X');
text(0,5,0,'Y');
text(0,0,5,'Z');
vecs = [1 1 1; 2.5 3 -2];
center=vecs(2,:);
plot3(vecs(:,1),vecs(:,2),vecs(:,3),'r')
disp('ready to rotate vector about z at one end')
pause
for ang=10:10:350
rvecs=htransform_vectors(rotate_about_center(hmatrix_rotate_z(ang),center),vecs);
plot3(rvecs(:,1),rvecs(:,2),rvecs(:,3),'g')
end
disp('ready to rotate vector about x at midpoint')
pause
center=0.5*(vecs(2,:)+vecs(1,:));
for ang=10:10:350
rvecs=htransform_vectors(rotate_about_center(hmatrix_rotate_x(ang),center),vecs);
plot3(rvecs(:,1),rvecs(:,2),rvecs(:,3),'b')
end

center = [-2 -2 2];
origin = [0 0 0];
direction = center - origin;

vecs=[center; center + [1 0 -1]];

plot3([origin(1) center(1)] , [origin(2) center(2)], [origin(3) center(3)], 'c');
plot3(vecs(:,1), vecs(:,2), vecs(:,3),'m');
disp('ready to rotate about arbitrary axis')

pause
for ang = 10:10:360
    rmat = hmatrix_rotate_about(direction, ang);
    rvecs=htransform_vectors(rotate_about_center(rmat, center), vecs);
    plot3(rvecs(:,1),rvecs(:,2),rvecs(:,3),'m');
end

figure
cameratoolbar
plot3([-5 5], [0 0] ,[0 0])
hold on
plot3([0 0],[-5 5], [0 0])
plot3([0 0],[0 0],[-5 5])
text(5,0,0,'X');
text(0,5,0,'Y');
text(0,0,5,'Z');
vecs=[-1 1.5 2;-1 1 0; 1 1 0; 1 1 3; -1 0 0; 2 -1 4];
rvecs=htransform_vectors(hmatrix_rotate_x(20)*hmatrix_rotate_z(-30)*hmatrix_rotate_y(160)...
    *hmatrix_translate([-1 2 3]), vecs);


plot_vectors_3d(vecs,'r');
plot_vectors_3d(rvecs,'g');

disp('ready to align fiducial directions');
disp('original fiducials are red, misaligned ones are green');
disp('realigned fiducials will be dashed magenta');
pause;
alignmat = align_fiducials(vecs, rvecs);
avecs=htransform_vectors(alignmat, rvecs);
plot_vectors_3d(avecs,'m','--');
disp('ready to translate fiducials');
disp('translated fiducials are dashed cyan');
disp('cyan should lie on top of original red');
pause
[trans, newvecs] = minimize_fiducial_distance(vecs, avecs);
plot_vectors_3d(newvecs,'c', '--');
