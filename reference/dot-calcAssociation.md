# Compute associations between taxa

Computes associations between taxa or distances between subjects for a
given read count matrix

## Usage

``` r
.calcAssociation(countMat, measure, measurePar, verbose)
```

## Arguments

- countMat:

  numeric read count matrix, where rows are samples and columns are
  OTUs/taxa.

- measure:

  character giving the measure used for estimating associations or
  dissimilarities

- measurePar:

  optional list with parameters passed to the function for estimating
  associations/dissimilarities

- verbose:

  if `TRUE`, progress messages are returned.
