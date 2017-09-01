%% raw scribbles
images = loadMNISTImages('t10k-images.idx3-ubyte');

a = images;
b = reshape(a,28,28,10000);

raw = b(:,:,3);

I = 0.5 * ones(28); imagesc(I);

% I2 = imnoise(I, 'gaussian', 0,0.6); imshow(I2);
% I3 = imgaussfilt(I2, 2.5); imshow(I3);

I2 = imnoise(I, 'gaussian', 0,0.6); imshow(I2);
I3 = imgaussfilt(I2, 4.5); imshow(I3);              %2.5 to 4


I22 = imnoise(I, 'gaussian', 0,0.6); imshow(I22);
I32 = imgaussfilt(I2, 2); imshow(I32);
I32 = I32';

imshowpair(I3,I32,'montage');

%f3 = ((I32+ 0.2) .* raw ); imshow(f3);
f1 = (I3 - (0.5*I32.*raw)); imshow(f4);    
f2 = imgaussfilt(f1, 0.5); imshow(f5);%this group works


imshowpair(raw,f2,'montage');

%% basic x - input images

images = loadMNISTImages('t10k-images.idx3-ubyte');

a = images;
b = reshape(a,28,28,10000);


I = 0.5 * ones(28); imagesc(I);

% I2 = imnoise(I, 'gaussian', 0,0.6); imshow(I2);
% I3 = imgaussfilt(I2, 2.5); imshow(I3);

figure(2)
for n = 1:16
    raw = b(:,:,n);
    
    I2 = imnoise(I, 'gaussian', 0,0.6);
    I3 = imgaussfilt(I2, 4.5);              %2.5 to 4
    
    
    I22 = imnoise(I, 'gaussian', 0,0.6); 
    I32 = imgaussfilt(I2, 2);
    I32 = I32';
    
    %imshowpair(I3,I32,'montage');
    
    f1 = (I3 - (0.5*I32.*raw)); 
    f2 = imgaussfilt(f1, 0.5);
    
    subplot(4,4,n)
   
    imshow(f2);
%     imagesc(f2);
%     colormap(gray);
end


%% segmentation y - finding threshold

for n = 1:16
end
    raw = b(:,:,n);
    
    raw = b(:,:,10);
    
    %gtruth = (raw > 0.4);
    gtruth = (raw > 0.3);
    
    imshowpair(raw,gtruth,'montage');
 
raw = f2;
raw = b(:,:,9);

figure
text(.75,1.25,'Threshold values')
for n = 1:20

    th = n /20;
    gtruth = (raw > th);
    
    subplot(4,5,n)
    
    imshow(gtruth);
    title(th);
    
    if n == 20
        imshow(raw);
        title('original')
    end
end

%%
figure
imshow(b(:,:,9))

%% segmentation y - ground truth

figure
th = 0.48;
for n = 1:16
    
    raw = b(:,:,n);
    %gtruth = (raw > th);
    smooth = imgaussfilt(raw, 0.6);
    gtruth = (smooth > th);

    subplot(4,4,n)
    imshow(gtruth);
    
end

% th = 0.45;
% for n = 1:16
%     
%     raw = b(:,:,n);
%     smooth = imgaussfilt(raw, 0.6);
%     %gtruth = (raw > th);
%     gtruth = (smooth > th);
%     subplot(4,4,n)
%     imshow(gtruth);
%     
% end

%%

% Load saved figures
c=hgload('mnist_original_4x4.fig');
k=hgload('mnist_fundus_4x4.fig');
% Prepare subplots
figure
h(1)=subplot(1,2,1);
h(2)=subplot(1,2,2);
% Paste figures on the subplots
copyobj(allchild(get(c,'CurrentAxes')),h(1));
copyobj(allchild(get(k,'CurrentAxes')),h(2));
% Add legends
l(1)=legend(h(1),'LegendForFirstFigure')
l(2)=legend(h(2),'LegendForSecondFigure')

%% make and store x


images = loadMNISTImages('t10k-images.idx3-ubyte');
totalsamples = 10000;

a = images;
b = reshape(a,28,28,totalsamples);


I = 0.5 * ones(28); 

samples = 10000;
plotsize = 4;
plotstart = samples - power(plotsize,2);


figure
for n = 1:samples
    raw = b(:,:,n);
    
    I2 = imnoise(I, 'gaussian', 0,0.6);
    I3 = imgaussfilt(I2, 4.5);              %2.5 to 4
    
    
    I22 = imnoise(I, 'gaussian', 0,0.6); 
    I32 = imgaussfilt(I2, 2);
    I32 = I32';
    
    %imshowpair(I3,I32,'montage');
    
    f1 = (I3 - (0.5*I32.*raw)); 
    f2 = imgaussfilt(f1, 0.5);
    
%     if n > plotstart
%         subplot(plotsize, plotsize, n-plotstart)
%         imshow(f2);
%     end
    
%   standard:
%   subplot(4,4,n)
%   imshow(f2);

   
    x_vals(:,:,n) = f2;

%     imagesc(f2);
%     colormap(gray);
end

figure
imshow(x_vals(:,:,n));

x_vals2 = permute(x_vals, [3, 1, 2]);

%%

%% make and store y

images = loadMNISTImages('t10k-images.idx3-ubyte');
totalsamples = 10000;
samples = totalsamples;

a = images;
b = reshape(a,28,28,totalsamples);


figure
th = 0.48;
for n = 1:samples
    
    raw = b(:,:,n);
    %gtruth = (raw > th);
    smooth = imgaussfilt(raw, 0.6);
    gtruth = (smooth > th);

%     subplot(4,4,n)
%     imshow(gtruth);
    
    y_vals(:,:,n) = gtruth;
end


figure
imshow(y_vals(:,:,n));

y_vals2 = permute(y_vals, [3, 1, 2]);