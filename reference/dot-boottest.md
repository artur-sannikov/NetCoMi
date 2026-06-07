# Bootstrap Procedure for Testing Statistical Significance of Correlation Values

Statistical significance of correlations between pairs of taxonomic
units is tested using a bootstrap procedure as proposed by Friedman and
Alm (2012).

## Usage

``` r
.boottest(
  countMat,
  assoMat,
  nboot = 1000,
  measure,
  measurePar,
  cores = 4,
  logFile = NULL,
  verbose = TRUE,
  seed = NULL,
  assoBoot = NULL
)
```

## Arguments

- countMat:

  matrix containing microbiome data (read counts) for which the
  correlations are calculated (rows represent samples, columns represent
  taxa)

- assoMat:

  matrix containing associations that have been estimated for
  `countMat`.

- nboot:

  number of bootstrap samples.

- measure:

  character specifying the method used for computing the associations
  between taxa.

- measurePar:

  list with parameters passed to the function for computing
  associations/dissimilarities. See details for the respective
  functions.

- cores:

  number of CPU cores used for parallelization.

- logFile:

  character defining a log file, where the number of iteration is
  stored. If NULL, no log file is created. wherein the current iteration
  numbers are stored.

- verbose:

  logical; if `TRUE`, the iteration numbers are printed to the R console

- seed:

  an optional seed for reproducibility of the results.

- assoBoot:

  list with bootstrap association matrices.

## Value

|           |                              |
|-----------|------------------------------|
| `pvals`   | calculated p-values          |
| `corrMat` | estimated correlation matrix |

## References

Friedman J, Alm EJ (2012). “Inferring Correlation Networks from Genomic
Survey Data.” *PLoS Computational Biology*, 8, e1002687.
