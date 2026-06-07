# Adding transparency to a color

Adding transparency to a color

## Usage

``` r
colToTransp(col, percent = 50)
```

## Arguments

- col:

  color vector specified similar to the `col` argument in
  [`col2rgb`](https://rdrr.io/r/grDevices/col2rgb.html)

- percent:

  numeric between 0 and 100 giving the level of transparency. Defaults
  to 50.

## Examples

``` r
# Excepts hexadecimal strings, written colors, or numbers as input
colToTransp("#FF0000FF", 50)
#> [1] "#FF00007F"
colToTransp("black", 50)
#> [1] "#0000007F"
colToTransp(2)
#> [1] "#DF536B7F"

# Different shades of red
r80 <- colToTransp("red", 80)
r50 <- colToTransp("red", 50)
r20 <- colToTransp("red", 20)

barplot(rep(5, 4), col=c("red", r20, r50, r80), names.arg = 1:4)


# Vector as input
rain_transp <- colToTransp(rainbow(5), 50)

barplot(rep(5, 5), col = rain_transp, names.arg = 1:5)

```
