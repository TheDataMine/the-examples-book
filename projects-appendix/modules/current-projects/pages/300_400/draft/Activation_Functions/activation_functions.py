#!/usr/bin/env python
# coding: utf-8

# # Activation Functions

# ## Module Objectives
# - Explore Activation Functions
# - Implement Activation Functions Using `keras`
# - Deep Dive Into ReLU and Softmax Activation Functions

# ## Our Sources

# * https://keras.io/api/layers/activations/
# * https://www.statlearning.com/ (Chapter 10)
# * https://web.archive.org/web/20231204181718/https://en.wikipedia.org/wiki/Activation_function (has good reference table built for many different activation functions)
# * https://web.archive.org/web/20230828124751/https://towardsdatascience.com/softmax-activation-function-how-it-actually-works-d292d335bd78
# * https://web.archive.org/web/20231122184108/https://developers.google.com/machine-learning/crash-course/multi-class-neural-networks/softmax

# ## Introduction

# Recall the equation given for a (single hidden) neural network layer (see Basics of Neural Networks homework for a reminder of its interpretation): 
# 
# $f(X) =\beta_0+\sum_{k=1}^{K}\beta_kh_k(X)$
# <br>$ f(X)=\beta_0+\sum_{k=1}^{K}\beta_kg(w_{k0}+\sum_{j=1}^{p}w_{kj}X_j)$
# 
# where $K$ is the total number of neurons (and $k$ is an individual neuron), $w$ is the weight, and $p$ is the predictor/inputs.
# 
# Recall that the activation function is the portion
# 
# $A_k = h_k(X) = g(w_{k0}+\sum_{j=1}^{p}w_{kj}X_{j})=g(z)$
# 
# The commonly used shorthand is $g(z)$. Notice too that there is exactly one activation function per neuron in any layer.
# 
# Activation functions are critical to neural networks. They serve 2 primary purposes:
# 
# 1. They create nonlinearity (where otherwise you might have a simple linear relationship)
# 2. They ensure the model can capture complex nonlinearities and interactions between the variables
# 
# In short, activation functions are what ensure neural networks produce nonlinear output. There are other properties that activation functions can bring, but they differ depending on which activation function gets used. 

# ## Activation Functions provided by `keras` (1 point)

# There are a few major "families" of activation functions that have the desirable properties for activation functions, including:
# 
# * *-LU: Linear Unit (such as ReLU)
# * Sigmoid
# * Hyperbolic (such as tanh)
# * Softmax
# 
# There are certainly others as activation functions are still heavily under research, however these are the most common varieties you will see in use today.
# 
# `keras` carries all of these, with multiple different varieties. Below we list some of the most commonly used activation functions and their use case:
# 
# * ReLU (Rectified Linear Unit): Most commonly used. Good general purpose activation function. Can be computed and stored more efficiently than sigmoid (see https://dl.acm.org/doi/pdf/10.1145/3065386, under section 4.1).
# * Sigmoid: Used to be the most commonly used, before ReLU. Is also used in logistic regression to convert a linear function into probabilities between 0 and 1.
# * Softmax: Also used for (multinomial) logistic regression. Used when there is categorical output and when you want a probability of the chance of each given category. 
# 
# In general, it's not a bad idea to stick to the Linear Unit family (ReLU, GELU, etc) of activation functions (ReLU in particular) unless you are doing categorical output, in which case a softmax family function (softmax, softplus, etc) might come in handy. 

# ## Implementing Activation Functions in `keras` (2 points)

# Adding activation functions in `keras` is a breeze. Below is a simple implementation of a single layer neural network **that will have ReLU in the hidden layer and sigmoid for the output layer**.
# 
# **For the cell below, type in the `keras` syntax for both of the activation functions**. Verify it's correct with https://keras.io/api/layers/activations/ if needed.

# In[ ]:


from keras.models import Sequential
from keras.layers import Input, Dense


# In[ ]:


hidden_layer_1_activation = ??
output_layer_activation = ??


# In[ ]:


#check the strings on these for points


# In[ ]:


model = Sequential()
model.add(Input(shape=(82,))) #input layer
model.add(Dense(41, activation=hidden_layer_1_activation)) #hidden layer 1
model.add(Dense(10, activation=output_layer_activation)) #output layer


# ## ReLU: Deep Dive (1 point)

# The ReLU activation function is the most commonly used because of its efficient computational properties (relative to the previous standard, sigmoid). 
# 
# The ReLU function is defined as
# 
# $ g(z) = \left\{\begin{array}{ll}0 & \text{if} \ z<0 \\z & \text{otherwise} \\\end{array} \right. $
# 
# Recall the single layer neural network equation for the hidden layer:
# 
# $ f(X)=\beta_0+\sum_{k=1}^{K}\beta_kg(w_{k0}+\sum_{j=1}^{p}w_{kj}X_j)$
# 
# We pointed out in the introduction that 
# 
# $g(w_{k0}+\sum_{j=1}^{p}w_{kj}X_{j})=g(z)$
# 
# Recall that $w_k$ is the weight at the neuron $k$, and $p$ is the total number of predictors/inputs. $w_{k0}$ is the bias intercept at that given neuron; and the summation is all the weights at the current neuron for each predictor times each predictor. As long as $w_{k0}+\sum_{j=1}^{p}w_{kj}X_{j}$ is positive, then the ReLU activation function is equivalent to its value; else, it's set to 0. Let's see what happens if it is set to 0:
# 
# $ f(X)=\beta_0+\sum_{k=1}^{K}\beta_k*0$
# 
# $ f(X)=\beta_0$
# 
# Let's see what happens when $g(z)=1$:
# 
# $ f(X)=\beta_0+\sum_{k=1}^{K}\beta_k*1$
# 
# $ f(X)=\beta_0+\beta_1+\beta_2+...+\beta_k$
# 
# This situation, where the $z$ value is the same across all weight, neuron and predictor combinations, is highly unlikely. Let's see a simple demonstration that is slightly more likely, where we have 3 neurons ($K=3$) and the results of $g(z)$ are 1, 2 and 3 respectively:
# 
# $ f(X)=\beta_0+\beta_1 + 2\beta_2+3\beta_3$
# 
# But with 3 neurons, we would have 3 activation functions total in that layer, with the values:
# 
# $A_1 = \beta_1$
# <br> $A_2 = 2\beta_2$
# <br> $A_3 = 3\beta_3$
# 
# From there, the results would feed into the next layer (in this case of a single layer network, into the output layer; for deep learning, into the next hidden layer) as the input.
# 
# There are many other varieties of the Linear Unit family of functions, such as GELU ("Gaussian Error Linear Units") which is used for BERT, ChatGPT and the like (source: https://arxiv.org/pdf/1606.08415.pdf). ReLU is the "tried and true" gold standard and the other Linear Unit functions are often judged by their ability to improve ReLU.
# 
# The `keras` implementation of ReLU comes with configuration options. **Read about the configuration options <a href=https://keras.io/api/layers/activations/#relu-function>here</a> and add the command to change the max value of the threshold to (int) 20**. Below we have implemented an example using a different option for reference. 
## EXAMPLE

relu_model = Sequential()
relu_model.add(Input(shape=(129,))) #input layer
relu_model.add(Dense(13, activation=tf.keras.layers.ReLU(threshold=15)))
relu_model.add(Dense(1, activation='sigmoid')) #output layer
# In[ ]:


relu_model = Sequential()
relu_model.add(Input(shape=(129,))) #input layer
relu_model.add(Dense(13, activation=??))
relu_model.add(Dense(1, activation='sigmoid')) #output layer


# ## Softmax: Deep Dive (1 point)

# The softmax function gets used when there is categorical output for the output layer. **Read about the softmax function from at least one of these resources then answer the question below:**
# 
# * https://web.archive.org/web/20230828124751/https://towardsdatascience.com/softmax-activation-function-how-it-actually-works-d292d335bd78
# * https://web.archive.org/web/20231122184108/https://developers.google.com/machine-learning/crash-course/multi-class-neural-networks/softmax
# * https://keras.io/api/layers/activations/#softmax-function
# 
# **In the hidden cell below is a vector of probabilities that is the output of a softmax function. Based on what you know about the softmax function, set the answer variable `sum` equal to what all of the (output) probabilities will sum to.** Hint: You cannot know what these probabilities are, nor how many there are. 

# In[ ]:


sum = ??


# In[ ]:


#hidden test, sum = 1

