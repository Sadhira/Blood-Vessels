# Blood-Vessels

Machine Learning to detect blood vessels and their crossing points in fundus images, photographs of the back of the eye. Pre-processing done in Matlab to generate customised ground truth from MNIST images. Primary and post processing performed using Python, using frontend Keras and backend Theano, with the Jupyter IDE. Inspired by UberNet and U-Net.


## Main scripts
### Python
mySeg7 - segmentation of modified MNIST.

mySeg8 - crossing point detection for modified MNIST.

mySeg9 - amalgamation for modified MNIST.

myVes2 - segmentation for blood vessels.


### Matlab
mnist_modify2 - generation of input and vessel segmentation ground truth.

## Output

mnist_crossing - generation of crossing detection ground truth.
### Final Network
![Network Structure](https://github.com/Sadhira/Blood-Vessels/blob/master/Network%20Structure.png)

### Vessel Results
![Vessel Results](https://github.com/Sadhira/Blood-Vessels/blob/master/Vessel%20Results.png)

