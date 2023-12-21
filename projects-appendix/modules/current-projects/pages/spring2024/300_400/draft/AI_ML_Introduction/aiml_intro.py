#!/usr/bin/env python
# coding: utf-8

# # Introduction to Artificial Intelligence and Machine Learning (AI/ML)

# ## Module Objectives
# - Define AI/ML and the difference between them
# - Compare ML vs. expert based systems
# - Explore ways in which AI/ML gets used
# - Do the "Hello World" of neural networks as an introduction to AI/ML

# ## AI and ML: Definitions and Differences (1 point)

# Read from both of these links on the difference (or lack thereof) between AI and ML:
# 
# - <a href=https://web.archive.org/web/20231129013703/https://www.ibm.com/topics/artificial-intelligence>What is Artificial Intelligence? (IBM)<a>
# - <a href=https://web.archive.org/web/20231127132627/https://www.ibm.com/topics/machine-learning>What is Machine Learning? (IBM)<a>
# 
# **In a few sentences, describe the difference (or lack thereof) between machine learning and artificial intelligence in the cell below.** Citations are not required.

# 

# ## Expert Based Systems (1 point)

# Read from <a href=https://web.archive.org/web/20140505045226/http://stpk.cs.rtu.lv/sites/all/files/stpk/materiali/MI/Artificial%20Intelligence%20A%20Modern%20Approach.pdf>this paper from Russell & Norvig (1995)</a> on what an **expert system** is. Then describe the difference between an expert system and machine learning. The relevant section is titled *Knowledge-based systems: The key to power? (1969-1979)* and starts at page 22 (you should only need to read this one section).
# 
# **In a few sentences, describe the difference between machine learning and expert systems in the cell below**. Citations are not required.

# 

# ## Use Cases For AI/ML (1 point)

# Go back to the link <a href=https://web.archive.org/web/20231127132627/https://www.ibm.com/topics/machine-learning>What is Machine Learning? (IBM)<a> and scroll down to the "Real-world machine learning use cases" section.
# 
# **In 1-3 sentences, explain which one of the given use cases interest you the most and why**. Citations are not required.

# 

# ## A Machine Learning Algorithm: $k$-nearest neighbors (knn)

# Enough talk- let's create a machine learning algorithm!
# 
# Below we implement the $k$-nearest neighbors algorithm using Scikit-Learn, a machine learning package. 
# 
# **There might be a lot of terms here that you are unfamiliar with, like conditional distribution, preprocessing, EDA, etc- that's ok!** For this introductory homework, we don't expect you to know all these terms. **The entire algorithm is mostly implemented for you; all you need to do is edit a few lines of code to finish it. There will be clear instructions at each point where you need to edit the code to get it to work.**
# 
# If you are interested in learning more about $k$-nearest neighbors, check out chapter 2.2.3 of ISL: https://www.statlearning.com/ or visit the <a href=https://the-examples-book.com/starter-guides/data-science/data-analysis/k-nearest-neighbors>Starter Guide page</a>.

# ### Package Imports

# In[ ]:


import pandas as pd
import openpyxl
import numpy as np
from sklearn.neighbors import KNeighborsClassifier
from sklearn import metrics
import seaborn as sns
import matplotlib.pyplot as plt
import warnings
import math
from sklearn.model_selection import train_test_split

warnings.filterwarnings('ignore') #ignore warnings that occur


# ### A Brief Technical Overview

# While knn can be used for either regression or classification, we are going to demonstrate its uses for classification. 
# 
# One of the primary challenges of classification is that we don't know the conditional distribution of $Y$ given $X$ for our dataset. To deal with this, we attempt to *estimate* the conditional distribution of $Y$ given $X$, then classify any given individual observation using that estimated probability of what it *should* be. **knn can be used to estimate what the conditional distribution should be.**

# ### Deep Dive Into The Algorithm

# Given some positive integer $k$ and our data observation $x_0$, knn identifies the $k$ nearest points to $x_0$, represented by $n_0$.
# 
# Then, we estimate the conditional probability of class $j$ as the fraction of points in $n_0$ whose response values equal $j$:
# 
# $$ Pr(Y=j|X=x_0)=\frac{1}{k}\sum_{i\in n_0}I(y_i=j) $$
# 
# Finally, knn classifies the test observation we started with ($x_0$) to the class ($j$) with the largest probability from the above equation.

# ### A Visual Example

# In the example below, we simulate 3 different $k$ values: 3, 5, and 11. We have 11 different data points plus our test point, and 2 labels (magenta and yellow). 
# 
# When $k$=3, the black dot (our $x_0$) would be classified as yellow, because the 3 nearest points are 2 yellow and 1 magenta; so the chance of it being yellow is 2/3, and magenta is 1/3. When $k$=5, our black dot would be classified as magenta, because magenta is higher than yellow with 3/5, vs 2/5. Finally, when we include all the points with $k$=11, our $x_0$ would be classified as yellow, because there is a 7/11 chance of yellow and 4/11 chance of magenta.
# 
# We could theoretically take any integer $k$ values from 2 to 11. In practice, when $k$ is the same as the max amount of points, you are really just taking the average, and if you were going to do that in the first place you wouldn't need k-nearest neighbors to do it. *Often, detecting the right value of $k$ can be a challenge*.

# <img src="images/knn.gif" alt="knn gif" />

# ### Our Data

# We are working with an airline customer satisfaction dataset. The data comes from Kaggle: https://www.kaggle.com/datasets/johndddddd/customer-satisfaction

# ### Our Goal

# Classify observations by their level of satisfaction using knn. We want to know what variables really matter to customer satisfaction. For instance, is flight delay time the biggest indicator of overall customer satisfaction?

# ### EDA

# Below we take a quick look at the data. We drop rows with NA once we load it in.

# In[ ]:


df = pd.read_excel("data.xlsx")
df = df.dropna()


# In[ ]:


df.head()


# In[ ]:


df.info()


# In[ ]:


df.describe()


# `id` probably won't be relevant for us, and will get dropped. 

# In[ ]:


df['satisfaction_v2'].unique()


# In[ ]:


df['satisfaction_v2'].value_counts()


# `satisfaction_v2` is the satisfaction by the customer, a True or False essentially. In this case it's assumed that neutral is bad and bad is bad. It would've been nicer to see more discrete categories of satisfaction, but this is all the data we have to work with.

# ### Preprocessing

# Here we drop the `id` column, categorically convert the other non-int columns, make a new data frame, and then normalize. Finally, we make train/valid/test splits.

# In[ ]:


columns_to_convert = ['satisfaction_v2','Gender','Customer Type','Type of Travel','Class']

for column in columns_to_convert:
    df[column] = df[column].astype('category')
    df[column+"_coded"] = df[column].cat.codes

old_df = df

df = df.drop(columns=['id'])
df = df.drop(columns=columns_to_convert)


# In[ ]:


df.info()


# In[ ]:


columns_to_norm = ['Age','Flight Distance','Departure Delay in Minutes','Arrival Delay in Minutes']

for column in columns_to_norm:
    df[column] = df[column]/np.max(df[column])


# #### Train Test Splits (1 point)

# Below we create the cross validation train test splits from our data. You can learn about train/test splits here: https://the-examples-book.com/starter-guides/data-science/data-modeling/resampling-methods/cross-validation/train-valid-test
# 
# **Set test_size to be some value between 0.05 and 0.30 to create a test split that is 5-30% of our total dataset**. `test_size` gets used in the scikit-learn function `train_test_split` to automatically shuffle our data and create train test splits.

# In[ ]:


test_size = ??


# In[ ]:


if test_size < 0.05 or test_size > 0.30:
    raise AssertionError("The test_size is too big or too small.")


# In[ ]:


labels = df['satisfaction_v2_coded'] #create the labels 
data = df.drop(columns=['satisfaction_v2_coded']) #recreate the data
train_x, test_x, train_y, test_y = train_test_split(data, labels, test_size=test_size, random_state=42)


# #### Setting the Max $k$ Value (1 point)

# Below we create a for loop to try out multiple different $k$ values. Here we set the maximum value of $k$. You will want to set your `max_k` value to not be more than 20; it might take a while if you go higher than that, and besides, you will see that this data (like most datasets) doesn't benefit from a $k$ value higher than 10. **Set `max_k` to be equal to an int between 1 and 21 of your choice.**

# In[ ]:


max_k = ??


# In[ ]:


if max_k > 20 or max_k < 2:
    raise AssertionError("The max k value is larger than 20 or smaller than 2.")


# ### Model Building

# We create a for loop to test out many different values of $k$. It creates the $k$-nearest neighbors classifier using the $k$ value, makes predictions, and gets the accuracy metric back on those predictions into the array. Finally, it saves the result of the metrics to results_df so we can plot them.

# In[ ]:


k_values = []
train_acc = []
test_acc = []

#for each possible k we can test from 2 to the max possible k value (including max_k)
for k in range(2,max_k+1):
#Train Model and Predict  
    print("Now testing value of k:",k)
    neigh = KNeighborsClassifier(n_neighbors = k).fit(train_x,train_y)
    yhat = neigh.predict(test_x)
    k_values.append(k)
    train_acc.append(metrics.accuracy_score(train_y, neigh.predict(train_x)))
    test_acc.append(metrics.accuracy_score(test_y, yhat))

#convert results to df
results_data = {'k':k_values, 'Training Accuracy':train_acc, 'Test Accuracy':test_acc}
results_df = pd.DataFrame(data=results_data)


# In[ ]:


print("The k value with the highest accuracy betwen 2 and", max_k,"is",np.argmax(test_acc)+2)


# In[ ]:


# setting the dimensions
fig, ax = plt.subplots(figsize=(30, 18))
 
# drawing the plot
sns.lineplot(results_df, x='k',y='Test Accuracy', ax=ax).set_title("Test Accuracy For Each k Value")
plt.show()


# ### Discussion

# For most data, it is common that the ideal $k$ value is often somewhere between 5 and 10. There will often be an approximate arc like you see above, and the ideal $k$ will typically be an inflection point, after which the accuracy (or whatever other metric used) fares progressively worse.

# ### Summary

# k-nearest neighbors is a very simple algorithm to understand and implement. It can be used for both classification and regression, and its ease of use can make it a great starting point for many datasets.
