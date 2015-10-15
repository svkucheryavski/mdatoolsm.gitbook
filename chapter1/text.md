# Models and results

In *mdatools*, any method for data analysis, such as PCA, PLS regression, SIMCA classification and so on, can create two types of objects — a model and a result. Every time you build a model you get a *model object*. Every time you apply the model to a dataset you get a *result object*. Thus for PCA, the objects have classes `pca` and `pcares` correspondingly.

Each object includes a list with variables (e.g. loadings for model, scores and explained variance for result) and provides a number of methods for investigation.

## Model calibration

Let's see how this works using a simple example  — Principal Component Analysis of *People* data. The data consists of 32 objects (persons from Scandinavian and Mediterranean countries, 16 male and 16 female) and 12 variables (height, weight, shoesize, annual income, beer and wine consumption and so on.). More information about the data can be found using `?people`. We will first load the data matrix and split it into two subsets as following:

```r
library(mdatools)
data(people)
  	
idx = seq(4, 32, 4)
cset = people[-idx, ]
tset = people[idx, ]
```

So `cset` is our calibration subset we are going to use for building a PCA model and `tset` is a subset we will apply the calibrated model to. Now let's build the model and show an information about the model object:

```r
model = pca(cset, scale = T, info = "People PCA model")
	
model = selectCompNum(model, 5)
print(model)
```

Here `pca` is a function that builds (calibrates) a PCA model and returns the model object. Function `selectCompNum` allows to select an “optimal” number of components for the model. Finally, function `print` prints the model object info:

```
PCA model (class pca)
	
Info:
People PCA model
	
Call:
pca(x = cset, scale = T, info = "People PCA model")
	
Major fields:
$loadings - matrix with loadings
$eigenvals - eigenvalues for components
$ncomp - number of calculated components
$ncomp.selected - selected number of components
$center - values for centering data
$scale - values for scaling data
$cv - number of segments for cross-validation
$alpha - significance level for Q residuals
$calres - results (scores, etc) for calibration set
```

As you can see there are no scores, explained variance values, residuals and so on. Because they actually are not part of a PCA model, they are results of applying the model to a calibration set. But loadings, eigenvalues, number of calculated and selected principal components, vectors for centering and scaling the data, number of segments for cross-validation and significance level are model fields:

```
model$loadings[1:4, 1:4]  
	
             Comp 1      Comp 2      Comp 3      Comp 4
Height   -0.3792846  0.08004057 -0.06676611  0.04512380
Weight   -0.3817929  0.08533809 -0.08527883 -0.04051629
Hairleng  0.3513874 -0.22676635 -0.02273504  0.01575716
Shoesize -0.3776985  0.12503739 -0.02117369  0.09929010
```

One can also notice that the model object has a particular field — `calres`, which is in fact a PCA *result object* containing results of applying the model to the calibration set. If we look at the object description we will get the following:

```
> print(model$calres)
	
Results for PCA decomposition (class pcares) 
	
Major fields:
$scores - matrix with score values
$T2 - matrix with T2 distances
$Q - matrix with Q residuals
$ncomp.selected - selected number of components
$expvar - explained variance for each component
$cumexpvar - cumulative explained variance
```

And if we want to look at scores, here is the way:

```
> model$calres$scores[1:4, 1:4]
          Comp 1     Comp 2     Comp 3      Comp 4
Lars   -5.108742 -1.2714943  1.0765871  1.08910438
Peter  -3.021811 -0.3163758 -0.2958259 -1.36053121
Rasmus -2.887335 -0.4428721  0.1231706 -1.15070563
Mette   1.116457 -1.3716444 -1.6344512 -0.03803356
```

Both model and result objects also have related functions, first of all for visualizing various values (e.g. scores plot, loadings plot, etc.). Some of the functions are discussed in the [next chapter](Plotting-tools), a full list can be found in help for a proper method.

## Applying model to a new data

The *result object* is also generated every time you apply a model to a new data. Like in many built in R methods, function `predict` is used in this case. The first argument of the function is always a model object. Here is a PCA example (assuming we have already built the model):

```
> res = predict(model, tset)
> print(res)
	
Results for PCA decomposition (class pcares) 
	
Major fields:
$scores - matrix with score values
$T2 - matrix with T2 distances
$Q - matrix with Q residuals
$ncomp.selected - selected number of components
$expvar - explained variance for each component
$cumexpvar - cumulative explained variance
```

## Model validation

Any model can be validated with cross-validation or/and test set validation. The validation results are, of course, represented by *result objects*, which are fields of a *model object* similar to `calres`, but with names `cvres` and `testres` correspondingly.

Here is how to build a PCA model with full cross-validation and test set validation (we will use `tset` as test data):

```r
model = pca(cset, scale = T, cv = 1, x.test = tset, info = "PCA model")
model = selectCompNum(model, 5)
```

Parameter `cv` specifies options for cross-validation. If a numeric value is provided then it will be used as number of segments for random cross-validation, e.g. if `cv = 2` cross-validation with two segments will be used. For full cross-validation use `cv = 1` like we did in the example above. For more advanced option you can provide a list with name of cross-validation method, number of segments and number of iterations, e.g. `cv = list('rand', 4, 4)` for running random cross-validation with four segments and four repetitions.

And here is the model object info:

```
> print(model)
	
PCA model (class pca)
	
Call:
pca(x = cset, scale = T, cv = 1, x.test = tset)
	
Major fields:
$loadings - matrix with loadings
$eigenvals - eigenvalues for components
$ncomp - number of calculated components
$ncomp.selected - selected number of components
$center - values for centering data
$scale - values for scaling data
$cv - number of segments for cross-validation
$alpha - significance level for Q residuals
$calres - results (scores, etc) for calibration set
$cvres - results for cross-validation
$testres - results for test set
```

As you can see we have all three types of results now — calibration, cross-validation and test set validation. Let's compare, for example, the explained variance values for the results:

```
> cbind(model$calres$expvar, model$cvres$expvar, model$testres$expvar)
	
               [,1]        [,2]       [,3]
Comp 1  54.23864691 43.30674751 44.8183978
Comp 2  20.28232983 20.99943694 17.1681782
Comp 3  13.10288913 14.70622977 16.9932063
Comp 4   7.88223195 13.00109104  8.0441691
Comp 5   2.26858962  3.57562285  4.4311656
Comp 6   1.14031431  2.01785501  2.4012850
Comp 7   0.47959862  0.76529214  0.7288616
Comp 8   0.24185482  0.05667122  0.5221894
Comp 9   0.22088015  0.77905369  0.5064012
Comp 10  0.11338134  0.65262040  0.2456456
Comp 11  0.02928332  0.13937943  0.3145322
Comp 12  0.00000000  0.00000000  3.8259682
```

The same methodology is used for any other method, e.g. PLS or SIMCA. In the next chapter we will look at how to use plotting functions for models and results.