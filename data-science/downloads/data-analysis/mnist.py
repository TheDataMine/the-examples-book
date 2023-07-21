#!/usr/bin/env python
# coding: utf-8

from tensorflow.keras.datasets import mnist
import numpy as np #for the end section
import random #for the end section
import matplotlib.pyplot as plt #for plotting


# the data, split between train and validation sets
(x_train, y_train), (x_valid, y_valid) = mnist.load_data()


x_train.shape


x_valid.shape


x_train.dtype


x_valid.dtype


x_train.min()


x_valid.min()


x_train.max()


x_valid.max()


x_train[72]


image = x_train[72]
plt.imshow(image, cmap='gray')


y_train[72]


x_train = x_train.reshape(60000, 784)
x_valid = x_valid.reshape(10000, 784)


x_train.shape


x_train[0]


x_train = x_train / 255
x_valid = x_valid / 255 


x_train.dtype


x_train.min()


x_train.max()


import tensorflow.keras as keras

#we have 0,1,2,3,4,5,6,7,8,9 as outputs, leading to 10 possible labels in output
num_labels = 10

y_train = keras.utils.to_categorical(y_train, num_labels)
y_valid = keras.utils.to_categorical(y_valid, num_labels)


from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense

model = Sequential() #sequential just tells Keras to connect all the layers in our model sequentially.


model.add(Dense(units = NEURONS, activation='ACTIVATION FOR HIDDEN LAYER', input_shape=(INPUT SHAPE,))) #the input layer
model.add(Dense(units = NEURONS, activation='ACTIVATION FOR HIDDEN LAYER')) #the hidden layer
model.add(Dense(units = OUTPUT NEURONS, activation='ACTIVATION FOR OUTPUT LAYER')) #the output layer


model.summary() #a printout to summarize our whole model


model.compile(loss='categorical_crossentropy', metrics=['accuracy'])


model.fit(
    x_train, y_train, epochs=5, verbose=1, validation_data=(x_valid, y_valid)
)


model.fit(
    x_train, y_train, epochs=5, verbose=1, validation_data=(x_valid, y_valid)
)


image_number = random.randint(0,1000)
pred_image = x_valid[image_number]
yhat = model.predict(np.expand_dims(pred_image,0)) #the np.expand_dims command here just gets our data in a list form so that we can feed it into the model
print(yhat)


print(np.argmax(yhat))


print(np.argmax(y_valid[image_number]))

