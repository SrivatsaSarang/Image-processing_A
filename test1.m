I=imread('newcameraman.jpg')%import image
I1=I;
Iscaled=im2double(I);%convert integer to double
imshow(Iscaled)
Faf{1} = [0         0
   -0.0884   -0.0112
    0.0884    0.0112
    0.6959    0.0884
    0.6959    0.0884
    0.0884   -0.6959
   -0.0884    0.6959
    0.0112   -0.0884
    0.0112   -0.0884
         0         0];
Faf{2} = [ 0.0112  0
    0.0112         0
   -0.0884   -0.0884
    0.0884   -0.0884
    0.6959    0.6959
    0.6959   -0.6959
    0.0884    0.0884
   -0.0884    0.0884
         0    0.0112
         0   -0.0112];
     af{1} = [ 0.0352         0
         0         0
   -0.0883   -0.1143
    0.2339         0
    0.7603    0.5875
    0.5875   -0.7603
         0    0.2339
   -0.1143    0.0883
         0         0
         0   -0.0352];

af{2} = [0   -0.0352
         0         0
   -0.1143    0.0883
         0    0.2339
    0.5875   -0.7603
    0.7603    0.5875
    0.2339         0
   -0.0883   -0.1143
         0         0
    0.0352         0];
%filter coefficients
wt = dddtree2('cplxdt',Iscaled,1,'FSfarras','qshift10');%find Dual tree complex wavelet coefficients 
waveletcfs = wt.cfs{1}; %the coefficients
subplot(311)
imagesc(waveletcfs(:,:,3,1,2));%imaginary part

subplot(312)
imagesc(waveletcfs(:,:,3,2,2));%imaginary part

Y = max(waveletcfs(:,:,3,1,2),-0.4)%thresholding the coefficients
subplot(313)
imagesc(Y);


oc=zeros(size(Y));%create a matrix of zeros 
for i=1:numel(Y)%to calculate the occurance of elements in matrix
    for j=1:size(Y)
         for k=1:size(Y)
            if Y(i)==Y(j,k)
                oc(i)=oc(i)+1;
            end
        end
    end
end
oc=oc/numel(Y)%stores the  probability of each character
Y1=huffmanenco(Y,oc)%generates a huffman encoded image
