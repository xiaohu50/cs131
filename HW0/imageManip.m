%reads in the image, converts it to grayscale, and converts the intensities
%from uint8 integers to doubles. (Brightness must be in 'double' format for
%computations, or else MATLAB will do integer math, which we don't want.)
dark = double(rgb2gray(imread('u2dark.png')));

%%%%%% Your part (a) code here: calculate statistics
minv = min(dark(:))
maxv = max(dark(:))
meanv = mean(dark(:))

%%%%%% Your part (b) code here: apply offset and scaling
fixedimg = [];
fixedimg = (dark-minv).*255/(maxv-minv)

%displays the image
imshow(uint8(fixedimg));

%%%%%% Your part (c) code here: apply the formula to increase contrast,
% and display the image
contrasted = [];
contrasted = 2.*(dark - 128) + 128
contrasted(contrasted<0)=0
contrasted(contrasted>255)=255
imshow(uint8(contrasted));

