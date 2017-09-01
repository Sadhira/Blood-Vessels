%preliminary

restart = 0;

if restart == 1
    for i = 1
    %% basic x - input images

    loadedflat = loadMNISTImages('t10k-images.idx3-ubyte');
    images10k = reshape(loadedflat,28,28,10000);
    images = images10k;
%     images = images10k(:,:,1:1000);

    % loaded
    figure()
    for n = 1:16
        raw = images(:,:,n);
        subplot(4,4,n)
        imshow(raw)
    end


    % extract 8s

    %labels = loadMNISTImages('t10k-labels.idx1-ubyte');

    % [images2, labels] = mnist_parse('t10k-images.idx3-ubyte', 't10k-labels.idx1-ubyte');

    samples = 10000;
    msize = 20;
    msize = 28;

    [images2, labels] = readMNIST('t10k-images.idx3-ubyte', 't10k-labels.idx1-ubyte', samples, 0);

    eightsind = (labels == 8);
    num8 = sum(eightsind);
    eights = zeros(msize,msize,num8);

    
    % extract 8s
    eights = images;
    for i = samples:-1:1
        if eightsind(i) == 0
            eights(:,:,i) = [];
        end
    end
    
    % subplot for initial default
    for n = 1:16
        raw = images(:,:,n);
        subplot(4,4,n)
        imshow(raw)
    end


    % subplot for 8s
    figure()
    for n = 1:16
        raw8 = eights(:,:,n);
        subplot(4,4,n)
        imshow(raw8)
    end

    % different extract 8s
    % j = 0;
    % for i = 1:samples
    %     if eightsind(i,1) == 1
    %         j = j+1;
    %         eights(msize,msize,j) == images(msize,msize,i);
    %         
    %     end
    % end
    %% create mask

    refx = eights(:,:,4)
    figure()
    imshow(refx)

    maskx = refx;
    maskx(17:20,:) = [];
    maskx(1:6,:) = [];
    maskx(:,17:20) = [];
    maskx(:,1:4)=[];

    figure()
    imshow(maskx)
    imshow(refx)

    mask = load('maskx_from_eight4');

    %or use:
    mask = rgb2gray(imread('maskx_from_eight4_modded.png'));

    end
end
%%
mask = rgb2gray(imread('maskx_from_eight4_modded3.png'));
eights = load('eights_from_10k.mat');
dettruth = load('det8_from_10k.mat');


eights = eights.eights2;
dettruth = dettruth.det8;

%%
eighttest = eights(:,:,1);
figure()
imshow(eighttest)
imshowpair(eighttest, mask, 'montage');

for n = 1:16
    eighttest = eights(:,:,n);
    c = normxcorr2(mask, eighttest);
    figure, surf(c), shading flat
    [ypeak xpeak] = find(c == max(c(:)));

    % yoffSet = ypeak-size(mask,1);
    % xoffSet = xpeak-size(mask,2);
    yoffSet = ypeak-9;
    xoffSet = xpeak-10;

    subplot(4,4,n)
%     hFig = figure;
    hAx  = axes;
    mask = im2double(mask);
    
    imshow(eighttest,'Parent', hAx);

   
%     a = xoffSet+1;
%     b = yoffSet+1;
%     c = size(mask,2);
%     d = size(mask,1);

    imrect(hAx, [xoffSet+1, yoffSet+1, size(mask,2), size(mask,1)]);
end

dettruth = zeros(size(eights));
sizedet = 5;
k = (sizedet - 1)/2;

for n = 1:num8
%   eighttest = eights(:,:,n);
    %c = normxcorr2(mask, eights(:,:,n));
    c = normxcorr2e(mask, eights(:,:,n), 'same');
    %figure, surf(c), shading flat
    [ypeak xpeak] = find(c == max(c(:)));
   
    for i = -k:1:k
        for j = -k:1:k
            dettruth(ypeak + i, xpeak + j, n) = 1;
        end
    end
    
end

figure
nsubp = 10;
for n = 1:(nsubp*nsubp)
    if j < num8
        %raw = dettruth(:,:,n);
        subplot(nsubp,nsubp,n)
        %imshow(raw)
        imshowpair(eights(:,:,n), dettruth(:,:,n))
        j = j+1;
    end
end

dettruth2 = permute(dettruth, [3,1,2]);
eights2 = permute(eights, [3,1,2]);
close all
% 
% figure
% m = 2
% c = normxcorr2(mask, eights(:,:,m));
%  [ypeak xpeak] = find(c == max(c(:)));
% surf(c), shading flat
% dettruth1 = dettruth(:,:,m);
%%
 for n = 1:16
        raw = det80(:,:,n);
        subplot(4,4,n)
        imshow(raw)
 end
    
 input8 = xvals2;
 seg8 = yvals2;
 
 %% removing invalid cross-cors
 
eights = load('eights_from_10k.mat');
input8 = load('input8_from_10k.mat');
det8 = load('det8_from_10k.mat');
seg8 = load('seg8_from_10k.mat');

eights = eights.eights2;
input8 = input8.input8;
det8 = det8.det8;
seg8 = seg8.seg8;

eights = permute(eights, [2,3,1]);
input8 = permute(input8, [2,3,1]);
det8 = permute(det8, [2,3,1]);
seg8 = permute(seg8, [2,3,1]);

%num8 = 974;
num8 = 677;
 
figure
nsubp = 10;
%for n = 1:(nsubp*nsubp)
for n = 1:(nsubp*nsubp)
    if j < num8
        %raw = dettruth(:,:,n);
        subplot(nsubp,nsubp,n)
        %imshow(raw)
        imshowpair(eights(:,:,n), det8(:,:,n))
        j = j+1;
        title(n);
    end
end

figure
nsubp = 10;
m = 901;
j = m;
%for n = 1:(nsubp*nsubp)
for n = 1:100;
   
    if j < num8
        %raw = dettruth(:,:,n);
        subplot(nsubp,nsubp,n)
        %imshow(raw)
        imshowpair(eights(:,:,m), det8(:,:,m))
        title(m);
        j = j+1;
        m = m+1;
    end
end


toremove = [1,2,14,17,18,20,22,23,24,30,36,38,40,42,43,44,45, ...
    53,58,69,71,74,76,78,79,80,85,86,88,89,91,92,94,95, ...
    105,107,110,120,125,127,130,132,141,142,144,148,149, ...
    152,153,154,165,167,168,170,171,172,173,177,178,179,180, ...
    181,183,190,191,196,199,202,204,213,220,224,225,227,228, ...
    231,233,234,235,238,243,246,248,256,264,268,270,276,278,279, ...
    281,296,297,299,303,323,328,329,330,323,333,334,338,340, ...
    344,345,346,348,349,350,356,359,360,367,376,380,384,385,390, ...
    391,394,395,397,402,403,406,410,414,422,425,426,429,434,438, ...
    440,443,444,445,446,447,452,454,458,463,470,471,479,481,484, ...
    485,486,488,490,494,...
    504,512,518,520,522,525,527,528,529,540,541,542,543,544,545, ...
    546,547,559,563,564,566,567,568,570,581,583,584,586,587,589, ...
    591,592,593,595,596,597,599,600,601,602,603,617,618,619,628, ...
    630,631,632,633,635,644,645,646,657,658,660,663,664,680,691, ...
    703,704,705,706,707,708,710,711,713,716,720,721,727,734,735, ...
    736,737,738,740,741,742,743,766,770,772,774,785,787,796, ...
    804,806,807,808,809,819,820,825,829,830,831,832,834,836,837 ...
    855,863,865,866,867,868,869,870,871,874,883,886,887,888,889, ...
    891,892,893,894,898,899,901,902,903,905,908,909,929,930, ...
    931,932,933,934,935,948,950,952,953,967];
 
nremove = length(toremove);
nkeep = 974 - nremove;
 

input8c = input8;
det8c = det8;
seg8c = seg8;

for i = nremove:-1:1
    input8c(:,:,toremove(i)) = [];
    det8c(:,:,toremove(i)) = [];
    seg8c(:,:,toremove(i)) = [];
    delind = 1
end
 
%   eights = images;
%     for i = samples:-1:1
%         if eightsind(i) == 0
%             eights(:,:,i) = [];
%         end
%     end
 
 
figure
nsubp = 10;
m = 1;
j = m;
%for n = 1:(nsubp*nsubp)
for n = 1:100;
   
    if j < num8
        %raw = dettruth(:,:,n);
        subplot(nsubp,nsubp,n)
        %imshow(raw)
        imshowpair(input8c(:,:,m), det8c(:,:,m));
        title(m);
        j = j+1;
        m = m+1;
    end
end

input8ck = permute(input8c, [3,1,2]);
det8ck = permute(det8c, [3,1,2]);
seg8ck = permute(seg8c, [3,1,2]); 
 
 
 
 
 
 
 
 
 
 
