# Calculate network properties

Calculates network properties for a given adjacency matrix

## Usage

``` r
.calcProps(
  adjaMat,
  dissMat,
  assoMat,
  avDissIgnoreInf,
  sPathNorm,
  sPathAlgo,
  normNatConnect,
  weighted,
  isempty,
  clustMethod,
  clustPar,
  weightClustCoef,
  hubPar,
  hubQuant,
  lnormFit,
  connectivity,
  graphlet,
  orbits,
  weightDeg,
  normDeg,
  normBetw,
  normClose,
  centrLCC,
  jaccard = FALSE,
  jaccQuant = NULL,
  verbose = 0
)
```

## Arguments

- adjaMat:

  adjacency matrix

- dissMat:

  dissimilarity matrix

- assoMat:

  association matrix

- avDissIgnoreInf:

  logical indicating whether to ignore infinities when calculating the
  average dissimilarity. If `FALSE` (default), infinity values are set
  to 1.

- sPathNorm:

  logical. If `TRUE` (default), shortest paths are normalized by average
  dissimilarity (only connected nodes are considered), i.e., a path is
  interpreted as steps with average dissimilarity. If `FALSE`, the
  shortest path is the minimum sum of dissimilarities between two nodes.

- sPathAlgo:

  character indicating the algorithm used for computing the shortest
  paths between all node pairs.
  [`distances`](https://r.igraph.org/reference/distances.html) (igraph)
  is used for shortest path calculation. Possible values are:
  "unweighted", "dijkstra" (default), "bellman-ford", "johnson", or
  "automatic" (the fastest suitable algorithm is used). The shortest
  paths are needed for the average (shortest) path length and closeness
  centrality.

- normNatConnect:

  logical. If `TRUE` (default), the normalized natural connectivity is
  returned.

- weighted:

  logical indicating whether the network is weighted.

- isempty:

  logical indicating whether the network is empty.

- clustMethod:

  character indicating the clustering algorithm. Possible values are
  `"hierarchical"` for a hierarchical algorithm based on dissimilarity
  values, or the clustering methods provided by the igraph package (see
  [`communities`](https://r.igraph.org/reference/communities.html) for
  possible methods). Defaults to `"cluster_fast_greedy"` for
  association-based networks and to `"hierarchical"` for sample
  similarity networks.

- clustPar:

  list with parameters passed to the clustering functions. If
  hierarchical clustering is used, the parameters are passed to
  [`hclust`](https://rdrr.io/r/stats/hclust.html) as well as
  [`cutree`](https://rdrr.io/r/stats/cutree.html).

- weightClustCoef:

  logical indicating whether (global) clustering coefficient should be
  weighted (`TRUE`, default) or unweighted (`FALSE`).

- hubPar:

  character vector with one or more elements (centrality measures) used
  for identifying hub nodes. Possible values are `degree`,
  `betweenness`, `closeness`, and `eigenvector`. If multiple measures
  are given, hubs are nodes with highest centrality for all selected
  measures. See details.

- hubQuant:

  quantile used for determining hub nodes. Defaults to 0.95.

- lnormFit:

  hubs are nodes with a centrality value above the 95% quantile of the
  fitted log-normal distribution (if `lnormFit = TRUE`) or of the
  empirical distribution of centrality values (`lnormFit = FALSE`;
  default).

- connectivity:

  logical. If `TRUE` (default), edge and vertex connectivity are
  calculated. Might be disabled to reduce execution time.

- graphlet:

  logical. If `TRUE` (default), graphlet-based network properties are
  computed: orbit counts of graphlets with 2-4 nodes (`ocount`) and
  Graphlet Correlation Matrix (`gcm`).

- orbits:

  numeric vector with integers from 0 to 14 defining the graphlet
  orbits.

- weightDeg:

  logical. If `TRUE`, the weighted degree is used (see
  [`strength`](https://r.igraph.org/reference/strength.html)). Default
  is `FALSE`. Is automatically set to `TRUE` for a fully connected
  (dense) network.

- normDeg, normBetw, normClose:

  logical. If `TRUE` (default for all measures), a normalized version of
  the respective centrality values is returned.

- centrLCC:

  logical indicating whether to compute centralities only for the
  largest connected component (LCC). If `TRUE` (default), centrality
  values of disconnected components are zero.

- jaccard:

  shall the Jaccard index be calculated?

- jaccQuant:

  quantile for the Jaccard index

- verbose:

  integer indicating the level of verbosity. Possible values: `"0"`: no
  messages, `"1"`: only important messages, `"2"`(default): all progress
  messages are shown. Can also be logical.
