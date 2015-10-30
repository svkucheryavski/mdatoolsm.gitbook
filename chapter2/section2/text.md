# Sorting data and making subsets

In this section and onward we will use a *People* dataset instead of generating numbers. The dataset consists of measurements of 12 variables done for 32 persons (16 males and 16 females, half from Scandinavia, half from Mediterranean region). The variables include height, weight, shoe size, income, beer and wine consumption and so on. For details, please, see K. Esbensen. *Multivariate data analysis in practice.* Camo, 2005.

The data can be sorted using one or several columns:

```matlab
load people
show(people)
```
```
People:
People dataset

                                                  Variables
            Height  Weight  Hairleng  Shoesize  Age    Income  Beer  Wine  Sex  Swim  Region   IQ
           ------- ------- --------- --------- ---- --------- ----- ----- ---- ----- ------- ----
      Lars     198      92        -1        48   48   4.5e+04   420   115   -1    98      -1  100
     Peter     184      84        -1        44   33   3.3e+04   350   102   -1    92      -1  130
    Rasmus     183      83        -1        44   37   3.4e+04   320    98   -1    91      -1  127
      Lene     166      47        -1        36   32   2.8e+04   270    78    1    75      -1  112
     Mette     170      60         1        38   23     2e+04   312    99    1    81      -1  110
     Gitte     172      64         1        39   24   2.2e+04   308    91    1    82      -1  102
      Jens     182      80        -1        42   35     3e+04   398    65   -1    85      -1  140
      Erik     180      80        -1        43   36     3e+04   388    63   -1    84      -1  129
     Lotte     169      51         1        36   24   2.3e+04   250    89    1    78      -1   98
     Heidi     168      52         1        37   27  2.35e+04   260    86    1    78      -1  100
       Kaj     183      81        -1        42   37   3.5e+04   345    45   -1    90      -1  105
     Gerda     157      47         1        36   32   3.2e+04   235    92    1    70      -1  127
      Anne     164      50         1        38   41   3.4e+04   255   134    1    76      -1  101
    Britta     162      49         1        37   40   3.4e+04   265   124    1    75      -1  108
    Magnus     180      82        -1        44   43   3.7e+04   355    82   -1    88      -1  109
    Casper     180      81        -1        44   46   4.2e+04   362    90   -1    86      -1  113
      Luka     185      82        -1        45   26   1.6e+04   295   180   -1    92       1  109
  Federico     187      84        -1        46   27  1.65e+04   299   178   -1    95       1  119
      Dona     168      50         1        37   49   3.4e+04   170   162    1    76       1  135
  Fabrizia     166      49         1        36   21   1.4e+04   150   245    1    75       1  123
      Lisa     158      46         1        34   30   1.8e+04   120   120    1    70       1  119
    Benito     177      65        -1        41   26   1.8e+04   209   160   -1    86       1  120
    Franko     180      72        -1        43   33   1.9e+04   236   175   -1    85       1  115
Alessandro     181      75        -1        43   42   3.1e+04   198   161   -1    83       1  105
   Leonora     163      50         1        36   18   1.1e+04   143   136    1    75       1  102
  Giuliana     162      50         1        36   20  1.15e+04   133   146    1    74       1  132
  Giovanni     176      68        -1        42   50   3.6e+04   195   177   -1    82       1   96
  Leonardo     175      67         1        42   55   3.8e+04   185   187   -1    80       1  105
     Marta     165      51         1        36   36   2.6e+04   121   129    1    76       1  126
   Rosetta     161      48         1        35   41  3.15e+04   116   196    1    75       1  120
     Romeo     178      75        -1        42   30   2.4e+04   203   208   -1    81       1  118
    Romina     160      48         1        35   40   3.1e+04   118   198    1    74       1  129
```


```matlab
people.sort('Sex')
show(people)
```
```
People:
People dataset

                                                  Variables
            Height  Weight  Hairleng  Shoesize  Age    Income  Beer  Wine  Sex  Swim  Region   IQ
           ------- ------- --------- --------- ---- --------- ----- ----- ---- ----- ------- ----
      Lars     198      92        -1        48   48   4.5e+04   420   115   -1    98      -1  100
     Peter     184      84        -1        44   33   3.3e+04   350   102   -1    92      -1  130
    Rasmus     183      83        -1        44   37   3.4e+04   320    98   -1    91      -1  127
    Magnus     182      80        -1        42   35     3e+04   398    65   -1    85      -1  140
    Casper     180      80        -1        43   36     3e+04   388    63   -1    84      -1  129
    Benito     183      81        -1        42   37   3.5e+04   345    45   -1    90      -1  105
  Leonardo     180      82        -1        44   43   3.7e+04   355    82   -1    88      -1  109
     Romeo     180      81        -1        44   46   4.2e+04   362    90   -1    86      -1  113
      Lene     185      82        -1        45   26   1.6e+04   295   180   -1    92       1  109
     Mette     187      84        -1        46   27  1.65e+04   299   178   -1    95       1  119
     Gerda     177      65        -1        41   26   1.8e+04   209   160   -1    86       1  120
      Anne     180      72        -1        43   33   1.9e+04   236   175   -1    85       1  115
    Britta     181      75        -1        43   42   3.1e+04   198   161   -1    83       1  105
      Lisa     176      68        -1        42   50   3.6e+04   195   177   -1    82       1   96
   Leonora     175      67         1        42   55   3.8e+04   185   187   -1    80       1  105
   Rosetta     178      75        -1        42   30   2.4e+04   203   208   -1    81       1  118
      Jens     166      47        -1        36   32   2.8e+04   270    78    1    75      -1  112
      Erik     170      60         1        38   23     2e+04   312    99    1    81      -1  110
       Kaj     172      64         1        39   24   2.2e+04   308    91    1    82      -1  102
      Luka     169      51         1        36   24   2.3e+04   250    89    1    78      -1   98
  Federico     168      52         1        37   27  2.35e+04   260    86    1    78      -1  100
    Franko     157      47         1        36   32   3.2e+04   235    92    1    70      -1  127
Alessandro     164      50         1        38   41   3.4e+04   255   134    1    76      -1  101
  Giovanni     162      49         1        37   40   3.4e+04   265   124    1    75      -1  108
     Gitte     168      50         1        37   49   3.4e+04   170   162    1    76       1  135
     Lotte     166      49         1        36   21   1.4e+04   150   245    1    75       1  123
     Heidi     158      46         1        34   30   1.8e+04   120   120    1    70       1  119
      Dona     163      50         1        36   18   1.1e+04   143   136    1    75       1  102
  Fabrizia     162      50         1        36   20  1.15e+04   133   146    1    74       1  132
  Giuliana     165      51         1        36   36   2.6e+04   121   129    1    76       1  126
     Marta     161      48         1        35   41  3.15e+04   116   196    1    75       1  120
    Romina     160      48         1        35   40   3.1e+04   118   198    1    74       1  129

```

```matlab
people.sort({'Sex', 'Region'}, 'descend')
show(people)
```
```
People:
People dataset

                                                  Variables
            Height  Weight  Hairleng  Shoesize  Age    Income  Beer  Wine  Sex  Swim  Region   IQ
           ------- ------- --------- --------- ---- --------- ----- ----- ---- ----- ------- ----
      Lars     168      50         1        37   49   3.4e+04   170   162    1    76       1  135
     Peter     166      49         1        36   21   1.4e+04   150   245    1    75       1  123
    Rasmus     158      46         1        34   30   1.8e+04   120   120    1    70       1  119
      Jens     163      50         1        36   18   1.1e+04   143   136    1    75       1  102
      Erik     162      50         1        36   20  1.15e+04   133   146    1    74       1  132
       Kaj     165      51         1        36   36   2.6e+04   121   129    1    76       1  126
    Magnus     161      48         1        35   41  3.15e+04   116   196    1    75       1  120
    Casper     160      48         1        35   40   3.1e+04   118   198    1    74       1  129
      Luka     166      47        -1        36   32   2.8e+04   270    78    1    75      -1  112
  Federico     170      60         1        38   23     2e+04   312    99    1    81      -1  110
    Benito     172      64         1        39   24   2.2e+04   308    91    1    82      -1  102
    Franko     169      51         1        36   24   2.3e+04   250    89    1    78      -1   98
Alessandro     168      52         1        37   27  2.35e+04   260    86    1    78      -1  100
  Giovanni     157      47         1        36   32   3.2e+04   235    92    1    70      -1  127
  Leonardo     164      50         1        38   41   3.4e+04   255   134    1    76      -1  101
     Romeo     162      49         1        37   40   3.4e+04   265   124    1    75      -1  108
      Lene     185      82        -1        45   26   1.6e+04   295   180   -1    92       1  109
     Mette     187      84        -1        46   27  1.65e+04   299   178   -1    95       1  119
     Gitte     177      65        -1        41   26   1.8e+04   209   160   -1    86       1  120
     Lotte     180      72        -1        43   33   1.9e+04   236   175   -1    85       1  115
     Heidi     181      75        -1        43   42   3.1e+04   198   161   -1    83       1  105
     Gerda     176      68        -1        42   50   3.6e+04   195   177   -1    82       1   96
      Anne     175      67         1        42   55   3.8e+04   185   187   -1    80       1  105
    Britta     178      75        -1        42   30   2.4e+04   203   208   -1    81       1  118
      Dona     198      92        -1        48   48   4.5e+04   420   115   -1    98      -1  100
  Fabrizia     184      84        -1        44   33   3.3e+04   350   102   -1    92      -1  130
      Lisa     183      83        -1        44   37   3.4e+04   320    98   -1    91      -1  127
   Leonora     182      80        -1        42   35     3e+04   398    65   -1    85      -1  140
  Giuliana     180      80        -1        43   36     3e+04   388    63   -1    84      -1  129
     Marta     183      81        -1        42   37   3.5e+04   345    45   -1    90      -1  105
   Rosetta     180      82        -1        44   43   3.7e+04   355    82   -1    88      -1  109
    Romina     180      81        -1        44   46   4.2e+04   362    90   -1    86      -1  113
```

Making subsets is as easy as with matrices, just specify indices for rows and columns:

```matlab
show(people([1, 2], :))
```
```
People:
People dataset

                                            Variables
       Height  Weight  Hairleng  Shoesize  Age   Income  Beer  Wine  Sex  Swim  Region   IQ
      ------- ------- --------- --------- ---- -------- ----- ----- ---- ----- ------- ----
 Lars     198      92        -1        48   48  4.5e+04   420   115   -1    98      -1  100
Peter     184      84        -1        44   33  3.3e+04   350   102   -1    92      -1  130

```

```matlab
show(people(1:3, 1:2:end-2))
```
```
People:
People dataset

                   Variables
        Height  Hairleng  Age  Beer  Sex
       ------- --------- ---- ----- ----
  Lars     198        -1   48   420   -1
 Peter     184        -1   33   350   -1
Rasmus     183        -1   37   320   -1
```

In addition to that, `mdadata` objects can be also subset by using column and row names, either one or several, combined to a cell array.

```matlab
show(people(1:5, 'Height'))
```
```
People:
People dataset
        Height
       -------
  Lars     198
 Peter     184
Rasmus     183
  Lene     166
 Mette     170
```

```matlab
show(people('Lars', :))
```
```
People:
People dataset

                                           Variables
      Height  Weight  Hairleng  Shoesize  Age   Income  Beer  Wine  Sex  Swim  Region   IQ
     ------- ------- --------- --------- ---- -------- ----- ----- ---- ----- ------- ----
Lars     198      92        -1        48   48  4.5e+04   420   115   -1    98      -1  100

```

```matlab
show(people({'Lars', 'Lene'}, {'Height', 'Weight'}))
```
```
People:
People dataset

        Variables
      Height  Weight
     ------- -------
Lars     198      92
Lene     166      47
```

Names can also be used to specify a sequence of columns or rows:

```matlab 
show(people(1:3, 'Height:Income'))
```
```
People:
People dataset

                           Variables
        Height  Weight  Hairleng  Shoesize  Age   Income
       ------- ------- --------- --------- ---- --------
  Lars     198      92        -1        48   48  4.5e+04
 Peter     184      84        -1        44   33  3.3e+04
Rasmus     183      83        -1        44   37  3.4e+04
```

```matlab
show(people('Lars:Lene', :))
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
```

```matlab
show(people('Lars:Lene', 'Height:Income'))
```
```
People:
People dataset

                           Variables
        Height  Weight  Hairleng  Shoesize  Age   Income
       ------- ------- --------- --------- ---- --------
  Lars     198      92        -1        48   48  4.5e+04
 Peter     184      84        -1        44   33  3.3e+04
Rasmus     183      83        -1        44   37  3.4e+04
  Lene     166      47        -1        36   32  2.8e+04
```

Be sure that you use correct column names, not the ones that were specified for printing or plotting. Check `data.colNames` if you have doubts.

```matlab
d = mdadata([180 85; 165 55], {}, {'Height (cm)', 'Body mass (kg)'});

disp('Column names are:')
disp(d.colNames);

% correct name
show(d(:, 'Bodymass'))

% wrong name
try
   show(d(:, 'Body mass (kg)'))
catch e
   disp(e.message)
end
```
```
Column names are:
    'Height'    'Bodymass'


  Body mass (kg)
 ---------------
              85
              55

Wrong values for column indices!
```

Last but not least, one can use logical expressions with columns to make subsets. In this case the logical expression must be written as a text string and be used instead of row indices. In the expression you can use column names or numbers, in the latter case they should be specified with leading dollar sign: `'$1'`, `'$15'` and so on. Here are some examples:

```matlab
show(people('Sex == 1', 1:4));
```
```
People:
People dataset

                      Variables
          Height  Weight  Hairleng  Shoesize
         ------- ------- --------- ---------
    Lene     166      47        -1        36
   Mette     170      60         1        38
   Gitte     172      64         1        39
   Lotte     169      51         1        36
   Heidi     168      52         1        37
   Gerda     157      47         1        36
    Anne     164      50         1        38
  Britta     162      49         1        37
    Dona     168      50         1        37
Fabrizia     166      49         1        36
    Lisa     158      46         1        34
 Leonora     163      50         1        36
Giuliana     162      50         1        36
   Marta     165      51         1        36
 Rosetta     161      48         1        35
  Romina     160      48         1        35
```

```matlab
show(people('Sex == 1 & Weight > 60', 1:4));
```
```
People:
People dataset

                   Variables
       Height  Weight  Hairleng  Shoesize
      ------- ------- --------- ---------
Gitte     172      64         1        39
```

```matlab
show(people('$1 < 180 & $3 == -1', 1:4));
```
```
People:
People dataset

                      Variables
          Height  Weight  Hairleng  Shoesize
         ------- ------- --------- ---------
    Lene     166      47        -1        36
  Benito     177      65        -1        41
Giovanni     176      68        -1        42
   Romeo     178      75        -1        42
```

function `find()` can be used to get indices of rows, which meet logical conditions.

```matlab
i = find(people, 'Sex == 1 & Region == -1');
disp(people.rowNames(i)');
```
```
  Columns 1 through 7

    'Lene'    'Mette'    'Gitte'    'Lotte'    'Heidi'    'Gerda'    'Anne'

  Column 8

    'Britta'
```