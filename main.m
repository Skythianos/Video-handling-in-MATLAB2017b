clear all
close all

tic

vname = 'video_0.avi'; % Name of the video file
StartFrame = 6000;  % Start Frame
EndFrame   = 6100;  % End Frame

display.wait = [];
display.close = logical( [] );
display.draw = [false, true];

playVideo(vname,[StartFrame EndFrame],display);

toc