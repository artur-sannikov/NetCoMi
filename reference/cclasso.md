# CCLasso: Correlation inference of Composition data through Lasso method

Implementation of the CCLasso approach (Fang et al., 2015), which is
published on GitHub (Fang, 2016). The function is extended by a progress
message.

## Usage

``` r
cclasso(
  x,
  counts = F,
  pseudo = 0.5,
  sig = NULL,
  lams = 10^(seq(0, -8, by = -0.01)),
  K = 3,
  kmax = 5000,
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

- sig:

  numeric matrix giving an initial covariance matrix. If `NULL`
  (default), `diag(rep(1, p))` is used.

- lams:

  numeric vector specifying the tuning parameter sequences. Default is
  `10^(seq(0, -8, by = -0.01))`.

- K:

  numeric value (integer) giving the folds of crossvalidation. Defaults
  to 3.

- kmax:

  numeric value (integer) specifying the maximum iteration for augmented
  lagrangian method. Default is 5000.

- verbose:

  logical indicating whether a progress indicator is shown (`TRUE` by
  default).

## Value

A list containing the following elements:

|         |                        |
|---------|------------------------|
| `cov.w` | Covariance estimation  |
| `cor.w` | Correlation estimation |
| `lam`   | Final tuning parameter |

## References

Fang H, Huang C, Zhao H, Deng M (2015). “CCLasso: correlation inference
for compositional data through Lasso.” *Bioinformatic*s, 31(19),
3172–3180.  
  
Fang H (2016). “CCLasso: Correlation Inference for Compositional Data
through Lasso.” https://github.com/huayingfang/CCLasso.

## Author

Fang Huaying, Peking University (R code)  
Stefanie Peschel (documentation)
