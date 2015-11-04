# Data preprocessing

The toolbox has a special object, which can be used to build a sequence of preprocessing methods and then use it either for preprocessing of original data or provide it as a preprocessing module to a model. In the latter case, every time the model is applied to a new data the data will be preprocessed first. In this chapter a brief description of the methods with several examples will be shown.

The general syntax is following. First one creates and empty preprocessing object. Then add or remove methods by using methods `add('name', param1, param2, ...)` or `remove('name', param1, param2, ...`). Let us start with simple preprocessing, which include centering and standardization.

## Autoscaling

Autoscaling consists of two steps. First step is *centering* (or, more precise, *mean centering*) when center of a data cloud in variable space is moved to an origin. Mathematically it is done by subtracting mean from the data values separately for every variable. Second step is *standardization* (or *scaling*) when data values are divided to standard deviation so the variables have unit variance. 

Here are some examples how apply these two operations in *mdatools* (in all plots axes have the same limits to show the effect of preprocessing). We start with creating object with centering.

```matlab
load(people)

% create a preprocessing object only for centering
p = prep();
p.add('center');

% show information about the object
show(p);
```
```
Preprocessing ("prep") object
methods included: 1
1. center (mean centering)

Use "obj.add(name, properties)" to add a new method.
Use "obj.remove(n)" to remove a method from the list.

See "help prep" for list of available methods.
```
Method `show()`displays the list of added preprocessing methods, their order as well as some help information. Now we can apply the preprocessing methods of the created object to the data. In order to compare the original and preprocessed data we create a copy for the dataset.
```matlab

pdata = copy(data);

p.apply(pdata);

figure

subplot 121
scatter(data)
title('Original data')

subplot 122
scatter(pdata)
title('After centering')
```


Centered (left) and autoscaled (right) data.

One can also use arbitrary values to center or/and scale the data, in this case use sequence or vector with these values should be provided as an argument for center or scale. Here is an example for median centering:

# median centering
mcdata = prep.autoscale(odata, center = apply(odata, 2, median))
Correction of spectral baseline

Baseline correction methods so far include Standard Normal Variate (SNV) and Multiplicative Scatter Correction (MSC).

SNV is a very simple procedure aiming first of all to remove additive and multiplicative scatter effects from Vis/NIR spectra. It is applied to every individual spectrum by subtracting its average and dividing its standard deviation from all spectral values. Here is an example:

# load UV/Vis spectra from Simdata
data(simdata)
ospectra = simdata$spectra.c

# apply SNV and show the spectra
pspectra = prep.snv(ospectra)

par(mfrow = c(2, 1))
matplot(t(ospectra), type = 'l', col = 'blue', lty = 1, main = 'Original')
matplot(t(pspectra), type = 'l', col = 'blue', lty = 1, main = 'after SNV')
Original (left) and SNV processed (right) spectra.

Multiplicative Scatter Correction does the same as SNV but in a different way. First it calculates a mean spectrum for the whole set (mean spectrum can be also provided as an extra argument). Then for each individual spectrum it makes a line fit for the spectral values and the mean spectrum. The coefficients of the line, intercept and slope, are used to correct the additive and multiplicative effects correspondingly.

The prep.msc() function returns a list for corrected spectra and the mean spectrum calculated for the original spectral data, so it can be reused later.

# apply MSC and and get the preprocessed spectra
res = prep.msc(ospectra)
pspectra = res$cspectra;

# show the result
par(mfrow = c(2, 1))
matplot(t(ospectra), type = 'l', col = 'blue', lty = 1, main = 'Original')
matplot(t(pspectra), type = 'l', col = 'blue', lty = 1, main = 'After MSC')
Original (left) and MSC processed (right) spectra.

Smoothing and derivatives

Savitzky-Golay filter is used to smooth signals and calculate derivatives. The filter has three arguments: a width of the filter (width), a polynomial order (porder) and the derivative order (dorder). If the derivative order is zero (default value) then only smoothing will be performed.


# add random noise to the spectra
nspectra = ospectra + 0.025 * matrix(rnorm(length(ospectra)), dim(ospectra))

# apply SG filter for smoothing
pspectra = prep.savgol(nspectra, width = 15, porder = 1)

# apply SG filter for smoothing and take a first derivative
dpspectra = prep.savgol(nspectra, width = 15, porder = 1, dorder = 1)

# show results
par(mfrow = c(2, 2))
matplot(t(ospectra), type = 'l', col = 'blue', lty = 1, main = 'Original')
matplot(t(nspectra), type = 'l', col = 'blue', lty = 1, main = 'Noise added')
matplot(t(pspectra), type = 'l', col = 'blue', lty = 1, main = 'SG smoothing')
matplot(t(dpspectra), type = 'l', col = 'blue', lty = 1, main = '1st derivative')
Original and noisy spectra (top) and results of SG preprocessing (bottom).