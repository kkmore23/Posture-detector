
clc;
clear all;
close all;
%earsideway detection
h=load('D:\Final year Project\Posture correction\ESH detection\EAR\main ear labelling session\labelingSession.mat');
imDira = fullfile('D:\Final year Project\Posture correction\ESH detection\EAR\ear hostel photos');
addpath(imDira);
negativeFolder = fullfile('E:\photos college\Trad day 2014 Suyog');
trainCascadeObjectDetector('earr.xml',h.labelingSession.ImageSet.ImageStruct,negativeFolder,'FalseAlarmRate',0.2,'NumCascadeStages',5);
detector = vision.CascadeObjectDetector('earr.xml');
x = imread('C:\Users\ANAGA\Downloads\SHAREit\20160325_211839.jpg');
imges=imrotate(x,-90);
imges=imresize(imges,0.2);
 %detector.MergeThreshold = 4;
bboxes = step(detector,imges);
detectedImges = insertObjectAnnotation(imges,'rectangle',bboxes,'ear');
%shoulder detection
h=load('D:\Final year Project\Posture correction\ESH detection\SHOULDER\labelling session\shoulder main\labelingSession.mat');
imDira = fullfile('D:\Final year Project\Posture correction\ESH detection\SHOULDER\Banyan');
addpath(imDira);
negativeFolder = fullfile('D:\Final year Project\Posture correction\ESH detection\EAR\New pics of ear');
trainCascadeObjectDetector('shoulder.xml',h.labelingSession.ImageSet.ImageStruct,negativeFolder,'FalseAlarmRate',0.2,'NumCascadeStages',5);
detector = vision.CascadeObjectDetector('shoulder.xml');
%y = imread('D:\Final year Project\Posture correction\ESH detection\photos\20160325_211839.jpg');
imgss=imrotate(x,-90);
imgss=imresize(imgss,0.2);
detector.MergeThreshold = 20;
bboxss = step(detector,imgss);
detectedImgss = insertObjectAnnotation(imgss,'rectangle',bboxss,'shoulder');
%hipsideway detection
h=load('D:\Final year Project\Posture correction\ESH detection\HIP\hip photos\labelling session\labelleingmainhip\labelingSession.mat');
imDira = fullfile('D:\Final year Project\Posture correction\ESH detection\HIP');
addpath(imDira);
negativeFolder = fullfile('D:\Final year Project\Posture correction\ESH detection\EAR\New pics of ear');
trainCascadeObjectDetector('hip.xml',h.labelingSession.ImageSet.ImageStruct,negativeFolder,'FalseAlarmRate',0.2,'NumCascadeStages',6);
detector = vision.CascadeObjectDetector('hip.xml');
%z = imread('D:\Final year Project\Posture correction\ESH detection\photos\20160325_211839.jpg');
imghs=imrotate(x,-90);
imghs=imresize(imghs,0.2);
detector.MergeThreshold = 10;
bboxhs = step(detector,imghs);
detectedImghs = insertObjectAnnotation(imghs,'rectangle',bboxhs,'hip');
%  figure;
% imshow(detectedImghs);
% rmpath(imDira);
% subplot(2,2,1);
% imshow(detectedImges);
% subplot(2,2,2);
% imshow(detectedImgss);
% subplot(2,2,3);
imshow(detectedImghs);
% for ear
xes1=bboxes(1,1);
yes1=bboxes(1,2);
wes=bboxes(1,3);
hes=bboxes(1,4);
cxes=xes1+wes/2;
cyes=yes1+hes/2;
%for sholder
xss1=bboxss(1,1);
yss1=bboxss(1,2);
wss=bboxss(1,3);
hss=bboxss(1,4);
cxss=xss1+wss/2;
cyss=yss1+hss/2;
% for hip
xhs1=bboxhs(1,1);
yhs1=bboxhs(1,2);
whs=bboxhs(1,3);
hhs=bboxhs(1,4);
cxhs=xss1+whs/2;
cyhs=yhs1+hhs/2;
h1 = imdistline(gca,[cxes cxss],[cyes cyss]);
api = iptgetapi(h1);
dist1 = api.getDistance();
anglebetweenearandshoulder=api.getAngleFromHorizontal();
h2 = imdistline(gca,[cxss cxhs],[cyss cyhs]);
api = iptgetapi(h2);
dist2 = api.getDistance();
anglebetweenshoulderandhip=api.getAngleFromHorizontal();

% if (anglebetweenearandshoulder>90)
%     anglebetweenearandshoulder=180-anglebetweenearandshoulder;
% else
%     
%     anglebetweenearandshoulder=anglebetweenearandshoulder;
% end
%     display(anglebetweenearandshoulder);
%     
% if (anglebetweenshoulderandhip>90)
%     anglebetweenshoulderandhip=180-anglebetweenshoulderandhip;
% else
%     
%     anglebetweenshoulderandhip;
% end
    display(anglebetweenearandshoulder);
    display(anglebetweenshoulderandhip);
 
    if anglebetweenearandshoulder<85
      
  classinfo={'VIEW','','Region of angle','','Software','Ideal angle','','Disorder';
        'Side view','','ear to shoulder','',anglebetweenearandshoulder,90,'','spondylitis/kyphosis';
       '','','shoulder to hip','',anglebetweenshoulderandhip,90,'','';
       '','','','','','','','';
       'Front view','','nose to collarbone','','',90,'',''};
    xlswrite('sample2.xlsx',classinfo,4);
    else
        if anglebetweenshoulderandhip<80
            
    classinfo={'VIEW','','Region of angle','','Software','Ideal angle','','Disorder';
        'Side view','','ear to shoulder','',anglebetweenearandshoulder,90,'','';
       '','','shoulder to hip','',anglebetweenshoulderandhip,90,'','Kyphosis';
       '','','','','','','','';
       'Front view','','nose to collarbone','','',90,'',''};
    xlswrite('sample2.xlsx',classinfo,4);
        else
            if anglebetweenshoulderandhip<85
                 classinfo={'VIEW','','Region of angle','','Software','Ideal angle','','Disorder/Direction';
        'Side view','','ear to shoulder','',anglebetweenearandshoulder,90,'','';
       '','','shoulder to hip','',anglebetweenshoulderandhip,90,'','Lordosis';
       '','','','','','','','';
       'Front view','','nose to collarbone','','',90,'',''};
    xlswrite('sample2.xlsx',classinfo,4);
            else
                classinfo={'VIEW','','Region of angle','','Software','Ideal angle','','Disorder/Direction';
        'Side view','','ear to shoulder','',anglebetweenearandshoulder,90,'','none';
       '','','shoulder to hip','',anglebetweenshoulderandhip,90,'','none';
       '','','','','','','','';
       'Front view','','nose to collarbone','','',90,'',''};
    xlswrite('sample2.xlsx',classinfo,1);
            end
        end
    end
