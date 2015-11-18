# Multiple linear regression

Multiple linear regression (MLR) is a simplest method, which can be used for relating a multivariate dataset **X** with a vector of response values **y** as a linear combination: $$y_i = b_0 + b_1x_{i1} + b_2x_{i2} + ... + b_nx_{in}$$. In its simplest form (meaning without constraints, penalties, etc.) the solution can be found by using one line of MATLAB code (we assume that matrix X already has a column of ones here).

```matlab
b = X \ y
```
However, besides just obtaining the vector with regression coefficients, one can do a lot of other things, including computing of performance statistics (prediction quality), model validation (cross-validation and test set validation), calculation of confidence intervals for the regression coefficients and, of course, graphical representation of all calculations. Moreover, other regression methods, such as Projection on Latent Structures (PLS) can be represented using MLR results as a basis. Therefore it was decided to include this method to the toolbox and in this chapter we will show how to work with the regression results and model. All methods and plots we are going to consider here are also available for other methods, e.g. PLS.

## Calibrating an MLR model

The idea is absolutely the same as with PCA — a method creates two kinds of objects, a *model* object, which contains all model properties, and one or several *result* objects with results of applying the model to a particular dataset. To calibrate a model one has to provide just two datasets — with **X** and **y** values. We will use a reduces *People* data for all examples in this chapter trying to predict *Shoe size* using *Height*, *Income*, *Age*, *Beer* and *IQ* values. 

We will also split the values into a calibration and a test set.

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

% create a model and show the object info
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

Parameters `info` and `cv` have the same meaning as for PCA. Parameter `nComp` is number of components in a model, and since MLR does not use any components it is always set to one. The parameter is needed for compatibility with other regression methods. Parameter `alpha` for MLR and other regression models is a significance level used for calculation of confidence intervals for regression coefficients (will be discussed later in this chapter).

Another similar parameter, `prep`, now looks a cell array with two values — preprocessing objects. The first is used for preprocessing of predictors (**X**) and the second for response (**y**) values. By default model centers both data sets. Similar to PCA, one can also scale the values using parameter `'Scale'` and/or define a manual set of preprocessing methods and provide it to the model using parameter `'Prep'`. In this case it is necessary to provide two preprocessing objects combaining them using a cell array. In the example below we will create the objects with standardization and provide them to the MLR model instead of just setting `'Scale'` to `'on'`. 

```matlab
px = prep();
px.add('scale');

py = prep();
py.add('scale');

m = mdamlr(Xc, yc, 'Prep', {px, py});
```

If there is no need to preprocess e.g. **y** values, then an empty preprocessing object should be provided. It can be created using method `prep()` as above, just do not add any preprocessing methods to it.

## Exploring MLR results

Let us look at the calibration results for the model we created in the last code section.

```matlab
disp(m.calres)
```
```
  24x1 mlrres array with properties:

    info: 'Results for calibration set'
    yref: [24x1 mdadata]
    stat: [1x1 struct]
```

The result object has three properties: `info`, which is just a text with information about the object, `yref` - a dataset with reference (provided by a user) response values and `stat` - a structure with performance statistics. Actually there is one more, hidden property, `ypred`, with a dataset where predicted response values are stored.

```matlab
disp(m.calres.ypred)
```
```
  24x1 mdadata array with properties:

            name: 'Predicted values'
            info: []
        dimNames: {'Objects'  'Responses'}
          values: [24x1 double]
           nCols: 1
           nRows: 24
        nFactors: 0
        rowNames: {24x1 cell}
        colNames: {'Shoesize'}
    rowFullNames: {24x1 cell}
    colFullNames: {'Shoesize'}
```

So we can look at the reference and predicted values:

```matlab
show([m.calres.yref m.calres.ypred])
```
```
               Variables
          Shoesize  VShoesize
         --------- ----------
    Lars        48         49
   Peter        44         43
  Rasmus        44       42.9
   Mette        38       38.5
   Gitte        39       39.1
    Jens        42       43.2
   Lotte        36       37.6
   Heidi        37       37.7
     Kaj        42       43.1
    Anne        38       36.7
  Britta        37       35.9
  Magnus        44       42.7
    Luka        45       44.7
Federico        46       45.4
    Dona        37       38.5
    Lisa        34       34.5
  Benito        41         41
  Franko        43       43.2
 Leonora        36       35.8
Giuliana        36       35.3
Giovanni        42       41.7
   Marta        36       36.5
 Rosetta        35       35.1
   Romeo        42         41
```

Because column name in both datasets is `'Shoesize'` a letter `'V'` was added to the second column when datasets were binded.

The parameter `stat` combines datasets with performance statistics based on the predicted and reference values, which include the coefficient of determination (R<sup>2</sup>), the root mean squared error (RMSE), bias, slope, as well as the ratio of standard error of prediciton to sample standard deviation (RPD).

```matlab
disp(m.calres.stat)
```
```
     rmse: [1x1 mdadata]
     bias: [1x1 mdadata]
    slope: [1x1 mdadata]
       r2: [1x1 mdadata]
      rpd: [1x1 mdadata]
```

The MLR results also have a couple of methods for quick overview of the predictions results. First of all it is already known `summary()`, which, in this case, shows the mentioned above statistics for predictions.

```matlab
summary(m.calres)
```
```
Results for calibration set

Prediction performance for Shoesize:
   RMSE      Bias  Slope     R2  RPD
 ------ --------- ------ ------ ----
  0.899  3.26e-15  0.948  0.948  4.4
```

As well as two plots. One with predicted and reference response values and one with residuals (difference between predicted and reference values) against the reference values.

```matlab
figure
subplot 121
plotpredictions(m.calres)
subplot 122
plotyresiduals(m.calres)
```

![Main plots for MLR results]("chapter5/fig1.png")

The plots can be tuned as any conventional plot for the `mdadata` object.

```matlab
figure
subplot 121
plotpredictions(m.calres, 'Marker', 's', 'Colorby', m.calres.yref)
subplot 122
plotyresiduals(m.calres, 'Color', 'c', 'Labels', 'names')
```

![Tuning pltos for MLR results]("chapter5/fig1.png")


## Validation

Any MLR (as well as any other regression model) can be validated using cross-validation or validation with a test set. The procedure is very similar to what we did with PCA. For cross-validation one has to specify a cell array with main parameters. In this case we will use random cross-validation with 8 segments and 4 repetitions. Also, to make the code shorter, we will use parameter `'Scale'` for scaling instead of providing preprocessing objects as we did before.

```matlab
mcv = mdamlr(Xc, yc, 'Scale', 'on', 'CV', {'rand', 8, 4});
disp(mcv)
```
```
  mdamlr with properties:

         info: []
         prep: {[1x1 prep]  [1x1 prep]}
           cv: {'rand'  [8]  [4]}
    regcoeffs: [1x1 regcoeffs]
       calres: [1x1 mlrres]
        cvres: [1x1 mlrres]
      testres: []
        alpha: 0.0500
        nComp: 1
```

As one can notice, the parameters `cv` and `cvres` are not empty anymore. 

```matlab
summary(mcv.cvres)
```
```
Results for cross-validation

Prediction performance for Shoesize:
  RMSE    Bias  Slope     R2   RPD
 ----- ------- ------ ------ -----
  1.26  0.0599  0.945  0.901  3.14
```

For test set validation (again, similar to PCA) one has to provide values for the parameter `TestSet`. Since for regression we need two datasets, they should be combined using a cell array.

```matlab
mt = mdamlr(Xc, yc, 'Scale', 'on', 'TestSet', {Xt, yt});
```

And, of course, both validation methods can be combined.

```matlab
mcvt = mdamlr(Xc, yc, 'Scale', 'on', 'CV', {'rand', 8, 4}, 'TesetSet', {Xt, yt});
disp(mcvt)
```
```
  mdamlr with properties:

         info: []
         prep: {[1x1 prep]  [1x1 prep]}
           cv: {'rand'  [8]  [4]}
    regcoeffs: [1x1 regcoeffs]
       calres: [1x1 mlrres]
        cvres: [1x1 mlrres]
      testres: [1x1 mlrres]
        alpha: 0.0500
        nComp: 1
```

## Exploring MLR model


## Confidence intervals for coefficients


