# Hiding and removing rows and columns

Rows and columns in the mdadata datasets can be excluded from calculations and other manipulations. The main idea is to give a tool which allows to exclude/hide part without actually removing it. It can be used, for possible outliers. Here we will show several examples on how this hiding works.

To exclude row or column can be done with methods `excluderows()` and `excludecols()` correspondingly. Number, sequence, names or sequence of names can be used as an argument.

```matlab
load people
show(people(1:5, :))
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
```

```matlab
people.excludecols({'Income', 'Beer', 'IQ'})
show(people(1:5, :))
```
```
People:
People dataset

                                   Variables
        Height  Weight  Hairleng  Shoesize  Age  Wine  Sex  Swim  Region
       ------- ------- --------- --------- ---- ----- ---- ----- -------
  Lars     198      92        -1        48   48   115   -1    98      -1
 Peter     184      84        -1        44   33   102   -1    92      -1
Rasmus     183      83        -1        44   37    98   -1    91      -1
  Lene     166      47        -1        36   32    78    1    75      -1
 Mette     170      60         1        38   23    99    1    81      -1
```

```matlab
people.excluderows(1)
show(people(1:5, :))
```
```
People:
People dataset

                                   Variables
        Height  Weight  Hairleng  Shoesize  Age  Wine  Sex  Swim  Region
       ------- ------- --------- --------- ---- ----- ---- ----- -------
 Peter     184      84        -1        44   33   102   -1    92      -1
Rasmus     183      83        -1        44   37    98   -1    91      -1
  Lene     166      47        -1        36   32    78    1    75      -1
 Mette     170      60         1        38   23    99    1    81      -1
 Gitte     172      64         1        39   24    91    1    82      -1
```

The excluded data is absolutely hidden for most of the operations, including mathematical calculations and plots.

```matlab
m = mean(people);
show(m)
```
```
                                   Variables
      Height  Weight  Hairleng  Shoesize  Age  Wine     Sex  Swim  Region
     ------- ------- --------- --------- ---- ----- ------- ----- -------
Mean     172    63.6    0.0323      39.6   34   132  0.0323    81  0.0323
```

One can print the names and numbers of excluded rows and columns. If several excluded rows or columns are successive, they will be shown as a sequence.

```matlab
people.showexcludedcols()
people.showexcludedrows()
```
```
Excluded columns: 
   Num	               Names
------	--------------------
   6:7	       'Income:Beer'
    12	                'IQ'

Excluded rows: 
 Num	                   Names
----	------------------------
   1	                  'Lars'
```

The excluded values can be unhidden as easily as hide.

```matlab
people.includecols('IQ')
people.includerows(1)

show(people(1:5, :))
```
```
People:
People dataset

                                      Variables
        Height  Weight  Hairleng  Shoesize  Age  Wine  Sex  Swim  Region   IQ
       ------- ------- --------- --------- ---- ----- ---- ----- ------- ----
  Lars     198      92        -1        48   48   115   -1    98      -1  100
 Peter     184      84        -1        44   33   102   -1    92      -1  130
Rasmus     183      83        -1        44   37    98   -1    91      -1  127
  Lene     166      47        -1        36   32    78    1    75      -1  112
 Mette     170      60         1        38   23    99    1    81      -1  110
```

If necessary, rows and/or columns can be removed completely from a dataset with methods `removerows()`and `removecols()`. They work similarly to the methods described above, but once a row or a column is removed it is not possible to undo this operation.
