# Multiple linear regression

Multiple linear regression (MLR) is a simplest method, which can be used for relating a multivariate dataset **X** with a vector of response values **y** as a linear combination: $$y_i = b_0 + b_1x_{i1} + b_2x_{i2} + ... + b_nx_{in}$$. In its simplest form (meaning without constraints, penalties, etc.) the solution can be found by using one line of MATLAB code (we assume that matrix X already has a column of ones here).

```matlab
b = X \ y
```
However, besides just obtaining the vector with regression coefficients, one can do a lot of other things, including computing of performance statistics (prediction quality), model validation (cross-validation and test set validation), calculation of confidence intervals for the regression coefficients and, of course, graphical representation of all calculations. Moreover, other regression methods, such as Projection on Latent Structures (PLS) can be represented using MLR results as a basis. Therefore it was decided to include this method to the toolbox and in this chapter we will show how to work with the regression results and model. All methods and plots we are going to consider here are also available for other methods, e.g. PLS.

## Calibrating an MLR model

The idea is absolutely the same as with PCA — a method creates two kinds of objects, a *model* object, which contains all model properties, and one or several *result* objects with results of applying the model to a particular dataset. To calibrate a model one has to provide just two datasets — with **X** and **y** values. We will use a reduces *People* data for all examples in this chapter trying to predict *Shoe size* using *Height*, *Income*, *Age*, *Beer* and *IQ* values. 


```matlab
load('people');

X = people(:, {'Height', 'Income', 'Age', 'Beer', 'IQ'});
y = people(:, 'Shoesize');

m = mdamlr(X, y);
disp(m)
```


## Exploring MLR results

## Exploring MLR model

## Validation

## Confidence intervals for coefficients


