# Multiple linear regression

Multiple linear regression (MLR) is a simplest method, which can be used for relating a multivariate dataset **X** with a vector of response values **y** as a linear combination: $$y_i = b_0 + b_1x_{i1} + b_2x_{i2} + ... + b_nx_{in}$$. In its simplest form (meaning without constraints, penalties, etc.) the solution can be found by using one line of MATLAB code (we assume that matrix X already has a column of ones here).

```matlab
b = X \ y
```
However, besides just obtaining the vector with regression coefficients, one can do a lot of other things, including computing of performance statistics (prediction quality), model validation (cross-validation and test set validation), calculation of confidence intervals for the regression coefficients and, of course, graphical representation of all calculations. Moreover, other regression methods, such as Projection on Latent Structures (PLS) can be represented using MLR results as a basis. Therefore it was decided to include this method to the toolbox and in this chapter we will show how to work with the regression results and model. All methods and plots we are going to consider here are also available for other methods, e.g. PLS.

## Calibrating and exploring an MLR model

The idea is absolutely the same as with PCA — a method creates two kinds of objects, a *model* object, which contains all model properties, and one or several *result* objects with results of applying the model to a particular dataset. To calibrate a model one has to provide just two datasets — with **X** and **y** values. We will use a reduces *People* data for all examples in this chapter trying to predict *Shoe size* using *Height*, *Income*, *Age*, *Beer* and *IQ* values. 


```matlab
load('people');

X = people(:, {'Height', 'Income', 'Age', 'Beer', 'IQ'});
y = people(:, 'Shoesize');

m = mdamlr(X, y);
disp(m)
```
```
  mdamlr with properties:

         info: []
         prep: {[1x1 prep]  [1x1 prep]}
           cv: []
    regcoeffs: [1x1 regcoeffs]
       calres: [1x1 mlrres]
        cvres: []
      testres: []
        alpha: 0.0500
        nComp: 1
```

The main properties of the model object are the following. First of all, one can notice three properties related to results, similar to what was in PCA model, — `calres`, `cvres`, and `testres`. Because we did not use any validation in this case, the last two properties are empty and `calres` is an object of `mlrres` (MLR results) class.

Parameters `info` and `cv` have the same meaning as for PCA. Parameter `nComp` is number of components in a model, and since MLR does not use any components it is always set to one. The parameter is needed for compatibility with other regression methods. Parameter `alpha` for MLR and other regression models is a significance level used for calculation of confidence intervals for regression coefficients (will be discussed later in this chapter).

Another similar parameter, `prep`, now looks a cell array with two values — `prep` objects. The first is used for preprocessing of predictors (**X**) and the second for response (**y**) values. By default model centers both data sets. Similar to PCA one can scale the values using parameter `'Scale'` and/or define a manual set of preprocessing methods and provide it to the model using parameter `'Prep'`. In this case it is necessary to provide two preprocessing objects combaining them using a cell array. In the example below we will create the objects with standardization and provide them to the MLR model instead of just setting `'Scale'` to `'on'`. 

```matlab
px = prep();
px.add('scale');

py = prep();
py.add('scale');

m = mdamlr(X, y, 'Prep', {px, py});
```



## Exploring MLR results

## Validation

## Confidence intervals for coefficients


