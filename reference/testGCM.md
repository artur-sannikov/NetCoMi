# Test GCM(s) for statistical significance

The function tests whether graphlet correlations (entries of the GCM)
are significantly different from zero.  
  
If two GCMs are given, the graphlet correlations of the two networks are
tested for being significantly different, i.e., Fishers z-test is
performed to test if the absolute differences between graphlet
correlations are significantly different from zero.

## Usage

``` r
testGCM(
  obj1,
  obj2 = NULL,
  adjust = "adaptBH",
  lfdrThresh = 0.2,
  trueNullMethod = "convest",
  alpha = 0.05,
  verbose = TRUE
)
```

## Arguments

- obj1:

  object of class `GCM` or `GCD` returned by
  [`calcGCM`](https://netcomi.de/reference/calcGCM.md) or
  [`calcGCD`](https://netcomi.de/reference/calcGCD.md). See details.

- obj2:

  optional object of class `GCM` returned by
  [`calcGCM`](https://netcomi.de/reference/calcGCM.md). See details.

- adjust:

  character indicating the method used for multiple testing adjustment.
  Possible values are "lfdr" (default) for local false discovery rate
  correction (via
  [`fdrtool`](https://rdrr.io/pkg/fdrtool/man/fdrtool.html)), "adaptBH"
  for the adaptive Benjamini-Hochberg method (Benjamini and Hochberg,
  2000), or one of the methods provided by
  [`p.adjust`](https://rdrr.io/r/stats/p.adjust.html).

- lfdrThresh:

  defines a threshold for the local fdr if "lfdr" is chosen as method
  for multiple testing correction. Defaults to 0.2 meaning that
  differences with a corresponding local fdr less than or equal to 0.2
  are identified as significant.

- trueNullMethod:

  character indicating the method used for estimating the proportion of
  true null hypotheses from a vector of p-values. Used for the adaptive
  Benjamini-Hochberg method for multiple testing adjustment (chosen by
  `adjust = "adaptBH"`). Accepts the provided options of the `method`
  argument of
  [`propTrueNull`](https://rdrr.io/pkg/limma/man/propTrueNull.html):
  "convest" (default), "lfdr", "mean", and "hist". Can alternatively be
  "farco" for the "iterative plug-in method" proposed by Farcomeni
  (2007).

- alpha:

  numeric value between 0 and 1 giving the desired significance level.

- verbose:

  logical. If `TRUE` (default), progress messages are printed.

## Value

A list with the following elements:

|            |                                       |
|------------|---------------------------------------|
| `gcm1`     | Graphlet Correlatoin Matrix GCM1      |
| `pvals1`   | Matrix with p-values (H0: gc1_ij = 0) |
| `padjust1` | Matrix with adjusted p-values         |

  
Additional elements if two GCMs are given:

|  |  |
|----|----|
| `gcm2` | Graphlet Correlatoin Matrix GCM2 |
| `pvals2` | Matrix with p-values (H0: gc2_ij = 0) |
| `padjust2` | Matrix with adjusted p-values |
| `diff` | Matrix with differences between graphlet correlations (GCM1 - GCM2) |
| `absDiff` | Matrix with absolute differences between graphlet correlations (\|GCM1 - GCM2\|) |
| `pvalsDiff` | Matrix with p-values (H0: \|gc1_ij - gc2_ij\| = 0) |
| `pAdjustDiff` | Matrix with adjusted p-values |
| `sigDiff` | Same as `diff`, but non-significant differences are set to zero. |
| `sigAbsDiff` | Same as `absDiff`, but non-significant values are set to zero. |

## Details

By applying Student's t-test to the Fisher-transformed correlations, all
entries of the GCM(s) are tested for being significantly different from
zero:  
  
H0: gc_ij = 0 vs. H1: gc_ij != 0,  
  
with gc_ij being the graphlet correlations.  
  

If both GCMs are given or `obj1` is of class `GCD`, the absolute
differences between graphlet correlations are tested for being different
from zero using Fisher's z-test. The hypotheses are:  
  
H0: \|d_ij\| = 0 vs. H1: \|d_ij\| \> 0,  
  
where d_ij = gc1_ij - gc2_ij

## Examples

``` r
# See help page of calcGCD()
?calcGCD
```
