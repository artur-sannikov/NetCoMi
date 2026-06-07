# gCoda: conditional dependence network inference for compositional data

A parallelized implementation of the gCoda approach (Fang et al., 2017),
published on GitHub (Fang, 2016).

## Usage

``` r
gcoda(
  x,
  counts = F,
  pseudo = 0.5,
  lambda.min.ratio = 1e-04,
  nlambda = 15,
  ebic.gamma = 0.5,
  cores = 1L,
  verbose = TRUE
)
```

## Arguments

- x:

  numeric matrix (*n*x*p*) with samples in rows and OTUs/taxa in
  columns.

- counts:

  logical indicating whether x constains counts or fractions. Defaults
  to `FALSE` meaning that x contains fractions so that rows sum up to 1.

- pseudo:

  numeric value giving a pseudo count, which is added to all counts if
  `counts = TRUE`. Default is 0.5.

- lambda.min.ratio:

  numeric value specifying lambda(max) / lambda(min). Defaults to 1e-4.

- nlambda:

  numberic value (integer) giving the of tuning parameters. Defaults to
  15.

- ebic.gamma:

  numeric value specifying the gamma value of EBIC. Defaults to 0.5.

- cores:

  integer indicating the number of CPU cores used for computation.
  Defaults to 1L. For `cores` \> 1L,
  [`foreach`](https://rdrr.io/pkg/foreach/man/foreach.html) is used for
  parallel execution.

- verbose:

  logical indicating whether a progress indicator is shown (`TRUE` by
  default).

## Value

A list containing the following elements:

|              |                                                |
|--------------|------------------------------------------------|
| `lambda`     | lambda sequence for compuation of EBIC score   |
| `nloglik`    | negative log likelihood for lambda sequence    |
| `df`         | number of edges for lambda sequence            |
| `path`       | sparse pattern for lambda sequence             |
| `icov`       | inverse covariance matrix for lambda sequence  |
| `ebic.score` | EBIC score for lambda sequence                 |
| `refit`      | sparse pattern with best EBIC score            |
| `opt.icov`   | inverse covariance matrix with best EBIC score |
| `opt.lambda` | lambda with best EBIC score                    |

## References

Fang H (2016). “gCoda: conditional dependence network inference for
compositional data.” https://github.com/huayingfang/gCoda.  
  
Fang H, Huang C, Zhao H, Deng M (2017). “gCoda: Conditional Dependence
Network Inference for Compositional Data.” *Journal of Computational
Biology*, 24(7), 699–708.

## Author

Fang Huaying, Peking University (R-Code and documentation)  
Stefanie Peschel (Parts of the documentation; Parallelization)
