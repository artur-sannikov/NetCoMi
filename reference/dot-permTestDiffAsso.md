# Permutation Tests for Determining Differential Associations

The function implements procedures to test whether pairs of taxa are
differentially associated, whether a taxon is differentially associated
to all other taxa, or whether two networks are differentially associated
between two groups as proposed by Gill et al.(2010).

## Usage

``` r
.permTestDiffAsso(
  countMat1,
  countMat2,
  countsJoint,
  normCounts1,
  normCounts2,
  assoMat1,
  assoMat2,
  paramsNetConstruct,
  method = c("connect.pairs", "connect.variables", "connect.network"),
  fisherTrans = TRUE,
  pvalsMethod = "pseudo",
  adjust = "lfdr",
  adjust2 = "holm",
  trueNullMethod = "convest",
  alpha = 0.05,
  lfdrThresh = 0.2,
  nPerm = 1000,
  matchDesign = NULL,
  callNetConstr = NULL,
  cores = 4,
  verbose = TRUE,
  logFile = "log.txt",
  seed = NULL,
  fileLoadAssoPerm = NULL,
  fileLoadCountsPerm = NULL,
  storeAssoPerm = FALSE,
  fileStoreAssoPerm = "assoPerm",
  storeCountsPerm = FALSE,
  fileStoreCountsPerm = c("countsPerm1", "countsPerm2"),
  assoPerm = NULL
)
```

## Arguments

- countMat1, countMat2:

  matrices containing microbiome data (read counts) of group 1 and group
  2 (rows represent samples and columns taxonomic units, respectively).

- countsJoint:

  joint count matrices before preprocessing

- normCounts1, normCounts2:

  normalized count matrices.

- assoMat1, assoMat2:

  association matrices corresponding to the two count matrices. The
  associations must have been estimated from the count matrices
  `countMat1` and `countMat2`.

- paramsNetConstruct:

  parameters used for network construction.

- method:

  character vector indicating the tests to be performed. Possible values
  are `"connect.pairs"` (differentially correlated taxa pairs),
  `"connect.variables"` (one taxon to all other) and `"connect.network"`
  (differentially connected networks). By default, all three tests are
  conducted.

- fisherTrans:

  logical indicating whether the correlation values should be
  Fisher-transformed.

- pvalsMethod:

  currently only `"pseudo"` is available, where 1 is added to the number
  of permutations and the permutation test statistics being more extreme
  than the observed one in order to avoid zero p-values.

- adjust:

  multiple testing adjustment for the tests for differentially
  correlated pairs of taxa; possible values are "lfdr" (default) for
  local false discovery rate correction (via
  [`fdrtool`](https://rdrr.io/pkg/fdrtool/man/fdrtool.html)) or one of
  the methods provided by
  [`p.adjust`](https://rdrr.io/r/stats/p.adjust.html)

- adjust2:

  multiple testing adjustment for the tests if a taxa pair is
  differentially correlated to all other taxa; possible methods are
  those provided by [`p.adjust`](https://rdrr.io/r/stats/p.adjust.html)
  (a few hundred tests are necessary for the local fdr correction)

- trueNullMethod:

  character indicating the method used for estimating the proportion of
  true null hypotheses from a vector of p-values. Used for the adaptive
  Benjamini-Hochberg method for multiple testing adjustment (chosen by
  `adjust = "adaptBH"`).

- alpha:

  significance level

- lfdrThresh:

  defines a threshold for the local fdr if "lfdr" is chosen as method
  for multiple testing correction; defaults to 0.2, which means that
  correlations with a corresponding local fdr less than or equal to 0.2
  are identified as significant

- nPerm:

  number of permutations

- matchDesign:

  Numeric vector with two elements specifying an optional matched-group
  (i.e. matched-pair) design, which is used for the permutation tests in
  [`netCompare`](https://netcomi.de/reference/netCompare.md) and
  [`diffnet`](https://netcomi.de/reference/diffnet.md). `c(1,1)`
  corresponds to a matched-pair design. A 1:2 matching, for instance, is
  defined by `c(1,2)`, which means that the first sample of group 1 is
  matched to the first two samples of group 2 and so on. The appropriate
  order of samples must be ensured. If `NULL`, the group memberships are
  shuffled randomly while group sizes identical to the original data set
  are ensured.

- callNetConstr:

  call inherited from
  [`netConstruct()`](https://netcomi.de/reference/netConstruct.md).

- cores:

  number of CPU cores (permutation tests are executed parallel)

- verbose:

  if `TRUE`, status messages and numbers of SparCC iterations are
  printed

- logFile:

  character string naming the log file within which the current
  iteration number is stored

- seed:

  an optional seed for reproducibility of the results

- fileLoadAssoPerm:

  character giving the name (without extenstion) or path of the file
  storing the "permuted" association/dissimilarity matrices that have
  been exported by setting `storeAssoPerm` to `TRUE`. Only used for
  permutation tests. Set to `NULL` if no existing associations should be
  used.

- fileLoadCountsPerm:

  character giving the name (without extenstion) or path of the file
  storing the "permuted" count matrices that have been exported by
  setting `storeCountsPerm` to `TRUE`. Only used for permutation tests,
  and if `fileLoadAssoPerm = NULL`. Set to `NULL` if no existing count
  matrices should be used.

- storeAssoPerm:

  logical indicating whether the association (or dissimilarity) matrices
  for the permuted data should be stored in a file. The filename is
  given via `fileStoreAssoPerm`. If `TRUE`, the computed "permutation"
  association/dissimilarity matrices can be reused via
  `fileLoadAssoPerm` to save runtime. Defaults to `FALSE`.

- fileStoreAssoPerm:

  character giving the file name to store a matrix containing a matrix
  with associations/dissimilarities for the permuted data. Can also be a
  path.

- storeCountsPerm:

  logical indicating whether the permuted count matrices should be
  stored in an external file. Defaults to `FALSE`.

- fileStoreCountsPerm:

  character vector with two elements giving the names of two files
  storing the permuted count matrices belonging to the two groups.

- assoPerm:

  not used anymore.

## References

Gill R, Datta S, Datta S (2010). “A statistical framework for
differential network analysis from microarray data.” *BMC
Bioinformatics*, 11, 95.  
  
Knijnenburg TA, Wessels LF, Reinders MJ, Shmulevich I (2009). “Fewer
permutations, more accurate P-values.” *Bioinformatics*, 25(12),
i161–i168.

## See also

[`diffnet`](https://netcomi.de/reference/diffnet.md)
