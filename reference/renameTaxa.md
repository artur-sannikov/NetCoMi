# Rename taxa

Function for renaming taxa in a taxonomy table, which can be given as
matrix or phyloseq object.  
  
It comes with functionality for making unknown and unclassified taxa
unique and substituting them by the next higher known taxonomic level,
e.g., an unknown genus "g\_\_" can automatically be renamed to
"1_Streptococcaceae(F)". User-defined patterns determine the format of
known and substituted names. Unknown names (e.g., NAs) and unclassified
taxa can be handled separately. Duplicated names within one or more
chosen ranks can also be made unique by numbering them consecutively.

## Usage

``` r
renameTaxa(
  taxtab,
  pat = "<r>_<name>",
  substPat = "<r>_<name>_<subst_r>_<subst_name>",
  unknown = c(NA, "", " ", "__"),
  numUnknown = TRUE,
  unclass = c("unclassified", "Unclassified"),
  numUnclass = TRUE,
  numUnclassPat = "<name><num>",
  numDupli = NULL,
  numDupliPat = "<name><num>",
  ranks = NULL,
  ranksAbb = NULL,
  ignoreCols = NULL
)
```

## Arguments

- taxtab:

  taxonomy table (matrix containing the taxonomic names; columns must be
  taxonomic ranks). Can also be an object of the classes:
  [`phyloseq`](https://rdrr.io/pkg/phyloseq/man/phyloseq-class.html),
  [`SummarizedExperiment`](https://rdrr.io/pkg/SummarizedExperiment/man/SummarizedExperiment-class.html),
  [`TreeSummarizedExperiment`](https://rdrr.io/pkg/TreeSummarizedExperiment/man/TreeSummarizedExperiment-class.html).

- pat:

  character specifying the pattern of new taxonomic names if the current
  name is KNOWN. See the examples and default value for a demo. Possible
  space holders are:

  `<name>`

  :   Taxonomic name (either the original or replaced one)

  `<rank>`

  :   Taxonomic rank in lower case

  `<Rank>`

  :   Taxonomic rank with first letter in upper case

  `<r>`

  :   Abbreviated taxonomic rank in lower case

  `<R>`

  :   Abbreviated taxonomic rank in upper case

- substPat:

  character specifying the pattern of new taxonomic names if the current
  name is UNKNOWN. The current name is substituted by the next higher
  existing name. Possible space holders (in addition to that of `pat`):

  `<subst_name>`

  :   Substituted taxonomic name (next higher existing name)

  `<subst_rank>`

  :   Taxonomic rank of substitute name in lower case

  `<subst_Rank>`

  :   Taxonomic rank of substitute name with first letter in upper case

  `<subst_r>`

  :   Abbreviated taxonomic rank of substitute name in lower case

  `<subst_R>`

  :   Abbreviated taxonomic rank of substitute name in upper case

- unknown:

  character vector giving the labels of unknown taxa, without leading
  rank label (e.g., "g\_" or "g\_\_" for genus level). If
  `numUnknown = TRUE`, unknown names are replaced by a number.

- numUnknown:

  logical. If `TRUE`, a number is assigned to all unknown taxonomic
  names (defined by `unknown`) to make them unique.

- unclass:

  character vector giving the label of unclassified taxa, without
  leading rank label (e.g., "g\_" or "g\_\_" for genus level). If
  `numUnclass = TRUE`, a number is added to the names of unclassified
  taxa. Note that unclassified taxa and unknown taxa get a separate
  numbering if `unclass` is set. To replace all unknown and unclassified
  taxa by numbers, add "unclassified" (or the appropriate counterpart)
  to `unknown` and set `unclass` to `NULL`.

- numUnclass:

  logical. If `TRUE`, a number is assigned to all unclassified taxa
  (defined by `unclass`) to make them unique. The pattern is defined via
  `numUnclassPat`.

- numUnclassPat:

  character defining the pattern used for numbering unclassified taxa.
  Must include a space holder for the name ("\<name\>") and one for the
  number ("\<num\>"). Default is "\<name\>\<num\>" resulting e.g., in
  "unclassified1".

- numDupli:

  character vector giving the ranks that should be made unique by adding
  a number. Elements must match column names. The pattern is defined via
  `numDupliPat`.

- numDupliPat:

  character defining the pattern used for numbering duplicated names (if
  `numDupli` is given). Must include a space holder for the name
  ("\<name\>") and one for the number ("\<num\>"). Default is
  "\<name\>\<num\>" resulting e.g., in "Ruminococcus1".

- ranks:

  character vector giving rank names used for renaming the taxa. If
  `NULL`, the functions tries to automatically set rank names based on
  common usage.

- ranksAbb:

  character vector giving abbreviated rank names, which are directly
  used for the place holders \<r\>, \<subst_r\>, \<R\>, and \<subst_R\>
  (the former two in lower case and the latter two in upper case). If
  `NULL`, the first letter of the rank names is used.

- ignoreCols:

  numeric vector with columns to be ignored. Names remain unchanged for
  these columns. Columns containing `NA`s are ignored automatically only
  if `ignoreCols = NULL`. Note: length of `ranks` and `ranksAbb` must
  match the number of non-ignored columns.

## Value

Renamed taxonomy table (matrix or phyloseq object, depending on the
input).

## Examples

``` r
#--- Load and edit data -----------------------------------------------------

library(phyloseq)
data("GlobalPatterns")
global <- subset_taxa(GlobalPatterns, Kingdom == "Bacteria")
taxtab <- global@tax_table@.Data[1:10, ]

# Add some unclassified taxa
taxtab[c(2,3,5), "Species"] <- "unclassified"
taxtab[c(2,3), "Genus"] <- "unclassified"
taxtab[2, "Family"] <- "unclassified"

# Add some blanks
taxtab[7, "Genus"] <- " "
taxtab[7:9, "Species"] <- " "

# Add taxon that is unclassified up to Kingdom
taxtab[9, ] <- "unclassified"
taxtab[9, 1] <- "Unclassified"

# Add row names
rownames(taxtab) <- paste0("OTU", 1:nrow(taxtab))

print(taxtab)
#>       Kingdom        Phylum           Class            Order            
#> OTU1  "Bacteria"     "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU2  "Bacteria"     "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU3  "Bacteria"     "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU4  "Bacteria"     "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU5  "Bacteria"     "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU6  "Bacteria"     "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU7  "Bacteria"     "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU8  "Bacteria"     "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU9  "Unclassified" "unclassified"   "unclassified"   "unclassified"   
#> OTU10 "Bacteria"     "Actinobacteria" "Actinobacteria" "Actinomycetales"
#>       Family                 Genus                Species                 
#> OTU1  "Propionibacteriaceae" "Propionibacterium"  "Propionibacteriumacnes"
#> OTU2  "unclassified"         "unclassified"       "unclassified"          
#> OTU3  "Propionibacteriaceae" "unclassified"       "unclassified"          
#> OTU4  "Propionibacteriaceae" "Tessaracoccus"      NA                      
#> OTU5  "Propionibacteriaceae" "Aestuariimicrobium" "unclassified"          
#> OTU6  NA                     NA                   NA                      
#> OTU7  "Nocardioidaceae"      " "                  " "                     
#> OTU8  "Nocardioidaceae"      "Propionicimonas"    " "                     
#> OTU9  "unclassified"         "unclassified"       "unclassified"          
#> OTU10 NA                     NA                   NA                      

#--- Example 1 (default setting) --------------------------------------------

# Example 1 (default setting)
# - Known names are replaced by "<r>_<name>"
# - Unknown names are replaced by "<r>_<name>_<subst_r>_<subst_name>"
# - Unclassified taxa have separate numbering
# - Ranks are taken from column names
# - e.g., unknown genus -> "g_1_f_Streptococcaceae"

renamed1 <- renameTaxa(taxtab)
renamed1
#>       Kingdom           Phylum                           
#> OTU1  "k_Bacteria"      "p_Actinobacteria"               
#> OTU2  "k_Bacteria"      "p_Actinobacteria"               
#> OTU3  "k_Bacteria"      "p_Actinobacteria"               
#> OTU4  "k_Bacteria"      "p_Actinobacteria"               
#> OTU5  "k_Bacteria"      "p_Actinobacteria"               
#> OTU6  "k_Bacteria"      "p_Actinobacteria"               
#> OTU7  "k_Bacteria"      "p_Actinobacteria"               
#> OTU8  "k_Bacteria"      "p_Actinobacteria"               
#> OTU9  "k_Unclassified1" "p_unclassified1_k_Unclassified1"
#> OTU10 "k_Bacteria"      "p_Actinobacteria"               
#>       Class                             Order                            
#> OTU1  "c_Actinobacteria"                "o_Actinomycetales"              
#> OTU2  "c_Actinobacteria"                "o_Actinomycetales"              
#> OTU3  "c_Actinobacteria"                "o_Actinomycetales"              
#> OTU4  "c_Actinobacteria"                "o_Actinomycetales"              
#> OTU5  "c_Actinobacteria"                "o_Actinomycetales"              
#> OTU6  "c_Actinobacteria"                "o_Actinomycetales"              
#> OTU7  "c_Actinobacteria"                "o_Actinomycetales"              
#> OTU8  "c_Actinobacteria"                "o_Actinomycetales"              
#> OTU9  "c_unclassified1_k_Unclassified1" "o_unclassified1_k_Unclassified1"
#> OTU10 "c_Actinobacteria"                "o_Actinomycetales"              
#>       Family                             
#> OTU1  "f_Propionibacteriaceae"           
#> OTU2  "f_unclassified1_o_Actinomycetales"
#> OTU3  "f_Propionibacteriaceae"           
#> OTU4  "f_Propionibacteriaceae"           
#> OTU5  "f_Propionibacteriaceae"           
#> OTU6  "f_1_o_Actinomycetales"            
#> OTU7  "f_Nocardioidaceae"                
#> OTU8  "f_Nocardioidaceae"                
#> OTU9  "f_unclassified2_k_Unclassified1"  
#> OTU10 "f_2_o_Actinomycetales"            
#>       Genus                                   
#> OTU1  "g_Propionibacterium"                   
#> OTU2  "g_unclassified1_o_Actinomycetales"     
#> OTU3  "g_unclassified2_f_Propionibacteriaceae"
#> OTU4  "g_Tessaracoccus"                       
#> OTU5  "g_Aestuariimicrobium"                  
#> OTU6  "g_1_o_Actinomycetales"                 
#> OTU7  "g_2_f_Nocardioidaceae"                 
#> OTU8  "g_Propionicimonas"                     
#> OTU9  "g_unclassified3_k_Unclassified1"       
#> OTU10 "g_3_o_Actinomycetales"                 
#>       Species                                 
#> OTU1  "s_Propionibacteriumacnes"              
#> OTU2  "s_unclassified1_o_Actinomycetales"     
#> OTU3  "s_unclassified2_f_Propionibacteriaceae"
#> OTU4  "s_1_g_Tessaracoccus"                   
#> OTU5  "s_unclassified3_g_Aestuariimicrobium"  
#> OTU6  "s_2_o_Actinomycetales"                 
#> OTU7  "s_3_f_Nocardioidaceae"                 
#> OTU8  "s_4_g_Propionicimonas"                 
#> OTU9  "s_unclassified4_k_Unclassified1"       
#> OTU10 "s_5_o_Actinomycetales"                 

#--- Example 2 --------------------------------------------------------------
# - Use phyloseq object (subset of class clostridia to decrease runtime)

global_sub <- subset_taxa(global, Class == "Clostridia")

renamed2 <- renameTaxa(global_sub)
tax_table(renamed2)[1:5, ]
#> Taxonomy Table:     [5 taxa by 7 taxonomic ranks]:
#>        Kingdom      Phylum         Class          Order              
#> 69790  "k_Bacteria" "p_Firmicutes" "c_Clostridia" "o_Halanaerobiales"
#> 201587 "k_Bacteria" "p_Firmicutes" "c_Clostridia" "o_Halanaerobiales"
#> 14244  "k_Bacteria" "p_Firmicutes" "c_Clostridia" "o_Clostridiales"  
#> 589048 "k_Bacteria" "p_Firmicutes" "c_Clostridia" "o_Clostridiales"  
#> 310026 "k_Bacteria" "p_Firmicutes" "c_Clostridia" "o_Clostridiales"  
#>        Family                 Genus                     
#> 69790  "f_Halobacteroidaceae" "g_1_f_Halobacteroidaceae"
#> 201587 "f_Halanaerobiaceae"   "g_2_f_Halanaerobiaceae"  
#> 14244  "f_1_o_Clostridiales"  "g_3_o_Clostridiales"     
#> 589048 "f_2_o_Clostridiales"  "g_4_o_Clostridiales"     
#> 310026 "f_3_o_Clostridiales"  "g_5_o_Clostridiales"     
#>        Species                   
#> 69790  "s_1_f_Halobacteroidaceae"
#> 201587 "s_2_f_Halanaerobiaceae"  
#> 14244  "s_3_o_Clostridiales"     
#> 589048 "s_4_o_Clostridiales"     
#> 310026 "s_5_o_Clostridiales"     

#--- Example 3 --------------------------------------------------------------
# - Known names remain unchanged
# - Substituted names are indicated by their rank in brackets
# - Pattern for numbering unclassified taxa changed
# - e.g., unknown genus -> "Streptococcaceae (F)"
# - Note: Numbering of unknowns is not shown because "<name>" is not 
#   included in "substPat"

renamed3 <- renameTaxa(taxtab, numUnclassPat = "<name>_<num>",
                         pat = "<name>", 
                         substPat = "<subst_name> (<subst_R>)")
renamed3
#>       Kingdom          Phylum               Class               
#> OTU1  "Bacteria"       "Actinobacteria"     "Actinobacteria"    
#> OTU2  "Bacteria"       "Actinobacteria"     "Actinobacteria"    
#> OTU3  "Bacteria"       "Actinobacteria"     "Actinobacteria"    
#> OTU4  "Bacteria"       "Actinobacteria"     "Actinobacteria"    
#> OTU5  "Bacteria"       "Actinobacteria"     "Actinobacteria"    
#> OTU6  "Bacteria"       "Actinobacteria"     "Actinobacteria"    
#> OTU7  "Bacteria"       "Actinobacteria"     "Actinobacteria"    
#> OTU8  "Bacteria"       "Actinobacteria"     "Actinobacteria"    
#> OTU9  "Unclassified_1" "Unclassified_1 (K)" "Unclassified_1 (K)"
#> OTU10 "Bacteria"       "Actinobacteria"     "Actinobacteria"    
#>       Order                Family                 Genus                     
#> OTU1  "Actinomycetales"    "Propionibacteriaceae" "Propionibacterium"       
#> OTU2  "Actinomycetales"    "Actinomycetales (O)"  "Actinomycetales (O)"     
#> OTU3  "Actinomycetales"    "Propionibacteriaceae" "Propionibacteriaceae (F)"
#> OTU4  "Actinomycetales"    "Propionibacteriaceae" "Tessaracoccus"           
#> OTU5  "Actinomycetales"    "Propionibacteriaceae" "Aestuariimicrobium"      
#> OTU6  "Actinomycetales"    "Actinomycetales (O)"  "Actinomycetales (O)"     
#> OTU7  "Actinomycetales"    "Nocardioidaceae"      "Nocardioidaceae (F)"     
#> OTU8  "Actinomycetales"    "Nocardioidaceae"      "Propionicimonas"         
#> OTU9  "Unclassified_1 (K)" "Unclassified_1 (K)"   "Unclassified_1 (K)"      
#> OTU10 "Actinomycetales"    "Actinomycetales (O)"  "Actinomycetales (O)"     
#>       Species                   
#> OTU1  "Propionibacteriumacnes"  
#> OTU2  "Actinomycetales (O)"     
#> OTU3  "Propionibacteriaceae (F)"
#> OTU4  "Tessaracoccus (G)"       
#> OTU5  "Aestuariimicrobium (G)"  
#> OTU6  "Actinomycetales (O)"     
#> OTU7  "Nocardioidaceae (F)"     
#> OTU8  "Propionicimonas (G)"     
#> OTU9  "Unclassified_1 (K)"      
#> OTU10 "Actinomycetales (O)"     

#--- Example 4 --------------------------------------------------------------
# - Same as before but numbering shown for unknown names
# - e.g., unknown genus -> "1 Streptococcaceae (F)"

renamed4 <- renameTaxa(taxtab, numUnclassPat = "<name>_<num>",
                         pat = "<name>", 
                         substPat = "<name> <subst_name> (<subst_R>)")
renamed4
#>       Kingdom          Phylum                             
#> OTU1  "Bacteria"       "Actinobacteria"                   
#> OTU2  "Bacteria"       "Actinobacteria"                   
#> OTU3  "Bacteria"       "Actinobacteria"                   
#> OTU4  "Bacteria"       "Actinobacteria"                   
#> OTU5  "Bacteria"       "Actinobacteria"                   
#> OTU6  "Bacteria"       "Actinobacteria"                   
#> OTU7  "Bacteria"       "Actinobacteria"                   
#> OTU8  "Bacteria"       "Actinobacteria"                   
#> OTU9  "Unclassified_1" "unclassified_1 Unclassified_1 (K)"
#> OTU10 "Bacteria"       "Actinobacteria"                   
#>       Class                               Order                              
#> OTU1  "Actinobacteria"                    "Actinomycetales"                  
#> OTU2  "Actinobacteria"                    "Actinomycetales"                  
#> OTU3  "Actinobacteria"                    "Actinomycetales"                  
#> OTU4  "Actinobacteria"                    "Actinomycetales"                  
#> OTU5  "Actinobacteria"                    "Actinomycetales"                  
#> OTU6  "Actinobacteria"                    "Actinomycetales"                  
#> OTU7  "Actinobacteria"                    "Actinomycetales"                  
#> OTU8  "Actinobacteria"                    "Actinomycetales"                  
#> OTU9  "unclassified_1 Unclassified_1 (K)" "unclassified_1 Unclassified_1 (K)"
#> OTU10 "Actinobacteria"                    "Actinomycetales"                  
#>       Family                              
#> OTU1  "Propionibacteriaceae"              
#> OTU2  "unclassified_1 Actinomycetales (O)"
#> OTU3  "Propionibacteriaceae"              
#> OTU4  "Propionibacteriaceae"              
#> OTU5  "Propionibacteriaceae"              
#> OTU6  "1 Actinomycetales (O)"             
#> OTU7  "Nocardioidaceae"                   
#> OTU8  "Nocardioidaceae"                   
#> OTU9  "unclassified_2 Unclassified_1 (K)" 
#> OTU10 "2 Actinomycetales (O)"             
#>       Genus                                    
#> OTU1  "Propionibacterium"                      
#> OTU2  "unclassified_1 Actinomycetales (O)"     
#> OTU3  "unclassified_2 Propionibacteriaceae (F)"
#> OTU4  "Tessaracoccus"                          
#> OTU5  "Aestuariimicrobium"                     
#> OTU6  "1 Actinomycetales (O)"                  
#> OTU7  "2 Nocardioidaceae (F)"                  
#> OTU8  "Propionicimonas"                        
#> OTU9  "unclassified_3 Unclassified_1 (K)"      
#> OTU10 "3 Actinomycetales (O)"                  
#>       Species                                  
#> OTU1  "Propionibacteriumacnes"                 
#> OTU2  "unclassified_1 Actinomycetales (O)"     
#> OTU3  "unclassified_2 Propionibacteriaceae (F)"
#> OTU4  "1 Tessaracoccus (G)"                    
#> OTU5  "unclassified_3 Aestuariimicrobium (G)"  
#> OTU6  "2 Actinomycetales (O)"                  
#> OTU7  "3 Nocardioidaceae (F)"                  
#> OTU8  "4 Propionicimonas (G)"                  
#> OTU9  "unclassified_4 Unclassified_1 (K)"      
#> OTU10 "5 Actinomycetales (O)"                  

#--- Example 5 --------------------------------------------------------------
# - Same numbering for unkown names and unclassified taxa
# - e.g., unknown genus -> "1_Streptococcaceae(F)"
# - Note: We get a warning here because "Unclassified" (with capital U) 
#   are not included in "unknown" but occur in the data

renamed5 <- renameTaxa(taxtab, unclass = NULL,
                         unknown = c(NA, " ", "unclassified"), 
                         pat = "<name>", 
                         substPat = "<name>_<subst_name>(<subst_R>)")
#> Warning: Taxonomy table contains unclassified taxa. Consider adding "Unclassified" to argument "unknown".
renamed5
#>       Kingdom        Phylum              Class              
#> OTU1  "Bacteria"     "Actinobacteria"    "Actinobacteria"   
#> OTU2  "Bacteria"     "Actinobacteria"    "Actinobacteria"   
#> OTU3  "Bacteria"     "Actinobacteria"    "Actinobacteria"   
#> OTU4  "Bacteria"     "Actinobacteria"    "Actinobacteria"   
#> OTU5  "Bacteria"     "Actinobacteria"    "Actinobacteria"   
#> OTU6  "Bacteria"     "Actinobacteria"    "Actinobacteria"   
#> OTU7  "Bacteria"     "Actinobacteria"    "Actinobacteria"   
#> OTU8  "Bacteria"     "Actinobacteria"    "Actinobacteria"   
#> OTU9  "Unclassified" "1_Unclassified(K)" "1_Unclassified(K)"
#> OTU10 "Bacteria"     "Actinobacteria"    "Actinobacteria"   
#>       Order               Family                 Genus                      
#> OTU1  "Actinomycetales"   "Propionibacteriaceae" "Propionibacterium"        
#> OTU2  "Actinomycetales"   "1_Actinomycetales(O)" "1_Actinomycetales(O)"     
#> OTU3  "Actinomycetales"   "Propionibacteriaceae" "2_Propionibacteriaceae(F)"
#> OTU4  "Actinomycetales"   "Propionibacteriaceae" "Tessaracoccus"            
#> OTU5  "Actinomycetales"   "Propionibacteriaceae" "Aestuariimicrobium"       
#> OTU6  "Actinomycetales"   "2_Actinomycetales(O)" "3_Actinomycetales(O)"     
#> OTU7  "Actinomycetales"   "Nocardioidaceae"      "4_Nocardioidaceae(F)"     
#> OTU8  "Actinomycetales"   "Nocardioidaceae"      "Propionicimonas"          
#> OTU9  "1_Unclassified(K)" "3_Unclassified(K)"    "5_Unclassified(K)"        
#> OTU10 "Actinomycetales"   "4_Actinomycetales(O)" "6_Actinomycetales(O)"     
#>       Species                    
#> OTU1  "Propionibacteriumacnes"   
#> OTU2  "1_Actinomycetales(O)"     
#> OTU3  "2_Propionibacteriaceae(F)"
#> OTU4  "3_Tessaracoccus(G)"       
#> OTU5  "4_Aestuariimicrobium(G)"  
#> OTU6  "5_Actinomycetales(O)"     
#> OTU7  "6_Nocardioidaceae(F)"     
#> OTU8  "7_Propionicimonas(G)"     
#> OTU9  "8_Unclassified(K)"        
#> OTU10 "9_Actinomycetales(O)"     

#--- Example 6 --------------------------------------------------------------
# - Same as before, but OTU9 is now renamed correctly

renamed6 <- renameTaxa(taxtab, unclass = NULL,
                         unknown = c(NA, " ", "unclassified", "Unclassified"),
                         pat = "<name>", 
                         substPat = "<name>_<subst_name>(<subst_R>)")
renamed6
#>       Kingdom    Phylum           Class            Order            
#> OTU1  "Bacteria" "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU2  "Bacteria" "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU3  "Bacteria" "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU4  "Bacteria" "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU5  "Bacteria" "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU6  "Bacteria" "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU7  "Bacteria" "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU8  "Bacteria" "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU9  "1"        "1_1(K)"         "1_1(K)"         "1_1(K)"         
#> OTU10 "Bacteria" "Actinobacteria" "Actinobacteria" "Actinomycetales"
#>       Family                 Genus                      
#> OTU1  "Propionibacteriaceae" "Propionibacterium"        
#> OTU2  "1_Actinomycetales(O)" "1_Actinomycetales(O)"     
#> OTU3  "Propionibacteriaceae" "2_Propionibacteriaceae(F)"
#> OTU4  "Propionibacteriaceae" "Tessaracoccus"            
#> OTU5  "Propionibacteriaceae" "Aestuariimicrobium"       
#> OTU6  "2_Actinomycetales(O)" "3_Actinomycetales(O)"     
#> OTU7  "Nocardioidaceae"      "4_Nocardioidaceae(F)"     
#> OTU8  "Nocardioidaceae"      "Propionicimonas"          
#> OTU9  "3_1(K)"               "5_1(K)"                   
#> OTU10 "4_Actinomycetales(O)" "6_Actinomycetales(O)"     
#>       Species                    
#> OTU1  "Propionibacteriumacnes"   
#> OTU2  "1_Actinomycetales(O)"     
#> OTU3  "2_Propionibacteriaceae(F)"
#> OTU4  "3_Tessaracoccus(G)"       
#> OTU5  "4_Aestuariimicrobium(G)"  
#> OTU6  "5_Actinomycetales(O)"     
#> OTU7  "6_Nocardioidaceae(F)"     
#> OTU8  "7_Propionicimonas(G)"     
#> OTU9  "8_1(K)"                   
#> OTU10 "9_Actinomycetales(O)"     

#--- Example 7 --------------------------------------------------------------
# - Add "(<Rank>: unknown)" to unknown names
# - e.g., unknown genus -> "1 Streptococcaceae (Genus: unknown)"

renamed7 <- renameTaxa(taxtab, unclass = NULL,
                         unknown = c(NA, " ", "unclassified", "Unclassified"),
                         pat = "<name>", 
                         substPat = "<name> <subst_name> (<Rank>: unknown)")
renamed7
#>       Kingdom    Phylum                  Class                 
#> OTU1  "Bacteria" "Actinobacteria"        "Actinobacteria"      
#> OTU2  "Bacteria" "Actinobacteria"        "Actinobacteria"      
#> OTU3  "Bacteria" "Actinobacteria"        "Actinobacteria"      
#> OTU4  "Bacteria" "Actinobacteria"        "Actinobacteria"      
#> OTU5  "Bacteria" "Actinobacteria"        "Actinobacteria"      
#> OTU6  "Bacteria" "Actinobacteria"        "Actinobacteria"      
#> OTU7  "Bacteria" "Actinobacteria"        "Actinobacteria"      
#> OTU8  "Bacteria" "Actinobacteria"        "Actinobacteria"      
#> OTU9  "1"        "1 1 (Phylum: unknown)" "1 1 (Class: unknown)"
#> OTU10 "Bacteria" "Actinobacteria"        "Actinobacteria"      
#>       Order                  Family                               
#> OTU1  "Actinomycetales"      "Propionibacteriaceae"               
#> OTU2  "Actinomycetales"      "1 Actinomycetales (Family: unknown)"
#> OTU3  "Actinomycetales"      "Propionibacteriaceae"               
#> OTU4  "Actinomycetales"      "Propionibacteriaceae"               
#> OTU5  "Actinomycetales"      "Propionibacteriaceae"               
#> OTU6  "Actinomycetales"      "2 Actinomycetales (Family: unknown)"
#> OTU7  "Actinomycetales"      "Nocardioidaceae"                    
#> OTU8  "Actinomycetales"      "Nocardioidaceae"                    
#> OTU9  "1 1 (Order: unknown)" "3 1 (Family: unknown)"              
#> OTU10 "Actinomycetales"      "4 Actinomycetales (Family: unknown)"
#>       Genus                                    
#> OTU1  "Propionibacterium"                      
#> OTU2  "1 Actinomycetales (Genus: unknown)"     
#> OTU3  "2 Propionibacteriaceae (Genus: unknown)"
#> OTU4  "Tessaracoccus"                          
#> OTU5  "Aestuariimicrobium"                     
#> OTU6  "3 Actinomycetales (Genus: unknown)"     
#> OTU7  "4 Nocardioidaceae (Genus: unknown)"     
#> OTU8  "Propionicimonas"                        
#> OTU9  "5 1 (Genus: unknown)"                   
#> OTU10 "6 Actinomycetales (Genus: unknown)"     
#>       Species                                    
#> OTU1  "Propionibacteriumacnes"                   
#> OTU2  "1 Actinomycetales (Species: unknown)"     
#> OTU3  "2 Propionibacteriaceae (Species: unknown)"
#> OTU4  "3 Tessaracoccus (Species: unknown)"       
#> OTU5  "4 Aestuariimicrobium (Species: unknown)"  
#> OTU6  "5 Actinomycetales (Species: unknown)"     
#> OTU7  "6 Nocardioidaceae (Species: unknown)"     
#> OTU8  "7 Propionicimonas (Species: unknown)"     
#> OTU9  "8 1 (Species: unknown)"                   
#> OTU10 "9 Actinomycetales (Species: unknown)"     

#--- Example 8 --------------------------------------------------------------
# - Do not substitute unknowns and unclassified taxa by higher ranks
# - e.g., unknown genus -> "1"

renamed8 <- renameTaxa(taxtab, 
                         pat = "<name>", substPat = "<name>")
renamed8
#>       Kingdom         Phylum           Class            Order            
#> OTU1  "Bacteria"      "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU2  "Bacteria"      "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU3  "Bacteria"      "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU4  "Bacteria"      "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU5  "Bacteria"      "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU6  "Bacteria"      "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU7  "Bacteria"      "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU8  "Bacteria"      "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU9  "Unclassified1" "unclassified1"  "unclassified1"  "unclassified1"  
#> OTU10 "Bacteria"      "Actinobacteria" "Actinobacteria" "Actinomycetales"
#>       Family                 Genus                Species                 
#> OTU1  "Propionibacteriaceae" "Propionibacterium"  "Propionibacteriumacnes"
#> OTU2  "unclassified1"        "unclassified1"      "unclassified1"         
#> OTU3  "Propionibacteriaceae" "unclassified2"      "unclassified2"         
#> OTU4  "Propionibacteriaceae" "Tessaracoccus"      "1"                     
#> OTU5  "Propionibacteriaceae" "Aestuariimicrobium" "unclassified3"         
#> OTU6  "1"                    "1"                  "2"                     
#> OTU7  "Nocardioidaceae"      "2"                  "3"                     
#> OTU8  "Nocardioidaceae"      "Propionicimonas"    "4"                     
#> OTU9  "unclassified2"        "unclassified3"      "unclassified4"         
#> OTU10 "2"                    "3"                  "5"                     

#--- Example 9 --------------------------------------------------------------
# - Error if ranks cannot be automatically determined 
#   from column names or taxonomic names

taxtab_noranks <- taxtab
colnames(taxtab_noranks) <- paste0("Rank", 1:ncol(taxtab))
head(taxtab_noranks)
#>      Rank1      Rank2            Rank3            Rank4            
#> OTU1 "Bacteria" "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU2 "Bacteria" "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU3 "Bacteria" "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU4 "Bacteria" "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU5 "Bacteria" "Actinobacteria" "Actinobacteria" "Actinomycetales"
#> OTU6 "Bacteria" "Actinobacteria" "Actinobacteria" "Actinomycetales"
#>      Rank5                  Rank6                Rank7                   
#> OTU1 "Propionibacteriaceae" "Propionibacterium"  "Propionibacteriumacnes"
#> OTU2 "unclassified"         "unclassified"       "unclassified"          
#> OTU3 "Propionibacteriaceae" "unclassified"       "unclassified"          
#> OTU4 "Propionibacteriaceae" "Tessaracoccus"      NA                      
#> OTU5 "Propionibacteriaceae" "Aestuariimicrobium" "unclassified"          
#> OTU6 NA                     NA                   NA                      

if (FALSE) { # \dontrun{
renamed9 <- renameTaxa(taxtab_noranks, 
                         pat = "<name>", 
                         substPat = "<name>_<subst_name>(<subst_R>)")
} # }

# Ranks can either be given via "ranks" ... 
(ranks <- colnames(taxtab))
#> [1] "Kingdom" "Phylum"  "Class"   "Order"   "Family"  "Genus"   "Species"

renamed9 <- renameTaxa(taxtab_noranks, 
                         pat = "<name>", 
                         substPat = "<name>_<subst_name>(<subst_R>)",
                         ranks = ranks)
renamed9
#>       Rank1           Rank2                           
#> OTU1  "Bacteria"      "Actinobacteria"                
#> OTU2  "Bacteria"      "Actinobacteria"                
#> OTU3  "Bacteria"      "Actinobacteria"                
#> OTU4  "Bacteria"      "Actinobacteria"                
#> OTU5  "Bacteria"      "Actinobacteria"                
#> OTU6  "Bacteria"      "Actinobacteria"                
#> OTU7  "Bacteria"      "Actinobacteria"                
#> OTU8  "Bacteria"      "Actinobacteria"                
#> OTU9  "Unclassified1" "unclassified1_Unclassified1(K)"
#> OTU10 "Bacteria"      "Actinobacteria"                
#>       Rank3                            Rank4                           
#> OTU1  "Actinobacteria"                 "Actinomycetales"               
#> OTU2  "Actinobacteria"                 "Actinomycetales"               
#> OTU3  "Actinobacteria"                 "Actinomycetales"               
#> OTU4  "Actinobacteria"                 "Actinomycetales"               
#> OTU5  "Actinobacteria"                 "Actinomycetales"               
#> OTU6  "Actinobacteria"                 "Actinomycetales"               
#> OTU7  "Actinobacteria"                 "Actinomycetales"               
#> OTU8  "Actinobacteria"                 "Actinomycetales"               
#> OTU9  "unclassified1_Unclassified1(K)" "unclassified1_Unclassified1(K)"
#> OTU10 "Actinobacteria"                 "Actinomycetales"               
#>       Rank5                             
#> OTU1  "Propionibacteriaceae"            
#> OTU2  "unclassified1_Actinomycetales(O)"
#> OTU3  "Propionibacteriaceae"            
#> OTU4  "Propionibacteriaceae"            
#> OTU5  "Propionibacteriaceae"            
#> OTU6  "1_Actinomycetales(O)"            
#> OTU7  "Nocardioidaceae"                 
#> OTU8  "Nocardioidaceae"                 
#> OTU9  "unclassified2_Unclassified1(K)"  
#> OTU10 "2_Actinomycetales(O)"            
#>       Rank6                                  
#> OTU1  "Propionibacterium"                    
#> OTU2  "unclassified1_Actinomycetales(O)"     
#> OTU3  "unclassified2_Propionibacteriaceae(F)"
#> OTU4  "Tessaracoccus"                        
#> OTU5  "Aestuariimicrobium"                   
#> OTU6  "1_Actinomycetales(O)"                 
#> OTU7  "2_Nocardioidaceae(F)"                 
#> OTU8  "Propionicimonas"                      
#> OTU9  "unclassified3_Unclassified1(K)"       
#> OTU10 "3_Actinomycetales(O)"                 
#>       Rank7                                  
#> OTU1  "Propionibacteriumacnes"               
#> OTU2  "unclassified1_Actinomycetales(O)"     
#> OTU3  "unclassified2_Propionibacteriaceae(F)"
#> OTU4  "1_Tessaracoccus(G)"                   
#> OTU5  "unclassified3_Aestuariimicrobium(G)"  
#> OTU6  "2_Actinomycetales(O)"                 
#> OTU7  "3_Nocardioidaceae(F)"                 
#> OTU8  "4_Propionicimonas(G)"                 
#> OTU9  "unclassified4_Unclassified1(K)"       
#> OTU10 "5_Actinomycetales(O)"                 

# ... or "ranksAbb" (we now use the lower case within "substPat")
(ranks <- substr(colnames(taxtab), 1, 1))
#> [1] "K" "P" "C" "O" "F" "G" "S"

renamed9 <- renameTaxa(taxtab_noranks, 
                         pat = "<name>", 
                         substPat = "<name>_<subst_name>(<subst_r>)",
                         ranksAbb = ranks)
renamed9
#>       Rank1           Rank2                           
#> OTU1  "Bacteria"      "Actinobacteria"                
#> OTU2  "Bacteria"      "Actinobacteria"                
#> OTU3  "Bacteria"      "Actinobacteria"                
#> OTU4  "Bacteria"      "Actinobacteria"                
#> OTU5  "Bacteria"      "Actinobacteria"                
#> OTU6  "Bacteria"      "Actinobacteria"                
#> OTU7  "Bacteria"      "Actinobacteria"                
#> OTU8  "Bacteria"      "Actinobacteria"                
#> OTU9  "Unclassified1" "unclassified1_Unclassified1(k)"
#> OTU10 "Bacteria"      "Actinobacteria"                
#>       Rank3                            Rank4                           
#> OTU1  "Actinobacteria"                 "Actinomycetales"               
#> OTU2  "Actinobacteria"                 "Actinomycetales"               
#> OTU3  "Actinobacteria"                 "Actinomycetales"               
#> OTU4  "Actinobacteria"                 "Actinomycetales"               
#> OTU5  "Actinobacteria"                 "Actinomycetales"               
#> OTU6  "Actinobacteria"                 "Actinomycetales"               
#> OTU7  "Actinobacteria"                 "Actinomycetales"               
#> OTU8  "Actinobacteria"                 "Actinomycetales"               
#> OTU9  "unclassified1_Unclassified1(k)" "unclassified1_Unclassified1(k)"
#> OTU10 "Actinobacteria"                 "Actinomycetales"               
#>       Rank5                             
#> OTU1  "Propionibacteriaceae"            
#> OTU2  "unclassified1_Actinomycetales(o)"
#> OTU3  "Propionibacteriaceae"            
#> OTU4  "Propionibacteriaceae"            
#> OTU5  "Propionibacteriaceae"            
#> OTU6  "1_Actinomycetales(o)"            
#> OTU7  "Nocardioidaceae"                 
#> OTU8  "Nocardioidaceae"                 
#> OTU9  "unclassified2_Unclassified1(k)"  
#> OTU10 "2_Actinomycetales(o)"            
#>       Rank6                                  
#> OTU1  "Propionibacterium"                    
#> OTU2  "unclassified1_Actinomycetales(o)"     
#> OTU3  "unclassified2_Propionibacteriaceae(f)"
#> OTU4  "Tessaracoccus"                        
#> OTU5  "Aestuariimicrobium"                   
#> OTU6  "1_Actinomycetales(o)"                 
#> OTU7  "2_Nocardioidaceae(f)"                 
#> OTU8  "Propionicimonas"                      
#> OTU9  "unclassified3_Unclassified1(k)"       
#> OTU10 "3_Actinomycetales(o)"                 
#>       Rank7                                  
#> OTU1  "Propionibacteriumacnes"               
#> OTU2  "unclassified1_Actinomycetales(o)"     
#> OTU3  "unclassified2_Propionibacteriaceae(f)"
#> OTU4  "1_Tessaracoccus(g)"                   
#> OTU5  "unclassified3_Aestuariimicrobium(g)"  
#> OTU6  "2_Actinomycetales(o)"                 
#> OTU7  "3_Nocardioidaceae(f)"                 
#> OTU8  "4_Propionicimonas(g)"                 
#> OTU9  "unclassified4_Unclassified1(k)"       
#> OTU10 "5_Actinomycetales(o)"                 

#--- Example 10 -------------------------------------------------------------
# - Make names of ranks "Family" and "Order" unique by adding numbers to 
#   duplicated names

renamed10 <- renameTaxa(taxtab, 
                          pat = "<name>", 
                          substPat = "<name>_<subst_name>(<subst_R>)",
                          numDupli = c("Family", "Order"))
renamed10
#>       Kingdom         Phylum                          
#> OTU1  "Bacteria"      "Actinobacteria"                
#> OTU2  "Bacteria"      "Actinobacteria"                
#> OTU3  "Bacteria"      "Actinobacteria"                
#> OTU4  "Bacteria"      "Actinobacteria"                
#> OTU5  "Bacteria"      "Actinobacteria"                
#> OTU6  "Bacteria"      "Actinobacteria"                
#> OTU7  "Bacteria"      "Actinobacteria"                
#> OTU8  "Bacteria"      "Actinobacteria"                
#> OTU9  "Unclassified1" "unclassified1_Unclassified1(K)"
#> OTU10 "Bacteria"      "Actinobacteria"                
#>       Class                            Order                           
#> OTU1  "Actinobacteria"                 "Actinomycetales1"              
#> OTU2  "Actinobacteria"                 "Actinomycetales2"              
#> OTU3  "Actinobacteria"                 "Actinomycetales3"              
#> OTU4  "Actinobacteria"                 "Actinomycetales4"              
#> OTU5  "Actinobacteria"                 "Actinomycetales5"              
#> OTU6  "Actinobacteria"                 "Actinomycetales6"              
#> OTU7  "Actinobacteria"                 "Actinomycetales7"              
#> OTU8  "Actinobacteria"                 "Actinomycetales8"              
#> OTU9  "unclassified1_Unclassified1(K)" "unclassified1_Unclassified1(K)"
#> OTU10 "Actinobacteria"                 "Actinomycetales9"              
#>       Family                             
#> OTU1  "Propionibacteriaceae1"            
#> OTU2  "unclassified1_Actinomycetales2(O)"
#> OTU3  "Propionibacteriaceae2"            
#> OTU4  "Propionibacteriaceae3"            
#> OTU5  "Propionibacteriaceae4"            
#> OTU6  "1_Actinomycetales6(O)"            
#> OTU7  "Nocardioidaceae1"                 
#> OTU8  "Nocardioidaceae2"                 
#> OTU9  "unclassified2_Unclassified1(K)"   
#> OTU10 "2_Actinomycetales9(O)"            
#>       Genus                                   
#> OTU1  "Propionibacterium"                     
#> OTU2  "unclassified1_Actinomycetales2(O)"     
#> OTU3  "unclassified2_Propionibacteriaceae2(F)"
#> OTU4  "Tessaracoccus"                         
#> OTU5  "Aestuariimicrobium"                    
#> OTU6  "1_Actinomycetales6(O)"                 
#> OTU7  "2_Nocardioidaceae1(F)"                 
#> OTU8  "Propionicimonas"                       
#> OTU9  "unclassified3_Unclassified1(K)"        
#> OTU10 "3_Actinomycetales9(O)"                 
#>       Species                                 
#> OTU1  "Propionibacteriumacnes"                
#> OTU2  "unclassified1_Actinomycetales2(O)"     
#> OTU3  "unclassified2_Propionibacteriaceae2(F)"
#> OTU4  "1_Tessaracoccus(G)"                    
#> OTU5  "unclassified3_Aestuariimicrobium(G)"   
#> OTU6  "2_Actinomycetales6(O)"                 
#> OTU7  "3_Nocardioidaceae1(F)"                 
#> OTU8  "4_Propionicimonas(G)"                  
#> OTU9  "unclassified4_Unclassified1(K)"        
#> OTU10 "5_Actinomycetales9(O)"                 

any(duplicated(renamed10[, "Family"]))
#> [1] FALSE
any(duplicated(renamed10[, "Order"]))
#> [1] FALSE
```
