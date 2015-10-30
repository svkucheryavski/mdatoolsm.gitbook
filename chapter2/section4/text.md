# Quantitative statistics

Most of the statistical functions can be also applied directly to the `mdadata` objects. Besides that, a few of additional methods have been implemented, including for example, `summary()`, which is an analogue of the same function in R. The default functions include: `mean()`, `std()`, `min()`, `max()`, `var()`, `cov()` and `corr()`.

The functions calculate statistics for each column. The result of calculations is also an object of dataset class.

```matlab
load people

% take only first six columns
data = people(:, [1:2 4:6]);

% calculate simple statistics and show result
show(mean(data))
show(std(data))
```

```
                     Variables
      Height  Weight  Shoesize   Age    Income
     ------- ------- --------- ----- ---------
Mean     173    64.5      39.9  34.4  2.74e+04



                      Variables
       Height  Weight  Shoesize   Age    Income
      ------- ------- --------- ----- ---------
Stdev    10.1    15.2       3.9  9.52  8.93e+03
```

The results of calculation can be concatenated into a single dataset:

```matlab
show([mean(data); std(data); var(data); min(data); max(data)])
```
```
                         Variables
          Height  Weight  Shoesize   Age    Income
         ------- ------- --------- ----- ---------
    Mean     173    64.5      39.9  34.4  2.74e+04
   Stdev    10.1    15.2       3.9  9.52  8.93e+03
Variance     101     231      15.2  90.6  7.97e+07
     Min     157      46        34    18   1.1e+04
     Max     198      92        48    55   4.5e+04
```

Calculation of covariance and correlation always results in a matrix.

```matlab
show(cov(data))
```
```
Covariance:

                             Variables
           Height    Weight  Shoesize       Age    Income
         -------- --------- --------- --------- ---------
  Height      101       147      37.7      23.1   2.7e+04
  Weight      147       231      57.4      36.8  4.55e+04
Shoesize     37.7      57.4      15.2        12  1.23e+04
     Age     23.1      36.8        12      90.6  7.52e+04
  Income  2.7e+04  4.55e+04  1.23e+04  7.52e+04  7.97e+07
```

```matlab
show(corr(data(:, [1 3])))
```
```
Correlation:

             Variables
          Height  Shoesize
         ------- ---------
  Height       1     0.961
Shoesize   0.961         1
```

The additional methods include calculation of percentiles, standard error, confidence intervals, one-sample t-test and summary statistics for a dataset.

```matlab
show(percentile(data, 5))
show(se(data))
show(ci(data))
show(ci(data, 0.01))

Percentiles:

                   Variables
    Height  Weight  Shoesize  Age    Income
   ------- ------- --------- ---- ---------
5%     158    46.5      34.5   19  1.12e+04



                           Variables
            Height  Weight  Shoesize   Age    Income
           ------- ------- --------- ----- ---------
Std. error    1.78    2.69     0.689  1.68  1.58e+03



Confidence intervals (95%):

                      Variables
       Height  Weight  Shoesize   Age    Income
      ------- ------- --------- ----- ---------
Lower     169      59      38.5    31  2.42e+04
Upper     177    69.9      41.3  37.9  3.07e+04



Confidence intervals (99%):

                      Variables
       Height  Weight  Shoesize   Age    Income
      ------- ------- --------- ----- ---------
Lower     168    57.1        38  29.8  2.31e+04
Upper     178    71.8      41.8  39.1  3.18e+04

show(ttest(data))
show(ttest(data(:, 'Height'), 170))

show(summary(data))

P-values for t-test (mu = 0):

                          Variables
            Height  Weight  Shoesize  Age  Income
           ------- ------- --------- ---- -------
 Left tail       1       1         1    1       1
Both tails       0       0         0    0       0
Right tail       0       0         0    0       0



P-values for t-test (mu = 170):
            Height
           -------
 Left tail   0.956
Both tails  0.0887
Right tail  0.0443



Summary statistics:

                       Variables
        Height  Weight  Shoesize   Age    Income
       ------- ------- --------- ----- ---------
   Min     157      46        34    18   1.1e+04
    Q1     164      50        36  26.5  1.95e+04
Median     174    64.5        40    34     3e+04
  Mean     173    64.5      39.9  34.4  2.74e+04
    Q3     180    80.5        43    41   3.4e+04
   Max     198      92        48    55   4.5e+04