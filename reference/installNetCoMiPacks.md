# Install all packages used within NetCoMi

This function installs the R packages used in NetCoMi not listed as
dependencies or imports in NetCoMi's description file. These are
optional packages only needed in certain network construction
settings.  

`BiocManager::`[`install`](https://bioconductor.github.io/BiocManager/reference/install.html)
is used for installation since it installs or updates Bioconductor as
well as CRAN packages.  

Installed CRAN packages:

- cccd

- LaplacesDemon

- propr

- zCompositions

Installed Bioconductor packages:

- ccrepe

- DESeq2

- discordant

- limma

- metagenomeSeq

If not installed via this function, the packages are installed by the
respective NetCoMi functions when needed.

## Usage

``` r
installNetCoMiPacks(onlyMissing = TRUE, lib = NULL, ...)
```

## Arguments

- onlyMissing:

  logical. If `TRUE` (default),
  [`installed.packages`](https://rdrr.io/r/utils/installed.packages.html)
  is used to read out the packages installed in the given library and
  only missing packages are installed. If `FALSE`, all packages are
  installed or updated (if already installed).

- lib:

  character vector giving the library directories where to install
  missing packages. If `NULL`, the first element of
  [`.libPaths`](https://rdrr.io/r/base/libPaths.html) is used.

- ...:

  Additional arguments used by
  [`install`](https://bioconductor.github.io/BiocManager/reference/install.html)
  or
  [`install.packages`](https://rdrr.io/r/utils/install.packages.html).
