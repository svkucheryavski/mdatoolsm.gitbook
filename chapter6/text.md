# Projection on Latent Structures

[Projection on Latent Structures](https://en.wikipedia.org/wiki/Partial_least_squares_regression) also known as Partial Least Squares (PLS) is a linear regression method introduced and developed by Herman and Svante Wold for dealing multivariate data with a high degree of collinearity. The method aims, among others, at overcome the drawbacks of MLR and allows to create a linear regression model when number of objects is smaller than the number of variables.

PLS decomposes both $$X$$ and $$Y$$ space by projecting data points to a set of latent variables (PLS components or just components) similar to PCA decomposition:

$$
X = TP^T + E_X
$$
$$
Y = UQ^T + E_Y
$$

So there is a set of loadings $$(P,Q)$$, scores $$(T,U)$$ and residuals for each of the spaces. However, in this case, the PLS components are oriented to get a covariance between X-scores ($$T$$) and Y-scores ($$U$$) maximized (in contrast to PCA where the components are oriented along the direction of maximum variance of the data points). One can say, that PLS tries to capture the part of the X-data which explains maximum of the variance in Y-data.

The final PLS regression model is actually similar to MLR model and is represented by a set of regression coefficients (and its confidence intervals if they were calculated). So all plots and methods discussed in the previous section for MLR method will work similarly with PLS. But PLS has a lot of additional properties and tools for exploring the both datasets and for optimizing the prediction performance, which we are going to discuss in this section.

## Calibration of a PLS model

The general syntax for calibration is very similar to the MLR method, however in this case user can provide one more parameter — number of components to be used in the decomposition of $$X$$ and $$Y$$ spaces. The general syntax and short description of main parameters are shown below.

```matlab
m = mdapls(X, y, nComp, 'Param1', value1, 'Param2', value2, ...);
```

|Parameter|Description|
|---------|-----------|
|`X`|A dataset (object of `mdadata`class) with predictors.|
|`y`|A dataset (object of `mdadata`class) with responses.|
|`nComp`|A number of PLS components to be used in the model.|
|`'Center'`|Center or not the data values (`'on'`/`'off'`, by default is on).|
|`'Scale'`|Standardize or not the data values (`'on'`/`'off'`, by default is off).|
|`'Prep'`|A cell array with two preprocessing objects (first for X and second for y).|
|`'Alpha'`|A significance level used for calculation of confidence intervals for regression coefficients.|
|`'CV'`|A cell array with cross-validation parameters.|
|`'TestSet'`|A cell array with two dataset (X and y, both objects of `mdadata` class) for test set validation.|
|`'Method'`|PLS algorithm, so far only `''` is available.| 

We will use a reduced *People* data for all examples in this chapter trying to predict *Shoesize* using *Height*, *Income*, *Age*, *Beer* and *IQ* values. We will also split the values into a calibration and a test set.

```matlab
load('people');

% split data into subsets
tind = 4:4:32;

Xc = people(:, {'Height', 'Income', 'Age', 'Beer', 'IQ'});
Xc.removerows(tind);
yc = people(:, 'Shoesize');
yc.removerows(tind);

Xt = people(tind, {'Height', 'Income', 'Age', 'Beer', 'IQ'});
yt = people(tind, 'Shoesize');

% create a model object and show the object info
m = mdamlr(Xc, yc);
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