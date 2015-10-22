# Introduction to mdadata class

Class `mdadata` extends usability of conventional matrices, allowing to keep row and column names with data values and use them when show or plot the data. The `mdadata` can be used only with numerical values.

Every object of `mdadata` class has following properties, which can be set by a user when creating:

`values` — data values, a matrix with numbers
`rowNames` a cell array with row names (optional)
`colNames` a cell array with column names (optional)
`dimNames` a cell array with names for each of the two dimensions (optional)
`name` a text string with short name of the dataset (optional)

The default syntax for creating the dataset object is:

```matlab
data = mdadata(values, objNames, colNames, dimNames, name);
```

Most of the properties are optional, they will be generated automatically or remain empty if user does not provide the proper values:

```matlab
% Create a dataset with default property values:
d = mdadata([180 85; 172 68; 156 50]);
show(d)
```

```matlab

 Variables
    1   2
 ---- ---
  180  85
  172  68
  156  50
```
  
```matlab
disp('Dim names are:')
disp(d.dimNames)
```
```
Dim names are:
    'Objects'    'Variables'
```

Function `show()` shows dataset values as a table with column and row names. As one can see column names were generated as `'1'`, `'2'` and so on and row names remain empty. Default `dimnames` values are `'Objects'` and `'Variables'` and dataset name is not defined. The row names and column names must be unique!

Here is an example with all options.

```matlab
% create a dataset with all properties provided
d = mdadata([180 85; 172 68; 156 50], {'Lars', 'Peter', 'Lena'}, ...
   {'Height', 'Weight'}, {'People', 'Parameters'}, 'People data');
show(d)
```
```
People data:

         Parameters
       Height  Weight
      ------- -------
 Lars     180      85
Peter     172      68
 Lena     156      50
```

Column and row names should consist only of Latin letters and/or numbers. However you can provide them in a free form (e.g. (`'Height of person, cm'`) and the name will be converted as following: spaces will be removed and every word capitalized, if there are punctuation marks or parentheses they will be also removed as well as the part of the name after the first punctuation symbol (for the example above it will become `'HeightOfPerson'`).

This is needed to identify the names correctly when subset the datasets with logical expressions. The original (user provided) names will be also kept and used as labels when you print or plot the data.
```matlab
d = mdadata([180 81; 172 66; 156 48], {'Lars Larsen', 'Peter from room 22', 'Lena'}, ...
   {'Height', 'Body mass (kg)'});
show(d)
```
```
                          Variables
                    Height  Body mass (kg)
                   ------- ---------------
       Lars Larsen     180              81
Peter from room 22     172              66
              Lena     156              48
```

```matlab              
disp('Column names are:')
disp(d.colNames)
```
```              
Column names are:
    'Height'    'Bodymass'
```

```matlab              
disp('Row names are:')
disp(d.rowNames)
```
```
Row names are:
    'LarsLarsen'    'Peterfromroom22'    'Lena'
```

If it is needed to specify only selected parameters, the others should be provided as empty arrays:

```matlab
% create a dataset with variable and dimension names provided
d = mdadata([180 85; 172 68; 156 50], [], {'Height', 'Weight'}, {'People', 'Parameters'});
show(d)
```
```
    Parameters
  Height  Weight
 ------- -------
     180      85
     172      68
     156      50
```

Names and values can be changed for existent object:

```matlab
d = mdadata([180 85; 172 68; 156 50]);

d(:, 1).colNames =  {'Height'};
d.dimNames = {'People', 'Parameters'};
d(1, :).values = [181 88];

show(d)
````
```
  Parameters
  Height   2
 ------- ---
     181  88
     172  68
     156  50
```

Rows and columns can be removed using specific methods.

```matlab
d = mdadata([180 85 20; 172 68 20; 156 50 21; 161 51 22]);
show(d)
```
```
   Variables
    1   2   3
 ---- --- ---
  180  85  20
  172  68  20
  156  50  21
  161  51  22
```

```matlab
d.removecols(1);
show(d)
```
```
Variables
   2   3
 --- ---
  85  20
  68  20
  50  21
  51  22
```

```matlab
d.removerows(2:3);
show(d)
```
```
Variables
   2   3
 --- ---
  85  20
  51  22
```

You already know about function show(), it has an additional parameter, which defines how many significant digits to show (default value is 3):

d = mdadata([180 0.02345; 175 0.00123]);

show(d)
show(d, 2)
show(d, 5)

   Variables
    1        2
 ---- --------
  180   0.0234
  175  0.00123



     Variables
        1       2
 -------- -------
  1.8e+02   0.023
  1.8e+02  0.0012



   Variables
    1        2
 ---- --------
  180  0.02345
  175  0.00123