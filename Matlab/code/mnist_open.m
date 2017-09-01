% Change the filenames if you've saved the files under different names
% On some platforms, the files might be saved as 
% train-images.idx3-ubyte / train-labels.idx1-ubyte
%images = loadMNISTImages('train-images-idx3-ubyte');

images = loadMNISTImages('t10k-images.idx3-ubyte');
%labels = loadMNISTLabels('train-labels-idx1-ubyte');
 
% We are using display_network from the autoencoder code
display_network(images(:,1:100)); % Show the first 100 images
disp(labels(1:10));

%%

a = reshape(images(:,2), 28, 28);
imshow(a);

%%

a = images;
b = permute(a, [2 1]);
c = reshape(b, 10000, 28, 28);

imshow(b(1,:,:));

%% main
images = loadMNISTImages('t10k-images.idx3-ubyte');

a = images;
b = reshape(a,28,28,10000);
imshow(b(:,:,1));

n = 4;
for k = 1:(n*n)
    subplot (n, n, k)
    imshow(b(:,:,k));
end

c = b(:,:,1);
figure(2)
imagesc(c);
colormap(gray)
colorbar

%d = imnoise(c, 'speckle', 3);
d = imnoise(c, 'speckle', 1);
d = imnoise(c, 'poisson');
d = imnoise(c, 'gaussian', 0,0.04); % this 
imagesc(d); colorbar;
imshow(d);

e = imcomplement(d)
imagesc(e)
e2 = imadjust(e, [0 1], [0.2, 0.7]);
imagesc(e2);
imshow(e2);  % not bad here


imcontrast
imcontrast(e2)
hfigure = imcontrast(...);
    

%%

I = 0.5 * ones(28); imagesc(I);
I2 = imnoise(I, 'gaussian', 0,0.01); imshow(I2);
I3 = imgaussfilt(I2, 1); imshow(I3);
%I3 = imnoise(I2, 'poisson'); imshow(I3);

% I2 = imnoise(I, 'gaussian', 0.2,1); imshow(I2);
% I3 = imgaussfilt(I2, 3); imshow(I3);
% I3 = I3 - 0.2*(ones(28)); imshow(I3);

I2 = imnoise(I, 'gaussian', 0,0.4); imshow(I2);
I3 = imgaussfilt(I2, 3); imshow(I3);

I2 = imnoise(I, 'gaussian', 0,0.6); imshow(I2);
I3 = imgaussfilt(I2, 2.5); imshow(I3);

I2 = imnoise(I, 'gaussian', 0,1.2); imshow(I2);
I3 = imgaussfilt(I2, 2); imshow(I3);

I22 = imnoise(I, 'gaussian', 0,0.6); imshow(I22);
I32 = imgaussfilt(I2, 2); imshow(I32);
I32 = I32';

imshowpair(I3,I32,'montage');


% truesize(I32, [200 200]);

% avgH = integralKernel([1 1 9 9], 1/81);
% %avgH = integralKernel([1 1 15 15], 1/(15*15));
% I4 = integralFilter(I2, avgH); imagesc(I4)


figure()
imshow(e)

f = (I3 - (0.7*c)); imshow(f);
f2 = imgaussfilt(f, 1); imshow(f2);

f3 = ((I32+ 0.2) .* c ); imshow(f3);
f4 = (I3 - (0.5*f3)); imshow(f4);    
f5 = imgaussfilt(f4, 0.5); imshow(f5);%this group works

f3 = ((I32+ 0.2) .* c ); imshow(f3);
f4 = (I3 - (0.5*I32.*c)); imshow(f4);    
f52 = imgaussfilt(f4, 0.5); imshow(f5);%this group works

subplot(1,3,1)
imshow(f5);
subplot(1,3,2)
imshow(f52);
subplot(1,3,3)
f5dif = f5 -f52;
imshow(f5dif);

imshowpair(f5,f52,'montage');


%%






%%
I = c;
figure, imshow(I)
title('Original Image')
%PSF = fspecial('gaussian',11,5);
PSF = fspecial('gaussian',0,0.1);
Blurred = imfilter(I,PSF,'conv');

V = .01;
BlurredNoisy = imnoise(Blurred,'gaussian',0,V);
figure, imshow(BlurredNoisy)
title('Blurred and Noisy Image')

NP = V*prod(size(I)); 
[reg1 LAGRA] = deconvreg(BlurredNoisy,PSF,NP);
figure,imshow(reg1)
title('Restored Image')
%%

avgH = integralKernel([1 1 3 3], 1/2);
J = integralFilter(d, avgH);

imshow(J);
imagesc(J);
colormap(gray)
colorbar
%%
%//Read in total number of images
%//A = fread(fid, 4, 'uint8');
%//totalImages = sum(bitshift(A', [24 16 8 0]));

%//OR
A = fread(fid, 1, 'uint32');
totalImages = swapbytes(uint32(A));

%//Read in number of rows
%//A = fread(fid, 4, 'uint8');
%//numRows = sum(bitshift(A', [24 16 8 0]));

%//OR
A = fread(fid, 1, 'uint32');
numRows = swapbytes(uint32(A));

%//Read in number of columns
%//A = fread(fid, 4, 'uint8');
%//numCols = sum(bitshift(A', [24 16 8 0]));

%// OR
A = fread(fid, 1, 'uint32');
numCols = swapbytes(uint32(A));

%//For each image, store into an individual cell
imageCellArray = cell(1, totalImages);
for k = 1 : totalImages
    %//Read in numRows*numCols pixels at a time
    A = fread(fid, numRows*numCols, 'uint8');
    %//Reshape so that it becomes a matrix
    %//We are actually reading this in column major format
    %//so we need to transpose this at the end
    imageCellArray{k} = reshape(uint8(A), numCols, numRows)';
end

%//Close the file
fclose(fid);

%%


% trlblid = fopen('train-labels.idx1-ubyte');    
% trimgid = fopen('train-images.idx3-ubyte');    
% tslblid = fopen('t10k-labels.idx1-ubyte');    
tsimgid = fopen('t10k-images.idx3-ubyte');    

% % read train labels    
% fread(trlblid, 4);    
% numtrlbls = toint(fread(trlblid, 4));    
% trainlabels = fread(trlblid, numtrlbls);    
% 
% % read train data    
% fread(trimgid, 4);    
% numtrimg = toint(fread(trimgid, 4));    
% trimgh = toint(fread(trimgid, 4));    
% trimgw = toint(fread(trimgid, 4));    
% trainimages = permute(reshape(fread(trimgid,trimgh*trimgw*numtrimg),trimgh,trimgw,numtrimg), [2 1 3]);    
% 
% % read test labels    
% fread(tslblid, 4);    
% numtslbls = toint(fread(tslblid, 4));    
% testlabels = fread(tslblid, numtslbls);    

% read test data    
fread(tsimgid, 4);    
numtsimg = int16(fread(tsimgid, 4));    
tsimgh = int16(fread(tsimgid, 4));    
tsimgw = int16(fread(tsimgid, 4));    
testimages = permute(reshape(fread(tsimgid, tsimgh*tsimgw*numtsimg),tsimgh,tsimgw,numtsimg), [2 1 3]);    