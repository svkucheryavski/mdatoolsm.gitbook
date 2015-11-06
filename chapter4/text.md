# Principal Component Analysis

In this chapter we will show how to use PCA method implemented in the *mdatools*. Besides that, we will use PCA examples to introduce some principles, which are common for most of the other methods (e.g. PLS, SIMCA, PLS-DA, etc.) available in this toolbox. This includes such things as model and result objects, showing performance statistics for models and results, validation, different kinds of plots, and so on.

Principal component analysis is one of the methods that decompose a data matrix **X** into a combination of three matrices: **X** = **TP'** + **E**. Here **P** is a matrix with unit vectors, defined in the original variables space. The unit vectors form a new basis, which is used to project all data points into. Matrix **T** contains coordinates of the projections. Matrix **E** contains residuals — difference between position of projected data points and their original locations.

In terms of PCA, the unit-vectors defining the new coordinate space are called *loadings* and the coordinate axes oriented alongside the loadings are *Principal Components* (PC). The coordinates of data points projected to the principal components are called *scores*. 

There are several other methods, such as *Projection Pursuit* (PP), *Independent Component Analysis* (ICA) and some others,  that work in a similar way and resulting in the data decomposition shown above. The principal difference among the methods is the way they find the orientation of the unit-vectors. Thus, PCA finds them as directions of maximum variance of data points. In addition to that, all PCA loadings are orthogonal to each other. The PP and ICA use other criteria for the orientation of the vectors for basis and e.g. for ICA the vectors are not orthogonal.

It was decided to put several methods, including ICA (and in future PP) under the PCA umbrella. First of all it was done to reduce amount of code, as the interpretation and analysis of the results, the methods return is very similar. In order to select which method (algorithm) to use for the decomposition there is a parameter `method` which can be defined by a user as it will be shown in the examples below.


## Model and result objects

In *mdatools*, any method for data analysis, such as PCA, PLS regression, SIMCA classification and so on, can create two types of objects — a *model* and a *result*. Every time you build a model you get a *model* object. Every time you apply the model to a dataset you get a *result* object. Thus for PCA, the objects have classes `mdapca` and `pcares` correspondingly.

Each *object* includes properties (e.g. loadings for model, scores and explained variance for result) and provides a number of methods for using the object and exploring its properties).

To calibrate a PCA model the following syntax is used:
```matlab
m = mdapca(data, ncomp, 'Param1', value1, 'Param2', value2, ...);
```
The full list of parameters is given below: 

|Parameter|Description|
|---------|-----------|
|`'Center'`|Center or not the data values (`'on'`/`'off'`, by default is on)|
|`'Scale'`|Standardize or not the data values (`'on'`/`'off'`, by default is off)|
|`'Prep'`|A preprocessing object, if provided will be used to transform the data values before creating the model or before applying the model to a new dataset|
|`'Alpha'`||
|`'Info'`||
|`''`||
|`''`||

Let us see how this works using a simple example — Principal Component Analysis of *People* data. We will first load the dataset and split it into two subsets as following:

```matlab
load(people);

dcal = people(1:2:end, :);
dtest = people(2:2:end, :);
```
So `dcal` is our calibration subset, which we are going to use for creating a PCA model and `dtest` is a subset we will apply the created model to. Now let's build the model and show an information about the model object:

```matlab
m = mdapca(dcal, 7, 'Scale', 'on')

disp(m)
```
```
  mdapca with properties:

           info: []
          nComp: 7
       loadings: [12x7 mdadata]
    eigenvalues: [7x1 mdadata]
           prep: [1x1 prep]
          alpha: 0.0500
             cv: []
         calres: [1x1 pcares]
          cvres: []
        testres: []
         limits: [2x7 mdadata]
         method: 'svd'
```
As one can see, the variable `m` is an object of `mdapca` class with many properties. The short explanation for each is given below:

|Property|Description|
|----|------------------------------------|
|`info`|A short information about the object (text)|
|`nComp`|Number of components in the model|
|`loadings`|A dataset with calculated loadings|
|`prep`|Preprocessing used to transform the data before model calibration|
|`alpha`|A significance level for calculation of statistical limits for residuals|
|``||
|``||
|``||
|``||
|``||

## Plots

## Tuning the method

## Validation

## Making preprocessing part of a model

