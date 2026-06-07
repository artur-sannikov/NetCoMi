# Summary Method for Objects of Class microNetProps

The main results returned by
[`netAnalyze`](https://netcomi.de/reference/netAnalyze.md) are printed
in a well-arranged format.

## Usage

``` r
# S3 method for class 'microNetProps'
summary(
  object,
  groupNames = NULL,
  showCompSize = TRUE,
  showGlobal = TRUE,
  showGlobalLCC = TRUE,
  showCluster = TRUE,
  clusterLCC = FALSE,
  showHubs = TRUE,
  showCentr = "all",
  numbNodes = NULL,
  digits = 5L,
  ...
)

# S3 method for class 'summary.microNetProps'
print(x, ...)
```

## Arguments

- object:

  object of class `microNetProps` (returned by
  [`netAnalyze`](https://netcomi.de/reference/netAnalyze.md)).

- groupNames:

  character vector with two elements giving the group names
  corresponding to the two networks. If `NULL`, the names are adopted
  from `object`. Ignored if `object` contains a single network.

- showCompSize:

  logical. If `TRUE`, the component sizes are printed.

- showGlobal:

  logical. If `TRUE`, global network properties for the whole network
  are printed.

- showGlobalLCC:

  logical. If `TRUE`, global network properties for the largest
  connected component are printed. If the network is connected (number
  of components is 1) the global properties are printed only once (if
  one of the arguments `showGlobal` and `showGlobalLCC`) is `TRUE`.

- showCluster:

  logical. If `TRUE`, the cluster(s) are printed.

- clusterLCC:

  logical. If `TRUE`, clusters are printed only for the largest
  connected component. Defaults to `FALSE` (whole network).

- showHubs:

  logical. If `TRUE`, the detected hubs are printed.

- showCentr:

  character vector indicating for which centrality measures the results
  shall be printed. Possible values are "all", "degree", "betweenness",
  "closeness", "eigenvector" and "none".

- numbNodes:

  integer indicating for how many nodes the centrality values shall be
  printed. Defaults to 10L for a single network and 5L for two networks.
  Thus, in case of a single network, the first 10 nodes with highest
  centrality value of the specific centrality measure are shown. If
  `object` contains two networks, for each centrality measure a splitted
  matrix is shown where the upper part contains the highest values of
  the first group, and the lower part the highest values of the second
  group.

- digits:

  integer giving the number of decimal places to which the results are
  rounded. Defaults to 5L.

- ...:

  not used.

- x:

  object of class `summary.microNetProps` (returned by to
  `summary.microNetProps`).

## See also

[`netConstruct`](https://netcomi.de/reference/netConstruct.md),
[`netAnalyze`](https://netcomi.de/reference/netAnalyze.md)
