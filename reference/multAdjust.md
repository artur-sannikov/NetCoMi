# Multiple testing adjustment

The functions adjusts a vector of p-values for multiple testing

## Usage

``` r
multAdjust(
  pvals,
  adjust = "adaptBH",
  trueNullMethod = "convest",
  pTrueNull = NULL,
  verbose = FALSE
)
```

## Arguments

- pvals:

  numeric vector with p-values

- adjust:

  character specifying the method used for adjustment. Can be `"lfdr"`,
  `"adaptBH"`, or one of the methods provided by
  [`p.adjust`](https://rdrr.io/r/stats/p.adjust.html).

- trueNullMethod:

  character indicating the method used for estimating the proportion of
  true null hypotheses from a vector of p-values. Used for the adaptive
  Benjamini-Hochberg method for multiple testing adjustment (chosen by
  `adjust = "adaptBH"`). Accepts the provided options of the `method`
  argument of
  [`propTrueNull`](https://rdrr.io/pkg/limma/man/propTrueNull.html):
  `"convest"`(default), `"lfdr"`, `"mean"`, and `"hist"`. Can
  alternatively be `"farco"` for the "iterative plug-in method" proposed
  by Farcomeni (2007).

- pTrueNull:

  proportion of true null hypothesis used for the adaptBH method. If
  `NULL`, the proportion is computed using the method defined via
  `trueNullMethod`.

- verbose:

  if `TRUE`, progress messages are returned.

## References

Farcomeni A (2007). “Some results on the control of the false discovery
rate under dependence.” *Scandinavian Journal of Statistics*, 34(2),
275–297.
