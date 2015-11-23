# Discrimination of data with PLS-DA

The PLS regression method, described in the [previous chapter](chapter6/text.md), can also be used for classification (or, more precise, *discrimination*) of multivariate data. The general idea is rather simple:

1. Use a categorical binary variable, which have values +1 for objects, belonging to a particular class, and –1 for objects, which are not from the class, as a response in calibration set.
2. Create a PLS-regression model as usual, using the response values defined above.
3. Make predictions. If a predicted response value is above or equal to 0, the corresponding object is considered to be from the class, if not, the object is rejected as not the class member.

So in fact PLS-DA is a PLS with an extra step — classification by using a threshold for predicted y-values. It means that a PLS-DA model as well as PLS-DA results inherit all methods and properties from the conventional PLS objects. In this chapter we will thefroe focusing on the extra options and methods, available exclusively for PLS-DA.

It must be noted that PLS-DA in general supports multiclass classification, when one provide the binary values in several columns (one for each class). However it is not recommended to do it (see e.g. explanation here) and better create several one-class PLS-DA models instead of one for multiple classes. 

## Calibration of PLS-DA model

The biggest difference with PLS here is how to provide proper values for responses. There are two possibilities. First, is to use a dataset with single factor column and specify either a level number or a label for the level as a class name. Second is to provide a vector with logical values (true for class members and false for strangers) and a class name. In the code below we create PLS-DA models for discrimination between Scandinavians and the others (in our case Mediterraneans, since we do not have any other regions) in the *People* data. 

First we need to load the dataset.
```matlab
load('people')
```

Here is how to create the model using factors
```matlab
X = copy(people);
X.removecols('Region');

c = people('Region');
c.factor(1, {'A', 'B'});

m1 = mdaplsda(X, c, 'A', 3, 'Scale', 'on');
```

And here how to do the same using logical values.
```matlab
X = copy(people);
X.removecols('Region');

c = people(:, 'Region') == -1;

m1 = mdaplsda(X, c, 'A', 3, 'Scale', 'on');
```

The result will be absolutely the same.