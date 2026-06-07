# Package index

## Main functions

Main functions to follow the workflow of constructing, analyzing, and
comparing microbiome networks.

- [`netConstruct()`](https://netcomi.de/reference/netConstruct.md) :
  Constructing Networks for Microbiome Data
- [`netAnalyze()`](https://netcomi.de/reference/netAnalyze.md) :
  Microbiome Network Analysis
- [`netCompare()`](https://netcomi.de/reference/netCompare.md) : Group
  Comparison of Network Properties
- [`diffnet()`](https://netcomi.de/reference/diffnet.md) : Constructing
  Differential Networks for Microbiome Data
- [`installNetCoMiPacks()`](https://netcomi.de/reference/installNetCoMiPacks.md)
  : Install all packages used within NetCoMi

## Association estimation

Association estimation methods implemented in NetCoMi.

- [`cclasso()`](https://netcomi.de/reference/cclasso.md) : CCLasso:
  Correlation inference of Composition data through Lasso method
- [`gcoda()`](https://netcomi.de/reference/gcoda.md) : gCoda:
  conditional dependence network inference for compositional data

## Helpers

A bunch of helpful functions that are mainly used by other functions.

- [`createAssoPerm()`](https://netcomi.de/reference/createAssoPerm.md) :
  Create and store association matrices for permuted data
- [`colToTransp()`](https://netcomi.de/reference/colToTransp.md) :
  Adding transparency to a color
- [`calcGCD()`](https://netcomi.de/reference/calcGCD.md) : Graphlet
  Correlation Distance (GCD)
- [`calcGCM()`](https://netcomi.de/reference/calcGCM.md) : Graphlet
  Correlation Matrix (GCM)
- [`editLabels()`](https://netcomi.de/reference/editLabels.md) : Edit
  labels
- [`multAdjust()`](https://netcomi.de/reference/multAdjust.md) :
  Multiple testing adjustment
- [`plotHeat()`](https://netcomi.de/reference/plotHeat.md) : Create a
  heatmap with p-values
- [`renameTaxa()`](https://netcomi.de/reference/renameTaxa.md) : Rename
  taxa
- [`testGCM()`](https://netcomi.de/reference/testGCM.md) : Test GCM(s)
  for statistical significance

## S3 methods

- [`plot(`*`<diffnet>`*`)`](https://netcomi.de/reference/plot.diffnet.md)
  : Plot method for objects of class diffnet
- [`plot(`*`<microNetProps>`*`)`](https://netcomi.de/reference/plot.microNetProps.md)
  : Plot Method for microNetProps Objects
- [`print(`*`<GCD>`*`)`](https://netcomi.de/reference/print.GCD.md) :
  Print method for GCD objects
- [`summary(`*`<microNetComp>`*`)`](https://netcomi.de/reference/summarize.microNetComp.md)
  [`print(`*`<summary.microNetComp>`*`)`](https://netcomi.de/reference/summarize.microNetComp.md)
  : Summary Method for Objects of Class microNetComp
- [`summary(`*`<microNetProps>`*`)`](https://netcomi.de/reference/summarize.microNetProps.md)
  [`print(`*`<summary.microNetProps>`*`)`](https://netcomi.de/reference/summarize.microNetProps.md)
  : Summary Method for Objects of Class microNetProps
