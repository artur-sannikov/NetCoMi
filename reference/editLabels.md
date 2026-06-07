# Edit labels

Function for editing node labels, i.e., shortening to a certain length
and removing unwanted characters.  
  
The function is used by NetCoMi's plot functions
[`plot.microNetProps`](https://netcomi.de/reference/plot.microNetProps.md)
and [`plot.diffnet`](https://netcomi.de/reference/plot.diffnet.md).

## Usage

``` r
editLabels(
  x,
  shortenLabels = c("intelligent", "simple", "none"),
  labelLength = 6,
  labelPattern = NULL,
  addBrack = TRUE,
  charToRm = NULL,
  verbose = TRUE
)
```

## Arguments

- x:

  character vector with node labels.

- shortenLabels:

  character indicating how to shorten the labels. Available options are:

  `"intelligent"`

  :   Elements of `charToRm` are removed, labels are shortened to length
      `labelLength`, and duplicates are removed using `labelPattern`.

  `"simple"`

  :   Elements of `charToRm` are removed and labels are shortened to
      length `labelLength`.

  `"none"`

  :   Labels are not shortened.

- labelLength:

  integer defining the length to which labels shall be shortened if
  `shortenLabels` is used. Defaults to 6.

- labelPattern:

  vector of three or five elements, which is used if argument
  `shortenLabels` is set to `"intelligent"`. If cutting a label to
  length `labelLength` leads to duplicates, the label is shortened
  according to `labelPattern`, where the first entry gives the length of
  the first part, the second entry is used a separator, and the third
  entry is the length of the third part. If `labelPattern` has five
  elements and the shortened labels are still not unique, the fourth
  element serves as further separator, and the fifth element gives the
  length of the last label part. Defaults to c(4, "'", 3, "'", 3). See
  details for an example.

- addBrack:

  logical indicating whether to add a closing square bracket. If `TRUE`,
  a "\]" is added if the first part contains a "\[".

- charToRm:

  character vector giving one or more patterns to remove from the
  labels.

- verbose:

  logical. If `TRUE`, the function is allowed to return messages.

## Value

Character vector with edited labels.

## Details

Consider a vector with three bacteria names: "Streptococcus1",
"Streptococcus2", and "Streptomyces".  
  

`shortenLabels = "simple"` with `labelLength = 6` leads to shortened
labels: "Strept", "Strept", and "Strept", which are not
distinguishable.  
  

`shortenLabels = "intelligent"` with `labelPattern = c(5, "'", 3)` leads
to shortened labels: "Strep'coc", "Strep'coc", are "Strep'myc", where
the first two are not distinguishable.

`shortenLabels = "intelligent"` with
`labelPattern = c(5, "'", 3, "'", 3)` leads to shortened labels:
"Strep'coc'1", "Strep'coc'2", and "Strep'myc", from which the original
labels can be inferred.  
  

The intelligent approach is as follows:  
  
First, labels are shortened to the defined length (argument
`labelLength`). The `labelPattern` is then applied to all duplicated
labels. For each group of duplicates, the third label part starts at the
letter where two or more labels are different for the first time. The
five-part pattern (if given) applies if a group of duplicates consists
of more than two labels and if the shortened labels are not unique after
applying the three-part pattern. Then, the fifth part starts at the
letter where all labels are different for the first time.  
  
A message is printed if the returned labels are not unique.

## Examples

``` r
labels <- c("Salmonella", 
            "Clostridium", "Clostridiales(O)", 
            "Ruminococcus", "Ruminococcaceae(F)", 
            "Enterobacteriaceae", "Enterococcaceae",
            "[Bacillus] alkalinitrilicus",
            "[Bacillus] alkalisediminis",
            "[Bacillus] oceani")

# Use the "simple" method to shorten labels
editLabels(labels, shortenLabels = "simple", labelLength = 6)
#>  [1] "Salmon" "Clostr" "Clostr" "Rumino" "Rumino" "Entero" "Entero" "[Bacil"
#>  [9] "[Bacil" "[Bacil"
# -> Original labels cannot be inferred from shortened labels

# Use the "intelligent" method to shorten labels with three-part pattern
editLabels(labels, shortenLabels = "intelligent", labelLength = 6,
           labelPattern = c(6, "'", 4))
#> Shortened labels could not be made unique.
#>  [1] "Salmon"       "Clostr'um  "  "Clostr'ales"  "Rumino'us  "  "Rumino'acea" 
#>  [6] "Entero'bact"  "Entero'cocc"  "[Bacil]'alka" "[Bacil]'alka" "[Bacil]'ocea"
# -> [Bacillus] alkalinitrilicus and [Bacillus] alkalisediminis not 
#    distinguishable

# Use the "intelligent" method to shorten labels with five-part pattern
editLabels(labels, shortenLabels = "intelligent", labelLength = 6,
           labelPattern = c(6, "'", 3, "'", 3))
#>  [1] "Salmon"          "Clostr'um "      "Clostr'ale"      "Rumino'us "     
#>  [5] "Rumino'ace"      "Entero'bac"      "Entero'coc"      "[Bacil]'alk'nit"
#>  [9] "[Bacil]'alk'sed" "[Bacil]'oce"    

# Same as before but no brackets are added
editLabels(labels, shortenLabels = "intelligent", labelLength = 6, 
           addBrack = FALSE, labelPattern = c(6, "'", 3, "'", 3))
#>  [1] "Salmon"         "Clostr'um "     "Clostr'ale"     "Rumino'us "    
#>  [5] "Rumino'ace"     "Entero'bac"     "Entero'coc"     "[Bacil'alk'nit"
#>  [9] "[Bacil'alk'sed" "[Bacil'oce"    

# Remove character pattern(s) (can also be a vector with multiple patterns)
labels <- c("g__Faecalibacterium", "g__Clostridium", "g__Eubacterium", 
            "g__Bifidobacterium", "g__Bacteroides")
            
editLabels(labels, charToRm = "g__")
#> [1] "Faecal" "Clostr" "Eubact" "Bifido" "Bacter"
```
