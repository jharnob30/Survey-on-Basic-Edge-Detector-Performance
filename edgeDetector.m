clear all
close all

im = imread('./Images/test/image (1).jpg');
if size(im,3) == 3 % if input is rgb
     im = rgb2gray(im);
end
% ref = imread('image.png'); %refernece image
% ref = imresize(ref, [size(im,1), size(im,2)]); %keeping same size
ref = imread('./Images/reference/image (1).png');

% %smoothing for a bit denosing before applying edge detection method 
im = medfilt2(im, [5,5]);
% sigma = 5;
% filter = fspecial('gaussian',[11,11],sigma);

% Find edges using edge detection methods.
tic
BW1 = edge(im,'Canny');
toc
tic
BW2 = edge(im,'Prewitt');
toc
tic
BW3 = edge(im,'sobel');
toc
tic
BW4 = edge(im,'roberts');
toc
tic
BW5 = edge(im,'log');
toc

%binary2grayscale
BW1 = uint8(BW1*255);
BW2 = uint8(BW2*255);
BW3 = uint8(BW3*255);
BW4 = uint8(BW4*255);
BW5 = uint8(BW5*255);

% MSE value mesure for noise level mesurment: 
squaredErrorImage1 = (ref - BW1) .^ 2;
mse1 = sum(sum(squaredErrorImage1))/ (size(im,1) * size(im,2));
fprintf('\n MSE value for Canny edge detector is %0.5f', mse1);
squaredErrorImage2 = (ref - BW2) .^ 2;
mse2 = sum(sum(squaredErrorImage2))/ (size(im,1) * size(im,2));
fprintf('\n MSE value for Prewitt edge detector is %0.5f', mse2);
squaredErrorImage3 = (ref - BW3) .^ 2;
mse3 = sum(sum(squaredErrorImage3))/ (size(im,1) * size(im,2));
fprintf('\n MSE value for Sobel edge detector is %0.5f', mse3);
squaredErrorImage4 = (ref - BW4) .^ 2;
mse4 = sum(sum(squaredErrorImage4))/ (size(im,1) * size(im,2));
fprintf('\n MSE value for roberts edge detector is %0.5f', mse4);
squaredErrorImage5 = (ref - BW5) .^ 2;
mse5 = sum(sum(squaredErrorImage5))/ (size(im,1) * size(im,2));
fprintf('\n MSE value for log edge detector is %0.5f', mse5);

% PSNR value mesure for noise level mesurment: 
psnr1 = 10*log10(256^2/mse1);
fprintf('\n\n PSNR value for Canny edge detector is %0.5f', psnr1);
psnr2 = 10*log10(256^2/mse2);
fprintf('\n PSNR value for Prewitt edge detector is %0.5f', psnr2);
psnr3 = 10*log10(256^2/mse3);
fprintf('\n PSNR value for Sobel edge detector is %0.5f', psnr3);
psnr4 = 10*log10(256^2/mse4);
fprintf('\n PSNR value for roberts edge detector is %0.5f', psnr4);
psnr5 = 10*log10(256^2/mse5);
fprintf('\n PSNR value for log edge detector is %0.5f', psnr5);

% DETAILS LOSS IN EDGE DETECTION: 
E1 = entropy(im)-entropy(BW1);
fprintf('\n\n information loss in Canny edge detector is %0.5f', E1);
E2 = entropy(im)-entropy(BW2);
fprintf('\n information loss in Prewitt edge detector is %0.5f', E2);
E3 = entropy(im)-entropy(BW3);
fprintf('\n information loss in Sobel edge detector is %0.5f', E3);
E4 = entropy(im)-entropy(BW4);
fprintf('\n information loss in roberts edge detector is %0.5f', E4);
E5 = entropy(im)-entropy(BW5);
fprintf('\n information loss in log edge detector is %0.5f', E5);

%num of connected components
[L1, num1]= bwlabel(BW1,8);
fprintf('\n\n connected componets for Canny edge detector is %0.5f', num1);
[L2, num2]= bwlabel(BW2,8);
fprintf('\n connected componets for Prewitt edge detector is %0.5f', num2);
[L3, num3]= bwlabel(BW3,8);
fprintf('\n connected componets for Sobel edge detector is %0.5f', num3);
[L4, num4]= bwlabel(BW4,8);
fprintf('\n connected componets for Roberts edge detector is %0.5f', num4);
[L5, num5]= bwlabel(BW5,8);
fprintf('\n connected componets for Log edge detector is %0.5f', num5);

%PIQE SCORE IMAGE QUALITY MEASURE
score1 = piqe(BW1);
fprintf('\n\n Piqe score for Canny edge detector is %0.5f', score1);
score2 = piqe(BW2);
fprintf('\n Piqe score for Prewitt edge detector is %0.5f', score2);
score3 = piqe(BW3);
fprintf('\n Piqe score for sobel edge detector is %0.5f', score3);
score4 = piqe(BW4);
fprintf('\n Piqe score for roberts edge detector is %0.5f', score4);
score5 = piqe(BW5);
fprintf('\n Piqe score for log edge detector is %0.5f', score5);

%show output image
subplot(2,3,1);
imshow(BW1);title("Canny");
subplot(2,3,2);
imshow(BW2);title("Prewitt");
subplot(2,3,3);
imshow(BW3);title("sobel");
subplot(2,3,4);
imshow(BW4);title("roberts");
subplot(2,3,5);
imshow(BW5);title("log");
subplot(2,3,6);
imshow(im);title("original");

%%
im = imread('./Images/test/ecimage (1).jpg');
if size(im,3) == 3 % if input is rgb
     im = rgb2gray(im);
end

% %smoothing for a bit denosing before applying edge detection method 
im = medfilt2(im, [5,5]);

% Find edges using edge detection methods.
BW1 = edge(im,'Canny');
BW2 = edge(im,'Prewitt');
BW3 = edge(im,'sobel');
BW4 = edge(im,'roberts');
BW5 = edge(im,'log');

% %
% BW1 = bwmorph(BW1, 'bridge'); % Use this to connect the pixels for morph image 
% BW2 = bwmorph(BW2, 'bridge');
% BW3 = bwmorph(BW3, 'bridge');
% BW4 = bwmorph(BW4, 'bridge');
% BW5 = bwmorph(BW5, 'bridge');
% 
% se = strel('disk',2); %# structuring element
% BW1 = imclose(BW1,se);
% BW2 = imclose(BW2,se);
% BW3 = imclose(BW3,se);
% BW4 = imclose(BW4,se);
% BW5 = imclose(BW5,se);

%edge count
[labeledImage1, numberOfEdges1] = bwlabel(BW1);
[labeledImage2, numberOfEdges2] = bwlabel(BW2);
[labeledImage3, numberOfEdges3] = bwlabel(BW3);
[labeledImage4, numberOfEdges4] = bwlabel(BW4);
[labeledImage5, numberOfEdges5] = bwlabel(BW5);