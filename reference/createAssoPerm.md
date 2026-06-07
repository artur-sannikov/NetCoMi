# Create and store association matrices for permuted data

The function creates and returns a matrix with permuted group labels and
saves association matrices computed for the permuted data to an external
file.

## Usage

``` r
createAssoPerm(
  x,
  computeAsso = TRUE,
  nPerm = 1000L,
  cores = 1L,
  seed = NULL,
  permGroupMat = NULL,
  fileStoreAssoPerm = "assoPerm",
  append = TRUE,
  storeCountsPerm = FALSE,
  fileStoreCountsPerm = c("countsPerm1", "countsPerm2"),
  logFile = NULL,
  verbose = TRUE
)
```

## Arguments

- x:

  object of class `"microNet"` or `"microNetProps"` (returned by
  [`netConstruct`](https://netcomi.de/reference/netConstruct.md) or
  [`netAnalyze`](https://netcomi.de/reference/netAnalyze.md)).

- computeAsso:

  logical indicating whether the association matrices should be
  computed. If `FALSE`, only the permuted group labels are computed and
  returned.

- nPerm:

  integer indicating the number of permutations.

- cores:

  integer indicating the number of CPU cores used for permutation tests.
  If cores \> 1, the tests are performed in parallel. Is limited to the
  number of available CPU cores determined by
  [`detectCores`](https://rdrr.io/r/parallel/detectCores.html). Defaults
  to 1L (no parallelization).

- seed:

  integer giving a seed for reproducibility of the results.

- permGroupMat:

  an optional matrix with permuted group labels (with nPerm rows and
  n1+n2 columns).

- fileStoreAssoPerm:

  character giving the name of a file to which the matrix with
  associations/dissimilarities of the permuted data is saved. Can also
  be a path.

- append:

  logical indicating whether existing files (given by fileStoreAssoPerm
  and fileStoreCountsPerm) should be extended. If `TRUE`, a new file is
  created only if the file is not existing. If `FALSE`, a new file is
  created in any case.

- storeCountsPerm:

  logical indicating whether the permuted count matrices should be saved
  to an external file. Defaults to `FALSE`. Ignored if
  `fileLoadCountsPerm` is not `NULL`.

- fileStoreCountsPerm:

  character vector with two elements giving the names of two files
  storing the permuted count matrices belonging to the two groups.

- logFile:

  character string naming the log file to which the current iteration
  number is written. Defaults to `NULL` so that no log file is
  generated.

- verbose:

  logical. If `TRUE` (default), status messages are shown.

## Value

Invisible object: Matrix with permuted group labels.

## Examples

``` r
# \donttest{
  # Load data sets from American Gut Project (from SpiecEasi package)
  data("amgut1.filt")

  # Generate a random group vector
  set.seed(123456)
  group <- sample(1:2, nrow(amgut1.filt), replace = TRUE)

  # Network construction:
  amgut_net <- netConstruct(amgut1.filt, group = group,
                            measure = "pearson",
                            filtTax = "highestVar",
                            filtTaxPar = list(highestVar = 30),
                            zeroMethod = "pseudoZO", normMethod = "clr")
#> Checking input arguments ... 
#> Done.
#> Data filtering ...
#> 97 taxa removed.
#> 30 taxa and 289 samples remaining.
#> 
#> Zero treatment:
#> Zero counts replaced by 1
#> 
#> Normalization:
#> Execute clr(){SpiecEasi} ... 
#> Done.
#> 
#> Calculate 'pearson' associations ... 
#> Done.
#> 
#> Calculate associations in group 2 ... 
#> Done.
#> 
#> Sparsify associations via 't-test' ... 
#> 
#> Adjust for multiple testing via 'adaptBH' ... 
#> Done.
#> Done.
#> 
#> Sparsify associations in group 2 ... 
#> 
#> Adjust for multiple testing via 'adaptBH' ... 
#> Done.
#> Done.

  # Network analysis:
  amgut_props <- netAnalyze(amgut_net, clustMethod = "cluster_fast_greedy")


  # Use 'createAssoPerm' to create "permuted" count and association matrices,
  # which can be reused by netCompare() and diffNet()
  # Note: 
  # createAssoPerm() accepts objects 'amgut_net' and 'amgut_props' as input
  
  createAssoPerm(amgut_props, nPerm = 100L, 
                 computeAsso = TRUE,
                 fileStoreAssoPerm = "assoPerm",
                 storeCountsPerm = TRUE, 
                 fileStoreCountsPerm = c("countsPerm1", "countsPerm2"),
                 append = FALSE, seed = 123456)
#> Create matrix with permuted group labels ... 
#> Done.
#> Files 'assoPerm.bmat and assoPerm.desc.txt created. 
#> Files 'countsPerm1.bmat, countsPerm1.desc.txt, countsPerm2.bmat, and countsPerm2.desc.txt created. 
#> Compute permutation associations ... 
#>   |                                                                              |                                                                      |   0%
#> Loading required package: dynamicTreeCut
#> Loading required package: fastcluster
#> 
#> Attaching package: ‘fastcluster’
#> The following object is masked from ‘package:stats’:
#> 
#>     hclust
#> 
#> Attaching package: ‘WGCNA’
#> The following object is masked from ‘package:stats’:
#> 
#>     cor
#> Loading required package: permute
#> 
#> Attaching package: ‘LaplacesDemon’
#> The following object is masked from ‘package:permute’:
#> 
#>     Blocks
#> Loading required package: S4Vectors
#> Loading required package: stats4
#> Loading required package: BiocGenerics
#> Loading required package: generics
#> 
#> Attaching package: ‘generics’
#> The following objects are masked from ‘package:base’:
#> 
#>     as.difftime, as.factor, as.ordered, intersect, is.element, setdiff,
#>     setequal, union
#> 
#> Attaching package: ‘BiocGenerics’
#> The following objects are masked from ‘package:stats’:
#> 
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from ‘package:base’:
#> 
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, aperm, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, is.unsorted, lapply,
#>     mapply, match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     rank, rbind, rownames, sapply, saveRDS, table, tapply, unique,
#>     unsplit, which.max, which.min
#> 
#> Attaching package: ‘S4Vectors’
#> The following object is masked from ‘package:utils’:
#> 
#>     findMatches
#> The following objects are masked from ‘package:base’:
#> 
#>     I, expand.grid, unname
#> Loading required package: IRanges
#> 
#> Attaching package: ‘IRanges’
#> The following object is masked from ‘package:phyloseq’:
#> 
#>     distance
#> Loading required package: GenomicRanges
#> Loading required package: Seqinfo
#> Loading required package: SummarizedExperiment
#> Loading required package: MatrixGenerics
#> Loading required package: matrixStats
#> 
#> Attaching package: ‘MatrixGenerics’
#> The following objects are masked from ‘package:matrixStats’:
#> 
#>     colAlls, colAnyNAs, colAnys, colAvgsPerRowSet, colCollapse,
#>     colCounts, colCummaxs, colCummins, colCumprods, colCumsums,
#>     colDiffs, colIQRDiffs, colIQRs, colLogSumExps, colMadDiffs,
#>     colMads, colMaxs, colMeans2, colMedians, colMins, colOrderStats,
#>     colProds, colQuantiles, colRanges, colRanks, colSdDiffs, colSds,
#>     colSums2, colTabulates, colVarDiffs, colVars, colWeightedMads,
#>     colWeightedMeans, colWeightedMedians, colWeightedSds,
#>     colWeightedVars, rowAlls, rowAnyNAs, rowAnys, rowAvgsPerColSet,
#>     rowCollapse, rowCounts, rowCummaxs, rowCummins, rowCumprods,
#>     rowCumsums, rowDiffs, rowIQRDiffs, rowIQRs, rowLogSumExps,
#>     rowMadDiffs, rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,
#>     rowOrderStats, rowProds, rowQuantiles, rowRanges, rowRanks,
#>     rowSdDiffs, rowSds, rowSums2, rowTabulates, rowVarDiffs, rowVars,
#>     rowWeightedMads, rowWeightedMeans, rowWeightedMedians,
#>     rowWeightedSds, rowWeightedVars
#> Loading required package: Biobase
#> Welcome to Bioconductor
#> 
#>     Vignettes contain introductory material; view with
#>     'browseVignettes()'. To cite Bioconductor, see
#>     'citation("Biobase")', and for packages 'citation("pkgname")'.
#> 
#> Attaching package: ‘Biobase’
#> The following object is masked from ‘package:MatrixGenerics’:
#> 
#>     rowMedians
#> The following objects are masked from ‘package:matrixStats’:
#> 
#>     anyMissing, rowMedians
#> The following object is masked from ‘package:phyloseq’:
#> 
#>     sampleNames
#>   |                                                                              |=                                                                     |   1%  |                                                                              |=                                                                     |   2%  |                                                                              |==                                                                    |   3%  |                                                                              |===                                                                   |   4%  |                                                                              |====                                                                  |   5%  |                                                                              |====                                                                  |   6%  |                                                                              |=====                                                                 |   7%  |                                                                              |======                                                                |   8%  |                                                                              |======                                                                |   9%  |                                                                              |=======                                                               |  10%  |                                                                              |========                                                              |  11%  |                                                                              |========                                                              |  12%  |                                                                              |=========                                                             |  13%  |                                                                              |==========                                                            |  14%  |                                                                              |==========                                                            |  15%  |                                                                              |===========                                                           |  16%  |                                                                              |============                                                          |  17%  |                                                                              |=============                                                         |  18%  |                                                                              |=============                                                         |  19%  |                                                                              |==============                                                        |  20%  |                                                                              |===============                                                       |  21%  |                                                                              |===============                                                       |  22%  |                                                                              |================                                                      |  23%  |                                                                              |=================                                                     |  24%  |                                                                              |==================                                                    |  25%  |                                                                              |==================                                                    |  26%  |                                                                              |===================                                                   |  27%  |                                                                              |====================                                                  |  28%  |                                                                              |====================                                                  |  29%  |                                                                              |=====================                                                 |  30%  |                                                                              |======================                                                |  31%  |                                                                              |======================                                                |  32%  |                                                                              |=======================                                               |  33%  |                                                                              |========================                                              |  34%  |                                                                              |========================                                              |  35%  |                                                                              |=========================                                             |  36%  |                                                                              |==========================                                            |  37%  |                                                                              |===========================                                           |  38%  |                                                                              |===========================                                           |  39%  |                                                                              |============================                                          |  40%  |                                                                              |=============================                                         |  41%  |                                                                              |=============================                                         |  42%  |                                                                              |==============================                                        |  43%  |                                                                              |===============================                                       |  44%  |                                                                              |================================                                      |  45%  |                                                                              |================================                                      |  46%  |                                                                              |=================================                                     |  47%  |                                                                              |==================================                                    |  48%  |                                                                              |==================================                                    |  49%  |                                                                              |===================================                                   |  50%  |                                                                              |====================================                                  |  51%  |                                                                              |====================================                                  |  52%  |                                                                              |=====================================                                 |  53%  |                                                                              |======================================                                |  54%  |                                                                              |======================================                                |  55%  |                                                                              |=======================================                               |  56%  |                                                                              |========================================                              |  57%  |                                                                              |=========================================                             |  58%  |                                                                              |=========================================                             |  59%  |                                                                              |==========================================                            |  60%  |                                                                              |===========================================                           |  61%  |                                                                              |===========================================                           |  62%  |                                                                              |============================================                          |  63%  |                                                                              |=============================================                         |  64%  |                                                                              |==============================================                        |  65%  |                                                                              |==============================================                        |  66%  |                                                                              |===============================================                       |  67%  |                                                                              |================================================                      |  68%  |                                                                              |================================================                      |  69%  |                                                                              |=================================================                     |  70%  |                                                                              |==================================================                    |  71%  |                                                                              |==================================================                    |  72%  |                                                                              |===================================================                   |  73%  |                                                                              |====================================================                  |  74%  |                                                                              |====================================================                  |  75%  |                                                                              |=====================================================                 |  76%  |                                                                              |======================================================                |  77%  |                                                                              |=======================================================               |  78%  |                                                                              |=======================================================               |  79%  |                                                                              |========================================================              |  80%  |                                                                              |=========================================================             |  81%  |                                                                              |=========================================================             |  82%  |                                                                              |==========================================================            |  83%  |                                                                              |===========================================================           |  84%  |                                                                              |============================================================          |  85%  |                                                                              |============================================================          |  86%  |                                                                              |=============================================================         |  87%  |                                                                              |==============================================================        |  88%  |                                                                              |==============================================================        |  89%  |                                                                              |===============================================================       |  90%  |                                                                              |================================================================      |  91%  |                                                                              |================================================================      |  92%  |                                                                              |=================================================================     |  93%  |                                                                              |==================================================================    |  94%  |                                                                              |==================================================================    |  95%  |                                                                              |===================================================================   |  96%  |                                                                              |====================================================================  |  97%  |                                                                              |===================================================================== |  98%  |                                                                              |===================================================================== |  99%  |                                                                              |======================================================================| 100%
#> Done.
  
  # Run netcompare using the stored permutation count matrices 
  # (association matrices are still computed within netCompare):
  amgut_comp1 <- netCompare(amgut_props, permTest = TRUE, nPerm = 100L, 
                            fileLoadCountsPerm = c("countsPerm1", 
                                                   "countsPerm2"),
                            seed = 123456)
#> Checking input arguments ... 
#> Done.
#> Calculate network properties ... 
#> Done.
#> Execute permutation tests ... 
#>   |                                                                              |                                                                      |   0%  |                                                                              |=                                                                     |   1%  |                                                                              |=                                                                     |   2%  |                                                                              |==                                                                    |   3%  |                                                                              |===                                                                   |   4%  |                                                                              |====                                                                  |   5%  |                                                                              |====                                                                  |   6%  |                                                                              |=====                                                                 |   7%  |                                                                              |======                                                                |   8%  |                                                                              |======                                                                |   9%  |                                                                              |=======                                                               |  10%  |                                                                              |========                                                              |  11%  |                                                                              |========                                                              |  12%  |                                                                              |=========                                                             |  13%  |                                                                              |==========                                                            |  14%  |                                                                              |==========                                                            |  15%  |                                                                              |===========                                                           |  16%  |                                                                              |============                                                          |  17%  |                                                                              |=============                                                         |  18%  |                                                                              |=============                                                         |  19%  |                                                                              |==============                                                        |  20%  |                                                                              |===============                                                       |  21%  |                                                                              |===============                                                       |  22%  |                                                                              |================                                                      |  23%  |                                                                              |=================                                                     |  24%  |                                                                              |==================                                                    |  25%  |                                                                              |==================                                                    |  26%  |                                                                              |===================                                                   |  27%  |                                                                              |====================                                                  |  28%  |                                                                              |====================                                                  |  29%  |                                                                              |=====================                                                 |  30%  |                                                                              |======================                                                |  31%  |                                                                              |======================                                                |  32%  |                                                                              |=======================                                               |  33%  |                                                                              |========================                                              |  34%  |                                                                              |========================                                              |  35%  |                                                                              |=========================                                             |  36%  |                                                                              |==========================                                            |  37%  |                                                                              |===========================                                           |  38%  |                                                                              |===========================                                           |  39%  |                                                                              |============================                                          |  40%  |                                                                              |=============================                                         |  41%  |                                                                              |=============================                                         |  42%  |                                                                              |==============================                                        |  43%  |                                                                              |===============================                                       |  44%  |                                                                              |================================                                      |  45%  |                                                                              |================================                                      |  46%  |                                                                              |=================================                                     |  47%  |                                                                              |==================================                                    |  48%  |                                                                              |==================================                                    |  49%  |                                                                              |===================================                                   |  50%  |                                                                              |====================================                                  |  51%  |                                                                              |====================================                                  |  52%  |                                                                              |=====================================                                 |  53%  |                                                                              |======================================                                |  54%  |                                                                              |======================================                                |  55%  |                                                                              |=======================================                               |  56%  |                                                                              |========================================                              |  57%  |                                                                              |=========================================                             |  58%  |                                                                              |=========================================                             |  59%  |                                                                              |==========================================                            |  60%  |                                                                              |===========================================                           |  61%  |                                                                              |===========================================                           |  62%  |                                                                              |============================================                          |  63%  |                                                                              |=============================================                         |  64%  |                                                                              |==============================================                        |  65%  |                                                                              |==============================================                        |  66%  |                                                                              |===============================================                       |  67%  |                                                                              |================================================                      |  68%  |                                                                              |================================================                      |  69%  |                                                                              |=================================================                     |  70%  |                                                                              |==================================================                    |  71%  |                                                                              |==================================================                    |  72%  |                                                                              |===================================================                   |  73%  |                                                                              |====================================================                  |  74%  |                                                                              |====================================================                  |  75%  |                                                                              |=====================================================                 |  76%  |                                                                              |======================================================                |  77%  |                                                                              |=======================================================               |  78%  |                                                                              |=======================================================               |  79%  |                                                                              |========================================================              |  80%  |                                                                              |=========================================================             |  81%  |                                                                              |=========================================================             |  82%  |                                                                              |==========================================================            |  83%  |                                                                              |===========================================================           |  84%  |                                                                              |============================================================          |  85%  |                                                                              |============================================================          |  86%  |                                                                              |=============================================================         |  87%  |                                                                              |==============================================================        |  88%  |                                                                              |==============================================================        |  89%  |                                                                              |===============================================================       |  90%  |                                                                              |================================================================      |  91%  |                                                                              |================================================================      |  92%  |                                                                              |=================================================================     |  93%  |                                                                              |==================================================================    |  94%  |                                                                              |==================================================================    |  95%  |                                                                              |===================================================================   |  96%  |                                                                              |====================================================================  |  97%  |                                                                              |===================================================================== |  98%  |                                                                              |===================================================================== |  99%  |                                                                              |======================================================================| 100%
#> Done.
#> Calculating p-values ... 
#> Done.
#> Adjust for multiple testing using 'adaptBH' ... 
#> Done.
                            
  # Run netcompare using the stored permutation association matrices:
  amgut_comp2 <- netCompare(amgut_props, permTest = TRUE, nPerm = 100L, 
                            fileLoadAssoPerm = "assoPerm")
#> Checking input arguments ... 
#> Done.
#> Calculate network properties ... 
#> Done.
#> Execute permutation tests ... 
#>   |                                                                              |                                                                      |   0%  |                                                                              |=                                                                     |   1%  |                                                                              |=                                                                     |   2%  |                                                                              |==                                                                    |   3%  |                                                                              |===                                                                   |   4%  |                                                                              |====                                                                  |   5%  |                                                                              |====                                                                  |   6%  |                                                                              |=====                                                                 |   7%  |                                                                              |======                                                                |   8%  |                                                                              |======                                                                |   9%  |                                                                              |=======                                                               |  10%  |                                                                              |========                                                              |  11%  |                                                                              |========                                                              |  12%  |                                                                              |=========                                                             |  13%  |                                                                              |==========                                                            |  14%  |                                                                              |==========                                                            |  15%  |                                                                              |===========                                                           |  16%  |                                                                              |============                                                          |  17%  |                                                                              |=============                                                         |  18%  |                                                                              |=============                                                         |  19%  |                                                                              |==============                                                        |  20%  |                                                                              |===============                                                       |  21%  |                                                                              |===============                                                       |  22%  |                                                                              |================                                                      |  23%  |                                                                              |=================                                                     |  24%  |                                                                              |==================                                                    |  25%  |                                                                              |==================                                                    |  26%  |                                                                              |===================                                                   |  27%  |                                                                              |====================                                                  |  28%  |                                                                              |====================                                                  |  29%  |                                                                              |=====================                                                 |  30%  |                                                                              |======================                                                |  31%  |                                                                              |======================                                                |  32%  |                                                                              |=======================                                               |  33%  |                                                                              |========================                                              |  34%  |                                                                              |========================                                              |  35%  |                                                                              |=========================                                             |  36%  |                                                                              |==========================                                            |  37%  |                                                                              |===========================                                           |  38%  |                                                                              |===========================                                           |  39%  |                                                                              |============================                                          |  40%  |                                                                              |=============================                                         |  41%  |                                                                              |=============================                                         |  42%  |                                                                              |==============================                                        |  43%  |                                                                              |===============================                                       |  44%  |                                                                              |================================                                      |  45%  |                                                                              |================================                                      |  46%  |                                                                              |=================================                                     |  47%  |                                                                              |==================================                                    |  48%  |                                                                              |==================================                                    |  49%  |                                                                              |===================================                                   |  50%  |                                                                              |====================================                                  |  51%  |                                                                              |====================================                                  |  52%  |                                                                              |=====================================                                 |  53%  |                                                                              |======================================                                |  54%  |                                                                              |======================================                                |  55%  |                                                                              |=======================================                               |  56%  |                                                                              |========================================                              |  57%  |                                                                              |=========================================                             |  58%  |                                                                              |=========================================                             |  59%  |                                                                              |==========================================                            |  60%  |                                                                              |===========================================                           |  61%  |                                                                              |===========================================                           |  62%  |                                                                              |============================================                          |  63%  |                                                                              |=============================================                         |  64%  |                                                                              |==============================================                        |  65%  |                                                                              |==============================================                        |  66%  |                                                                              |===============================================                       |  67%  |                                                                              |================================================                      |  68%  |                                                                              |================================================                      |  69%  |                                                                              |=================================================                     |  70%  |                                                                              |==================================================                    |  71%  |                                                                              |==================================================                    |  72%  |                                                                              |===================================================                   |  73%  |                                                                              |====================================================                  |  74%  |                                                                              |====================================================                  |  75%  |                                                                              |=====================================================                 |  76%  |                                                                              |======================================================                |  77%  |                                                                              |=======================================================               |  78%  |                                                                              |=======================================================               |  79%  |                                                                              |========================================================              |  80%  |                                                                              |=========================================================             |  81%  |                                                                              |=========================================================             |  82%  |                                                                              |==========================================================            |  83%  |                                                                              |===========================================================           |  84%  |                                                                              |============================================================          |  85%  |                                                                              |============================================================          |  86%  |                                                                              |=============================================================         |  87%  |                                                                              |==============================================================        |  88%  |                                                                              |==============================================================        |  89%  |                                                                              |===============================================================       |  90%  |                                                                              |================================================================      |  91%  |                                                                              |================================================================      |  92%  |                                                                              |=================================================================     |  93%  |                                                                              |==================================================================    |  94%  |                                                                              |==================================================================    |  95%  |                                                                              |===================================================================   |  96%  |                                                                              |====================================================================  |  97%  |                                                                              |===================================================================== |  98%  |                                                                              |===================================================================== |  99%  |                                                                              |======================================================================| 100%
#> Done.
#> Calculating p-values ... 
#> Done.
#> Adjust for multiple testing using 'adaptBH' ... 
#> Done.
  
  summary(amgut_comp1)
#> 
#> Comparison of Network Properties
#> ----------------------------------
#> CALL: 
#> netCompare(x = amgut_props, permTest = TRUE, nPerm = 100, seed = 123456, 
#>     fileLoadCountsPerm = c("countsPerm1", "countsPerm2"))
#> 
#> ______________________________
#> Global network properties
#> `````````````````````````
#> Largest connected component (LCC):
#>                          group '1'   group '2'    abs.diff.     p-value    
#> Relative LCC size            0.900       0.967        0.067    0.584158    
#> Clustering coefficient       0.522       0.394        0.128    0.277228    
#> Modularity                   0.364       0.307        0.056    0.485149    
#> Positive edge percentage    43.023      32.432       10.591    0.039604 *  
#> Edge density                 0.245       0.182        0.063    0.346535    
#> Natural connectivity         0.062       0.052        0.010    0.198020    
#> Vertex connectivity          1.000       1.000        0.000    1.000000    
#> Edge connectivity            1.000       1.000        0.000    1.000000    
#> Average dissimilarity*       0.927       0.949        0.021    0.217822    
#> Average path length**        1.624       1.819        0.195    0.435644    
#> 
#> Whole network:
#>                          group '1'   group '2'    abs.diff.     p-value    
#> Number of components         4.000       2.000        2.000    0.544554    
#> Clustering coefficient       0.522       0.394        0.128    0.277228    
#> Modularity                   0.364       0.307        0.056    0.504950    
#> Positive edge percentage    43.023      32.432       10.591    0.029703 *  
#> Edge density                 0.198       0.170        0.028    0.752475    
#> Natural connectivity         0.054       0.049        0.004    0.613861    
#> -----
#> p-values: one-tailed test with null hypothesis diff=0
#>  *: Dissimilarity = 1 - edge weight
#> **: Path length = Units with average dissimilarity
#> 
#> ______________________________
#> Jaccard index (similarity betw. sets of most central nodes)
#> ```````````````````````````````````````````````````````````
#>                     Jacc   P(<=Jacc)     P(>=Jacc)    
#> degree             0.333    0.631521      0.606925    
#> betweenness centr. 0.333    0.631521      0.606925    
#> closeness centr.   0.600    0.980338      0.076564 .  
#> eigenvec. centr.   0.778    0.999035      0.008281 ** 
#> hub taxa           0.000    0.197531      1.000000    
#> -----
#> Jaccard index in [0,1] (1 indicates perfect agreement)
#> 
#> ______________________________
#> Adjusted Rand index (similarity betw. clusterings)
#> ``````````````````````````````````````````````````
#>         wholeNet       LCC
#> ARI        0.095     0.095
#> p-value    0.071     0.064
#> -----
#> ARI in [-1,1] with ARI=1: perfect agreement betw. clusterings
#>                    ARI=0: expected for two random clusterings
#> p-value: permutation test (n=1000) with null hypothesis ARI=0
#> 
#> ______________________________
#> Graphlet Correlation Distance
#> `````````````````````````````
#>         wholeNet         LCC  
#> GCD     0.421000    0.945000  
#> p-value 0.990099    0.811881  
#> -----
#> GCD >= 0 (GCD=0 indicates perfect agreement between GCMs)
#> p-value: permutation test with null hypothesis GCD=0
#> 
#> ______________________________
#> Centrality measures
#> - In decreasing order
#> - Centrality of disconnected components is zero
#> ````````````````````````````````````````````````
#> Degree (normalized):
#>        group '1' group '2' abs.diff. adj.p-value  
#> 181095     0.207     0.000     0.207    0.965347  
#> 158660     0.414     0.241     0.172    0.965347  
#> 301645     0.414     0.241     0.172    0.965347  
#> 130663     0.069     0.207     0.138    0.965347  
#> 331820     0.241     0.103     0.138    0.965347  
#> 326977     0.207     0.069     0.138    0.965347  
#> 364563     0.241     0.345     0.103    0.965347  
#> 322235     0.310     0.207     0.103    0.965347  
#> 353985     0.138     0.034     0.103    0.965347  
#> 470973     0.138     0.034     0.103    0.965347  
#> 
#> Betweenness centrality (normalized):
#>        group '1' group '2' abs.diff. adj.p-value  
#> 130663     0.000     0.169     0.169    0.878790  
#> 512309     0.000     0.124     0.124    0.878790  
#> 181095     0.105     0.000     0.105    0.292930  
#> 326792     0.098     0.000     0.098    0.878790  
#> 326977     0.086     0.000     0.086    0.894207  
#> 331820     0.000     0.071     0.071    0.894207  
#> 248140     0.095     0.161     0.066    0.894207  
#> 188236     0.062     0.124     0.063    0.894207  
#> 361496     0.000     0.058     0.058    0.894207  
#> 9753       0.258     0.206     0.052    0.894207  
#> 
#> Closeness centrality (normalized):
#>        group '1' group '2' abs.diff. adj.p-value  
#> 181095     0.733     0.000     0.733    0.933522  
#> 259569     0.000     0.573     0.573    0.933522  
#> 127309     0.000     0.443     0.443    0.933522  
#> 549871     0.000     0.394     0.394    0.933522  
#> 470973     0.695     0.480     0.216    0.933522  
#> 331820     0.764     0.568     0.197    0.933522  
#> 353985     0.717     0.530     0.187    0.933522  
#> 541301     0.621     0.448     0.173    0.933522  
#> 158660     0.935     0.777     0.157    0.933522  
#> 244304     0.631     0.486     0.145    0.933522  
#> 
#> Eigenvector centrality (normalized):
#>        group '1' group '2' abs.diff. adj.p-value  
#> 331820     0.504     0.101     0.402    0.866062  
#> 301645     1.000     0.698     0.302    0.283710  
#> 158660     0.639     0.352     0.287    0.866062  
#> 181095     0.242     0.000     0.242    0.496493  
#> 307981     0.993     0.762     0.231    0.496493  
#> 364563     0.564     0.762     0.198    0.866062  
#> 326977     0.354     0.159     0.196    0.866062  
#> 353985     0.246     0.063     0.183    0.866062  
#> 188236     0.621     0.763     0.142    0.866062  
#> 259569     0.000     0.132     0.132    0.866062  
#> 
#> _________________________________________________________
#> Significance codes: ***: 0.001, **: 0.01, *: 0.05, .: 0.1
  summary(amgut_comp2)
#> 
#> Comparison of Network Properties
#> ----------------------------------
#> CALL: 
#> netCompare(x = amgut_props, permTest = TRUE, nPerm = 100, fileLoadAssoPerm = "assoPerm")
#> 
#> ______________________________
#> Global network properties
#> `````````````````````````
#> Largest connected component (LCC):
#>                          group '1'   group '2'    abs.diff.     p-value    
#> Relative LCC size            0.900       0.967        0.067    0.584158    
#> Clustering coefficient       0.522       0.394        0.128    0.277228    
#> Modularity                   0.364       0.307        0.056    0.485149    
#> Positive edge percentage    43.023      32.432       10.591    0.039604 *  
#> Edge density                 0.245       0.182        0.063    0.346535    
#> Natural connectivity         0.062       0.052        0.010    0.198020    
#> Vertex connectivity          1.000       1.000        0.000    1.000000    
#> Edge connectivity            1.000       1.000        0.000    1.000000    
#> Average dissimilarity*       0.927       0.949        0.021    0.217822    
#> Average path length**        1.624       1.819        0.195    0.435644    
#> 
#> Whole network:
#>                          group '1'   group '2'    abs.diff.     p-value    
#> Number of components         4.000       2.000        2.000    0.544554    
#> Clustering coefficient       0.522       0.394        0.128    0.277228    
#> Modularity                   0.364       0.307        0.056    0.504950    
#> Positive edge percentage    43.023      32.432       10.591    0.029703 *  
#> Edge density                 0.198       0.170        0.028    0.752475    
#> Natural connectivity         0.054       0.049        0.004    0.613861    
#> -----
#> p-values: one-tailed test with null hypothesis diff=0
#>  *: Dissimilarity = 1 - edge weight
#> **: Path length = Units with average dissimilarity
#> 
#> ______________________________
#> Jaccard index (similarity betw. sets of most central nodes)
#> ```````````````````````````````````````````````````````````
#>                     Jacc   P(<=Jacc)     P(>=Jacc)    
#> degree             0.333    0.631521      0.606925    
#> betweenness centr. 0.333    0.631521      0.606925    
#> closeness centr.   0.600    0.980338      0.076564 .  
#> eigenvec. centr.   0.778    0.999035      0.008281 ** 
#> hub taxa           0.000    0.197531      1.000000    
#> -----
#> Jaccard index in [0,1] (1 indicates perfect agreement)
#> 
#> ______________________________
#> Adjusted Rand index (similarity betw. clusterings)
#> ``````````````````````````````````````````````````
#>         wholeNet       LCC
#> ARI        0.095     0.095
#> p-value    0.055     0.068
#> -----
#> ARI in [-1,1] with ARI=1: perfect agreement betw. clusterings
#>                    ARI=0: expected for two random clusterings
#> p-value: permutation test (n=1000) with null hypothesis ARI=0
#> 
#> ______________________________
#> Graphlet Correlation Distance
#> `````````````````````````````
#>         wholeNet         LCC  
#> GCD     0.421000    0.945000  
#> p-value 0.990099    0.811881  
#> -----
#> GCD >= 0 (GCD=0 indicates perfect agreement between GCMs)
#> p-value: permutation test with null hypothesis GCD=0
#> 
#> ______________________________
#> Centrality measures
#> - In decreasing order
#> - Centrality of disconnected components is zero
#> ````````````````````````````````````````````````
#> Degree (normalized):
#>        group '1' group '2' abs.diff. adj.p-value  
#> 181095     0.207     0.000     0.207    0.965347  
#> 158660     0.414     0.241     0.172    0.965347  
#> 301645     0.414     0.241     0.172    0.965347  
#> 130663     0.069     0.207     0.138    0.965347  
#> 331820     0.241     0.103     0.138    0.965347  
#> 326977     0.207     0.069     0.138    0.965347  
#> 364563     0.241     0.345     0.103    0.965347  
#> 322235     0.310     0.207     0.103    0.965347  
#> 353985     0.138     0.034     0.103    0.965347  
#> 470973     0.138     0.034     0.103    0.965347  
#> 
#> Betweenness centrality (normalized):
#>        group '1' group '2' abs.diff. adj.p-value  
#> 130663     0.000     0.169     0.169    0.878790  
#> 512309     0.000     0.124     0.124    0.878790  
#> 181095     0.105     0.000     0.105    0.292930  
#> 326792     0.098     0.000     0.098    0.878790  
#> 326977     0.086     0.000     0.086    0.894207  
#> 331820     0.000     0.071     0.071    0.894207  
#> 248140     0.095     0.161     0.066    0.894207  
#> 188236     0.062     0.124     0.063    0.894207  
#> 361496     0.000     0.058     0.058    0.894207  
#> 9753       0.258     0.206     0.052    0.894207  
#> 
#> Closeness centrality (normalized):
#>        group '1' group '2' abs.diff. adj.p-value  
#> 181095     0.733     0.000     0.733    0.933522  
#> 259569     0.000     0.573     0.573    0.933522  
#> 127309     0.000     0.443     0.443    0.933522  
#> 549871     0.000     0.394     0.394    0.933522  
#> 470973     0.695     0.480     0.216    0.933522  
#> 331820     0.764     0.568     0.197    0.933522  
#> 353985     0.717     0.530     0.187    0.933522  
#> 541301     0.621     0.448     0.173    0.933522  
#> 158660     0.935     0.777     0.157    0.933522  
#> 244304     0.631     0.486     0.145    0.933522  
#> 
#> Eigenvector centrality (normalized):
#>        group '1' group '2' abs.diff. adj.p-value  
#> 331820     0.504     0.101     0.402    0.866062  
#> 301645     1.000     0.698     0.302    0.283710  
#> 158660     0.639     0.352     0.287    0.866062  
#> 181095     0.242     0.000     0.242    0.496493  
#> 307981     0.993     0.762     0.231    0.496493  
#> 364563     0.564     0.762     0.198    0.866062  
#> 326977     0.354     0.159     0.196    0.866062  
#> 353985     0.246     0.063     0.183    0.866062  
#> 188236     0.621     0.763     0.142    0.866062  
#> 259569     0.000     0.132     0.132    0.866062  
#> 
#> _________________________________________________________
#> Significance codes: ***: 0.001, **: 0.01, *: 0.05, .: 0.1
  all.equal(amgut_comp1$properties, amgut_comp2$properties)
#> [1] TRUE
  
  # Run diffnet using the stored permutation count matrices in diffnet()
  diff1 <- diffnet(amgut_net, diffMethod = "permute", nPerm = 100L, 
                  fileLoadCountsPerm = c("countsPerm1", "countsPerm2"))
#> Checking input arguments ... 
#> Done.
#> Execute permutation tests ... 
#>   |                                                                              |                                                                      |   0%  |                                                                              |=                                                                     |   1%  |                                                                              |=                                                                     |   2%  |                                                                              |==                                                                    |   3%  |                                                                              |===                                                                   |   4%  |                                                                              |====                                                                  |   5%  |                                                                              |====                                                                  |   6%  |                                                                              |=====                                                                 |   7%  |                                                                              |======                                                                |   8%  |                                                                              |======                                                                |   9%  |                                                                              |=======                                                               |  10%  |                                                                              |========                                                              |  11%  |                                                                              |========                                                              |  12%  |                                                                              |=========                                                             |  13%  |                                                                              |==========                                                            |  14%  |                                                                              |==========                                                            |  15%  |                                                                              |===========                                                           |  16%  |                                                                              |============                                                          |  17%  |                                                                              |=============                                                         |  18%  |                                                                              |=============                                                         |  19%  |                                                                              |==============                                                        |  20%  |                                                                              |===============                                                       |  21%  |                                                                              |===============                                                       |  22%  |                                                                              |================                                                      |  23%  |                                                                              |=================                                                     |  24%  |                                                                              |==================                                                    |  25%  |                                                                              |==================                                                    |  26%  |                                                                              |===================                                                   |  27%  |                                                                              |====================                                                  |  28%  |                                                                              |====================                                                  |  29%  |                                                                              |=====================                                                 |  30%  |                                                                              |======================                                                |  31%  |                                                                              |======================                                                |  32%  |                                                                              |=======================                                               |  33%  |                                                                              |========================                                              |  34%  |                                                                              |========================                                              |  35%  |                                                                              |=========================                                             |  36%  |                                                                              |==========================                                            |  37%  |                                                                              |===========================                                           |  38%  |                                                                              |===========================                                           |  39%  |                                                                              |============================                                          |  40%  |                                                                              |=============================                                         |  41%  |                                                                              |=============================                                         |  42%  |                                                                              |==============================                                        |  43%  |                                                                              |===============================                                       |  44%  |                                                                              |================================                                      |  45%  |                                                                              |================================                                      |  46%  |                                                                              |=================================                                     |  47%  |                                                                              |==================================                                    |  48%  |                                                                              |==================================                                    |  49%  |                                                                              |===================================                                   |  50%  |                                                                              |====================================                                  |  51%  |                                                                              |====================================                                  |  52%  |                                                                              |=====================================                                 |  53%  |                                                                              |======================================                                |  54%  |                                                                              |======================================                                |  55%  |                                                                              |=======================================                               |  56%  |                                                                              |========================================                              |  57%  |                                                                              |=========================================                             |  58%  |                                                                              |=========================================                             |  59%  |                                                                              |==========================================                            |  60%  |                                                                              |===========================================                           |  61%  |                                                                              |===========================================                           |  62%  |                                                                              |============================================                          |  63%  |                                                                              |=============================================                         |  64%  |                                                                              |==============================================                        |  65%  |                                                                              |==============================================                        |  66%  |                                                                              |===============================================                       |  67%  |                                                                              |================================================                      |  68%  |                                                                              |================================================                      |  69%  |                                                                              |=================================================                     |  70%  |                                                                              |==================================================                    |  71%  |                                                                              |==================================================                    |  72%  |                                                                              |===================================================                   |  73%  |                                                                              |====================================================                  |  74%  |                                                                              |====================================================                  |  75%  |                                                                              |=====================================================                 |  76%  |                                                                              |======================================================                |  77%  |                                                                              |=======================================================               |  78%  |                                                                              |=======================================================               |  79%  |                                                                              |========================================================              |  80%  |                                                                              |=========================================================             |  81%  |                                                                              |=========================================================             |  82%  |                                                                              |==========================================================            |  83%  |                                                                              |===========================================================           |  84%  |                                                                              |============================================================          |  85%  |                                                                              |============================================================          |  86%  |                                                                              |=============================================================         |  87%  |                                                                              |==============================================================        |  88%  |                                                                              |==============================================================        |  89%  |                                                                              |===============================================================       |  90%  |                                                                              |================================================================      |  91%  |                                                                              |================================================================      |  92%  |                                                                              |=================================================================     |  93%  |                                                                              |==================================================================    |  94%  |                                                                              |==================================================================    |  95%  |                                                                              |===================================================================   |  96%  |                                                                              |====================================================================  |  97%  |                                                                              |===================================================================== |  98%  |                                                                              |===================================================================== |  99%  |                                                                              |======================================================================| 100%
#> Adjust for multiple testing using 'lfdr' ... 
#> 
#> Execute fdrtool() ...
#> Step 1... determine cutoff point
#> Step 2... estimate parameters of null distribution and eta0
#> Step 3... compute p-values and estimate empirical PDF/CDF
#> Step 4... compute q-values and local fdr
#> 
#> Done.
#> No significant differential associations detected after multiple testing adjustment.
                  
  # Run diffnet using the stored permutation association matrices 
  diff2 <- diffnet(amgut_net, diffMethod = "permute", nPerm = 100L, 
                  fileLoadAssoPerm = "assoPerm")
#> Checking input arguments ... 
#> Done.
#> Execute permutation tests ... 
#>   |                                                                              |                                                                      |   0%  |                                                                              |=                                                                     |   1%  |                                                                              |=                                                                     |   2%  |                                                                              |==                                                                    |   3%  |                                                                              |===                                                                   |   4%  |                                                                              |====                                                                  |   5%  |                                                                              |====                                                                  |   6%  |                                                                              |=====                                                                 |   7%  |                                                                              |======                                                                |   8%  |                                                                              |======                                                                |   9%  |                                                                              |=======                                                               |  10%  |                                                                              |========                                                              |  11%  |                                                                              |========                                                              |  12%  |                                                                              |=========                                                             |  13%  |                                                                              |==========                                                            |  14%  |                                                                              |==========                                                            |  15%  |                                                                              |===========                                                           |  16%  |                                                                              |============                                                          |  17%  |                                                                              |=============                                                         |  18%  |                                                                              |=============                                                         |  19%  |                                                                              |==============                                                        |  20%  |                                                                              |===============                                                       |  21%  |                                                                              |===============                                                       |  22%  |                                                                              |================                                                      |  23%  |                                                                              |=================                                                     |  24%  |                                                                              |==================                                                    |  25%  |                                                                              |==================                                                    |  26%  |                                                                              |===================                                                   |  27%  |                                                                              |====================                                                  |  28%  |                                                                              |====================                                                  |  29%  |                                                                              |=====================                                                 |  30%  |                                                                              |======================                                                |  31%  |                                                                              |======================                                                |  32%  |                                                                              |=======================                                               |  33%  |                                                                              |========================                                              |  34%  |                                                                              |========================                                              |  35%  |                                                                              |=========================                                             |  36%  |                                                                              |==========================                                            |  37%  |                                                                              |===========================                                           |  38%  |                                                                              |===========================                                           |  39%  |                                                                              |============================                                          |  40%  |                                                                              |=============================                                         |  41%  |                                                                              |=============================                                         |  42%  |                                                                              |==============================                                        |  43%  |                                                                              |===============================                                       |  44%  |                                                                              |================================                                      |  45%  |                                                                              |================================                                      |  46%  |                                                                              |=================================                                     |  47%  |                                                                              |==================================                                    |  48%  |                                                                              |==================================                                    |  49%  |                                                                              |===================================                                   |  50%  |                                                                              |====================================                                  |  51%  |                                                                              |====================================                                  |  52%  |                                                                              |=====================================                                 |  53%  |                                                                              |======================================                                |  54%  |                                                                              |======================================                                |  55%  |                                                                              |=======================================                               |  56%  |                                                                              |========================================                              |  57%  |                                                                              |=========================================                             |  58%  |                                                                              |=========================================                             |  59%  |                                                                              |==========================================                            |  60%  |                                                                              |===========================================                           |  61%  |                                                                              |===========================================                           |  62%  |                                                                              |============================================                          |  63%  |                                                                              |=============================================                         |  64%  |                                                                              |==============================================                        |  65%  |                                                                              |==============================================                        |  66%  |                                                                              |===============================================                       |  67%  |                                                                              |================================================                      |  68%  |                                                                              |================================================                      |  69%  |                                                                              |=================================================                     |  70%  |                                                                              |==================================================                    |  71%  |                                                                              |==================================================                    |  72%  |                                                                              |===================================================                   |  73%  |                                                                              |====================================================                  |  74%  |                                                                              |====================================================                  |  75%  |                                                                              |=====================================================                 |  76%  |                                                                              |======================================================                |  77%  |                                                                              |=======================================================               |  78%  |                                                                              |=======================================================               |  79%  |                                                                              |========================================================              |  80%  |                                                                              |=========================================================             |  81%  |                                                                              |=========================================================             |  82%  |                                                                              |==========================================================            |  83%  |                                                                              |===========================================================           |  84%  |                                                                              |============================================================          |  85%  |                                                                              |============================================================          |  86%  |                                                                              |=============================================================         |  87%  |                                                                              |==============================================================        |  88%  |                                                                              |==============================================================        |  89%  |                                                                              |===============================================================       |  90%  |                                                                              |================================================================      |  91%  |                                                                              |================================================================      |  92%  |                                                                              |=================================================================     |  93%  |                                                                              |==================================================================    |  94%  |                                                                              |==================================================================    |  95%  |                                                                              |===================================================================   |  96%  |                                                                              |====================================================================  |  97%  |                                                                              |===================================================================== |  98%  |                                                                              |===================================================================== |  99%  |                                                                              |======================================================================| 100%
#> Adjust for multiple testing using 'lfdr' ... 
#> 
#> Execute fdrtool() ...
#> Step 1... determine cutoff point
#> Step 2... estimate parameters of null distribution and eta0
#> Step 3... compute p-values and estimate empirical PDF/CDF
#> Step 4... compute q-values and local fdr
#> 
#> Done.
#> No significant differential associations detected after multiple testing adjustment.
                 
 #plot(diff1)
 #plot(diff2)
 # Note: Networks are empty (no significantly different associations) 
 # for only 100 permutations
# }
```
