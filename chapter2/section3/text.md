# Mathematical operations and functions

The datasets can be transposed and concatenated. If column names or row names in the concatenated datasets are not unique, this will be corrected by adding an additional letter to the names:


```matlab
load people

d = people(1:4, 1:5);
show(d')
```
```
People:
People dataset

                   Objects
          Lars  Peter  Rasmus  Lene
         ----- ------ ------- -----
  Height   198    184     183   166
  Weight    92     84      83    47
Hairleng    -1     -1      -1    -1
Shoesize    48     44      44    36
     Age    48     33      37    32
```

```matlab
show([d d])
```
```
                                              Variables
        Height  Weight  Hairleng  Shoesize  Age  VHeight  VWeight  VHairleng  VShoesize  VAge
       ------- ------- --------- --------- ---- -------- -------- ---------- ---------- -----
  Lars     198      92        -1        48   48      198       92         -1         48    48
 Peter     184      84        -1        44   33      184       84         -1         44    33
Rasmus     183      83        -1        44   37      183       83         -1         44    37
  Lene     166      47        -1        36   32      166       47         -1         36    32
```

```matlab
show([d; d])
```
```
                        Variables
         Height  Weight  Hairleng  Shoesize  Age
        ------- ------- --------- --------- ----
   Lars     198      92        -1        48   48
  Peter     184      84        -1        44   33
 Rasmus     183      83        -1        44   37
   Lene     166      47        -1        36   32
  OLars     198      92        -1        48   48
 OPeter     184      84        -1        44   33
ORasmus     183      83        -1        44   37
  OLene     166      47        -1        36   32
```

The `mdadata` objects supports most of the basic arithmetic operations as well as some functions directly, converting all names automatically:


```matlab
a = mdadata(reshape(1:15, 5, 3));
b = mdadata(reshape(15:-1:1, 5, 3));

show(a + b)
```
```
  Variables
   1   2   3
 --- --- ---
  16  16  16
  16  16  16
  16  16  16
  16  16  16
  16  16  16
```

```matlab
show(a - b)
```
```
   Variables
    1   2   3
 ---- --- ---
  -14  -4   6
  -12  -2   8
  -10   0  10
   -8   2  12
   -6   4  14
```

```matlab
show(a * 5)
```
```
  Variables
   1   2   3
 --- --- ---
   5  30  55
  10  35  60
  15  40  65
  20  45  70
  25  50  75
```

```matlab
show(a * b')
```
```
         Variables
    1    2    3    4    5
 ---- ---- ---- ---- ----
  130  112   94   76   58
  160  139  118   97   76
  190  166  142  118   94
  220  193  166  139  112
  250  220  190  160  130
```

```matlab
show(a .* b)
```
```
  Variables
   1   2   3
 --- --- ---
  15  60  55
  28  63  48
  39  64  39
  48  63  28
  55  60  15
```

```matlab
show(a ./ b)
```
```
       Variables
       1      2     3
 ------- ------ -----
  0.0667    0.6   2.2
   0.143  0.778     3
   0.231      1  4.33
   0.333   1.29     7
   0.455   1.67    15
```

Linear equations can be solved directly for mdadata objects.

```matlab
load people

X = people(:, {'Weight', 'Beer', 'Swim'});
y = people(:, 'Height');

b = X\y;
show(b)
```
```
         Height
       --------
Weight   -0.342
  Beer  -0.0147
  Swim     2.44
```

```matlab
show(X * b)
```
```
            Height
           -------
      Lars     201
     Peter     190
    Rasmus     189
      Lene     163
     Mette     172
     Gitte     173
      Jens     174
      Erik     172
     Lotte     169
     Heidi     168
       Kaj     187
     Gerda     151
      Anne     164
    Britta     162
    Magnus     181
    Casper     177
      Luka     192
  Federico     198
      Dona     166
  Fabrizia     164
      Lisa     153
    Benito     184
    Franko     179
Alessandro     174
   Leonora     164
  Giuliana     161
  Giovanni     174
  Leonardo     169
     Marta     166
   Rosetta     165
     Romeo     169
    Romina     162
```

The full list of the functions includes: `plus()`, `minus()`, `uminus()`, `times()`, `mtimes()`, `rdivide()`, `mrdivide()`, `ldivide()`, `mldivide()`, `round()`, `abs()`, `power()`, `sqrt()`, `log()`, and `exp()`.

```matlab
a = mdadata(reshape(1:15, 5, 3));
show(log(a))
```

```
      Variables
      1     2     3
 ------ ----- -----
      0  1.79   2.4
  0.693  1.95  2.48
    1.1  2.08  2.56
   1.39   2.2  2.64
   1.61   2.3  2.71
```

```matlab
show(exp(a))
```
```
         Variables
     1         2         3
 ----- --------- ---------
  2.72       403  5.99e+04
  7.39   1.1e+03  1.63e+05
  20.1  2.98e+03  4.42e+05
  54.6   8.1e+03   1.2e+06
   148   2.2e+04  3.27e+06
```

```matlab
show(power(a, 0.5))
```
```
     Variables
     1     2     3
 ----- ----- -----
     1  2.45  3.32
  1.41  2.65  3.46
  1.73  2.83  3.61
     2     3  3.74
  2.24  3.16  3.87
```

```matlab
show(round(a/2))
```
```
 Variables
  1  2  3
 -- -- --
  1  3  6
  1  4  6
  2  4  7
  2  5  7
  3  5  8
```

Please, be aware that if a calculation results in a complex number, it will be converted to real and method will show a warning:

```matlab
d = mdadata([-1 0.5; 1 0]);
show(log(d))
```
```
Warning: Complex values were obtained, converted to real. 


  Variables
  1       2
 -- -------
  0  -0.693
  0    -Inf
```

```matlab
show(sqrt(d))
```
```
Warning: Complex values were obtained, converted to real. 


 Variables
  1      2
 -- ------
  0  0.707
  1      0
```

As an extra example we will calculate an BMI (Body Mass Index) of the persons in our *People* data and add it as an extra column to the original dataset. As one can see all names remain correct after the calculations.

```matlab
load people

bmi = people(:, 'Weight') ./ (people(:, 'Height') / 100).^2;
bmi.colNames = {'BMI'};
newdata = [people bmi];

show(bmi(1:5));
```
```
         BMI
       -----
  Lars  23.5
 Peter  24.8
Rasmus  24.8
  Lene  17.1
 Mette  20.8
```

```matlab
show(newdata(1:5, :));
```
```
                                                Variables
        Height  Weight  Hairleng  Shoesize  Age   Income  Beer  Wine  Sex  Swim  Region   IQ   BMI
       ------- ------- --------- --------- ---- -------- ----- ----- ---- ----- ------- ---- -----
  Lars     198      92        -1        48   48  4.5e+04   420   115   -1    98      -1  100  23.5
 Peter     184      84        -1        44   33  3.3e+04   350   102   -1    92      -1  130  24.8
Rasmus     183      83        -1        44   37  3.4e+04   320    98   -1    91      -1  127  24.8
  Lene     166      47        -1        36   32  2.8e+04   270    78    1    75      -1  112  17.1
 Mette     170      60         1        38   23    2e+04   312    99    1    81      -1  110  20.8
```

Calculation of size and length can be done using the same way as with matrices, plus there are two properties nrow and ncol. Function numel() was not overrided due to some technical reasons, so it will return 1 instead of number of values (use numel(d.values) if needed):

disp(people.nRows)
disp(people.nCols)
disp(size(people))
disp(length(people))
disp(numel(people))
    32

    12

    32    12

    32

     1
