#!/usr/bin/env python
# coding: utf-8

# # Basics of Neural Networks

# ## Our Sources

# - https://web.archive.org/web/20230730223730/https://developers.google.com/machine-learning/crash-course/introduction-to-neural-networks/anatomy
# - https://www.statlearning.com/ (Chapter 10)

# ## What is a Neural Network?

# A neural network takes an input vector of $p$ variables $X=(X_1, X_2, ..., X_p)$ and builds a nonlinear activation function $f(X)$ to predict the response $Y$. Neural networks are incredibly useful when the expected output is not a line. <a href=https://web.archive.org/web/20230730223730/https://developers.google.com/machine-learning/crash-course/introduction-to-neural-networks/anatomy>Check out this resource from Google for a visual introduction of what this can look like.</a>
# 
# Neural networks were originally inspired by animal brains/neurons, the idea being to create a machine that can learn by imitating neurons. While this has proven challenging at times given that contemporary neuroscience has revealed neurons to be far more complicated than expected, neural networks are a leading model architecture choice for machine learning today.

# ### Mathematical Definition

# <a href=https://www.statlearning.com/>ISLR chapters 10.1+10.2</a> is our reference for this section, and it comes with much better visuals- check it out!
# 
# We will define a single layer *feedforward* neural network model architecture. There are others, but we will not be exploring them here.
# 
# Given the features $X$, with $p$ predictors, we would have $X_1, X_2, ..., X_p$ input features. These are our **input** layer.
# 
# The input layer is fed into the **hidden layer(s)**; for now we will define a neural network with only one hidden layer, but we will soon see models with more than 1.
# 
# As such we have:
# 
# $f(X) =\beta_0+\sum_{k=1}^{K}\beta_kh_k(X)$
# <br>$ f(X)=\beta_0+\sum_{k=1}^{K}\beta_kg(w_{k0}+\sum_{j=1}^{p}w_{kj}X_j)$
# 
# $\beta_0$ is the bias term, sometimes called the intercept. If you've done regression before this is the same as an intercept bias term in a linear regression model.
# 
# $K$ is the number of neurons in the hidden layer. So the term $ \sum_{k=1}^{K} $ says "the summation from 1 to the max number of neurons". *The number of neurons per layer is up to you and a key **tuning** parameter*.
# 
# $\beta_k$ is the coefficient term for the given $k$ neuron.
# 
# You will notice the difference between the two given equations above is the $h_k(X)$ portion. This is the activation function; you will also see it written as $g(z)$. We will look a little more into activation functions soon, but for now just notice that
# 
# $A_k = h_k(X) = g(w_{k0}+\sum_{j=1}^{p}w_{kj}X_{j})=g(z)$
# 
# The $\beta$ and $w$ parameters need to be estimated; for modern architectures the standard technique is called **backpropagation**. We will learn how backpropogation works in future homeworks.
# 
# ADD TEH FINAL OUTPUT LAYER HERE

# ## Layers (1 point)

# A typical *feedforward* neural network architecture has 3 different types of layers: **input**, **output**, and **hidden**. The input and output layers are only 1 layer deep, but the hidden layers can be any positive non zero integer (when you have 2 or more layers, you are said to be performing *deep learning*). 
# 
# Instead of writing all this out, let's just *make our own with code*! `keras` can help us do that. `keras` is an interface to the Google machine learning package, `Tensorflow`. It let's us use `Tensorflow` in a simple and efficient manner.
# 
# We have a simple 1 layer neural network implemented below that needs the number of *neurons* added to it. Sometimes you will see neurons referred to as *nodes* or *units*; these are all analagous. `keras` gives us the ability to create a model *sequentially*, so we can add each layer one at a time, and that is what you see below. We aren't going to *train* the model; for now we are just building.

# In[ ]:


from keras.models import Sequential
from keras.layers import Input, Dense


# **We have 16 input variables, so set the `input_neurons` to reflect that. Let's use 8 neurons for the hidden layer, and we want 1 output neuron. Edit the variables below to create our model architecture.** Make sure to use ints and not floats here!

# In[ ]:


input_neurons = ??
hidden_layer_1_neurons = ??
output_neurons = ??


# In[ ]:


if input_neurons != 16:
    raise AssertionError("Input layer neurons is not correct.")


# In[ ]:


if hidden_layer_1_neurons != 8:
    raise AssertionError("Hidden layer neurons is not correct.")


# In[ ]:


if output_neurons != 1:
    raise AssertionError("Output layer neurons is not correct.")


# In[ ]:


model = Sequential()
model.add(Input(shape=(input_neurons,))) #input layer
model.add(Dense(hidden_layer_1_neurons)) #hidden layer
model.add(Dense(output_neurons)) #output layer


# `keras` can summarize our current model architecture. You should see two `Dense` layers, one for our hidden layer and one for our output layer. The number of parameters is important, and we will see later how this is calculated. You should have 145 total parameters.

# In[ ]:


model.summary()


# ## Weights + Parameters (1 point)

# Recall the $\beta$ and $w$ parameters above. These are coefficients that need to be estimated, much in the same way that $\beta$ values have to be estimated for a regression equation.
# 
# You will notice that for the $f(X)$ neural networks equation\, the $b_k$ coefficients are parameters for each given neuron. But what about the $w$ parameters? These are the coefficients for each neuron to neuron connection between layers. 
# 
# The blessing and the curse of neural networks is that they have so many parameters. Below we show why, and also learn how to calculate the parameters.

# ### Calculating Parameters

# ![alternative text](nnexmaple.png)
# 
# All models have 1 weight per neuron to neuron connection. So in the image above, in between the input neurons and hidden layer 1 is $W_1$. In a feedforward architecture, each layer is connected sequentially, so the hidden input layer feeds into the output layer, with the $W_2$ weights representing those connections. The total number of parameters is weights ($W$) plus $\beta$ values (recall there is an additional intercept value per each neuron at the next layer). 
# 
# For our model in the *layers* section, it would have 1 weight per neuron to neuron connection (so, with 16 inputs, and 8 neurons, that would be 16*8=128) plus 8 $\beta$ coefficients per neuron, so $8+128=136$ parameters.
# 
# For the next layer, it would have 1 weight per neuron to neuron connection, plus the additional $\beta$ coefficient for the final output neuron, which would be $8*1 + 1=9$. If we total these together, that's $136+9=145$ parameters.
# 
# Confirming the number of parameters during model building is important for neural networks. Although it can be tedious, manually calculating and confirming the number of parameters and then confirming with the `keras` `summary()` function to verify is a surefire way to ensure you are building the model you think you are building.
# 
# Incredibly large networks today order on the millions or billions scale of parameters, so manual verification might not be realistic; but you should still attempt to confirm the parameters because it is a check to ensure you understand the model architecture in general.

# **Manually calculate the number of weights for the following neural network model with 1 hidden layer:**
# 
# * 15 neuron input layer
# * 30 neuron hidden layer
# * 5 neuron output layer
# 
# **Set the variable `total_params` equal to the total number of parameters.** You can manually calculate it by hand and/or use a software package, **so long as the answer is an int and is the total number of parameters for this model architecture**.

# In[ ]:


total_params = ??


# In[ ]:


#test cell should be confirming that total_params = (15*30+15)+(30*5+30)=


# ## Activation Functions

# Activation functions are critical to neural networks. They serve 2 primary purposes:
# 
# 1. They create nonlinearity (where otherwise you might have a simple linear relationship)
# 2. They ensure the model can capture complex nonlinearities and interactions between the variables
# 
# In short, activation functions are what ensure neural networks produce nonlinear output.
# 
# Although there are many activation functions, two of the most common include the ReLU (Rectified Linear Unit) and sigmoid activation functions. <a href=https://keras.io/api/layers/activations/#available-activations>A machine learning package like `keras` will offer both of these and more</a>.

# ### Sigmoid Activation Function (1 point)

# The sigmoid function looks like a flattened "S" shape. Below is an example of a logistic function, a common type of sigmoid (which is also the same function used in logistic regression to convert a linear function into probabilities between 0 and 1).

# ![alternative text](320px-Logistic-curve.svg.png)

# The equation for this function is $g(z)=\frac{e^{z}}{1+e^{z}}=\frac{1}{1+e^{-z}}$. **Set the variable `sigmoid` equal to this function, using `z` as the variable.** Hint: use `exp(z)` for $e^{z}$.

# In[ ]:


from math import exp


# In[ ]:


sigmoid = lambda z : #YOUR FUNCTION IN CODE GOES HERE#


# In[ ]:


#check for the value of sigmoid(1), sigmoid(.85), sigmoid(19), sigmoid(3.17)


# ### ReLU Activation Function (1 point)

# The ReLU activation function is defined as:
# 
# $ g(z) = \left\{\begin{array}{ll}0 & \text{if} \ z<0 \\z & \text{otherwise} \\\end{array} \right. $

# Today, ReLU is the preferred choice for neural networks, in part because it can be computed and stored more efficiently than the sigmoid activation function. **Do the same here that we did with the sigmoid function; create your own ReLU function below using `z` as the variable.**

# In[ ]:


def ReLU(z):
    if z < 0:
        return ??
    else:
        return ??


# In[ ]:


#check that when ReLU(-.1), ReLU(-293), ReLU(2) and ReLU(100.17)


# ## Deep Learning (1 point)

# Deep learning is a neural network model with 2 or more hidden layers. So a deep learning neural network architecture would have 1 input layer, more than 1 hidden layer, and an output layer. Some of the more complex deep learning models out there include dozens or hundreds of layers. The number of layers, and the number of neurons per layer, is yet another **tuning parameter** to consider when designing neural network architectures.
# 
# You will notice that the input layer is fed into the first hidden layer, the first hidden layer feeds into the second, etc. You can in theory have as many layers as you like, but there are important considerations such as bias-variance tradeoff and computational resources that may limit the number of layers that is practical/ideal. We will explore these considerations in later homeworks.

# **For the final problem, finish the deep learning model by adding the given neurons to each specified layer:** 
# 
# * 34 input neurons
# * 17 hidden layer 1 neurons
# * 8 hidden layer 2 neurons
# * 4 output neurons

# In[ ]:


input_neurons = ??
hidden_layer_1_neurons = ??
hidden_layer_2_neurons = ??
output_neurons = ??


# In[ ]:


#test for 34, 17, 8, 4


# In[ ]:


dl_model = Sequential()
dl_model.add(Input(shape=(input_neurons,))) #input layer
dl_model.add(Dense(hidden_layer_1_neurons)) #hidden layer
dl_model.add(Dense(hidden_layer_2_neurons)) #hidden layer
dl_model.add(Dense(output_neurons)) #output layer


# In[ ]:


dl_model.summary()

