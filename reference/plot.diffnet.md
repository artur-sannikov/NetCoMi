# Plot method for objects of class diffnet

Plot method for objects of class diffnet

## Usage

``` r
# S3 method for class 'diffnet'
plot(
  x,
  adjusted = TRUE,
  layout = NULL,
  repulsion = 1,
  labels = NULL,
  shortenLabels = "none",
  labelLength = 6,
  labelPattern = c(5, "'", 3, "'", 3),
  charToRm = NULL,
  labelScale = TRUE,
  labelFont = 1,
  rmSingles = TRUE,
  nodeColor = "gray90",
  nodeTransp = 60,
  borderWidth = 1,
  borderCol = "gray80",
  edgeFilter = "none",
  edgeFilterPar = NULL,
  edgeWidth = 1,
  edgeTransp = 0,
  edgeCol = NULL,
  title = NULL,
  legend = TRUE,
  legendPos = "topright",
  legendGroupnames = NULL,
  legendTitle = NULL,
  legendArgs = NULL,
  cexNodes = 1,
  cexLabels = 1,
  cexTitle = 1.2,
  cexLegend = 1,
  mar = c(2, 2, 4, 6),
  ...
)
```

## Arguments

- x:

  object of class `diffnet` (returned by
  [`diffnet`](https://netcomi.de/reference/diffnet.md)) containing the
  adjacency matrix, whose entries are absolute differences between
  associations.

- adjusted:

  logical indicating whether the adjacency matrix based on adjusted
  p-values should be used. Defaults to `TRUE`. If `FALSE`, the adjacency
  matrix is based on non-adjusted p-values. Ignored for the discordant
  method.

- layout:

  indicates the layout used for defining node positions. Can be a
  character with one of the layouts provided by
  [`qgraph`](https://rdrr.io/pkg/qgraph/man/qgraph.html):
  `"spring"`(default), `"circle"`, or `"groups"`. Alternatively, the
  layouts provided by igraph (see
  [`layout_`](https://r.igraph.org/reference/layout_.html)) are accepted
  (must be given as character, e.g. `"layout_with_fr"`). Can also be a
  matrix with row number equal to the number of nodes and two columns
  corresponding to the x and y coordinate.

- repulsion:

  integer specifying repulse radius in the spring layout; for a value
  lower than 1, nodes are placed further apart

- labels:

  defines the node labels. Can be a character vector with an entry for
  each node. If `FALSE`, no labels are plotted. Defaults to the
  row/column names of the association matrices. Ignored if node labels
  are defined via `labels`. NetCoMi's function
  [`editLabels()`](https://netcomi.de/reference/editLabels.md) is used
  for label editing. Available options are:

  `"intelligent"`

  :   Elements of `charToRm` are removed, labels are shortened to length
      `labelLength`, and duplicates are removed using `labelPattern`.

  `"simple"`

  :   Elements of `charToRm` are removed and labels are shortened to
      length `labelLength`.

  `"none"`

  :   Default. Original dimnames of the adjacency matrices are used.

- shortenLabels:

  character indicating how to shorten the labels. Available options are:

  `"intelligent"`

  :   Elements of `charToRm` are removed, labels are shortened to length
      `labelLength`, and duplicates are removed using `labelPattern`.

  `"simple"`

  :   Elements of `charToRm` are removed and labels are shortened to
      length `labelLength`.

  `"none"`

  :   Default. Labels are not shortened.

- labelLength:

  integer defining the length to which labels shall be shortened if
  `shortenLabels` is set to `"simple"` or `"intelligent"`. Defaults to
  6.

- labelPattern:

  vector of three or five elements, which is used if argument
  `shortenLabels` is set to `"intelligent"`. If cutting a label to
  length `labelLength` leads to duplicates, the label is shortened
  according to `labelPattern`, where the first entry gives the length of
  the first part, the second entry is used a separator, and the third
  entry is the length of the third part. If `labelPattern` has five
  elements and the shortened labels are still not unique, the fourth
  element serves as further separator, and the fifth element gives the
  length of the last label part. Defaults to c(5, "'", 3, "'", 3). If
  the data contains, for example, three bacteria "Streptococcus1",
  "Streptococcus2" and "Streptomyces", they are by default shortened to
  "Strep'coc'1", "Strep'coc'2", and "Strep'myc".

- charToRm:

  vector with characters to remove from node names. Ignored if labels
  are given via `labels`.

- labelScale:

  logical. If `TRUE`, node labels are scaled according to node size

- labelFont:

  integer defining the font of node labels. Defaults to 1.

- rmSingles:

  logical. If `TRUE`, unconnected nodes are removed.

- nodeColor:

  character or numeric value specifying node colors. Can also be a
  vector with a color for each node.

- nodeTransp:

  an integer between 0 and 100 indicating the transparency of node
  colors. 0 means no transparency, 100 means full transparency. Defaults
  to 60.

- borderWidth:

  numeric specifying the width of node borders. Defaults to 1.

- borderCol:

  character specifying the color of node borders. Defaults to "gray80"

- edgeFilter:

  character indicating whether and how edges should be filtered.
  Possible values are `"none"` (all edges are shown) and `"highestDiff"`
  (the first x edges with highest absolute difference are shown). x is
  defined by `edgeFilterPar`.

- edgeFilterPar:

  numeric value specifying the "x" in `edgeFilter`.

- edgeWidth:

  numeric specifying the edge width. See argument `"edge.width"` of
  [`qgraph`](https://rdrr.io/pkg/qgraph/man/qgraph.html).

- edgeTransp:

  an integer between 0 and 100 indicating the transparency of edge
  colors. 0 means no transparency (default), 100 means full
  transparency.

- edgeCol:

  character vector specifying the edge colors. Must be of length 6 for
  the discordant method (default: c("hotpink", "aquamarine", "red",
  "orange", "green", "blue")) and of lengths 9 for permutation tests and
  Fisher's z-test (default: c("chartreuse2", "chartreuse4", "cyan",
  "magenta", "orange", "red", "blue", "black", "purple")).

- title:

  optional character string for the main title.

- legend:

  logical. If `TRUE`, a legend is plotted.

- legendPos:

  either a character specifying the legend's position or a numeric
  vector with two elements giving the x and y coordinates of the legend.
  See the description of the x and y arguments of
  [`legend`](https://rdrr.io/r/graphics/legend.html) for details.

- legendGroupnames:

  a vector with two elements giving the group names shown in the legend.

- legendTitle:

  character specifying the legend title.

- legendArgs:

  list with further arguments passed to
  [`legend`](https://rdrr.io/r/graphics/legend.html).

- cexNodes:

  numeric scaling node sizes. Defaults to 1.

- cexLabels:

  numeric scaling node labels. Defaults to 1.

- cexTitle:

  numeric scaling the title. Defaults to 1.2.

- cexLegend:

  numeric scaling the legend size. Defaults to 1.

- mar:

  a numeric vector of the form c(bottom, left, top, right) defining the
  plot margins. Works similar to the `mar` argument in
  [`par`](https://rdrr.io/r/graphics/par.html). Defaults to c(2,2,4,6).

- ...:

  further arguments being passed to
  [`qgraph`](https://rdrr.io/pkg/qgraph/man/qgraph.html).

## See also

[`diffnet`](https://netcomi.de/reference/diffnet.md),
[`netConstruct`](https://netcomi.de/reference/netConstruct.md)
