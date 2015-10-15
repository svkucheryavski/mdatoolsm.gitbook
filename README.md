# Getting started with mdatools for R

mdatools is an R package for preprocessing, exploring and analysis of multivariate data. The package provides methods mostly common for [Chemometrics](http://en.wikipedia.org/wiki/Chemometrics). The general idea of the package is to collect most of the common chemometric methods and give a similar "user interface" for using them. So if a user knows how to make a model and visualise results for one method, he or she can easily do this for the others.

It was created for an introductory PhD course on Chemometrics given at Section of Chemical Engineering, Aalborg University. Quickly I found out that using R for this course (with all advantages it gives) needs a lot of routine work from students, since most of them were also beginners in R. Of course it is nice when students get to know how to calculate explained variance and residuals manually, make corresponding plots and so on, but for the introductory course these things (as well as numerous typos and small mistakes in a code) take too much time, which can be spent for explaining methods and proper interpretation of results. 

This is actually true for everyday using of these methods, most of the routines can be written ones and simply reused with various options. So it was decided to write a package where most widely used chemometric methods for multivariate data analysis are implemented and which gives also quick and easy-to-use access to results, produced by these methods. First of all numerous plots.

Here how it works. Say, we need to make a PCA model for data matrix `x` with autoscaling. Then make an overview of most important plots and investigate scores and loadings for first three components. The `mdatools` solution will be:

```r

# make a model and show explained variance plot
m = pca(x, scale = T)
plotVariance(m)

# select optimal number of components (say, 4) for calculation of proper residuals
m = selectCompNum(m, 4)

# show plots for model overview
plot(m)

# show scores plot for PC1 and PC3
plotScores(m, c(1, 3))

# show loadings plot for the same components
plotLoadings(m, c(1, 3))

# show the loadings as a set of bar plots
plotLoadings(m, c(1, 3), type = 'h')
```

Fairly simple, is not it? The other "routine", which have been taken into account is cross-validation — any model can be cross-validated automatically and the model object will contain the validation results, which will also appear on all model plots, etc. See the next chapters for details.

## What it can do?

The package includes classes and functions for analysis, preprocessing and plotting data and results. So far the following methods for analysis are implemented:

* Principal Component Analysis (PCA)
* Soft Independent Modelling of Class Analogy (SIMCA)
* Partial Least Squares regression (PLS)
* Partial Least Squares Discriminant Analysis (PLS-DA)
* Randomisation test for PLS regression models

Preprocessing methods include:

* Mean centering, standardization and autoscaling
* Savitzky-Golay filter for smoothing and derivatives
* Standard Normal Variate for removing scatter effect from spectral data

More methods both for analysis and preprocessing are coming. Besides that, some extensions for the basic R plotting functionality have been also implemented and allow to do the following:

* Color grouping of objects with automatic color legend bar.
* Plot for several groups of objects with automatically calculated axes limits and plot legend.
* Two built-in color schemes — one is based on a diverging scheme from [Colorbrewer](http://colorbrewer2.org/) and the other one is a grayscale scheme.
* Very easy-to-use possibility to apply any user defined color scheme.  
* Possibility to show horizontal and vertical lines on the plot with automatically adjusted axes limits.

See `?mdatools` for more details.


## How to install

The package now is available from CRAN by usual installing procedure. However due to restrictions in CRAN politics regarding number of submissions (once in 3-4 month) only major releases will be published there. To get the latest release plase use GitHub sources. You can either [download](https://github.com/svkucheryavski/mdatools/releases) a zip-file with the source package and install it using the `install.packages` command, e.g. if the downloaded file is `mdatools_0.6.2.tar.gz` and it is located in a current working directory, just run the following:

```r
install.packages('mdatools_0.6.2.tar.gz')
```

If you have `devtools` package installed, the following command will install the latest release from the GitHub (do not forget to load the `devtools` package first):

```r
install_github('mdatools', username = 'svkucheryavski')
```
