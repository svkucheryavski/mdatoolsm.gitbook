# Projection on Latent Structures

[Projection on Latent Structures](https://en.wikipedia.org/wiki/Partial_least_squares_regression) also known as Partial Least Squares (PLS) is a linear regression method introduced and developed by Herman and Svante Wold for first multivariate data with a high degree of collinearity. The method aims, among others, at overcome the drawbacks of MLR and allows to make a linear regression model when number of objects is smaller than the number of variables.

PLS decomposes both $$X$$ and $$Y$$ space by projecting data points to a set of latent variables (PLS components or just components) similar to PCA decomposition:

$$
X = TP^T + E_X
Y = UQ^T + E_Y
$$

So there is a set of loadings $$(P,Q)$$, scores $$(T,U)$$ and residuals for each of the spaces. However in this case the direction of PLS components 