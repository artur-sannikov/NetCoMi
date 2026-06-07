# Summary Method for Objects of Class microNetComp

The main results returned by
[`netCompare`](https://netcomi.de/reference/netCompare.md) are printed
in a well-arranged format.

## Usage

``` r
# S3 method for class 'microNetComp'
summary(
  object,
  groupNames = NULL,
  showCentr = "all",
  numbNodes = 10L,
  showGlobal = TRUE,
  showGlobalLCC = TRUE,
  showJacc = TRUE,
  showRand = TRUE,
  showGCD = TRUE,
  pAdjust = TRUE,
  digits = 3L,
  digitsPval = 6L,
  ...
)

# S3 method for class 'summary.microNetComp'
print(x, ...)
```

## Arguments

- object:

  object of class `microNetComp` returned by
  [`netCompare`](https://netcomi.de/reference/netCompare.md).

- groupNames:

  character vector with two elements giving the group names for the two
  networks. If `NULL`, the names are adopted from `object`.

- showCentr:

  character vector indicating which centrality measures should be
  included in the summary. Possible values are "all", "degree",
  "betweenness", "closeness", "eigenvector" and "none".

- numbNodes:

  integer indicating for how many nodes the centrality values shall be
  printed. Defaults to 10 meaning that the first 10 taxa with highest
  absolute group difference of the specific centrality measure are
  shown.

- showGlobal:

  logical. If `TRUE`, global network properties for the whole network
  are printed.

- showGlobalLCC:

  logical. If `TRUE`, global network properties for the largest
  connected component are printed. If the network is connected (number
  of components is 1) the global properties are printed only once (if
  one of the arguments `showGlobal` and `showGlobalLCC`) is `TRUE`.

- showJacc:

  logical. If `TRUE`, the Jaccard index is printed.

- showRand:

  logical. If `TRUE`, the adjusted Rand index (if existent) is returned.

- showGCD:

  logical. If `TRUE`, the Graphlet Correlation Distance (if existent) is
  printed.

- pAdjust:

  logical. The permutation p-values (if existent) are adjusted if `TRUE`
  (default) and not adjusted if `FALSE`.

- digits:

  integer giving the number of decimal places to which the results are
  rounded. Defaults to 3L.

- digitsPval:

  integer giving the number of decimal places to which the p-values are
  rounded. Defaults to 6L.

- ...:

  not used.

- x:

  object of class `summary.microNetComp` (returned by
  `summary.microNetComp`).

## See also

[`netCompare`](https://netcomi.de/reference/netCompare.md)
