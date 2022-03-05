function [xt,yt,zt,pitch,yaw,roll]=decompmatrix(qh)
% disp('x translation');
xt = round(qh(4,1)*100)/100;
% disp('y translation');
yt = round(qh(4,2)*100)/100;
% disp('z translation');
zt = round(qh(4,3)*100)/100;
% disp('roll')
yaw = round(asin(qh(1,3))*(180/pi)*10)/10;
% disp('yaw')
roll = round(atan2(qh(1,2),qh(1,1))*(180/pi)*10)/10;
% disp('pitch')
pitch = round(atan2(qh(2,3),qh(3,3))*(180/pi)*10)/10;