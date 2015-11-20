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
|`'Method'`|PLS algorithm, so far only `'simpls'` is available.| 

We will use similar example as for MLR chapter but in this case we will use all variables from the *People* data trying to predict *Shoesize*. We will also split the values into a calibration and a test set.

```matlab
load('people');

% split data into subsets
tind = 4:4:32;

Xc = copy(people);
Xc.removerows(tind);
yc = people(:, 'Shoesize');
yc.removerows(tind);

Xt = people(tind, :);
yt = people(tind, 'Shoesize');

% create a model object and show the object info
m = mdapls(Xc, yc, 5);
disp(m)
```
```
  mdapls with properties:

    xloadings: [12x5 mdadata]
    yloadings: [1x5 mdadata]
      weights: [12x5 mdadata]
    vipscores: [12x1 mdadata]
     selratio: [12x1 mdadata]
         info: []
         prep: {[1x1 prep]  [1x1 prep]}
           cv: []
    regcoeffs: [1x1 regcoeffs]
       calres: [1x1 plsres]
        cvres: []
      testres: []
        alpha: 0.0500
        nComp: 5
```

We will skip the explanation of the model parameters that are similar to MLR. In addition to them there are loadings for X-space (`xloadings`), loadings for Y-space (`yloadings`), weights (in some literature they are called as “loading-weights”, `weights`), VIP scores (`vipscores`) and selectivity ratio (`selratio`). The last two parameters are statistics, which can be used to indentify variables, most important for prediction, and will be discussed in a separate chapter. 


Validation of a PLS-model as well as providing preprocessing objects can be carried out similar to MLR.

## Exploring PLS results

Let us first look at the ctructure of PLS results.

```matlab
disp(m.calres)
```
```

```

