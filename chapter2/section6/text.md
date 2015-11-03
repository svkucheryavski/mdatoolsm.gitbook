# Factors and groups

Dataset class has a possibility to mark one or several columns as factors. Factor is a qualitative variable, it has fixed values (levels) and normally can not be treated as quantitative variable.

Factors can be used for splitting datasets, combine data values into groups, calculate statistics and show plots for the groups. Besides that, one can calculate qualitative statistics for factors, such as frequencies, contingency table, chi-square test for association and so on. All arithmetic operators and functions as well as methods for quantitative statistic will ignore factors in calculations.

To add a factor you need to have a column in the dataset with discrete numeric values, such as variables Sex and Region in the People data. It is possible to define text values for each of the levels. Keep level names as simple as possible and avoid using spaces and other special symbols. The column name for a factor is marked with an asterisk when dataset is displaying.

```matlab
load people

d = people(1:8, :);
show(d)
```
```
People:
People dataset

                                             Variables
        Height  Weight  Hairleng  Shoesize  Age   Income  Beer  Wine  Sex  Swim  Region   IQ
       ------- ------- --------- --------- ---- -------- ----- ----- ---- ----- ------- ----
  Lars     198      92        -1        48   48  4.5e+04   420   115   -1    98      -1  100
 Peter     184      84        -1        44   33  3.3e+04   350   102   -1    92      -1  130
Rasmus     183      83        -1        44   37  3.4e+04   320    98   -1    91      -1  127
  Lene     166      47        -1        36   32  2.8e+04   270    78    1    75      -1  112
 Mette     170      60         1        38   23    2e+04   312    99    1    81      -1  110
 Gitte     172      64         1        39   24  2.2e+04   308    91    1    82      -1  102
  Jens     182      80        -1        42   35    3e+04   398    65   -1    85      -1  140
  Erik     180      80        -1        43   36    3e+04   388    63   -1    84      -1  129
```

Let us make 'Sex' as a factor and display the data again:

```matlab
d.factor('Sex');
show(d)
```
```
People:
People dataset

                                              Variables
        Height  Weight  Hairleng  Shoesize  Age   Income  Beer  Wine  * Sex  Swim  Region   IQ
       ------- ------- --------- --------- ---- -------- ----- ----- ------ ----- ------- ----
  Lars     198      92        -1        48   48  4.5e+04   420   115     -1    98      -1  100
 Peter     184      84        -1        44   33  3.3e+04   350   102     -1    92      -1  130
Rasmus     183      83        -1        44   37  3.4e+04   320    98     -1    91      -1  127
  Lene     166      47        -1        36   32  2.8e+04   270    78      1    75      -1  112
 Mette     170      60         1        38   23    2e+04   312    99      1    81      -1  110
 Gitte     172      64         1        39   24  2.2e+04   308    91      1    82      -1  102
  Jens     182      80        -1        42   35    3e+04   398    65     -1    85      -1  140
  Erik     180      80        -1        43   36    3e+04   388    63     -1    84      -1  129
```

The column *Sex* now is marked with an asterisk. Let us mark two columns as factors and provide text labels for the levels:

```matlab
d.factor('Sex', {'Male', 'Female'})
d.factor('Hairleng', {'Short', 'Long'})
show(d)
```
```
People:
People dataset

                                                Variables
        Height  Weight  * Hairleng  Shoesize  Age   Income  Beer  Wine   * Sex  Swim  Region   IQ
       ------- ------- ----------- --------- ---- -------- ----- ----- ------- ----- ------- ----
  Lars     198      92       Short        48   48  4.5e+04   420   115    Male    98      -1  100
 Peter     184      84       Short        44   33  3.3e+04   350   102    Male    92      -1  130
Rasmus     183      83       Short        44   37  3.4e+04   320    98    Male    91      -1  127
  Lene     166      47       Short        36   32  2.8e+04   270    78  Female    75      -1  112
 Mette     170      60        Long        38   23    2e+04   312    99  Female    81      -1  110
 Gitte     172      64        Long        39   24  2.2e+04   308    91  Female    82      -1  102
  Jens     182      80       Short        42   35    3e+04   398    65    Male    85      -1  140
  Erik     180      80       Short        43   36    3e+04   388    63    Male    84      -1  129
```

As you will in the example below *Sex* and *Hairleng* are now ignored in calculations.

```matlab
show(mean(d))
show(d * 10)
```
```
                                     Variables
      Height  Weight  Shoesize   Age    Income  Beer  Wine  Swim  Region   IQ
     ------- ------- --------- ----- --------- ----- ----- ----- ------- ----
Mean     179    73.8      41.8  33.5  3.02e+04   346  88.9    86      -1  119



                                             Variables
          Height  Weight  Shoesize  Age   Income      Beer      Wine  Swim  Region        IQ
       --------- ------- --------- ---- -------- --------- --------- ----- ------- ---------
  Lars  1.98e+03     920       480  480  4.5e+05   4.2e+03  1.15e+03   980     -10     1e+03
 Peter  1.84e+03     840       440  330  3.3e+05   3.5e+03  1.02e+03   920     -10   1.3e+03
Rasmus  1.83e+03     830       440  370  3.4e+05   3.2e+03       980   910     -10  1.27e+03
  Lene  1.66e+03     470       360  320  2.8e+05   2.7e+03       780   750     -10  1.12e+03
 Mette   1.7e+03     600       380  230    2e+05  3.12e+03       990   810     -10   1.1e+03
 Gitte  1.72e+03     640       390  240  2.2e+05  3.08e+03       910   820     -10  1.02e+03
  Jens  1.82e+03     800       420  350    3e+05  3.98e+03       650   850     -10   1.4e+03
  Erik   1.8e+03     800       430  360    3e+05  3.88e+03       630   840     -10  1.29e+03
```

One can also convert a factor back to a quantitative variable by using method `notfactor()`.
 
```matlab
d.notfactor('Sex');

% now 'Sex' is used for calculations again
show(d)
show(mean(d))
```
```
People:
People dataset

                                              Variables
        Height  Weight  * Hairleng  Shoesize  Age   Income  Beer  Wine  Sex  Swim  Region   IQ
       ------- ------- ----------- --------- ---- -------- ----- ----- ---- ----- ------- ----
  Lars     198      92       Short        48   48  4.5e+04   420   115   -1    98      -1  100
 Peter     184      84       Short        44   33  3.3e+04   350   102   -1    92      -1  130
Rasmus     183      83       Short        44   37  3.4e+04   320    98   -1    91      -1  127
  Lene     166      47       Short        36   32  2.8e+04   270    78    1    75      -1  112
 Mette     170      60        Long        38   23    2e+04   312    99    1    81      -1  110
 Gitte     172      64        Long        39   24  2.2e+04   308    91    1    82      -1  102
  Jens     182      80       Short        42   35    3e+04   398    65   -1    85      -1  140
  Erik     180      80       Short        43   36    3e+04   388    63   -1    84      -1  129



                                        Variables
      Height  Weight  Shoesize   Age    Income  Beer  Wine    Sex  Swim  Region   IQ
     ------- ------- --------- ----- --------- ----- ----- ------ ----- ------- ----
Mean     179    73.8      41.8  33.5  3.02e+04   346  88.9  -0.25    86      -1  119
```

Factors can be used to group your data according to combinations of the factor levels. Method `getgroups()` creates a dataset with binary values (0, 1) for each of the possible combinations of selected factors. Even though there is normally no need to use this method directly, it gives a good idea how the splitting is made.

```matlab
d = people(1:10, :);
d.factor('Sex', {'Male', 'Female'})
d.factor('Hairleng', {'Short', 'Long'})

show(d.getgroups({'Sex', 'Hairleng'}))
```
```
                 Groups (Sex, Hairleng)
        Male, Short  Female, Short  Female, Long
       ------------ -------------- -------------
  Lars            1              0             0
 Peter            1              0             0
Rasmus            1              0             0
  Lene            0              1             0
 Mette            0              0             1
 Gitte            0              0             1
  Jens            1              0             0
  Erik            1              0             0
 Lotte            0              0             1
 Heidi            0              0             1
```

The `getgroups()` is widely used in statistic and graphical methods. Here we will show how to use groups for calculation of quantitative statistics and in the next section graphical methods will be discussed.

The idea is rather simple, if one provide a dataset with one or several factors as a second argument of any statistical method, the statistics will be calculated for first column of original data and the values from this column will be split into the groups according to combination of the factor levels. Here is an example:


```matlab
people.factor('Sex', {'Male', 'Female'});
people.factor('Region', {'A', 'B'});
d = people(8:20, :);
show(d)
```
```
People:
People dataset

                                                  Variables
          Height  Weight  Hairleng  Shoesize  Age    Income  Beer  Wine   * Sex  Swim  * Region   IQ
         ------- ------- --------- --------- ---- --------- ----- ----- ------- ----- --------- ----
    Erik     180      80        -1        43   36     3e+04   388    63    Male    84         A  129
   Lotte     169      51         1        36   24   2.3e+04   250    89  Female    78         A   98
   Heidi     168      52         1        37   27  2.35e+04   260    86  Female    78         A  100
     Kaj     183      81        -1        42   37   3.5e+04   345    45    Male    90         A  105
   Gerda     157      47         1        36   32   3.2e+04   235    92  Female    70         A  127
    Anne     164      50         1        38   41   3.4e+04   255   134  Female    76         A  101
  Britta     162      49         1        37   40   3.4e+04   265   124  Female    75         A  108
  Magnus     180      82        -1        44   43   3.7e+04   355    82    Male    88         A  109
  Casper     180      81        -1        44   46   4.2e+04   362    90    Male    86         A  113
    Luka     185      82        -1        45   26   1.6e+04   295   180    Male    92         B  109
Federico     187      84        -1        46   27  1.65e+04   299   178    Male    95         B  119
    Dona     168      50         1        37   49   3.4e+04   170   162  Female    76         B  135
Fabrizia     166      49         1        36   21   1.4e+04   150   245  Female    75         B  123
```

```matlab
% just a normal use of mean for a column
m = mean(d(:, 'Height'));
show(m)

% grouping factors are provided
m = mean(d(:, 'Height'), d(:, {'Sex'}));
show(m)
```
```

      Height
     -------
Mean     173



Height:

      Groups (Sex)
      Male  Female
     ----- -------
Mean   182     165
```

If a method requires additional parameters, they should be specified after dataset with factors.

```matlab
p = percentile(d(:, 'Height'), 25);
show(p)

p = percentile(d(:, 'Height'), d(:, 'Sex'), 25);
show(p)
```
```
Percentiles:
     Height
    -------
25%     165


Percentiles for Height:

     Groups (Sex)
     Male  Female
    ----- -------
25%   180     162
```

Several factors can be used at the same time.

```matlab
s = ci(d(:, 'Height'), d(:, {'Sex', 'Region'}));
show(s)
```
```
Confidence intervals (95%) for Height:

                Groups (Sex, Region)
       Male, A  Male, B  Female, A  Female, B
      -------- -------- ---------- ----------
Lower      178      173        158        154
Upper      183      199        170        180
```


```matlab
s = ci(d(:, 'Height'), d(:, {'Sex', 'Region'}), 0.10);
show(s)
```
```
Confidence intervals (90%) for Height:

                Groups (Sex, Region)
       Male, A  Male, B  Female, A  Female, B
      -------- -------- ---------- ----------
Lower      179      180        159        161
Upper      183      192        169        173
```

## Qualitative statistics

Factors can be also used for calculation of qualitative statistics, including frequencies and relative frequencies (proportions) of factor levels, confidence interval for proportions, contingency tables for combination of two factors, chi square test for association of two factors, standardized residuals for observed and expected frequencies.

Let's take a part people data, so number of males and females, is different.

```matlab
load people
data = people(6:20, {'Sex', 'Region'});
data.factor('Sex', {'Male', 'Female'})
data.factor('Region', {'A', 'B'})
```
Here is an example on how to calculate frequency table, which includes the observed frequencies for each level, relative frequencies (proportions), and confidence interval for the proportions. Optional second argument is significance level (alpha) for the interval.

```matlab
f = freq(data(:, 'Sex'));
show(f)
```
```matlab
f = freq(data(:, 'Sex'), 0.1);
show(f)
```
```
Observed frequencies:

                  Sex
              Male  Female
            ------ -------
       Freq      7       8
  Rel. Freq  0.467   0.533
Lower (95%)  0.214   0.281
Upper (95%)  0.719   0.786
```

```matlab
f = freq(data(:, 'Sex'), 0.1);
show(f)
```
```
Observed frequencies:

                  Sex
              Male  Female
            ------ -------
       Freq      7       8
  Rel. Freq  0.467   0.533
Lower (90%)  0.255   0.321
Upper (90%)  0.679   0.745
```

For investigation of association between two factors one can calculate the contingency table.

```matlab
ct = crosstable(data);
show(ct)
```
```
Contingency table (Region, Sex):

            Sex
     Male  Female  Sum
    ----- ------- ----
  A     5       6   11
  B     2       2    4
Sum     7       8   15
```

As well as to use the chi-square test for association and calculate standardized residuals.

```matlab
ch = chi2test(data);
show(ch)
```
```
Chi2 test (Sex, Region):
      Statistics
     -----------
   p        0.56
chi2      0.0244
```

```matlab
res = crossresid(data);
show(res)
```
```
Standardized residuals (Region, Sex):

        Sex
     Male  Female
  ------- -------
A  -0.156   0.156
B   0.156  -0.156
```
