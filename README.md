# Blood-Vessels

Machine Learning to detect blood vessels and their crossing points in fundus images, photographs of the back of the eye. Matlab was used for preprocessing, and Python with frontend Keras and backend Theano for primary processing.

Pre-processing done in Matlab to generate customised ground truth from MNIST images. Primary and post processing performed using Python with the Jupyter IDE. Inspired by UberNet and U-Net.


Main scripts:
## Python
mySeg7 - segmentation of modified MNIST.
mySeg8 - crossing point detection for modified MNIST.
mySeg9 - amalgamation for modified MNIST.
myVes2 - segmentation for blood vessls.

## Matlab
mnist_modify2 - generation of input and vessel segmentation ground truth
mnist_crossing - generation of crossing detection ground truth
