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

## 