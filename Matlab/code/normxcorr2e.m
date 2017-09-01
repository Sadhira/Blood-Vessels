function I = normxcorr2e(template,im,shape)

  args={'full','same','valid'};
  cropSize=(find(strcmp(shape,args))-1)*size(template);
  crop=@(x,r) x(1+floor(r(1)/2):end-ceil(r(1)/2),1+floor(r(2)/2):end-ceil(r(2)/2))
  I=crop(normxcorr2(template,im),cropSize);