library(foreign)
library(stringr)
library(plyr)
library(reshape2)
library(tibble)
library(dplyr)
library(tidyverse)
library(tidyr)

# Load data -----------------------------------------------------------------------------

table4 <- read.spss("pew_raw.sav")
table4 <- as.data.frame(table4)

# Convert to tidy data ------------------------------------------------------------------

table4$religion 

table4.1<-table4 %>% 
  gather(`<$10k`, `$10-20k`, `$20-30k`, `$30-40k`, `$40-50k`, `$50-75k`, `$75-100k`, `$100-150k`,`>150k`,`Don't know/refused`, key= "income", value = "frequency")

table6<-table4.1 %>% arrange(religion)


